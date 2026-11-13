# Convencion de proteccion de la rama main

## Proposito

Documenta la configuracion de proteccion aplicada sobre la rama main del repositorio 30kT, la justificacion de cada regla, y los procedimientos de verificacion y cambio.

## Estado actual

La proteccion se aplica mediante dos mecanismos coexistentes:

- Ruleset de repositorio identificado como main, target branch, enforcement active, creado el 2026-11-01.
- Configuracion clasica de branch protection sobre main, aplicada via API el 2026-11-04.

La coexistencia es heredada de la evolucion del repositorio. La consolidacion en un solo mecanismo (rulesets) se aborda en A07 (#8). Mientras tanto, ambas configuraciones estan activas y se complementan.

## Reglas aplicadas

Cada fila indica la regla, su valor actual, y la justificacion.

| Regla | Valor | Justificacion |
|---|---|---|
| Pull request obligatorio | si | Ningun push directo a main, incluida la mantenedora. |
| enforce_admins | true | Sin bypass administrativo. La mantenedora queda sujeta a las mismas reglas. |
| Aprobaciones requeridas | 0 | Bootstrap mientras exista una sola mantenedora verificable. Restitucion a 1 es deuda D1. |
| dismiss_stale_reviews | true | Aprobaciones descartadas ante nuevo commit. Sin efecto con 0 requeridas, pero se mantiene por consistencia futura. |
| require_code_owner_reviews | false | Sin CODEOWNERS definido. Reevaluacion en A05 (#6) es deuda D3. |
| require_last_push_approval | false | Bloquearia el flujo con una sola mantenedora. Reevaluar junto con D1. |
| required_linear_history | true | Squash o rebase obligatorio. Historial lineal facilita auditoria y revert. |
| allow_force_pushes | false | Previene reescritura de historia. |
| allow_deletions | false | Impide borrado de main. |
| required_conversation_resolution | true | Conversaciones resueltas antes del merge. |
| required_status_checks | null | Pendiente de B02 (#12). Se agrega el contexto del job de CI cuando exista. Deuda D2. |
| lock_branch | false | Sin congelamiento. Reevaluar si se requiere freeze previo a release. |
| allow_fork_syncing | false | Sin forks sincronizados. Sin efecto practico mientras no existan forks. |

## Justificacion de las decisiones criticas

### enforce_admins true

Un repositorio de investigacion que publica resultados verificables necesita que la historia sea auditable sin excepciones. Si la mantenedora puede bypasear la proteccion, la garantia es condicional a su criterio. Con enforce_admins true, cada cambio a main, incluido el de la mantenedora, queda mediado por un PR y por los checks configurados. La proteccion deja de depender de la disciplina y pasa a depender del sistema.

### Aprobaciones en 0 por bootstrap

GitHub no permite autoaprobar PRs. Con una sola mantenedora y required_approving_review_count mayor a 0, el repositorio queda en deadlock: no hay forma de mergear el primer PR. La restitucion a 1 requiere que exista una segunda persona con permisos de write. Condicion de cierre en deuda D1.

### Linear history

Los merge commits agregan ramas paralelas en el grafo que dificultan el audit. Squash o rebase producen una historia lineal donde cada commit en main corresponde a un PR mergeado. Esto es especialmente relevante para un repositorio cuyos artefactos son evidencia de un procedimiento: la trazabilidad entre commit y PR es directa.

### Conversation resolution

Un PR puede quedar abierto con comentarios pendientes. El flag obliga a resolverlos antes del merge. Sin esto, las conversaciones abiertas quedan enterradas por el merge y se pierden.

## Deuda documentada

### D1. Aprobaciones requeridas

Estado: 0. Condicion de cierre: existencia de segunda persona con permisos de write.

Accion: cambiar required_approving_review_count a 1 y require_last_push_approval a true. Documentar el cambio en este archivo y en A11 (#11).

### D2. Required status checks

Estado: null. Condicion de cierre: workflow de CI con job identificable (B02 #12).

Accion: agregar required_status_checks.contexts con el nombre del job.

### D3. CODEOWNERS

Estado: no definido. Condicion de cierre: estructura de propiedad de archivos (A05 #6 o ADR posterior).

Accion: definir CODEOWNERS, activar require_code_owner_reviews.

### D4. Consolidacion de mecanismos

Estado: coexisten ruleset main y branch protection clasica. Condicion de cierre: migracion completa a rulesets.

Accion: A07 (#8) consolida en rulesets, que son el mecanismo recomendado por GitHub desde 2023.

## Verificacion

Para verificar la configuracion clasica:

```bash
gh api repos/NepoPetro/30kT/branches/main/protection
```
Debe mostrar enforce_admins enabled, required_linear_history enabled, allow_force_pushes disabled, allow_deletions disabled, required_conversation_resolution enabled, required_approving_review_count 0.

## Para verificar el ruleset:

```bash
gh api repos/NepoPetro/30kT/rulesets | ConvertFrom-Json | Select-Object id, name, target, enforcement
```
Debe mostrar al menos una regla con target branch y enforcement active.

Para verificar que la proteccion rechaza push directo a main (prueba destructiva, no ejecutar sin entender):

```bash
git push origin main:main --force
```
Debe fallar con error de protected branch. No ejecutar salvo que se necesite confirmar el rechazo.

## Cambio de la configuracion
Un cambio en la configuracion de proteccion requiere:

- PR a este archivo con la justificacion.
- Justificacion escrita del cambio y su impacto en la auditabilidad.
- Registro del cambio en el issue correspondiente.
- Verificacion post-cambio con el GET correspondiente.

Los cambios deben ser reversibles. Cualquier desproteccion, incluso temporal, se documenta con motivo, duracion y restauracion.

## Referencias
- ADR-001: docs/adr/ADR-001-encoding.md.
- ADR-002: docs/adr/ADR-002-multilingue.md.
- Convencion de tags: docs/conventions/tags.md.
- A06 (#7): branch protection y seguridad del repositorio.
- A07 (#8): higiene de CI, incluye consolidacion a rulesets.
- A11 (#11): criterios de aceptacion del proyecto.
- SECURITY.md: canal de reporte de vulnerabilidades.