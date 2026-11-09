# Codereview A04 - ADRs, convencoes e estrutura docs/

## Identificacao

- Issue: #5
- Data: 2026-11-09
- Branch: a04-adr-conventions
- Base: main @ 1fff4de
- Autora e revisora: Viki P. Sitzer (@mvikips). Funcoes: Data Architect, Stewardship & Governance Tech Lead.

## Escopo

Este documento cobre o PR de A04 (#5), que incorpora:

- ADR-001: codificacao UTF-8 sem BOM.
- ADR-002: documentacao trilingue e estrutura docs/.
- Convencao de idioma e codificacao.
- Convencao de atribuicao e funcoes.
- Index de navegacao para docs/.
- Este codereview e sua versao por arquivo.

Nao cobre: configuracao de GitHub Pages (divida D1), backfill de traducoes de A02 e A06 (divida D2), verificacao automatica em CI (divida D3), sincronizacao com a wiki (divida D4).

## Decisoes incorporadas

### ADR-001: UTF-8 sem BOM

Codificacao obrigatoria para todo arquivo do repositorio. Evidencia: tres incidentes registrados (m11 de A02, R3 de A06, incidente #2). O ADR documenta decisao, consequencias, alternativas descartadas e referencias.

### ADR-002: trilingue e estrutura docs/

Idioma principal espanhol, versoes -pt e -en para cada documento. Estrutura docs/ com subdiretorios adr/, conventions/, reviews/, wiki/. Compativel com publicacao via GitHub Pages com source em docs/.

A decisao se autoinstancia: este PR nasce trilingue, cumprindo o proprio ADR.

## Riscos identificados e tratamento

### R1. Drift de traducoes

Com tres versoes por documento, uma atualizacao em uma so versao gera inconsistencia. O ADR-002 reconhece e propoe marcacao de drift com cabecalho Desatualizado em relacao a X ate sincronizacao.

Tratamento: a convencao de idioma e o ADR-002 explicitam o mecanismo. A verificacao automatica fica como divida D3.

### R2. Gerador HTML nao escolhido

GitHub Pages requer um gerador para transformar .md em .html navegavel. O ADR-002 lista candidatos (MkDocs Material, Eleventy, script proprio) mas nao escolhe um.

Tratamento: divida D1. A decisao de gerador nao afeta a estrutura de fontes, entao o PR e valido sem escolhe-lo. Resolve-se em A07 (#8).

### R3. Backfill de documentos existentes

Os codereviews A02 e A06 estao apenas em espanhol. Sob ADR-002 deveriam ter versoes -pt e -en. O PR nao os traduz.

Tratamento: divida D2. Cria-se issue A15 de backfill imediato apos o merge de A04. O codereview A02 tambem contem blocos de codigo com comentarios internos (divida D5).

### R4. Regra de codigo sem comentarios vs documentos previos

A convencao de idioma e codificacao estabelece que os blocos de codigo em Markdown nao levam comentarios. Os codereviews A02 e A06 foram escritos antes da regra e contem blocos com comentarios.

Tratamento: divida D5. Nao se modifica retroativamente porque os codereviews sao registro historico. A regra aplica para frente. O codereview A06 foi limpo pelo PR #14, mas restam linhas em A02.

### R5. Tooling PowerShell 5.1

O ambiente local de autoria usa PowerShell 5.1, que corrompe argumentos nao-ASCII passados ao gh. O ADR-001 e a convencao de idioma documentam a mitigacao: titulos ASCII, corpos com --body-file, edicao de titulos com acentos via API com arquivo JSON.

Tratamento: mitigacao incorporada em convencoes. Nao ha divida tecnica no repositorio, a regra vive na convencao.

## Divida documentada

### D1. Gerador HTML e configuracao de Pages

GitHub Pages nao esta configurado ainda. O ADR-002 especifica source em docs/, mas falta a configuracao efetiva em Settings e a escolha do gerador estatico.

Condicao de fechamento: settings de Pages configurados e primeiro build bem-sucedido.

Acao: A05 (#6) pode incluir a configuracao. A escolha de gerador vai para A07 (#8).

### D2. Backfill de traducoes A02 e A06

Os codereviews A02 e A06 nao tem versoes -pt nem -en.

Condicao de fechamento: oito arquivos novos (quatro por cada codereview, sem contar os existentes).

Acao: criar issue A15 imediatamente apos o merge de A04.

### D3. Verificacao automatica de convencoes

As regras de ADR-001 (sem BOM) e ADR-002 (traducoes) nao se autoverificam. Falta verificacao em CI.

Condicao de fechamento: workflow que rejeite PRs com arquivos sem seus equivalentes -pt/-en e arquivos com BOM.

Acao: A07 (#8).

### D4. Sincronizacao com GitHub wiki

O ADR-002 estabelece docs/wiki/ como fonte de verdade e a wiki como espelho. Nao existe o diretorio docs/wiki/ nem o processo de sincronizacao.

Condicao de fechamento: docs/wiki/ criado com ao menos Home em tres idiomas, processo de sync definido.

Acao: A07 (#8) ou issue novo.

### D5. Codereview A02 com comentarios em blocos de codigo

O codereview A02 contem blocos de codigo com comentarios internos, contra a convencao de idioma e codificacao.

Condicao de fechamento: revisao de A02 sem comentarios em blocos.

Acao: pode ser resolvido junto com D2 (backfill de traducoes), no mesmo PR.

## Verificacao

Os 24 arquivos do PR cumprem:

- Codificacao UTF-8 sem BOM, verificado com leitura dos primeiros tres bytes em cada arquivo.
- Sem emojis no texto.
- Sem comentarios em blocos de codigo.
- Nomenclatura trilingue (base, -pt, -en) em todos os documentos.
- Referencias cruzadas consistentes entre ADRs, convencoes, index e este codereview.

## Aprovacao

Revisao e aprovacao a cargo da autora em suas funcoes de Data Architect, Stewardship & Governance Tech Lead.

Data: 2026-11-09.