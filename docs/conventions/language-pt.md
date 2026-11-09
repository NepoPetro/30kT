# Convencao de idioma e codificacao

## Idioma

Idioma principal: espanhol. Cada documento Markdown tem versoes em portugues (-pt) e ingles (-en).

Regra completa em ADR-002: docs/adr/ADR-002-multilingue-pt.md.

## Codificacao

Todos os arquivos sao salvos em UTF-8 sem BOM. A regra completa esta em ADR-001: docs/adr/ADR-001-encoding-pt.md.

## Nomenclatura de arquivos

- arquivo.md: espanhol (principal).
- arquivo-pt.md: portugues.
- arquivo-en.md: ingles.

## Estilo de escrita

- Sem emojis em codigo, texto, issues, PRs, comentarios nem documentacao.
- Sem comentarios no codigo. A explicacao vai em prosa fora do bloco de codigo.
- Datas no formato ISO 8601: YYYY-MM-DD.
- Codigos, identificadores tecnicos e slugs em ASCII. Acentos apenas no corpo do texto.
- Titulos de issues, PRs e mensagens de commit em ASCII.

## Blocos de codigo

Os blocos de codigo em Markdown nao incluem comentarios. Toda aclaracao vai em prosa antes ou depois do bloco. Esta regra aplica-se a linguagens onde o comentario e sintaticamente valido (PowerShell, bash, Python, YAML, JSON, JavaScript, SQL) e a linguagens onde o comentario e convencional (Markdown, HTML).

Razao: comentarios em blocos de codigo dentro de documentacao sao as vezes copiados como comandos executaveis. Um comentario que comeca com # ou // em PowerShell, bash ou YAML pode ser executado como comando se copiado incorretamente.

## Verificacao

Antes de cada commit:

- Verificar que os arquivos novos tenham seus equivalentes -pt e -en.
- Verificar ausencia de BOM em cada arquivo novo.
- Verificar ausencia de emojis no diff.
- Verificar ausencia de comentarios dentro de blocos de codigo em Markdown.

A automatizacao destas verificacoes e incorporada em A07 (#8).

## Excecoes

Um arquivo pode ser publicado apenas em espanhol de forma temporaria se cumprir as tres condicoes seguintes:

- E um arquivo gerado por script e nao versionado como fonte.
- E um arquivo de trabalho em uma branch nao mergeada em main.
- E um arquivo de configuracao tecnica cuja versao em outros idiomas nao agrega valor.

Em todos os casos, a excecao e documentada no PR com a justificativa.

## Referencias

- ADR-001: docs/adr/ADR-001-encoding-pt.md.
- ADR-002: docs/adr/ADR-002-multilingue-pt.md.
- Issue #8 (A07): higiene de CI inclui verificacao destas regras.