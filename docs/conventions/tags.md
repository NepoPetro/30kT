# Convencion de tags

## Proposito

Define el esquema de versionado por tags del repositorio 30kT y las reglas de proteccion aplicadas sobre ellos.

## Formato

v<major>.<minor>.<patch>-<milestone>

- v: prefijo literal obligatorio.
- major: entero, se incrementa ante cambio incompatible de estructura o datos.
- minor: entero, se incrementa ante nueva funcionalidad compatible.
- patch: entero, se incrementa ante correccion compatible.
- milestone: letra del milestone de origen en minuscula (a, b, c, d, e, f, g).

## Ejemplos validos

- v0.1.0-a02
- v0.1.0-a06
- v0.1.0-a16
- v0.2.0-a07
- v1.0.0-g01

## Ejemplos invalidos

- 0.1.0-a02 (falta prefijo v)
- v0.1-a02 (falta patch)
- v0.1.0 (falta milestone)
- v0.1.0-A02 (milestone en mayuscula)
- v0.1.0-a (milestone vacio)
- v0.1.0-a02-hotfix (sufijo no permitido)

## Relacion con milestones

Cada tag cierra el estado del repositorio al finalizar un milestone. El sufijo indica el milestone correspondiente segun la nomenclatura del proyecto:

- a: Organizacion inicial y alcance.
- b: Fuente primaria y marco documental.
- c: Arquitectura y trazabilidad.
- d: Notebook y respaldo matematico.
- e: Resultados y comunicacion.
- f: Documentos interdisciplinarios.
- g: Publicacion y cierre.

Un tag se crea al cerrar el ultimo issue del milestone. No se crea tag por issue individual.

## Creacion

El tag se crea sobre un commit de main, nunca sobre una rama de trabajo ni sobre un commit no mergeado.

```bash
git tag -a v0.1.0-a02 -m "Cierre del Milestone A"
git push origin v0.1.0-a02
```
El mensaje sigue el formato "Cierre del Milestone X" donde X es la letra en mayuscula.

## Proteccion

Los tags que coinciden con el patron v* estan protegidos contra borrado y modificacion. La proteccion se aplica via rulesets de GitHub y se verifica en este documento.

## Configuracion actual:

```bash
gh api repos/NepoPetro/30kT/rulesets
```

Debe listar la regla proteger-tags-v con target tag y enforcement active.

Si la proteccion falta o debe restablecerse, se aplica con el archivo ruleset-tags.json:

```bash
gh api -X POST repos/NepoPetro/30kT/rulesets --input ruleset-tags.json
```
La operacion requiere permisos de administracion sobre el repositorio.

## Configuracion:

```bash
gh api repos/NepoPetro/30kT/tags/protection
```
Debe devolver la regla que cubre v*.

Si la proteccion falta o debe restablecerse:

```bash
gh api -X POST repos/NepoPetro/30kT/tags/protection -f pattern="v*"
```
La operacion requiere permisos de administracion sobre el repositorio.

## Verificacion
Para verificar que un tag existente esta intacto:

```bash
git ls-remote --tags origin
```
La salida debe listar los tags esperados. Un tag creado no debe modificarse. Si se requiere corregir algo de un release ya tagueado, se crea un nuevo tag con patch incrementado, no se reescribe el anterior.

## Referencias
- ADR-001: docs/adr/ADR-001-encoding.md
- ADR-002: docs/adr/ADR-002-multilingue.md
- A13 (#15)
- A06 (#7)
- A10 (#10): politica de releases.

## Excepciones historicas

El tag v.0001 fue creado antes de la adopcion de esta convencion y no cumple el formato. Se elimino el 2026-11-11 sin reemplazo. No se crea un tag equivalente porque no corresponde a un cierre de milestone. La regla aplica hacia adelante.
