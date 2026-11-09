# ADR-001: Codificacao UTF-8 sem BOM

## Estado

Aceito.

## Data

2026-11-09.

## Autora

Viki P. Sitzer (@mvikips). Funcoes em docs/conventions/attribution.md.

## Contexto

O repositorio 30kT contem arquivos Markdown, JSON, YAML, PowerShell e Python. Ao longo dos primeiros milestones registraram-se tres incidentes de codificacao:

- m11 (A02): detectou-se um BOM no inicio de um arquivo de notas, que quebrava parsers que assumem UTF-8 sem BOM.
- R3 (A06): PowerShell 5.1 corrompe argumentos nao-ASCII ao passa-los a executaveis nativos. O titulo da issue #2 transformou-se de Inspeccion com acento para Inspeccion sem acento, com perda do byte original (C3 B3 para 3F).
- Incidente #2: a reescrita de um titulo com acentos substituiu a vogal acentuada por um ponto de interrogacao ASCII.

Os tres incidentes compartilham uma causa: ausencia de uma politica explicita de codificacao. A ausencia obriga cada ferramenta a inferir, e as inferencias nao sao consistentes.

## Decisao

Todo arquivo do repositorio e salvo com codificacao UTF-8 sem BOM. Arquivos de texto plano, Markdown, JSON, YAML, SQL, scripts e codigo-fonte cumprem a mesma regra.

Aclaracoes operacionais:

- Arquivos criados ou editados com editor de texto sao salvos em UTF-8 sem BOM. VSCode faz isso por padrao.
- Arquivos gerados por script usam codificacao UTF-8 sem BOM explicita.
- Arquivos JSON consumidos por GitHub Actions nao devem ter BOM. Os parsers de Actions rejeitam ou tratam incorretamente o BOM.
- Mensagens de commit, titulos de issues e titulos de PR sao escritos em ASCII. Se um titulo requer acentos, edita-se via API com arquivo JSON UTF-8 sem BOM, evitando a passagem por linha de comando do PowerShell 5.1.

## Consequencias

Positivas:

- Elimina a classe de incidentes documentados no Contexto.
- Garante compatibilidade com ferramentas que assumem UTF-8 sem BOM: parsers de YAML, Actions, git diff, gh CLI.
- Simplifica a revisao: arquivos com BOM geram diffs espurios.

Negativas:

- Requer disciplina em cada arquivo novo. A regra nao se autoverifica.
- Colaboradores que usam ferramentas Windows por padrao (Notepad antigo, certas versoes do Excel) podem reintroduzir BOM.

Mitigacao:

- Adicionar verificacao automatica de BOM no workflow de CI (A07, #8).
- Documentar o procedimento em docs/conventions/language.md.

## Alternativas descartadas

- UTF-8 com BOM: incompativel com parsers de Actions e com varias ferramentas de linha de comando. O BOM nao adiciona informacao em UTF-8.
- Latin-1 ou ISO-8859-1: cobre menos caracteres que UTF-8. Incompativel com a documentacao trilingue adotada em ADR-002.
- UTF-16: consome o dobro do espaco, incompativel com a maioria das ferramentas Unix, sem vantagens para o caso.

## Referencias

- m11 em docs/reviews/2026-11-04-codereview-A02.md.
- R3 em docs/reviews/2026-11-04-codereview-A06.md.
- Issue #2.
- A07 (#8): higiene de CI inclui verificacao de BOM.