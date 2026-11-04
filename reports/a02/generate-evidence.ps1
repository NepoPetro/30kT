#Requires -Version 5.1
param(
    [string]$RepoRoot = (Get-Location).Path
)

$ErrorActionPreference = "Stop"

Set-Location $RepoRoot

if (-not (Test-Path ".git")) {
    Write-Error "Must be run from repository root (no .git found in $RepoRoot)"
    exit 1
}

$scriptDir = $PSScriptRoot
$evidenceDir = Join-Path $scriptDir "evidence"
$sourceDir = Join-Path $scriptDir "evidence-source"

if (-not (Test-Path $evidenceDir)) {
    New-Item -ItemType Directory -Path $evidenceDir -Force | Out-Null
}

$agent = ""
try {
    $agent = (git config user.name).Trim()
} catch {
    $agent = "unknown"
}
if (-not $agent) { $agent = "unknown" }

$commit = ""
try {
    $commit = (git rev-parse HEAD).Trim()
} catch {
    $commit = "unknown"
}

function Invoke-Capture {
    param(
        [string]$Command,
        [string[]]$Arguments
    )
    $tmpOut = [System.IO.Path]::GetTempFileName()
    $tmpErr = [System.IO.Path]::GetTempFileName()
    try {
        try {
            $proc = Start-Process -FilePath $Command -ArgumentList $Arguments -NoNewWindow -PassThru -RedirectStandardOutput $tmpOut -RedirectStandardError $tmpErr
            $proc.WaitForExit()
            $exitCode = $proc.ExitCode
        } catch {
            return @{
                Output = "ERROR: $($_.Exception.Message)"
                ExitCode = 127
            }
        }
        $stdout = Get-Content $tmpOut -Raw -ErrorAction SilentlyContinue
        $stderr = Get-Content $tmpErr -Raw -ErrorAction SilentlyContinue
        $parts = @()
        if ($stdout) { $parts += ($stdout -replace "`r`n", "`n").TrimEnd() }
        if ($stderr) { $parts += ($stderr -replace "`r`n", "`n").TrimEnd() }
        return @{
            Output = ($parts -join "`n")
            ExitCode = $exitCode
        }
    } finally {
        Remove-Item $tmpOut -Force -ErrorAction SilentlyContinue
        Remove-Item $tmpErr -Force -ErrorAction SilentlyContinue
    }
}
function Get-NormalizedFileHash {
    param([string]$Path)
    $bytes = [System.IO.File]::ReadAllBytes($Path)
    if ($bytes.Length -ge 3 -and $bytes[0] -eq 0xEF -and $bytes[1] -eq 0xBB -and $bytes[2] -eq 0xBF) {
        $bytes = $bytes[3..($bytes.Length - 1)]
    }
    $text = [System.Text.Encoding]::UTF8.GetString($bytes)
    $normalized = $text -replace "`r`n", "`n"
    $normalizedBytes = [System.Text.Encoding]::UTF8.GetBytes($normalized)
    $sha = [System.Security.Cryptography.SHA256]::Create()
    $hash = $sha.ComputeHash($normalizedBytes)
    return ([System.BitConverter]::ToString($hash) -replace "-", "").ToLower()
}

function Write-Evidence {
    param(
        [string]$Name,
        [string]$CommandLine,
        [string]$Output,
        [int]$ExitCode
    )
    $ts = (Get-Date).ToUniversalTime().ToString("yyyy-MM-ddTHH:mm:ssZ")
    $path = Join-Path $evidenceDir $Name
    $header = @"
command: $CommandLine
agent: $agent
commit: $commit
timestamp_utc: $ts
---
"@
    $footer = @"
---
exit_code: $ExitCode
"@
    $Output = $Output -replace [regex]::Escape($env:USERPROFILE), "<USERPROFILE>"
    $content = $header + "`n" + $Output + "`n" + $footer
    $content | Out-File -FilePath $path -Encoding UTF8
    Write-Host "  evidence/$Name (exit $ExitCode)"
}

function Capture {
    param(
        [string]$Name,
        [string]$Command,
        [string[]]$Arguments
    )
    $cmdLine = "$Command $($Arguments -join ' ')"
    $result = Invoke-Capture -Command $Command -Arguments $Arguments
    Write-Evidence -Name $Name -CommandLine $cmdLine -Output $result.Output -ExitCode $result.ExitCode
}

Write-Host "Capturing execution context..."
$sanitizedPath = $env:PATH -replace [regex]::Escape($env:USERPROFILE), "<USERPROFILE>"
$sanitizedVenv = ""
if ($env:VIRTUAL_ENV) {
    $sanitizedVenv = $env:VIRTUAL_ENV -replace [regex]::Escape($env:USERPROFILE), "<USERPROFILE>"
}
$context = "PATH=$sanitizedPath`nVIRTUAL_ENV=$sanitizedVenv"
Write-Evidence -Name "context-session.txt" -CommandLine "(session context)" -Output $context -ExitCode 0

Write-Host "Capturing tool versions..."
Capture "env-python.txt" "python" @("--version")
Capture "env-uv.txt" "uv" @("--version")
Capture "env-ffmpeg.txt" "ffmpeg" @("-version")
Capture "env-ffprobe.txt" "ffprobe" @("-version")
Capture "env-node.txt" "node" @("--version")
Capture "env-npm.txt" "npm.cmd" @("--version")
Capture "env-manim.txt" "manim" @("--version")
Capture "env-latex.txt" "latex" @("--version")
Capture "env-pdflatex.txt" "pdflatex" @("--version")
Capture "env-dvisvgm.txt" "dvisvgm" @("--version")

Write-Host "Capturing python which latex..."
$whichResult = Invoke-Capture -Command "python" -Arguments @("-c", "import shutil; print(shutil.which('latex'))")
Write-Evidence -Name "env-python-which-latex.txt" -CommandLine "python -c <which latex>" -Output $whichResult.Output -ExitCode $whichResult.ExitCode

$probeScript = Join-Path $sourceDir "probe_latex.py"
if (Test-Path $probeScript) {
    Write-Host "Rendering probe scene..."
    $renderResult = Invoke-Capture -Command "manim" -Arguments @("render", "-ql", $probeScript, "LatexProbe")
    Write-Evidence -Name "render-latex-command.txt" -CommandLine "manim render -ql evidence-source/probe_latex.py LatexProbe" -Output $renderResult.Output -ExitCode $renderResult.ExitCode

    $mp4 = Get-ChildItem -Path $RepoRoot -Filter "LatexProbe.mp4" -Recurse -ErrorAction SilentlyContinue | Select-Object -First 1
    if ($mp4) {
        Write-Host "Capturing ffprobe on $($mp4.Name)..."
        $ffResult = Invoke-Capture -Command "ffprobe" -Arguments @("-v", "error", "-show_entries", "format=duration,size,format_name", "-show_entries", "stream=codec_name,width,height,r_frame_rate", "-of", "default=noprint_wrappers=1", $mp4.FullName)
        Write-Evidence -Name "render-latex-ffprobe.txt" -CommandLine "ffprobe on LatexProbe.mp4" -Output $ffResult.Output -ExitCode $ffResult.ExitCode
        Remove-Item -Path (Join-Path $RepoRoot "media") -Recurse -Force -ErrorAction SilentlyContinue
    }
}

Write-Host "Building manifest..."
$evidenceList = @()

Get-ChildItem -Path $evidenceDir -Filter "*.txt" | Sort-Object Name | ForEach-Object {
    $relPath = "evidence/" + $_.Name
    $hash = Get-NormalizedFileHash -Path $_.FullName
    $evidenceList += [PSCustomObject]@{
        file = $relPath
        sha256 = $hash
        size_bytes = $_.Length
        kind = "captured"
    }
}

$sourceFile = Join-Path $sourceDir "probe_latex.py"
if (Test-Path $sourceFile) {
    $hash = Get-NormalizedFileHash -Path $sourceFile
    $evidenceList += [PSCustomObject]@{
        file = "evidence-source/probe_latex.py"
        sha256 = $hash
        size_bytes = (Get-Item $sourceFile).Length
        kind = "source"
    }
}

$manifest = [PSCustomObject]@{
    issue = "2"
    issue_slug = "A02"
    generated_utc = (Get-Date).ToUniversalTime().ToString("yyyy-MM-ddTHH:mm:ssZ")
    agent = $agent
    commit = $commit
    evidence = $evidenceList
}

$manifestPath = Join-Path $scriptDir "manifest.json"
$manifest | ConvertTo-Json -Depth 5 | Out-File -FilePath $manifestPath -Encoding UTF8

Write-Host ""
Write-Host "Manifest: $manifestPath"
Write-Host "Entries: $($evidenceList.Count)"
Write-Host "Done."