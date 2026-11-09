# ADR-002: Documentacion multilingue y estructura docs/

## Estado

Aceptado.

## Fecha

2026-11-09.

## Autora

Viki P. Sitzer (@mvikips). Roles en docs/conventions/attribution.md.

## Contexto

El proyecto 30kT produce documentacion tecnica, metodologica y de gobernanza. La audiencia incluye investigadores de habla hispana, portuguesa e inglesa. Hasta el momento, los documentos se redactaron solo en espanol.

Se necesita:

- Definir un idioma principal y sus equivalentes.
- Establecer una estructura de directorios que permita publicar los documentos como HTML navegable desde un index, servido por GitHub Pages.
- Sincronizar la documentacion del repositorio con la wiki de GitHub, manteniendo la wiki como espejo navegable.

## Decision

Idioma principal: espanol. Cada documento Markdown tiene dos versiones adicionales: portugues e ingles. La nomenclatura es:

- archivo.md para espanol.
- archivo-pt.md para portugues.
- archivo-en.md para ingles.

Esta regla aplica a todo archivo Markdown del repositorio: ADRs, convenciones, reviews, wiki mirror, index, documentos de resultado.

Estructura de directorios:

```text
docs/
  index.md, index-pt.md, index-en.md
  adr/
    ADR-001-encoding.md, -pt, -en
    ADR-002-multilingue.md, -pt, -en
    README.md, -pt, -en
  conventions/
    language.md, -pt, -en
    attribution.md, -pt, -en
  reviews/
    2026-11-04-codereview-A02.md, -pt, -en
    2026-11-04-codereview-A06.md, -pt, -en
    2026-11-09-codereview-A04.md, -pt, -en
  wiki/
    Home.md, -pt, -en

## Publicacion:

GitHub Pages se configura en Settings, Pages, con source Deploy from branch, branch main, folder docs. La URL de publicacion es https://nepopetro.github.io/30kT/.

El archivo docs/index.html generado sirve como home. Los links relativos entre archivo.html, archivo-pt.html y archivo-en.html resuelven dentro del mismo arbol.

## Generacion de HTML:

El generador estatico se elige en un issue posterior (ver A07 #8). Candidatos evaluados: MkDocs Material con plugin i18n, Eleventy con colecciones i18n, script propio. La decision de generador no afecta la estructura de fuentes: los archivos fuente son los .md listados arriba.

## Sincronizacion con GitHub wiki:

La wiki de GitHub es espejo navegable de docs/wiki/. La fuente de verdad es docs/wiki/ en el repositorio. La direccion de sincronizacion es repositorio a wiki. La wiki no recibe ediciones directas: cualquier cambio se hace en docs/wiki/ y se refleja en la wiki por proceso manual o automatizado a definir en A07.

## Retroactividad:

Los documentos creados antes de este ADR (codereviews A02 y A06) se traducen en un issue de backfill inmediato (A15, a crear). Los documentos nuevos (A04 en adelante) nacen trilingues en su PR original.

## Consecuencias
### Positivas:

- Audiencia ampliada a los tres idiomas de la investigacion.
- Estructura unica facilita la generacion de HTML y la navegacion desde index.
- Disciplina forzada: cada PR nuevo incluye sus tres versiones.
- La wiki mirror queda versionada, no se pierde si la wiki se desactiva.

### Negativas:

- Triplica el volumen de archivos Markdown.
- Requiere disciplina de traduccion. Un PR monoingue rompe la convencion.
- El mantenimiento de tres versiones puede generar drift si una se actualiza y las otras no.

## Mitigacion:

Verificacion en CI de que cada archivo nuevo tiene sus dos equivalentes (A07 #8).
Proceso de traduccion documentado en docs/conventions/language.md.
Marcado de drift: si una version no se actualiza, se anota en el archivo con encabezado Desactualizado respecto de X hasta que se sincronice.

## Alternativas descartadas
Solo espanol: excluye audiencia internacional, reduce alcance del proyecto.
Solo ingles: excluye audiencia hispanohablante, principal idioma de la investigacion.
Traduccion fuera de banda en repositorio separado: duplica la gestion y diverge.
Carpetas por idioma: las rutas relativas se vuelven complejas y la estructura duplica directorios. La convencion sufijo -pt, -en es mas simple y compatible con generadores.

## Referencias
ADR-001: codificacion UTF-8 sin BOM.
docs/conventions/language.md.
Issue #5 (A04).
Issue #8 (A07): higiene de CI incluye verificacion de traducciones.