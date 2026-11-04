# A02 - Informe de inspección read-only del entorno

Issue asociado: #2
Milestone: A. Organización inicial y alcance
Fecha de inspección: 2026-11-02
Responsable: Viki P. Sitzer @mvikips


## Evidencia auditable

Este informe se acompaña de un *evidence bundle* verificable en `reports/a02/`:

- `evidence/`: salida literal de cada comando de verificación, con timestamp UTC, agente, commit y código de salida.
- `evidence-source/probe_latex.py`: código fuente de la escena de prueba con fórmula LaTeX.
- `manifest.json`: hashes SHA-256 de cada archivo de evidencia.
- `generate-evidence.ps1`: script que regenera la captura completa.
- `verify.ps1`: script que recomputa los hashes y falla si un archivo fue alterado.

Para verificar la integridad del bundle:
powershell -ExecutionPolicy Bypass -File reports\a02\verify.ps1

Salida esperada: `SUCCESS: all 15 entries verified.`

El workflow `.github/workflows/verify-a02.yml` ejecuta esta verificación en cada Pull Request que modifique archivos bajo `reports/a02/`. Un PR que altere cualquier archivo de evidencia sin regenerar el manifiesto falla la verificación y no puede mergearse.

Cada afirmación técnica de este informe puede contrastarse contra los archivos en `evidence/`: el archivo `env-python.txt` contiene la salida literal de `python --version`, `render-latex-ffprobe.txt` contiene la salida literal de `ffprobe` sobre el video de prueba, y así sucesivamente.

## Alcance

Inspección read-only del repositorio `nepopetro/30kT` y del repositorio satélite `nepopetro/tmura`, más verificación e instalación de las herramientas necesarias en el entorno local. No se modificó ningún archivo versionado en ninguno de los dos repositorios durante la inspección.

## Estado de 30kT

- Repositorio público, rama `main` protegida con regla que exige Pull Request.
- Contenido en la rama `main` al momento de la inspección: `LICENSE` (MIT), `.gitignore`, `README.md`.
- Sin workflows, sin Wiki inicializada, sin Discussions creadas al momento de la inspección.
- Rama de trabajo actual: `chore/A02-inspeccion-entorno`.

## Estado de tmura

Carpeta local: `$env:USERPROFILE\Archify-Bridge` (nombre anterior del proyecto, el remoto ya apunta a `nepopetro/tmura`).

Rama inspeccionada: `docs/architecture-review`, alineada con `origin/main` en el commit `d1a0f14`.

Trabajo sin commitear presente en la carpeta local que no forma parte de esta inspección y no fue modificado:

- `docs/ARCHITECTURE_REVIEW.html`
- `docs/adrs/adr-010-formal-verification-and-iac-standard.md`
- `infrastructure/`
- `scripts/verify_audit_chain.jl`
- `scripts/verify_audit_chain.wl`

Stack detectado:

- Node.js con `package.json` y `package-lock.json`.
- Script de build `build-docs.ps1` para generar el sitio HTML.
- Submódulos vía `.gitmodules`.
- Terraform en `infrastructure/` (`main.tf`, `enterprise_backend.tf`).
- Dos workflows de GitHub Actions: `.github/workflows/export.yml` y `.github/workflows/validate.yml`.
- ADRs 001 a 009 versionados, ADR-010 como archivo sin commitear.

Capacidades de diagramación verificadas por presencia de artefactos:

- Exportación a Mermaid: `exports/mermaid/*.mmd`.
- Exportación a Draw.io: `exports/drawio/*.drawio`.
- Exportación a HTML: `exports/archify/*.html` y `docs/**/*.html`.
- Documentación wiki ya publicada como `.md` y `.html` en `docs/wiki/` (Home, Architecture-Context, Computational-Evidence, Evidence-Standard, Examples, Glossary, Onboarding-Guide).

Capacidades no verificadas en esta inspección:

- Comandos exactos del CLI de tmura.
- Formato de invocación para generar nuevos diagramas desde cero.
- Comportamiento de `build-docs.ps1` con contenido externo al proyecto.
- Si tmura consume un Archify IR o un formato propio.

Estas capacidades se verificarán en el Issue C06 (PoC de tmura), no en A02.

## Herramientas del entorno local

Verificadas y operativas en esta sesión:

- Python 3.14.5 (sistema, no modificado).
- uv 0.13.6 (`$env:USERPROFILE\.local\bin`, en PATH de usuario).
- FFmpeg 9.0.2 y FFprobe 9.0.2 (`$env:USERPROFILE\AppData\Local\Microsoft\WinGet\Packages\Gyan.FFmpeg_Microsoft.Winget.Source_8wekyb3d8bbwe\ffmpeg-9.0.2-full_build\bin`, en PATH de usuario).
- Node.js 24.18.1.
- npm 11.16.0.
- Manim Community 0.22.1 instalado en el venv del proyecto `30kT` (`$env:USERPROFILE\30kT\.venv`, creado con `uv venv .venv`).
- MiKTeX 25.12 (`$env:USERPROFILE\AppData\Local\Programs\MiKTeX\miktex\bin\x64`, en PATH de usuario).
- dvisvgm 3.4.3 (mismo directorio que MiKTeX).
- LaTeX y pdflatex verificados: `MiKTeX-pdfTeX 4.23 (MiKTeX 25.12)`.

No instaladas:

- Cargo (Rust). Postergado por decisión técnica: no hay Issue activo que lo requiera. Se evaluará en D06 solo si una verificación independiente crítica lo justifica, con registro en el ADR correspondiente.

## Configuración del entorno virtual

El venv del proyecto está en `$env:USERPROFILE\30kT\.venv` y se activa con el script de activación estándar del entorno.

Se agregó al final de la configuración de activación una línea que agrega la carpeta `bin` de MiKTeX al PATH para que Manim encuentre LaTeX al lanzar subprocesos.

Esta línea es local al venv (no versionada, ignorada por `.gitignore`). Es necesaria porque el subproceso de Python que Manim invoca para compilar LaTeX no heredaba el PATH de la sesión de PowerShell sin ella.

Verificación desde Python: `python -c "import shutil; print(shutil.which('latex'))"` devuelve una ruta hacia `latex.EXE` dentro de la carpeta `bin` de MiKTeX.

## Verificación técnica del pipeline de respaldo matemático

### Render sin fórmula

- Comando: `manim render -ql probe_scene.py Probe`
- Resultado: `Probe.mp4` generado correctamente en `media\videos\probe_scene\480p15\`.
- Archivos de prueba eliminados después de la verificación.

### Render con fórmula LaTeX

- Comando: `manim render -ql probe_latex.py LatexProbe`
- Escena con `MathTex(r"R = \frac{N_{\text{doc}}}{N_{\text{decl}}}")`.
- Resultado: `LatexProbe.mp4` generado correctamente en `media\videos\probe_latex\480p15\`.
- Validación técnica del archivo con `ffprobe`:
  - `codec_name=h264`
  - `width=854`, `height=480`
  - `r_frame_rate=15/1`
  - `format_name=mov,mp4,m4a,3gp,3g2,mj2`
  - `duration=2.000000`
  - `size=11451`
- Archivos de prueba eliminados después de la verificación.

El pipeline Python aislado + Manim + FFmpeg + LaTeX + dvisvgm queda verificado de punta a punta.

Nota: el reproductor por defecto de Windows no abrió el archivo en la prueba visual, pero `ffprobe` confirma que el archivo es un MP4 H.264 estándar y bien formado. No es un problema del pipeline. Para verificación visual durante el desarrollo se recomienda VLC o abrir el archivo en el navegador.

## Advertencias observadas

- `pydub` emite `SyntaxWarning` por secuencias de escape en expresiones regulares. Es una dependencia de Manim escrita para Python anterior a 3.12. No rompe el render ni requiere acción por parte del proyecto.

## Capacidades ausentes o no verificadas

- Cargo no está instalado. Postergado con justificación.
- Los comandos exactos de tmura para producir diagramas nuevos no fueron verificados.
- La conversión de Wiki de GitHub a HTML estático y de Discussions a HTML estático no fue probada (ver Issues C08 y C09).

## Riesgos identificados

- El Python del sistema es 3.14.5 y el venv del proyecto también. Manim 0.22.1 funciona, pero futuras dependencias podrían no soportar 3.14. Mitigación: si un paquete falla, crear un venv paralelo con Python 3.12 vía `uv venv .venv312 --python 3.12` sin tocar el actual.
- La rama local `docs/architecture-review` de `tmura` tiene trabajo sin commitear que no es de esta inspección. Cualquier operación de Git sobre `tmura` debe hacerse en una rama nueva y sin tocar esa carpeta.
- El nombre local de la carpeta `tmura` sigue siendo `Archify-Bridge`. No es bloqueante, pero conviene renombrarla en algún momento para evitar confusión.
- La línea agregada a la activación del venv no está versionada (el venv entero está ignorado). Si la investigadora recrea el venv, debe volver a agregarla. Esto se documentará en el ADR de entorno reproducible (pendiente).

## Relación con la pregunta científica

Indirecta. La inspección confirma que el respaldo matemático del proyecto (Manim + Python aislado + FFmpeg + LaTeX) es técnicamente viable y está operativo en el entorno local, y que el sistema de diagramación (tmura) existe con capacidades de exportación a Mermaid, Draw.io y HTML reutilizables.

## Documentación que se actualiza

Ninguna en este Issue. Los hallazgos alimentan:

- A04 (ADR-001 de arquitectura documental).
- A06 (plantillas de Issue y PR).
- C06 (PoC de tmura).
- C08 (Wiki a HTML).
- C09 (Discussions a HTML).
- D08 (especificación matemática de escenas Manim).

## Condiciones para declarar el Issue terminado

- Informe publicado como comentario en el Issue #2.
- Investigadora revisó y aprobó.
- Bloqueos y riesgos técnicos registrados.