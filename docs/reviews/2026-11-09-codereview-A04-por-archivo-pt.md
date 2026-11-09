# Codereview A04 - Revisao por arquivo

## Identificacao

- Issue: #5
- Data: 2026-11-09
- Branch: a04-adr-conventions
- Autora e revisora: Viki P. Sitzer (@mvikips). Funcoes: Data Architect, Stewardship & Governance Tech Lead.

## Arquivos do PR (24)

### docs/adr/

- ADR-001-encoding.md, -pt.md, -en.md: decisao de codificacao UTF-8 sem BOM. Evidencia de tres incidentes. Alternativas descartadas. Verificado: estrutura Nygard completa, referencias cruzadas a A07 e A02/A06.
- ADR-002-multilingue.md, -pt.md, -en.md: decisao de documentacao trilingue e estrutura docs/. Inclui convencao de nomenclatura, estrutura de diretorios, plano de publicacao, gerador, wiki mirror e retroatividade.
- README.md, -pt.md, -en.md: indice do diretorio de ADRs com formato, nomenclatura, processo e estado dos dois ADRs atuais.

### docs/

- index.md, -pt.md, -en.md: home navegavel com links para subdiretorios, referencia a GitHub Pages e links para ADR-001 e ADR-002.

### docs/conventions/

- language.md, -pt.md, -en.md: convencao de idioma, codificacao, nomenclatura, estilo de escrita, blocos de codigo sem comentarios, verificacao, excecoes.
- attribution.md, -pt.md, -en.md: autoria do projeto, funcoes (Data Architect, Stewardship, Governance Tech Lead), citacao de autoria por tipo de documento, contribuicoes externas, alteracoes.

### docs/reviews/

- 2026-11-09-codereview-A04.md, -pt.md, -en.md: codereview principal do PR, com decisoes, riscos R1-R5, divida D1-D5.
- 2026-11-09-codereview-A04-por-archivo.md, -pt.md, -en.md: este documento.

## Verificacao por arquivo

Cada um dos 24 arquivos:

- Codificacao UTF-8 sem BOM. Verificado por leitura dos primeiros tres bytes.
- Sem emojis.
- Sem comentarios dentro de blocos de codigo.
- Nomenclatura trilingue completa para cada documento base.
- Referencias cruzadas consistentes: os ADRs referenciam convencoes e A07; o index referencia ADRs e convencoes; este documento referencia os 24 arquivos do PR.

## Arquivos nao modificados mas afetados

### docs/reviews/2026-11-04-codereview-A02.md

Contem blocos de codigo com comentarios internos. Sob a nova regra, deveria ser limpo. Fica como divida D5.

### docs/reviews/2026-11-04-codereview-A06.md

Ja limpo pelo PR #14. Cumpre a nova regra.

### README.md na raiz do repositorio

Nao e modificado neste PR. A referencia a SECURITY.md e a secao de governanca sao atualizadas em A10 (#10) e A14 (#16).

## Aprovacao

Revisao e aprovacao a cargo da autora em suas funcoes de Data Architect, Stewardship & Governance Tech Lead.

Data: 2026-11-09.