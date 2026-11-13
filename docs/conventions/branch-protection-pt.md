# Convencao de protecao da branch main

## Proposito

Documenta a configuracao de protecao aplicada sobre a branch main do repositorio 30kT, a justificativa de cada regra, e os procedimentos de verificacao e alteracao.

## Estado atual

A protecao e aplicada mediante dois mecanismos coexistentes:

- Ruleset de repositorio identificado como main, target branch, enforcement active, criado em 2026-11-01.
- Configuracao classica de branch protection sobre main, aplicada via API em 2026-11-04.

A coexistencia e herdada da evolucao do repositorio. A consolidacao em um unico mecanismo (rulesets) e abordada em A07 (#8). Enquanto isso, ambas as configuracoes estao ativas e se complementam.

## Regras aplicadas

Cada linha indica a regra, seu valor atual, e a justificativa.

| Regra | Valor | Justificativa |
|---|---|---|
| Pull request obrigatorio | sim | Nenhum push direto para main, incluindo a mantenedora. |
| enforce_admins | true | Sem bypass administrativo. A mantenedora esta sujeita as mesmas regras. |
| Aprovacoes requeridas | 0 | Bootstrap enquanto existir uma unica mantenedora verificavel. Restituicao para 1 e divida D1. |
| dismiss_stale_reviews | true | Aprovacoes descartadas ante novo commit. Sem efeito com 0 requeridas, mas mantido por consistencia futura. |
| require_code_owner_reviews | false | Sem CODEOWNERS definido. Reavaliacao em A05 (#6) e divida D3. |
| require_last_push_approval | false | Bloquearia o fluxo com uma unica mantenedora. Reavaliar junto com D1. |
| required_linear_history | true | Squash ou rebase obrigatorio. Historico linear facilita auditoria e revert. |
| allow_force_pushes | false | Previne reescrita de historia. |
| allow_deletions | false | Impede exclusao de main. |
| required_conversation_resolution | true | Conversas resolvidas antes do merge. |
| required_status_checks | null | Pendente de B02 (#12). Adiciona-se o contexto do job de CI quando existir. Divida D2. |
| lock_branch | false | Sem congelamento. Reavaliar se for necessario freeze antes de release. |
| allow_fork_syncing | false | Sem forks sincronizados. Sem efeito pratico enquanto nao houver forks. |

## Justificativa das decisoes criticas

### enforce_admins true

Um repositorio de pesquisa que publica resultados verificaveis precisa que a historia seja auditavel sem excecoes. Se a mantenedora pode burlar a protecao, a garantia e condicional ao seu criterio. Com enforce_admins true, cada mudanca em main, incluindo a da mantenedora, e mediada por um PR e pelos checks configurados. A protecao deixa de depender da disciplina e passa a depender do sistema.

### Aprovacoes em 0 por bootstrap

GitHub nao permite autoaprovar PRs. Com uma unica mantenedora e required_approving_review_count maior que 0, o repositorio entra em deadlock: nao ha como mergear o primeiro PR. A restituicao para 1 requer que exista uma segunda pessoa com permissoes de write. Condicao de fechamento em divida D1.

### Linear history

Merge commits adicionam branches paralelas no grafo que dificultam a auditoria. Squash ou rebase produzem uma historia linear onde cada commit em main corresponde a um PR mergeado. Isso e especialmente relevante para um repositorio cujos artefatos sao evidencia de um procedimento: a rastreabilidade entre commit e PR e direta.

### Conversation resolution

Um PR pode ficar aberto com comentarios pendentes. A flag obriga a resolve-los antes do merge. Sem isso, conversas abertas ficam enterradas pelo merge e se perdem.

## Divida documentada

### D1. Aprovacoes requeridas

Estado: 0. Condicao de fechamento: existencia de segunda pessoa com permissoes de write.

Acao: alterar required_approving_review_count para 1 e require_last_push_approval para true. Documentar a alteracao neste arquivo e em A11 (#11).

### D2. Required status checks

Estado: null. Condicao de fechamento: workflow de CI com job identificavel (B02 #12).

Acao: adicionar required_status_checks.contexts com o nome do job.

### D3. CODEOWNERS

Estado: nao definido. Condicao de fechamento: estrutura de propriedade de arquivos (A05 #6 ou ADR posterior).

Acao: definir CODEOWNERS, ativar require_code_owner_reviews.

### D4. Consolidacao de mecanismos

Estado: coexistem ruleset main e branch protection classica. Condicao de fechamento: migracao completa para rulesets.

Acao: A07 (#8) consolida em rulesets, que sao o mecanismo recomendado pelo GitHub desde 2023.

## Verificacao

Para verificar a configuracao classica:

```bash
gh api repos/NepoPetro/30kT/branches/main/protection
```
Deve mostrar enforce_admins enabled, required_linear_history enabled, allow_force_pushes disabled, allow_deletions disabled, required_conversation_resolution enabled, required_approving_review_count 0.

Para verificar o ruleset:

```bash
gh api repos/NepoPetro/30kT/rulesets | ConvertFrom-Json | Select-Object id, name, target, enforcement
```
Deve mostrar pelo menos uma regra com target branch e enforcement active.

Para verificar que a protecao rejeita push direto para main (teste destrutivo, nao executar sem entender):

```bash
git push origin main:main --force
```
Deve falhar com erro de protected branch. Nao executar salvo se for necessario confirmar a rejeicao.

## Alteracao da configuracao
Uma alteracao na configuracao de protecao requer:

- PR para este arquivo com a justificativa.
- Justificativa escrita da alteracao e seu impacto na auditabilidade.
- Registro da alteracao na issue correspondente.
- Verificacao pos-alteracao com o GET correspondente.

As alteracoes devem ser reversiveis. Qualquer desprotecao, mesmo temporaria, e documentada com motivo, duracao e restauracao.

## Referencias
- ADR-001: docs/adr/ADR-001-encoding-pt.md.
- ADR-002: docs/adr/ADR-002-multilingue-pt.md.
- Convencao de tags: docs/conventions/tags-pt.md.
- A06 (#7): branch protection e seguranca do repositorio.
- A07 (#8): higiene de CI, inclui consolidacao para rulesets.
- A11 (#11): criterios de aceitacao do projeto.
- SECURITY.md: canal de reporte de vulnerabilidades. (SECURITY-pt.md)