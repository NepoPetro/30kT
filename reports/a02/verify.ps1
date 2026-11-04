#Requires -Version 5.1
param()

$ErrorActionPreference = "Stop"

$scriptDir = $PSScriptRoot
$manifestPath = Join-Path $scriptDir "manifest.json"

if (-not (Test-Path $manifestPath)) {
    Write-Error "Manifest not found: $manifestPath"
    exit 1
}

$manifest = Get-Content $manifestPath -Raw -Encoding UTF8 | ConvertFrom-Json

Write-Host "Verifying $($manifest.evidence.Count) entries from manifest..."
Write-Host "Issue: $($manifest.issue) ($($manifest.issue_slug))"
Write-Host "Generated: $($manifest.generated_utc)"
Write-Host "Agent: $($manifest.agent)"
Write-Host ""

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

$failures = 0

foreach ($entry in $manifest.evidence) {
    $filePath = Join-Path $scriptDir $entry.file
    if (-not (Test-Path $filePath)) {
        Write-Host "  MISSING: $($entry.file)"
        $failures++
        continue
    }
    $actualHash = Get-NormalizedFileHash -Path $filePath
    if ($actualHash -ne $entry.sha256) {
        Write-Host "  MISMATCH: $($entry.file)"
        Write-Host "    expected: $($entry.sha256)"
        Write-Host "    actual:   $actualHash"
        $failures++
    } else {
        Write-Host "  OK: $($entry.file)"
    }
}

Write-Host ""
if ($failures -gt 0) {
    Write-Host "FAILED: $failures of $($manifest.evidence.Count) entries do not match."
    exit 1
}

Write-Host "SUCCESS: all $($manifest.evidence.Count) entries verified."
exit 0