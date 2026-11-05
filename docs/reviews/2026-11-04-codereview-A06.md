# Codereview A06 - Branch protection y seguridad del repositorio

## Identificacion

- Issue: #7
- Fecha: 2026-11-04
- Rama: a06-codereview
- Base: main @ 1020120
- Autor y revisor: Viki P. Sitzer @mvikips
- Roles: Data Architect, Stewardship & Governance, Tech Lead

## Alcance

Este documento cubre la aplicacion de branch protection sobre la rama main del repositorio NepoPetro/30kT como parte del Milestone A. Revisa decision, configuracion efectiva, riesgos y deuda derivada.

No cubre: workflows de CI (B02, #12), settings adicionales del repositorio (A05, #6), gobernanza OSS (A10, #10) ni politica de datos personales (A08, #9).

## Decision

Se protege main con las siguientes reglas activas:

| Regla | Valor | Justificacion |
|---|---|---|
| Pull request obligatorio | si | Ningun push directo a main, incluido admin. |
| enforce_admins | true | Sin bypass administrativo. El rol admin queda sujeto a las mismas reglas. |
| Aprobaciones requeridas | 0 | Bootstrap: un solo maintainer verificable. Restitucion a 1 cuando exista segundo revisor (D1). |
| dismiss_stale_reviews | true | Aprobaciones se descartan ante nuevo commit. Sin efecto mientras sean 0 requeridas; se mantiene por consistencia futura. |
| require_code_owner_reviews | false | Sin CODEOWNERS definido. Reevaluacion en A05 (D3). |
| require_last_push_approval | false | Sin segundo revisor, activarlo bloquearia el flujo. Reevaluar con D1. |
| required_linear_history | true | Squash o rebase obligatorio. Historial lineal facilita auditoria y revert. |
| allow_force_pushes | false | Previene reescritura de historia. |
| allow_deletions | false | Impide borrado de main. |
| required_conversation_resolution | true | Conversaciones resueltas antes de merge. |
| required_status_checks | null | Pendiente de B02 (#12). Se agrega contexto del job de CI cuando exista (D2). |
| lock_branch | false | Sin congelamiento. Reevaluar si se requiere freeze previo a release. |
| allow_fork_syncing | false | Sin fork sincronizado; irrelevante mientras no existan forks. |

## Riesgos identificados y tratamiento

### R1. Deadlock de bootstrap

Con enforce_admins true y required_approving_review_count 1, el unico maintainer no puede aprobar su propio PR (GitHub no lo permite) ni bypasear como admin. El repositorio queda en deadlock para mergear el primer PR.

Tratamiento: se aplico la configuracion inicialmente con 1 aprobacion, se detecto el deadlock y se ajusto a 0 aprobaciones requeridas. Resto de reglas permanece activa. Restitucion a 1 queda como deuda (D1).

### R2. Required status checks ausentes

Sin checks de CI configurados no hay gate tecnico previo al merge. El pull request obligatorio garantiza revision humana pero no ejecucion de tests ni verificacion de contenido.

Tratamiento: se acepta como deuda temporal. Depende de B02 (#12). Cuando B02 publique workflow y job name, se agrega required_status_checks con el contexto correspondiente (D2).

### R3. Tooling y encoding en Windows PowerShell 5.1

PowerShell 5.1 corrompe argumentos no-ASCII pasados a ejecutables nativos como gh. Se observo empiricamente: el titulo del issue #2 paso de o acentuada (bytes C3 B3) a signo de interrogacion ASCII (byte 3F) tras un gh issue edit --title con acento.

Tratamiento: regla operativa para el repositorio.
- Cuerpos de issues y PR: usar --body-file con archivo UTF-8 sin BOM generado por editor.
- Titulos: ASCII. Si se requiere acento, usar gh api --input con archivo JSON UTF-8 sin BOM.
- Verificacion: Format-Hex sobre la salida de gh para confirmar bytes.
- Documentos versionados: editar con editor, no construir strings en PowerShell.

## Deuda documentada

### D1. Restitucion de aprobaciones requeridas

required_approving_review_count esta en 0 por bootstrap. Condicion de cierre: existencia de un segundo revisor confiable con permisos de write.

Accion: actualizar la proteccion a required_approving_review_count 1 y require_last_push_approval true. Registrar el cambio en A11 (#11) y A10 (#10).

### D2. Required status checks

Pendiente de B02 (#12). Condicion de cierre: workflow de CI con job identificable.

Accion: agregar required_status_checks.contexts con el job name. No requiere reabrir A06; se registra como actualizacion de la proteccion.

### D3. Evaluacion de CODEOWNERS

require_code_owner_reviews esta en false. Condicion de reevaluacion: definicion de estructura de propiedad de archivos.

Accion: registrar como parte de A05 (#6) o ADR posterior.

## Reversibilidad

Desproteccion total de main: