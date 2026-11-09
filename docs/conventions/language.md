# Convencion de idioma y codificacion

## Idioma

Idioma principal: espanol. Cada documento Markdown tiene versiones en portugues (-pt) e ingles (-en).

Regla completa en ADR-002: docs/adr/ADR-002-multilingue.md.

## Codificacion

Todos los archivos se guardan en UTF-8 sin BOM. La regla completa esta en ADR-001: docs/adr/ADR-001-encoding.md.

## Nomenclatura de archivos

- archivo.md: espanol (principal).
- archivo-pt.md: portugues.
- archivo-en.md: ingles.

## Estilo de escritura

- Sin emojis en codigo, texto, issues, PRs, comentarios ni documentacion.
- Sin comentarios en el codigo. La explicacion va en prosa fuera del bloque de codigo.
- Fechas en formato ISO 8601: YYYY-MM-DD.
- Codigos, identificadores tecnicos y slugs en ASCII. Acentos solo en el cuerpo de texto.
- Titulos de issues, PRs y mensajes de commit en ASCII.

## Bloques de codigo

Los bloques de codigo en Markdown no incluyen comentarios. Toda aclaracion va en prosa antes o despues del bloque. Esta regla aplica a lenguajes donde el comentario es sintacticamente valido (PowerShell, bash, Python, YAML, JSON, JavaScript, SQL) y a lenguajes donde el comentario es convencional (Markdown, HTML).

Razon: los comentarios en bloques de codigo dentro de documentacion se copian a veces como comandos ejecutables. Un comentario que empieza con # o // en PowerShell, bash o YAML puede ejecutarse como comando si se copia mal.

## Verificacion

Antes de cada commit:

- Verificar que los archivos nuevos tengan sus equivalentes -pt y -en.
- Verificar ausencia de BOM en cada archivo nuevo.
- Verificar ausencia de emojis en el diff.
- Verificar ausencia de comentarios dentro de bloques de codigo en Markdown.

La automatizacion de estas verificaciones se incorpora en A07 (#8).

## Excepciones

Un archivo puede publicarse solo en espanol de forma temporal si cumple las tres condiciones siguientes:

- Es un archivo generado por script y no versionado como fuente.
- Es un archivo de trabajo en una rama no mergeada a main.
- Es un archivo de configuracion tecnica cuya version en otros idiomas no aporta valor.

En todos los casos, la excepcion se documenta en el PR con la justificacion.

## Referencias

- ADR-001: docs/adr/ADR-001-encoding.md.
- ADR-002: docs/adr/ADR-002-multilingue.md.
- Issue #8 (A07): higiene de CI incluye verificacion de estas reglas.