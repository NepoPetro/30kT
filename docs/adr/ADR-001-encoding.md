# ADR-001: Codificacion UTF-8 sin BOM

## Estado

Aceptado.

## Fecha

2026-11-09.

## Autora

Viki P. Sitzer (@mvikips). Roles en docs/conventions/attribution.md.

## Contexto

El repositorio 30kT contiene archivos Markdown, JSON, YAML, PowerShell y Python. En el transcurso de los primeros milestones se registraron tres incidentes de codificacion:

- m11 (A02): se detecto un BOM al inicio de un archivo de notas, que rompia parsers que asumen UTF-8 sin BOM.
- R3 (A06): PowerShell 5.1 corrompe argumentos no-ASCII al pasarlos a ejecutables nativos. El titulo del issue #2 se convirtio de Inspeccion con acento a Inspeccion sin acento, con perdida del byte original (C3 B3 a 3F).
- Incidente #2: la reescritura de un titulo con acentos termino sustituyendo la vocal acentuada por un signo de interrogacion ASCII.

Los tres incidentes comparten una causa: ausencia de una politica explicita de codificacion. La ausencia obliga a cada herramienta a inferir, y las inferencias no son consistentes.

## Decision

Todo archivo del repositorio se guarda con codificacion UTF-8 sin BOM. Los archivos de texto plano, Markdown, JSON, YAML, SQL, scripts y codigo fuente cumplen la misma regla.

Aclaraciones operativas:

- Los archivos creados o editados con editor de texto se guardan en UTF-8 sin BOM. VSCode lo hace por defecto.
- Los archivos generados por script usan codificacion UTF-8 sin BOM explicita.
- Los archivos JSON consumidos por GitHub Actions no deben tener BOM. Los parsers de Actions rechazan o tratan incorrectamente el BOM.
- Los mensajes de commit, titulos de issues y titulos de PR se escriben en ASCII. Si un titulo requiere acentos, se edita via la API con archivo JSON UTF-8 sin BOM, evitando el paso por linea de comandos de PowerShell 5.1.

## Consecuencias

Positivas:

- Elimina la clase de incidentes documentados en Contexto.
- Garantiza compatibilidad con herramientas que asumen UTF-8 sin BOM: parsers de YAML, Actions, git diff, gh CLI.
- Simplifica la revision: los archivos con BOM generan diffs espurios.

Negativas:

- Requiere disciplina en cada archivo nuevo. La regla no se autoverifica.
- Los colaboradores que usan herramientas Windows por defecto (Notepad antiguo, ciertas versiones de Excel) pueden reintroducir BOM.

Mitigacion:

- Anadir verificacion automatica de BOM en el workflow de CI (A07, #8).
- Documentar el procedimiento en docs/conventions/language.md.

## Alternativas descartadas

- UTF-8 con BOM: incompatible con parsers de Actions y con varias herramientas de linea de comandos. El BOM no aporta informacion en UTF-8.
- Latin-1 o ISO-8859-1: cubre menos caracteres que UTF-8. Incompatible con la documentacion trilingue adoptada en ADR-002.
- UTF-16: consume el doble de espacio, incompatible con la mayoria de herramientas Unix, sin ventajas para el caso.

## Referencias

- m11 en docs/reviews/2026-11-04-codereview-A02.md.
- R3 en docs/reviews/2026-11-04-codereview-A06.md.
- Issue #2.
- A07 (#8): higiene de CI incluye verificacion de BOM.