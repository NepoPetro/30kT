# ADR-002: Documentacao trilingue e estrutura docs/

## Estado

Aceito.

## Data

2026-11-09.

## Autora

Viki P. Sitzer (@mvikips). Funcoes em docs/conventions/attribution.md.

## Contexto

O projeto 30kT produz documentacao tecnica, metodologica e de governanca. A audiencia inclui pesquisadores de lingua espanhola, portuguesa e inglesa. Ate o momento, os documentos foram redigidos apenas em espanhol.

Necessita-se:

- Definir um idioma principal e seus equivalentes.
- Estabelecer uma estrutura de diretorios que permita publicar os documentos como HTML navegavel a partir de um index, servido por GitHub Pages.
- Sincronizar a documentacao do repositorio com a wiki do GitHub, mantendo a wiki como espelho navegavel.

## Decisao

Idioma principal: espanhol. Cada documento Markdown tem duas versoes adicionais: portugues e ingles. A nomenclatura e:

- arquivo.md para espanhol.
- arquivo-pt.md para portugues.
- arquivo-en.md para ingles.

Esta regra aplica-se a todo arquivo Markdown do repositorio: ADRs, convencoes, reviews, wiki mirror, index, documentos de resultado.

Estrutura de diretorios:

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

## Publicacao:

GitHub Pages e configurado em Settings, Pages, com source Deploy from branch, branch main, folder docs. A URL de publicacao e https://nepopetro.github.io/30kT/.

O arquivo docs/index.html gerado serve como home. Os links relativos entre arquivo.html, arquivo-pt.html e arquivo-en.html resolvem dentro da mesma arvore.

## Geracao de HTML:

O gerador estatico e escolhido em uma issue posterior (ver A07 #8). Candidatos avaliados: MkDocs Material com plugin i18n, Eleventy com colecoes i18n, script proprio. A decisao de gerador nao afeta a estrutura de fontes: os arquivos fonte sao os .md listados acima.

## Sincronizacao com GitHub wiki:

A wiki do GitHub e espelho navegavel de docs/wiki/. A fonte de verdade e docs/wiki/ no repositorio. A direcao de sincronizacao e repositorio para wiki. A wiki nao recebe edicoes diretas: qualquer mudanca e feita em docs/wiki/ e refletida na wiki por processo manual ou automatizado a definir em A07.

## Retroatividade:

Documentos criados antes deste ADR (codereviews A02 e A06) sao traduzidos em uma issue de backfill imediato (A15, a criar). Documentos novos (A04 em diante) nascem trilingues em seu PR original.

## Consequencias
### Positivas:

- Audiencia ampliada para os tres idiomas da pesquisa.
- Estrutura unica facilita a geracao de HTML e a navegacao a partir do index.
- Disciplina forcada: cada PR novo inclui suas tres versoes.
- A wiki mirror fica versionada, nao se perde se a wiki for desativada.

### Negativas:

-Triplica o volume de arquivos Markdown.
- Requer disciplina de traducao. Um PR monolingue quebra a convencao.
- A manutencao de tres versoes pode gerar drift se uma for atualizada e as outras nao.

## Mitigacao:

Verificacao em CI de que cada arquivo novo tem seus dois equivalentes (A07 #8).
Processo de traducao documentado em docs/conventions/language.md.
Marcacao de drift: se uma versao nao e atualizada, anota-se no arquivo com cabecalho Desatualizado em relacao a X ate que se sincronize.

## Alternativas descartadas
Apenas espanhol: exclui audiencia internacional, reduz o alcance do projeto.
Apenas ingles: exclui audiencia hispanofalante, principal idioma da pesquisa.
Traducao fora de banda em repositorio separado: duplica a gestao e diverge.
Pastas por idioma: as rotas relativas tornam-se complexas e a estrutura duplica diretorios. A convencao sufixo -pt, -en e mais simples e compativel com geradores.

## Referencias
ADR-001: codificacao UTF-8 sem BOM.
docs/conventions/language.md.
Issue #5 (A04).
Issue #8 (A07): higiene de CI inclui verificacao de traducoes.