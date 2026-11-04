# Code review — A02 evidence bundle (post A02, pre Milestone A)

## Metadatos

- Commit revisado: `0f9f508`
- Tag de referencia: `v0.1.0-a02` (`44add9a`), anotado
- Diff contra tag: vacío (contenido idéntico)
- Alcance: árbol completo a HEAD
- Revisora: Viki Perera
- Fecha: 2026-11-04
- Insumo para: A04, A05, A06, A07, A08, B02

## Resumen ejecutivo

El repositorio está en un estado inicial coherente: árbol limpio, sin ramas huérfanas, tag anotado, workflow verde, evidencia verificable por hash. La sanitización de rutas locales funciona para paths y variables de entorno, pero **no** cubre el campo `agent` (intencional, documentado aquí) ni la salida de subprocesos (ya mitigado por la reescritura de historia). El principal riesgo técnico es el modelo de confianza del workflow de verificación: ni el propio workflow ni `verify.ps1` están protegidos por el mecanismo de hashes, y el verificador se ejecuta desde el checkout del PR. Se detectaron, además, dos defectos en el pipeline de captura: `WaitForExit()` sin timeout y una corrupción silenciosa del probe de LaTeX con `exit_code=0` incorrecto. Ninguno invalida el bundle A02 como insumo histórico; sí invalidan `env-python-which-latex.txt` como evidencia utilizable.

Decisión: **aprobar contenido, registrar hallazgos, abrir B02** con los hallazgos B1, M2, M3, M4, M5, M6, m6, m7. A04–A08 desbloqueados.

## Hallazgos

### Bloqueante

**B1 — Modelo de confianza roto en `verify-a02.yml`.**

El workflow se dispara solo con cambios en `reports/a02/**`. Un PR que modifique únicamente `.github/workflows/verify-a02.yml` no ejecuta verificación. Además, el step ejecuta `reports/a02/verify.ps1` desde el checkout del PR, por lo que un PR puede modificar `verify.ps1` o `manifest.json` para que la verificación pase. Los hashes no cubren al verificador.

*Destino:* B02.

### Mayor

**M1 — `agent: "Viki Perera"` en headers y manifest.**

Atribución intencional bajo licencia MIT. Cierre acordado: documentar en `NOTA-RECONCILIACION.md`. No sanitizar.

*Destino:* A04 (convención de atribución) + nota.

**M2 — `verify.ps1` fail-open con manifest vacío.**

`foreach` sobre `$manifest.evidence` no valida que exista contenido; un manifest con `evidence: []` reporta `SUCCESS: all 0 entries verified` y sale `exit 0`.

*Destino:* B02.

**M3 — `Invoke-Capture` sin timeout.**

`$proc.WaitForExit()` bloquea indefinidamente. En CI agota el `timeout-minutes` default (360 min).

*Destino:* B02.

**M4 — Corrupción silenciosa del probe LaTeX.**

`Start-Process -ArgumentList @("-c", "import shutil; print(shutil.which('latex'))")` en PS 5.1 no cita el argumento de `-c`: Python recibe solo `import` y aborta con `SyntaxError`. Evidencia: `reports/a02/evidence/env-python-which-latex.txt`. Además, el `exit_code` capturado es `0` (debería ser `1`), lo que sugiere que `$proc.ExitCode` no refleja el proceso real en este caso. El manifest hashea el archivo corrupto como válido: la integridad se cumple, la corrección no.

*Destino:* B02. Nota de corrección en `NOTA-RECONCILIACION.md`.

**M5 — Actions pinneadas por tag mutable.**

`actions/checkout@v4` no es reproducible a largo plazo. Pin por SHA con comentario de versión.

*Destino:* B02 / A07.

**M6 — `shell: pwsh` seguido de `powershell -File`.**

Downgrade explícito de PS 7 a PS 5.1 dentro del step. Inconsistente con `#Requires -Version 5.1` en los scripts. Elegir uno: `#Requires -Version 7` + `pwsh`, o eliminar `shell: pwsh` del workflow.

*Destino:* B02.

**M7 — Encoding de `README.md` y `NOTA-RECONCILIACION.md` a verificar.**

La lectura local muestra `??` en lugar de caracteres acentuados. Puede ser artefacto de la cadena de lectura/pegado o corrupción real en el repo. Verificar con `git show HEAD:README.md | Format-Hex | Select-Object -First 3`. Si el repo es correcto, marcar como falso positivo y cerrar.

*Destino:* verificación puntual.

### Menor

- **m1** — `PATH` completo en `context-session.txt` expone software instalado (WhatsMkt, Docker, WSL, VS Code, GitHub CLI, etc.). Filtrar entradas irrelevantes antes de sanitizar.
- **m2** — `Remove-Item media -Recurse -Force` destructivo y no condicionado. Acotar a `media/videos/LatexProbe`.
- **m3** — `Get-ChildItem -Recurse -Filter LatexProbe.mp4` barre todo el árbol. Acotar a la ruta estándar de manim.
- **m4** — Falta `.gitattributes` (evidencia: commit `261a58f`). Añadir `* text=auto eol=lf`, `*.ps1 text eol=crlf`, `*.txt -text`.
- **m5** — `Out-File -Encoding UTF8` escribe BOM en PS 5.1 y no en PS 7. Fijar `#Requires -Version 7` + `-Encoding utf8NoBOM`.
- **m6** — Falta `timeout-minutes` y `concurrency` en el workflow.
- **m7** — `Get-NormalizedFileHash` duplicada entre `generate-evidence.ps1` y `verify.ps1`. Extraer a módulo común o añadir test de equivalencia.
- **m8** — Campo `commit` en headers es capture-time, no HEAD. Renombrar a `captured_at_commit` o mover al manifest.
- **m9** — `windows-latest` es tag móvil. Fijar `windows-2022`.
- **m10** — `LICENSE` declara `Copyright (c) 2026 NepoPetro`, no `Viki Perera`. Si NepoPetro = Viki Perera (handle), consistente con M1. Documentar en A04. Verificar también si XERJ requiere mención como licenciatario (según estado: consentimiento ya otorgado por Viki; publicación pendiente de XERJ).

### Nit

- `.gitignore` `lib/` ignora cualquier `lib/` en cualquier nivel. Acotar a `.venv/lib/` o eliminar.
- `!site/assets/videos/*.mp4` sin `site/` existente. Eliminar hasta que exista.

## Fuera de alcance

- Estadística más allá de descriptivos, reconciliación, cobertura, faltantes, cotas de sensibilidad.
- Licencia MIT (confirmada; sólo consistencia de titular en A04).
- Cambios al README sin PR y decisión explícita.

## Decisiones registradas

1. `agent: "Viki Perera"` es atribución intencional. Ver `reports/a02/NOTA-RECONCILIACION.md`.
2. `env-python-which-latex.txt` contiene un `SyntaxError` por bug de `Invoke-Capture`, no una ruta válida. La verificación por hash no detecta el defecto porque valida integridad, no corrección. Corrección en B02.

## Decisión

Aprobar contenido. B1, M2, M3, M4, M5, M6, m6, m7 → B02. M1, m10 → A04. m1–m10 → A07 salvo indicación. A04–A08 desbloqueados.

## Referencias

- B02 (a abrir): endurecer verificación A02 en CI.
- A04: ADR-001 + convención multilingüe + atribución (M1, m10).
- A07: higiene de CI (M5, m4, m6, m9, m7).
- A08: política de datos personales (m1, M1).