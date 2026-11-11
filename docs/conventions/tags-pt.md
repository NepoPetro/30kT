# Convencao de tags

## Proposito

Define o esquema de versionamento por tags do repositorio 30kT e as regras de protecao aplicadas sobre eles.

## Formato

v<major>.<minor>.<patch>-<milestone>

- v: prefixo literal obrigatorio.
- major: inteiro, incrementa-se ante mudanca incompativel de estrutura ou dados.
- minor: inteiro, incrementa-se ante nova funcionalidade compativel.
- patch: inteiro, incrementa-se ante correcao compativel.
- milestone: letra do milestone de origem em minuscula (a, b, c, d, e, f, g).

## Exemplos validos

- v0.1.0-a02
- v0.1.0-a06
- v0.1.0-a16
- v0.2.0-a07
- v1.0.0-g01

## Exemplos invalidos

- 0.1.0-a02 (falta prefixo v)
- v0.1-a02 (falta patch)
- v0.1.0 (falta milestone)
- v0.1.0-A02 (milestone em maiuscula)
- v0.1.0-a (milestone vazio)
- v0.1.0-a02-hotfix (sufixo nao permitido)

## Relacao com milestones

Cada tag fecha o estado do repositorio ao finalizar um milestone. O sufixo indica o milestone correspondente segundo a nomenclatura do projeto:

- a: Organizacao inicial e escopo.
- b: Fonte primaria e marco documental.
- c: Arquitetura e rastreabilidade.
- d: Notebook e respaldo matematico.
- e: Resultados e comunicacao.
- f: Documentos interdisciplinares.
- g: Publicacao e encerramento.

Um tag e criado ao fechar a ultima issue do milestone. Nao se cria tag por issue individual.

## Criacao

O tag e criado sobre um commit de main, nunca sobre uma branch de trabalho nem sobre um commit nao mergeado.

```bash
git tag -a v0.1.0-a02 -m "Encerramento do Milestone A"
git push origin v0.1.0-a02
```

A mensagem segue o formato "Encerramento do Milestone X" onde X e a letra em maiuscula.

## Protecao
Os tags que coincidem com o padrao v* estao protegidos contra exclusao e modificacao. A protecao e aplicada via API do GitHub e verificada neste documento.

## Configuracao:

```bash
gh api repos/NepoPetro/30kT/tags/protection
```
Deve retornar a regra que cobre v*.

Se a protecao faltar ou precisar ser restabelecida:

```bash
gh api -X POST repos/NepoPetro/30kT/tags/protection -f pattern="v*"
```
A operacao requer permissoes de administracao sobre o repositorio.

## Verificacao
Para verificar que um tag existente esta intacto:

```bash
git ls-remote --tags origin
```
A saida deve listar os tags esperados. Um tag criado nao deve ser modificado. Se for necessario corrigir algo de um release ja tagueado, cria-se um novo tag com patch incrementado, nao se reescreve o anterior.

## Referencias
- ADR-001: docs/adr/ADR-001-encoding-pt.md
- ADR-002: docs/adr/ADR-002-multilingue-pt.md
- A13 (#15)
- A06 (#7)
- A10 (#10): politica de releases.