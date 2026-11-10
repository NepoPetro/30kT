# Data sources

## Purpose

Catalog of official and secondary sources for the analysis of migration, security and open data in Argentina. Includes specific sources to verify public statements by the Executive Branch.

## Official high-priority sources

### datos.gob.ar

- Time Series API: https://apis.datos.gob.ar/series/api/
- General catalog: https://datos.gob.ar
- Full series dump: https://apis.datos.gob.ar/series/api/dump/

### INDEC

- Microdata and databases: https://www.indec.gob.ar/indec/web/Institucional-Indec-BasesDeDatos
- 2022 Census: definitive results by census tract, available at datos.gob.ar and the INDEC portal.

### BCRA

- Monetary Statistics API v4.0: https://api.bcra.gob.ar/estadisticas/v4.0/

### Buenos Aires Data (CABA)

- CKAN portal: https://data.buenosaires.gob.ar

### RENAPER

- Catalogs at datos.gob.ar: births, foreign population, population structure, surname distribution, naturalized population. Data 2013-2023.
- WMS geoservice: https://poblacion.idear.gov.ar

### IGN

- Geoportal: http://mapa.ign.gob.ar

### Georef

- API: https://apis.datos.gob.ar/georef/api/
- OpenAPI documentation: https://www.argentina.gob.ar/datos-abiertos/georef/openapi

### datos.gba.gob.ar

- CKAN catalog: https://catalogo.datos.gba.gob.ar

### Migrations

- Migration statistics: https://www.argentina.gob.ar/migraciones/estadisticas-movimientos-migratorios

### datos.jus.gob.ar

- Portal: https://datos.jus.gob.ar

### Ministry of Security

- Portal: https://www.argentina.gob.ar/seguridad

### SIDE - Declassified archives

- https://www.argentina.gob.ar/inteligencia/archivos
- Historical documents 1973-1983. Not current operational data. Does not publish statistical series.

## Official medium-priority sources

- datos.salud.gob.ar: open data portal of the Ministry of Health.
- datosgestionabierta.cba.gov.ar: open data of Cordoba Province.
- data.humdata.org: displaced populations and refugees.
- data.iadb.org: comparable indicators for Latin America.

## Secondary medium-priority sources

- github.com/ramadis/delitos-caba: CABA crime data. Secondary source, contrast with justice data.
- github.com/sandbox-ai/Jurisprudencia-Argentina: scraper and dataset of the Argentine Legal Information System.
- github.com/colossus-lab/openarg-frontend: aggregator of official portals. Not a primary source.
- github.com/Siguax/analisis-poblacion-extrangera-argentina: analysis of foreign population by province. Methodological reference.

## Discarded sources

- github.com/I-portugal/dataset-sql-provincias-argentina: replaced by Georef.
- github.com/nahueldreher-star/nbi-argentina: replaced by INDEC.
- github.com/michelmichu123-blip/www.migracionargentina2026: no verifiable structured dataset.

## Verification of public statements

### Terrorism cases: Adorni report

- Official source: Parliamentary Record N° 022 of March 31, 2026, Honorable Chamber of Deputies. Question N° 1942.
- URL: https://www2.hcdn.gob.ar/secparl/dsecretaria/s_t_parlamentario/tp.html?periodo=144&numero=022
- Official data: 215 cases filed between 2020 and 2025. 31 in progress, 184 closed.
- Coverage with textual reproduction: https://www.lapoliticaonline.com/politica/desmienten-a-milei-sobre-la-cantidad-de-terroristas-serian-apenas-92-casos-para-casal-y-215-para-adorni-1620/

### Impeachment requests: official records

Impeachment requests filed against the President since December 2023. None obtained committee report or floor treatment.

Records with official number at hcdn.gob.ar:

- 7905-D-2024, German Martinez (UxP), 20/02/2025. $LIBRA case.
- 7855-D-2024, Esteban Paulon, Monica Fein, Natalia de la Sota (Encuentro Federal / Socialismo), 17/02/2025. $LIBRA case.
- 7236-D-2025, Juan Marino (UxP). Expansion for $LIBRA and belligerent alignment (DNU 264/2026).
- 0997-D-2026, Juan Marino (UxP), 31/03/2026. Expansion of record 7236-D-2025.
- 1034-D-2026, Nestor Pitrola (FIT), 31/03/2026. Misconduct in office.
- 5387-D-2026, Monica Frade (Coherencia), 08/10/2026. Misconduct in office.

Additional requests without disaggregated individual record:

- Malvinas, April 2025, Aldo Leiva (UxP). Statements on sovereignty.
- Malvinas, April 2025, Agustina Propato (UxP). Statements on self-determination.
- Brazil, July 2026, Marcela Pagano (Coherencia). Damage to foreign relations.

Reference for the seven requests as a set: https://bardeo.news/

## Figures to verify

Each public statement requires contrast with an official source.

- Deportations: public figures of 10000 and 20000 do not match National Migration Directorate records. The CAREF series (non-governmental organization) records 920 effective expulsions in 2025 and 470 in the first half of 2026. Expulsion orders issued in 2025 were 4787.
- Terrorism cases: the Adorni report records 215 cases, not 30000. The Prosecutor's Office has mentioned fewer than 100 cases in progress.
- Coup attempts: the seven episodes the Executive calls coups correspond to seven impeachment requests in the Chamber's Impeachment Committee. They are not coups in the institutional sense.
- Destination of deportees: no disaggregated public official data by destination country.
- Grounds for expulsion: 2025 DNM data (drugs 44 percent, property crimes 29 percent, sexual integrity crimes 10 percent, crimes against persons 6.5 percent). None for terrorism.

## Update

A change to this catalog requires a PR. Maintained in three languages (es, pt, en) per ADR-002.

## References

- ADR-001: docs/adr/ADR-001-encoding-en.md
- ADR-002: docs/adr/ADR-002-multilingue-en.md
- A04 (#5)
- A08 (#9): personal data policy.
- A10 (#10): OSS governance.