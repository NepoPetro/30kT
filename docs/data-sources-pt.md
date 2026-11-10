# Fontes de dados

## Proposito

Catalogo de fontes oficiais e secundarias para a analise de migracao, seguranca e dados abertos na Argentina. Inclui fontes especificas para verificar afirmacoes publicas do Poder Executivo.

## Fontes oficiais de prioridade alta

### datos.gob.ar

- API Series de Tempo: https://apis.datos.gob.ar/series/api/
- Catalogo geral: https://datos.gob.ar
- Dump completo de series: https://apis.datos.gob.ar/series/api/dump/

### INDEC

- Microdados e bases de dados: https://www.indec.gob.ar/indec/web/Institucional-Indec-BasesDeDatos
- Censo 2022: resultados definitivos por radio censal, disponiveis em datos.gob.ar e no portal do INDEC.

### BCRA

- API de Estatisticas Monetarias v4.0: https://api.bcra.gob.ar/estadisticas/v4.0/

### Buenos Aires Data (CABA)

- Portal CKAN: https://data.buenosaires.gob.ar

### RENAPER

- Catalogos em datos.gob.ar: nascimentos, populacao estrangeira, estrutura de populacao, distribuicao de sobrenomes, populacao nacionalizada. Dados 2013-2023.
- Geoservico WMS: https://poblacion.idear.gov.ar

### IGN

- Geoportal: http://mapa.ign.gob.ar

### Georef

- API: https://apis.datos.gob.ar/georef/api/
- Documentacao OpenAPI: https://www.argentina.gob.ar/datos-abiertos/georef/openapi

### datos.gba.gob.ar

- Catalogo CKAN: https://catalogo.datos.gba.gob.ar

### Migracoes

- Estatisticas migratorias: https://www.argentina.gob.ar/migraciones/estadisticas-movimientos-migratorios

### datos.jus.gob.ar

- Portal: https://datos.jus.gob.ar

### Ministerio de Seguranca

- Portal: https://www.argentina.gob.ar/seguridad

### SIDE - Arquivos desclassificados

- https://www.argentina.gob.ar/inteligencia/archivos
- Documentos historicos 1973-1983. Nao operacionais atuais. Nao publica series estatisticas.

## Fontes oficiais de prioridade media

- datos.salud.gob.ar: portal de dados abertos do Ministerio da Saude.
- datosgestionabierta.cba.gov.ar: dados abertos da Provincia de Cordoba.
- data.humdata.org: populacoes deslocadas e refugiados.
- data.iadb.org: indicadores comparaveis para America Latina.

## Fontes secundarias de prioridade media

- github.com/ramadis/delitos-caba: delitos de CABA. Fonte secundaria, contrastar com justica.
- github.com/sandbox-ai/Jurisprudencia-Argentina: scraper e dataset do Sistema Argentino de Informacao Juridica.
- github.com/colossus-lab/openarg-frontend: agregador de portais oficiais. Nao e fonte primaria.
- github.com/Siguax/analisis-poblacion-extrangera-argentina: analise de populacao estrangeira por provincia. Referencia metodologica.

## Fontes descartadas

- github.com/I-portugal/dataset-sql-provincias-argentina: substituido por Georef.
- github.com/nahueldreher-star/nbi-argentina: substituido por INDEC.
- github.com/michelmichu123-blip/www.migracionargentina2026: sem dataset estruturado verificavel.

## Verificacao de afirmacoes publicas

### Casos de terrorismo: informe Adorni

- Fonte oficial: Tramite Parlamentario N° 022 de 31 de marco de 2026, Honorable Camara de Deputados. Pergunta N° 1942.
- URL: https://www2.hcdn.gob.ar/secparl/dsecretaria/s_t_parlamentario/tp.html?periodo=144&numero=022
- Dado oficial: 215 casos tramitados entre 2020 e 2025. 31 em tramite, 184 encerrados.
- Cobertura com reproducao textual: https://www.lapoliticaonline.com/politica/desmienten-a-milei-sobre-la-cantidad-de-terroristas-serian-apenas-92-casos-para-casal-y-215-para-adorni-1620/

### Pedidos de impeachment: expedientes oficiais

Pedidos de impeachment apresentados contra o Presidente desde dezembro de 2023. Nenhum obteve parecer nem tratamento em plenario.

Expedientes com numero oficial em hcdn.gob.ar:

- 7905-D-2024, German Martinez (UxP), 20/02/2025. Caso $LIBRA.
- 7855-D-2024, Esteban Paulon, Monica Fein, Natalia de la Sota (Encuentro Federal / Socialismo), 17/02/2025. Caso $LIBRA.
- 7236-D-2025, Juan Marino (UxP). Ampliacao por $LIBRA e alinhamento belico (DNU 264/2026).
- 0997-D-2026, Juan Marino (UxP), 31/03/2026. Ampliacao do expediente 7236-D-2025.
- 1034-D-2026, Nestor Pitrola (FIT), 31/03/2026. Mau desempenho em funcoes.
- 5387-D-2026, Monica Frade (Coherencia), 08/10/2026. Mau desempenho em funcoes.

Pedidos adicionais sem expediente individual desagregado:

- Malvinas, abril 2025, Aldo Leiva (UxP). Declaracoes sobre soberania.
- Malvinas, abril 2025, Agustina Propato (UxP). Declaracoes sobre autodeterminacao.
- Brasil, julho 2026, Marcela Pagano (Coherencia). Dano a relacoes exteriores.

Referencia de conjunto com os sete pedidos: https://bardeo.news/

## Cifras a verificar

Cada afirmacao publica requer contraste com fonte oficial.

- Deportacoes: as cifras publicas de 10000 e 20000 nao coincidem com os registros da Direcao Nacional de Migracoes. A serie de CAREF (organismo nao governamental) registra 920 expulsoes efetivas em 2025 e 470 no primeiro semestre de 2026. As ordens de expulsao ditadas em 2025 foram 4787.
- Casos de terrorismo: o informe Adorni registra 215 casos, nao 30000. A Procuradoria mencionou menos de 100 casos em tramite.
- Tentativas de golpe de estado: os sete episodios que o Executivo denomina golpes de estado correspondem a sete pedidos de impeachment na Comissao de Impeachment da Camara. Nao sao golpes de estado no sentido institucional.
- Destino de deportados: nao ha dados oficiais publicos desagregados por pais de destino.
- Motivos de expulsao: dados 2025 da DNM (drogas 44 por cento, delitos contra a propriedade 29 por cento, delitos contra a integridade sexual 10 por cento, delitos contra as pessoas 6.5 por cento). Nenhuma por terrorismo.

## Atualizacao

Uma alteracao neste catalogo requer PR. Mantem-se em tres idiomas (es, pt, en) conforme ADR-002.

## Referencias

- ADR-001: docs/adr/ADR-001-encoding-pt.md
- ADR-002: docs/adr/ADR-002-multilingue-pt.md
- A04 (#5)
- A08 (#9): politica de dados pessoais.
- A10 (#10): governanca OSS.