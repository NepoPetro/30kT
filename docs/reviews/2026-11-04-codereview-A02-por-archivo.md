# Code review por archivo — A02 evidence bundle

Complemento de `docs/reviews/2026-11-04-codereview-A02.md`.
Aplica tres lentes sobre cada artefacto del bundle A02:

- **ARQ (Arquitecto de datos):** estructura del bundle, modelo de trazabilidad,
  contrato integridad manifest-archivo, reproducibilidad del pipeline de captura.
- **STW (Data steward):** calidad, minimizacion, sanitizacion, exactitud,
  completitud, consistencia de encoding, atribucion.
- **GOV (Governance tech lead):** modelo de confianza del CI, policy-as-code,
  pinning, auditoria, separacion verificador/verificado.

Veredicto por archivo: **aceptado** / **aceptado con observaciones** / **rechazado como evidencia**.
Los hallazgos remiten al review principal (`B1`, `M*`, `m*`).

## `README.md`
- **Lente dominante:** STW.
- **Proposito:** puerta de entrada publica del repositorio.
- **Controles:** encoding UTF-8 sin BOM verificado por hexdump; acentos correctos
  (`C3 B3`, `C3 AD`); sin `3F 3F`. Contenido minimo: titulo, descripcion, estado.
- **Hallazgos:** M7 cerrado como falso positivo. Sin hallazgos propios.
- **Veredicto:** aceptado.

## `NOTA-RECONCILIACION.md`
- **Lente dominante:** STW + GOV.
- **Proposito:** declarar por que se reescribio la historia y que se sanitizo;
  cierra M1 y M4.
- **Controles:** acentos correctos; BOM UTF-8 presente (`EF BB BF`),
  inconsistente con README. Contenido de reconciliacion correcto (M1 atribucion
  intencional; M4 env-python-which-latex corrupto).
- **Hallazgos:** **m11** (BOM).
- **Veredicto:** aceptado con observaciones (m11).

## `LICENSE`
- **Lente dominante:** STW + GOV.
- **Proposito:** licencia MIT; define titular y derechos.
- **Controles:** titular `NepoPetro` (handle) vs `Viki Perera` (nombre en `agent`).
  Coherencia con M1 si NepoPetro = Viki Perera; verificar mencion de XERJ como
  licenciatario segun estado (consentimiento otorgado; publicacion pendiente).
- **Hallazgos:** **m10**.
- **Veredicto:** aceptado con observaciones (m10). Destino: A04.

## `.github/workflows/verify-a02.yml`
- **Lente dominante:** GOV + ARQ.
- **Proposito:** control de CI que verifica integridad del bundle A02 en cada PR.
- **Controles esperados:** disparo ante cambios del bundle y del propio workflow;
  verificacion desde fuente confiable (no del checkout del PR); acciones pinneadas
  por SHA; `timeout-minutes` y `concurrency`; shell consistente.
- **Hallazgos:** **B1** (no se dispara si el PR toca solo el workflow; ejecuta
  `verify.ps1` desde el checkout del PR, verificador modificable); **M5**
  (`actions/checkout@v4` tag mutable); **M6** (`shell: pwsh` + `powershell -File`,
  downgrade PS7 a PS5.1); **m6** (sin `timeout-minutes` ni `concurrency`);
  **m9** (`windows-latest` movil).
- **Veredicto:** aceptado como artefacto historico; **rechazado como control de
  seguridad** hasta B02.

## `reports/a02/verify.ps1`
- **Lente dominante:** GOV + ARQ.
- **Proposito:** verificar que cada archivo del manifest existe y su hash
  normalizado coincide.
- **Hallazgos:** **B1** (verificador en el arbol que verifica, fuera del manifest);
  **M2** (fail-open con `evidence: []`, reporta `all 0 entries verified` y exit 0);
  **M3** (`WaitForExit()` sin timeout); **M4** (`Invoke-Capture` rompe `python -c`
  por quoting en `Start-Process -ArgumentList`; `ExitCode` 0 en vez de 1);
  **m7** (`Get-NormalizedFileHash` duplicada con `generate-evidence.ps1`).
- **Veredicto:** aceptado con observaciones; correcciones en B02.

## `reports/a02/generate-evidence.ps1`
- **Lente dominante:** ARQ + STW.
- **Proposito:** capturar evidencia del entorno y generar el manifest.
- **Hallazgos:** **M3** (mismo `WaitForExit` sin timeout); **M4** (origen de la
  corrupcion de `env-python-which-latex.txt`); **m2** (`Remove-Item media -Recurse
  -Force` destructivo y no acotado); **m3** (`Get-ChildItem -Recurse -Filter
  LatexProbe.mp4` barre todo el arbol); **m5** (`Out-File -Encoding UTF8` con BOM
  en PS 5.1); **m7** (hash duplicado); **m8** (campo `commit` es capture-time,
  no HEAD).
- **Veredicto:** aceptado con observaciones; correcciones en B02.

## `reports/a02/evidence/env-python-which-latex.txt`
- **Lente dominante:** STW (calidad de evidencia).
- **Proposito:** probar disponibilidad de LaTeX en el entorno de captura.
- **Controles:** integridad por hash verificada (esta en manifest). Correccion
  no verificada (contiene `SyntaxError`, no una ruta). La afirmacion
  `SUCCESS: all 15 entries verified` valida integridad, no correccion.
- **Hallazgos:** **M4**.
- **Veredicto:** **rechazado como evidencia**; regenerar en B02.

## `.gitignore`
- **Lente dominante:** ARQ.
- **Proposito:** exclusion de artefactos no versionables.
- **Hallazgos:** nit, `lib/` ignora cualquier `lib/` en cualquier nivel;
  `!site/assets/videos/*.mp4` sin `site/` existente.
- **Veredicto:** aceptado con observaciones (nit).

## Pendientes de contenido

Para completar el review por archivo faltan los contenidos de:

- `reports/a02/context-session.txt` (m1 PATH)
- `reports/a02/manifest.json` (estructura, hashes, campo `commit`)
- `reports/a02/evidence/env-python-version.txt` y los demas entries del manifest
- `.gitattributes` (ausente; m4)

Se completan en el proximo chat con el inventario del bundle.