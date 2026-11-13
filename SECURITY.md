# Politica de seguridad

## Reporte de vulnerabilidades

Canal unico: GitHub Security Advisories del repositorio.

Crear un advisory privado en:

https://github.com/NepoPetro/30kT/security/advisories/new

El canal es privado entre la reportante y la mantenedora. No se aceptan reportes de vulnerabilidades por issues publicos, PRs, comentarios ni redes sociales, porque la divulgacion accidental antes de la correccion expone a terceros.

Las comunicaciones dentro del advisory se mantienen en el mismo hilo. No se solicita informacion por canales externos.

## Alcance

Este repositorio contiene documentacion de investigacion, catalogos de fuentes de datos, convenciones de gobernanza y scripts de verificacion. La superficie de ataque no es la de una aplicacion web en produccion, pero el repositorio maneja informacion cuya integridad, procedencia y confidencialidad importan.

Se considera vulnerabilidad cualquiera de los siguientes casos.

### 1. Exposicion de datos personales

- Datos personales de cualquier persona en archivos versionados, issues, PRs, wiki, comentarios o discusiones. Incluye nombre completo combinado con documento, direccion, telefono, email personal, fecha de nacimiento, datos de salud, datos biometricos o cualquier categoria que permita identificacion.
- Datos personales de terceros no consentidos, aun cuando sean publicos en otra fuente.
- Datos agregados que permitan reidentificacion por combinacion con otras fuentes.
- Capturas de pantalla, PDFs o imagenes que contengan datos personales no redactados.
- Metadatos de archivos (autor, ruta local, comentarios embebidos) que revelen informacion personal.

### 2. Integridad de datos

- Alteracion de datasets, catalogos de fuentes o documentos de resultados sin registro en el historial de git.
- Corrupcion silenciosa de archivos por encoding (BOM inyectado, mojibake, conversion no declarada).
- Modificacion de cifras o citas sin trazabilidad al cambio.
- Supresion de evidencia (borrado de archivos, force push, reescritura de historia) que impida auditar el estado anterior.
- Inconsistencia entre un documento y su version en otro idioma que altere el sentido.

### 3. Procedencia y atribucion

- Fuentes citadas incorrectamente o sin URL verificable.
- Atribucion falsa o incompleta de autoria.
- Catalogos de datos que incluyan fuentes no verificadas o eliminadas sin dejar registro.
- Ausencia de fecha de consulta o de version de la fuente en un dato citado.
- Uso de fuentes secundarias presentadas como primarias.

### 4. Credenciales y secretos

- Tokens, claves API, contrasenas, claves privadas o certificados en cualquier commit, actual o historico.
- Secretos en archivos de configuracion, workflows, variables de entorno versionadas o en la wiki.
- Secretos en logs de CI, artefactos o comentarios de bots.
- Patrones que sugieran fuga: claves con formato reconocible, URLs con parametros de autenticacion, cadenas base64 inusualmente largas en contexto sospechoso.

### 5. CI/CD y cadena de suministro

- Workflows de GitHub Actions con permisos excesivos sobre el repositorio u organizacion.
- Uso de actions de terceros no pinneadas por SHA de commit.
- Inyeccion de comandos en workflows a traves de campos controlables (titulos de issues, PRs, nombres de ramas, mensajes de commit).
- Dependencias con CVE conocidos o abandonadas.
- Riesgo de typosquatting en nombres de paquetes o actions.
- PRs maliciosos que busquen introducir cambios no revisados (por ejemplo, cambios en workflows que se autoaprueban).

### 6. Codigo y scripts

- Inyeccion de comandos en scripts PowerShell, bash o Python del repositorio.
- Ejecucion de codigo arbitrario a traves de entradas no validadas.
- Path traversal en scripts que manipulen archivos.
- Condiciones de carrera en scripts de verificacion o generacion.
- Scripts que escriban fuera del repositorio o con privilegios elevados sin justificacion.

### 7. Documentacion y contenido

- Instrucciones que, seguidas al pie de la letra, expongan datos personales, credenciales o permitan ejecucion de codigo no intencional.
- Enlaces a recursos externos que puedan cambiar de destino y afectar la integridad del contenido (link rot con reemplazo malicioso).
- Bloques de codigo copiables que incluyan comentarios ejecutables por error.
- Omision de advertencias sobre riesgos al ejecutar comandos destructivos.

### 8. Acceso y permisos

- Configuracion de branch protection o rulesets que permita saltar controles.
- Aprobaciones requeridas deshabilitadas sin justificacion.
- Bypass de administradores cuando no corresponde.
- Permisos de escritura otorgados a colaboradores sin necesidad.

## Modelo de amenazas

Actores considerados:

- Contribuyente externo malicioso: busca introducir cambios no revisados, exfiltrar informacion o degradar la integridad del repositorio.
- Actor que reporta de buena fe pero divulga de forma inapropiada: publica detalles antes de la correccion.
- Compromiso de cuenta: acceso no autorizado a la cuenta de la mantenedora o a la organizacion.
- Dependencia comprometida: paquete o action de terceros que cambia de comportamiento.
- Fuente de datos alterada: una fuente oficial externa que modifica su contenido despues de la cita.

Motivaciones plausibles: desacreditar la investigacion, manipular cifras, exponer a personas mencionadas en los datos, obtener credito sin trabajo, dano reputacional.

## Superficie de ataque:

- Repositorio (archivos versionados e historial).
- Issues, PRs, wiki, discusiones.
- Workflows de GitHub Actions.
- Dependencias de terceros.
- Fuentes externas citadas.

## Fuera de alcance

- Vulnerabilidades en la infraestructura de GitHub (se reportan a GitHub, no a este repositorio).
- Vulnerabilidades en las fuentes oficiales externas (se reportan a cada organismo).
- Errores tipograficos o de estilo sin impacto en integridad, procedencia o confidencialidad.
- Solicitudes de funcionalidad o cambios de contenido editoriales (van por issues normales).
- Discusiones metodologicas sobre los datos (van por issues, no por advisory).
- Ataques fisicos o de ingenieria social fuera del repositorio.

## Plazos de respuesta

- Acuse de recibo del reporte: 48 horas.
- Evaluacion inicial (confirmacion de que se considera dentro de alcance): 5 dias habiles.
- Resolucion segun severidad:
  - Critica (datos personales expuestos, credenciales comprometidas): 7 dias.
  - Alta (integridad de datos alterada, procedencia falsa): 30 dias.
  - Media (configuracion debil, documentacion riesgosa): 90 dias.
  - Baja (mejora de practica, sin impacto inmediato): proximo release.

Los plazos son objetivos, no garantias. Si no se puede cumplir un plazo, se comunica dentro del advisory con justificacion y nueva fecha estimada.

## Divulgacion responsable

- Embargo de 90 dias desde el acuse de recibo, o hasta la publicacion de la correccion, lo que ocurra primero.
- Si la correccion requiere mas tiempo, se acuerda extension con la reportante.
- Si la reportante desea divulgar antes del plazo, se coordina. No se toman represalias por divulgacion coordinada.
- La correccion se publica con referencia al advisory y reconocimiento a la reportante si lo autoriza.

## Reconocimiento

La reportante que lo desee se acredita en el advisory y en el commit de correccion. Si prefiere anonimato, se respeta.

**No hay recompensa economica. El reconocimiento es reputacional.**

## Roles y responsabilidades

Data Architect, Stewardship & Governance Tech Lead (Viki P. Sitzer, @mvikips):

- Custodia la integridad, procedencia y confidencialidad de los datos y la documentacion.
- Recibe y evalua los reportes.
- Define la severidad y los plazos.
- Coordina la correccion y la divulgacion.
- Registra la trazabilidad de cada cambio derivado de un reporte.

Las responsabilidades de stewardship incluyen verificar que las fuentes citadas sigan siendo accesibles, que las cifras publicadas coincidan con las fuentes oficiales, y que ningun dato personal de terceros quede expuesto en el repositorio o en su historial.

## Referencias cruzadas

- Politica de datos personales: docs/issues #9 (A08).
- Gobernanza OSS (NOTICE, CITATION, CONTRIBUTING): #10 (A10).
- Catalogo de fuentes y procedencia: docs/data-sources.md.
- Codificacion UTF-8 sin BOM: docs/adr/ADR-001-encoding.md.
- Documentacion multilingue: docs/adr/ADR-002-multilingue.md.
- Branch protection y proteccion de tags: docs/conventions/branch-protection.md y docs/conventions/tags.md.

## Cambios a este documento

Un cambio en el alcance, los plazos o el canal de reporte requiere PR con justificacion. Se mantiene en tres idiomas (es, pt, en) segun ADR-002. La version que GitHub muestra en la pestana Security es SECURITY.md (espanol).