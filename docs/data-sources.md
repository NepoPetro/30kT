# Fuentes de datos

## Proposito

Catalogo de fuentes oficiales y secundarias para el analisis de migracion, seguridad y datos abiertos en Argentina. Incluye fuentes especificas para verificar afirmaciones publicas del Poder Ejecutivo.

## Fuentes oficiales de prioridad alta

### datos.gob.ar

- API Series de Tiempo: https://apis.datos.gob.ar/series/api/
- Catalogo general: https://datos.gob.ar
- Dump completo de series: https://apis.datos.gob.ar/series/api/dump/

### INDEC

- Microdatos y bases de datos: https://www.indec.gob.ar/indec/web/Institucional-Indec-BasesDeDatos
- Censo 2022: resultados definitivos por radio censal, disponibles en datos.gob.ar y en el portal del INDEC.

### BCRA

- API de Estadisticas Monetarias v4.0: https://api.bcra.gob.ar/estadisticas/v4.0/

### Buenos Aires Data (CABA)

- Portal CKAN: https://data.buenosaires.gob.ar

### RENAPER

- Catalogos en datos.gob.ar: nacimientos, poblacion extranjera, estructura de poblacion, distribucion de apellidos, poblacion nacionalizada. Datos 2013-2023.
- Geoservicio WMS: https://poblacion.idear.gov.ar

### IGN

- Geoportal: http://mapa.ign.gob.ar

### Georef

- API: https://apis.datos.gob.ar/georef/api/
- Documentacion OpenAPI: https://www.argentina.gob.ar/datos-abiertos/georef/openapi

### datos.gba.gob.ar

- Catalogo CKAN: https://catalogo.datos.gba.gob.ar

### Migraciones

- Estadisticas migratorias: https://www.argentina.gob.ar/migraciones/estadisticas-movimientos-migratorios

### datos.jus.gob.ar

- Portal: https://datos.jus.gob.ar

### Ministerio de Seguridad

- Portal: https://www.argentina.gob.ar/seguridad

### SIDE - Archivos desclasificados

- https://www.argentina.gob.ar/inteligencia/archivos
- Documentos historicos 1973-1983. No operativos actuales. No publica series estadisticas.

## Fuentes oficiales de prioridad media

- datos.salud.gob.ar: portal de datos abiertos del Ministerio de Salud.
- datosgestionabierta.cba.gov.ar: datos abiertos de la Provincia de Cordoba.
- data.humdata.org: poblaciones desplazadas y refugiados.
- data.iadb.org: indicadores comparables para America Latina.

## Fuentes secundarias de prioridad media

- github.com/ramadis/delitos-caba: delitos de CABA. Fuente secundaria, contrastar con justicia.
- github.com/sandbox-ai/Jurisprudencia-Argentina: scraper y dataset del Sistema Argentino de Informacion Juridica.
- github.com/colossus-lab/openarg-frontend: agregador de portales oficiales. No es fuente primaria.
- github.com/Siguax/analisis-poblacion-extrangera-argentina: analisis de poblacion extranjera por provincia. Referencia metodologica.

## Fuentes descartadas

- github.com/I-portugal/dataset-sql-provincias-argentina: reemplazado por Georef.
- github.com/nahueldreher-star/nbi-argentina: reemplazado por INDEC.
- github.com/michelmichu123-blip/www.migracionargentina2026: sin dataset estructurado verificable.

## Verificacion de afirmaciones publicas

### Casos de terrorismo: informe Adorni

- Fuente oficial: Tramite Parlamentario N° 022 del 31 de marzo de 2026, Honorable Camara de Diputados. Pregunta N° 1942.
- URL: https://www2.hcdn.gob.ar/secparl/dsecretaria/s_t_parlamentario/tp.html?periodo=144&numero=022
- Dato oficial: 215 casos tramitados entre 2020 y 2025. 31 en tramite, 184 cerrados.
- Cobertura con reproduccion textual: https://www.lapoliticaonline.com/politica/desmienten-a-milei-sobre-la-cantidad-de-terroristas-serian-apenas-92-casos-para-casal-y-215-para-adorni-1620/

### Pedidos de juicio politico: expedientes oficiales

Pedidos de juicio politico presentados contra el Presidente desde diciembre de 2023. Ninguno obtuvo dictamen ni tratamiento en el recinto.

Expedientes con numero oficial en hcdn.gob.ar:

- 7905-D-2024, German Martinez (UxP), 20/02/2025. Caso $LIBRA.
- 7855-D-2024, Esteban Paulon, Monica Fein, Natalia de la Sota (Encuentro Federal / Socialismo), 17/02/2025. Caso $LIBRA.
- 7236-D-2025, Juan Marino (UxP). Ampliacion por $LIBRA y alineamiento belico (DNU 264/2026).
- 0997-D-2026, Juan Marino (UxP), 31/03/2026. Ampliacion del expediente 7236-D-2025.
- 1034-D-2026, Nestor Pitrola (FIT), 31/03/2026. Mal desempeno en funciones.
- 5387-D-2026, Monica Frade (Coherencia), 08/10/2026. Mal desempeno en funciones.

Pedidos adicionales sin expediente individual desagregado:

- Malvinas, abril 2025, Aldo Leiva (UxP). Declaraciones sobre soberania.
- Malvinas, abril 2025, Agustina Propato (UxP). Declaraciones sobre autodeterminacion.
- Brasil, julio 2026, Marcela Pagano (Coherencia). Dano a relaciones exteriores.

Referencia de conjunto con los siete pedidos: https://bardeo.news/

## Cifras a verificar

Cada afirmacion publica requiere contraste con fuente oficial.

- Deportaciones: las cifras publicas de 10000 y 20000 no coinciden con los registros de la Direccion Nacional de Migraciones. La serie de CAREF (organismo no gubernamental) registra 920 expulsiones efectivas en 2025 y 470 en el primer semestre de 2026. Las ordenes de expulsion dictadas en 2025 fueron 4787.
- Casos de terrorismo: el informe Adorni registra 215 casos, no 30000. La Fiscalia ha mencionado menos de 100 casos en tramite.
- Intentos de golpe de estado: los siete episodios que el Ejecutivo denomina golpes de estado corresponden a siete pedidos de juicio politico en la Comision de Juicio Politico de Diputados. No son golpes de estado en el sentido institucional.
- Destino de deportados: no hay datos oficiales publicos desagregados por pais de destino.
- Motivos de expulsion: datos 2025 de la DNM (drogas 44 por ciento, delitos contra la propiedad 29 por ciento, delitos contra la integridad sexual 10 por ciento, delitos contra las personas 6.5 por ciento). Ninguna por terrorismo.

## Actualizacion

Un cambio en este catalogo requiere PR. Se mantiene en tres idiomas (es, pt, en) segun ADR-002.

## Referencias

- ADR-001: docs/adr/ADR-001-encoding.md
- ADR-002: docs/adr/ADR-002-multilingue.md
- A04 (#5)
- A08 (#9): politica de datos personales.
- A10 (#10): gobernanza OSS.