# Nota de reconciliación — A02

Fecha: 2026-11-04
Motivo: reescritura de historia para sanitizar rutas locales en el evidence bundle.

## Qué se reescribió

Se ejecutó `git filter-repo --replace-text` sobre todo el historial del repositorio para reemplazar la ruta absoluta del perfil del usuario local por el placeholder `<USERPROFILE>`. El patrón afectado era `C:\Users\<local-user>` y aparecía únicamente en `render-latex-command.txt`, donde Manim imprime rutas absolutas de los archivos de salida. `generate-evidence.ps1` ya sanitizaba `PATH` y `VIRTUAL_ENV` en `context-session.txt`, pero no la salida de subprocesos.

Todos los SHA de commits cambiaron. El commit original del bundle pasó a tener un hash nuevo (`5565fff`), y el merge de PR #3 pasó a ser `faa27d8`. El contenido técnico del bundle es idéntico; solo cambia la representación de la ruta local.

## Qué se hizo después de la reescritura

1. Se actualizó `generate-evidence.ps1` para sanitizar cualquier salida capturada, no solo `PATH`:
   `$Output = $Output -replace [regex]::Escape($env:USERPROFILE), "<USERPROFILE>"`
2. Se regeneró el bundle completo en una sesión con el venv activo. Las salidas de las 15 entradas son coherentes con el entorno verificado en A02 (Python 3.14.5, Manim 0.22.1, MiKTeX 25.12, FFmpeg 9.0.2).
3. `verify.ps1` reporta `SUCCESS: all 15 entries verified.` sobre el bundle regenerado.

## Qué cambia respecto del bundle original

- Los `timestamp_utc` de los `.txt` corresponden a la regeneración (2026-11-04T06:07Z–06:19Z), no a la captura original (2026-11-04T00:14Z–00:18Z).
- Los `sha256` del `manifest.json` corresponden al contenido sanitizado.
- El campo `commit` del `manifest.json` y de los headers apunta a `faa27d8`, que es el HEAD del repositorio reescrito al momento de la regeneración.

El contenido técnico verificado es idéntico al original: versiones de herramientas, resultado del render (`codec_name=h264`, `width=854`, `height=480`, `duration=2.000000`, `size=11451`) y `exit_code=0` en las 15 entradas.

## Qué no cambia

El alcance de A02 sigue siendo read-only, la verificabilidad del bundle se mantiene, y `verify.ps1` continúa detectando alteraciones por hash normalizado (BOM/CRLF→LF). El workflow `verify-a02.yml` sigue ejecutándose en cada PR que modifique `reports/a02/**`.

## Respaldo

Existe un clon local pre-reescritura, fuera del repositorio, con el historial original. No se publicó y no se publicará.
