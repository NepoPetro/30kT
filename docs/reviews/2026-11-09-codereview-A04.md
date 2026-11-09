# Codereview A04 - ADRs, convenciones y estructura docs/

## Identificacion

- Issue: #5
- Fecha: 2026-11-09
- Rama: a04-adr-conventions
- Base: main @ 1fff4de
- Autora y revisora: Viki P. Sitzer (@mvikips). Roles: Data Architect, Stewardship & Governance Tech Lead.

## Alcance

Este documento cubre el PR de A04 (#5), que incorpora:

- ADR-001: codificacion UTF-8 sin BOM.
- ADR-002: documentacion multilingue y estructura docs/.
- Convencion de idioma y codificacion.
- Convencion de atribucion y roles.
- Index de navegacion para docs/.
- Este codereview y su version por archivo.

No cubre: configuracion de GitHub Pages (deuda D1), backfill de traducciones de A02 y A06 (deuda D2), verificacion automatica en CI (deuda D3), sincronizacion con la wiki (deuda D4).

## Decisiones incorporadas

### ADR-001: UTF-8 sin BOM

Codificacion obligatoria para todo archivo del repositorio. Evidencia: tres incidentes registrados (m11 de A02, R3 de A06, incidente #2). El ADR documenta decision, consecuencias, alternativas descartadas y referencias.

### ADR-002: multilingue y estructura docs/

Idioma principal espanol, versiones -pt y -en para cada documento. Estructura docs/ con subdirectorios adr/, conventions/, reviews/, wiki/. Compatible con publicacion via GitHub Pages con source en docs/.

La decision se autoinstancia: este PR nace trilingue, cumpliendo el propio ADR.

## Riesgos identificados y tratamiento

### R1. Drift de traducciones

Con tres versiones por documento, una actualizacion en una sola version genera inconsistencia. El ADR-002 lo reconoce y propone marcado de drift con encabezado Desactualizado respecto de X hasta sincronizacion.

Tratamiento: la convencion de idioma y el ADR-002 explicitan el mecanismo. La verificacion automatica queda como deuda D3.

### R2. Generador HTML no elegido

GitHub Pages requiere un generador para transformar .md en .html navegable. El ADR-002 lista candidatos (MkDocs Material, Eleventy, script propio) pero no elige uno.

Tratamiento: deuda D1. La decision de generador no afecta la estructura de fuentes, asi que el PR es valido sin elegirlo. Se resuelve en A07 (#8).

### R3. Backfill de documentos existentes

Los codereviews A02 y A06 estan solo en espanol. Bajo ADR-002 deberian tener versiones -pt y -en. El PR no los traduce.

Tratamiento: deuda D2. Se crea issue A15 de backfill inmediato tras el merge de A04. El codereview A02 tambien contiene bloques de codigo con comentarios internos (deuda D5).

### R4. Regla de codigo sin comentarios vs documentos previos

La convencion de idioma y codificacion establece que los bloques de codigo en Markdown no llevan comentarios. Los codereviews A02 y A06 fueron escritos antes de la regla y contienen bloques con comentarios.

Tratamiento: deuda D5. No se modifica retroactivamente porque los codereviews son registro historico. La regla aplica hacia adelante. El codereview A06 fue limpiado por PR #14, pero quedan lineas en A02.

### R5. Tooling PowerShell 5.1

El entorno local de autoria usa PowerShell 5.1, que corrompe argumentos no-ASCII pasados a gh. El ADR-001 y la convencion de idioma documentan la mitigacion: titulos ASCII, cuerpos con --body-file, edicion de titulos con acentos via API con archivo JSON.

Tratamiento: mitigacion incorporada en convenciones. No hay deuda tecnica en el repositorio, la regla vive en la convencion.

## Deuda documentada

### D1. Generador HTML y configuracion de Pages

GitHub Pages no esta configurado todavia. El ADR-002 especifica source en docs/, pero falta la configuracion efectiva en Settings y la eleccion del generador estatico.

Condicion de cierre: settings de Pages configurados y primer build exitoso.

Accion: A05 (#6) puede incluir la configuracion. La eleccion de generador va a A07 (#8).

### D2. Backfill de traducciones A02 y A06

Los codereviews A02 y A06 no tienen versiones -pt ni -en.

Condicion de cierre: ocho archivos nuevos (cuatro por cada codereview, sin contar los existentes).

Accion: crear issue A15 inmediatamente despues del merge de A04.

### D3. Verificacion automatica de convenciones

Las reglas de ADR-001 (sin BOM) y ADR-002 (traducciones) no se autoverifican. Falta verificacion en CI.

Condicion de cierre: workflow que rechace PRs con archivos sin sus equivalentes -pt/-en y archivos con BOM.

Accion: A07 (#8).

### D4. Sincronizacion con GitHub wiki

El ADR-002 establece docs/wiki/ como fuente de verdad y la wiki como espejo. No existe el directorio docs/wiki/ ni el proceso de sincronizacion.

Condicion de cierre: docs/wiki/ creado con al menos Home en tres idiomas, proceso de sync definido.

Accion: A07 (#8) o issue nuevo.

### D5. Codereview A02 con comentarios en bloques de codigo

El codereview A02 contiene bloques de codigo con comentarios internos, en contra de la convencion de idioma y codificacion.

Condicion de cierre: revision de A02 sin comentarios en bloques.

Accion: puede resolverse junto con D2 (backfill de traducciones), en el mismo PR.

## Verificacion

Los 24 archivos del PR cumplen:

- Codificacion UTF-8 sin BOM, verificado con lectura de primeros tres bytes en cada archivo.
- Sin emojis en texto.
- Sin comentarios en bloques de codigo.
- Nomenclatura trilingue (base, -pt, -en) en todos los documentos.
- Referencias cruzadas consistentes entre ADRs, convenciones, index y este codereview.

## Aprobacion

Revision y aprobacion a cargo de la autora en sus roles de Data Architect, Stewardship & Governance Tech Lead.

Fecha: 2026-11-09.