# Codereview A04 - Revision por archivo

## Identificacion

- Issue: #5
- Fecha: 2026-11-09
- Rama: a04-adr-conventions
- Autora y revisora: Viki P. Sitzer (@mvikips). Roles: Data Architect, Stewardship & Governance Tech Lead.

## Archivos del PR (24)

### docs/adr/

- ADR-001-encoding.md, -pt.md, -en.md: decision de codificacion UTF-8 sin BOM. Evidencia de tres incidentes. Alternativas descartadas. Verificado: estructura Nygard completa, referencias cruzadas a A07 y A02/A06.
- ADR-002-multilingue.md, -pt.md, -en.md: decision de documentacion trilingue y estructura docs/. Incluye convencion de nomenclatura, estructura de directorios, plan de publicacion, generador, wiki mirror y retroactividad.
- README.md, -pt.md, -en.md: indice del directorio de ADRs con formato, nomenclatura, proceso y estado de los dos ADRs actuales.

### docs/

- index.md, -pt.md, -en.md: home navegable con enlaces a subdirectorios, referencia a GitHub Pages y enlaces a ADR-001 y ADR-002.

### docs/conventions/

- language.md, -pt.md, -en.md: convencion de idioma, codificacion, nomenclatura, estilo de escritura, bloques de codigo sin comentarios, verificacion, excepciones.
- attribution.md, -pt.md, -en.md: autoria del proyecto, roles (Data Architect, Stewardship, Governance Tech Lead), cita de autoria por tipo de documento, contribuciones externas, cambios.

### docs/reviews/

- 2026-11-09-codereview-A04.md, -pt.md, -en.md: codereview principal del PR, con decisiones, riesgos R1-R5, deuda D1-D5.
- 2026-11-09-codereview-A04-por-archivo.md, -pt.md, -en.md: este documento.

## Verificacion por archivo

Cada uno de los 24 archivos:

- Codificacion UTF-8 sin BOM. Verificado por lectura de primeros tres bytes.
- Sin emojis.
- Sin comentarios dentro de bloques de codigo.
- Nomenclatura trilingue completa para cada documento base.
- Referencias cruzadas consistentes: los ADRs referencian convenciones y A07; el index referencia ADRs y convenciones; este documento referencia los 24 archivos del PR.

## Archivos no modificados pero afectados

### docs/reviews/2026-11-04-codereview-A02.md

Contiene bloques de codigo con comentarios internos. Bajo la nueva regla, deberia limpiarse. Queda como deuda D5.

### docs/reviews/2026-11-04-codereview-A06.md

Ya limpiado por PR #14. Cumple la nueva regla.

### README.md en raiz del repositorio

No se modifica en este PR. La referencia a SECURITY.md y la seccion de gobernanza se actualizan en A10 (#10) y A14 (#16).

## Aprobacion

Revision y aprobacion a cargo de la autora en sus roles de Data Architect, Stewardship & Governance Tech Lead.

Fecha: 2026-11-09.