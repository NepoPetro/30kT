# Politica de seguranca

## Reporte de vulnerabilidades

Canal unico: GitHub Security Advisories do repositorio.

Criar um advisory privado em:

https://github.com/NepoPetro/30kT/security/advisories/new

O canal e privado entre a reportante e a mantenedora. Nao se aceitam reportes de vulnerabilidades por issues publicas, PRs, comentarios nem redes sociais, porque a divulgacao acidental antes da correcao expoe terceiros.

As comunicacoes dentro do advisory sao mantidas no mesmo topico. Nao se solicita informacao por canais externos.

## Escopo

Este repositorio contem documentacao de pesquisa, catalogos de fontes de dados, convencoes de governanca e scripts de verificacao. A superficie de ataque nao e a de uma aplicacao web em producao, mas o repositorio lida com informacao cuja integridade, procedencia e confidencialidade importam.

Considera-se vulnerabilidade qualquer um dos casos seguintes.

### 1. Exposicao de dados pessoais

- Dados pessoais de qualquer pessoa em arquivos versionados, issues, PRs, wiki, comentarios ou discussoes. Inclui nome completo combinado com documento, endereco, telefone, email pessoal, data de nascimento, dados de saude, dados biometricos ou qualquer categoria que permita identificacao.
- Dados pessoais de terceiros nao consentidos, mesmo que sejam publicos em outra fonte.
- Dados agregados que permitam reidentificacao por combinacao com outras fontes.
- Capturas de tela, PDFs ou imagens que contenham dados pessoais nao redigidos.
- Metadados de arquivos (autor, caminho local, comentarios embutidos) que revelem informacao pessoal.

### 2. Integridade de dados

- Alteracao de datasets, catalogos de fontes ou documentos de resultados sem registro no historico do git.
- Corrupcao silenciosa de arquivos por encoding (BOM injetado, mojibake, conversao nao declarada).
- Modificacao de cifras ou citacoes sem rastreabilidade da mudanca.
- Supressao de evidencia (exclusao de arquivos, force push, reescrita de historia) que impeça auditar o estado anterior.
- Inconsistencia entre um documento e sua versao em outro idioma que altere o sentido.

### 3. Procedencia e atribuicao

- Fontes citadas incorretamente ou sem URL verificavel.
- Atribuicao falsa ou incompleta de autoria.
- Catalogos de dados que incluam fontes nao verificadas ou removidas sem deixar registro.
- Ausencia de data de consulta ou de versao da fonte em um dado citado.
- Uso de fontes secundarias apresentadas como primarias.

### 4. Credenciais e segredos

- Tokens, chaves API, senhas, chaves privadas ou certificados em qualquer commit, atual ou historico.
- Segredos em arquivos de configuracao, workflows, variaveis de ambiente versionadas ou na wiki.
- Segredos em logs de CI, artefatos ou comentarios de bots.
- Padroes que sugiram vazamento: chaves com formato reconhecivel, URLs com parametros de autenticacao, strings base64 incomumente longas em contexto suspeito.

### 5. CI/CD e cadeia de suprimentos

- Workflows de GitHub Actions com permissoes excessivas sobre o repositorio ou organizacao.
- Uso de actions de terceiros nao pinneadas por SHA de commit.
- Injecao de comandos em workflows atraves de campos controlaveis (titulos de issues, PRs, nomes de branches, mensagens de commit).
- Dependencias com CVE conhecidos ou abandonadas.
- Risco de typosquatting em nomes de pacotes ou actions.
- PRs maliciosos que busquem introduzir mudancas nao revisadas (por exemplo, mudancas em workflows que se autoaprovam).

### 6. Codigo e scripts

- Injecao de comandos em scripts PowerShell, bash ou Python do repositorio.
- Execucao de codigo arbitrario atraves de entradas nao validadas.
- Path traversal em scripts que manipulem arquivos.
- Condicoes de corrida em scripts de verificacao ou geracao.
- Scripts que escrevam fora do repositorio ou com privilegios elevados sem justificativa.

### 7. Documentacao e conteudo

- Instrucoes que, seguidas ao pe da letra, exponham dados pessoais, credenciais ou permitam execucao de codigo nao intencional.
- Links para recursos externos que possam mudar de destino e afetar a integridade do conteudo (link rot com substituicao maliciosa).
- Blocos de codigo copiaveis que incluam comentarios executaveis por engano.
- Omissao de advertencias sobre riscos ao executar comandos destrutivos.

### 8. Acesso e permissoes

- Configuracao de branch protection ou rulesets que permita saltar controles.
- Aprovacoes requeridas desabilitadas sem justificativa.
- Bypass de administradores quando nao corresponde.
- Permissoes de escrita concedidas a colaboradores sem necessidade.

## Modelo de ameacas

Atores considerados:

- Contribuinte externo malicioso: busca introduzir mudancas nao revisadas, exfiltrar informacao ou degradar a integridade do repositorio.
- Ator que reporta de boa fe mas divulga de forma inapropriada: publica detalhes antes da correcao.
- Comprometimento de conta: acesso nao autorizado a conta da mantenedora ou a organizacao.
- Dependencia comprometida: pacote ou action de terceiros que muda de comportamento.
- Fonte de dados alterada: uma fonte oficial externa que modifica seu conteudo depois da citacao.

Motivacoes plausiveis: desacreditar a pesquisa, manipular cifras, expor pessoas mencionadas nos dados, obter credito sem trabalho, dano reputacional.

Superficie de ataque:

- Repositorio (arquivos versionados e historico).
- Issues, PRs, wiki, discussoes.
- Workflows de GitHub Actions.
- Dependencias de terceiros.
- Fontes externas citadas.

## Fora de escopo

- Vulnerabilidades na infraestrutura do GitHub (sao reportadas ao GitHub, nao a este repositorio).
- Vulnerabilidades nas fontes oficiais externas (sao reportadas a cada orgao).
- Erros tipograficos ou de estilo sem impacto em integridade, procedencia ou confidencialidade.
- Solicitacoes de funcionalidade ou mudancas de conteudo editoriais (vao por issues normais).
- Discussoes metodologicas sobre os dados (vao por issues, nao por advisory).
- Ataques fisicos ou de engenharia social fora do repositorio.

## Prazos de resposta

- Acuse de recebimento do reporte: 48 horas.
- Avaliacao inicial (confirmacao de que se considera dentro do escopo): 5 dias uteis.
- Resolucao segundo severidade:
  - Critica (dados pessoais expostos, credenciais comprometidas): 7 dias.
  - Alta (integridade de dados alterada, procedencia falsa): 30 dias.
  - Media (configuracao fraca, documentacao arriscada): 90 dias.
  - Baixa (melhoria de pratica, sem impacto imediato): proximo release.

Os prazos sao objetivos, nao garantias. Se nao for possivel cumprir um prazo, comunica-se dentro do advisory com justificativa e nova data estimada.

## Divulgacao responsavel

- Embargo de 90 dias desde o acuse de recebimento, ou ate a publicacao da correcao, o que ocorrer primeiro.
- Se a correcao exigir mais tempo, acorda-se extensao com a reportante.
- Se a reportante desejar divulgar antes do prazo, coordena-se. Nao se tomam represalias por divulgacao coordenada.
- A correcao e publicada com referencia ao advisory e reconhecimento a reportante se ela autorizar.

## Reconhecimento

A reportante que o desejar e acreditada no advisory e no commit de correcao. Se preferir anonimato, respeita-se.

Nao ha recompensa economica. O reconhecimento e reputacional.

## Funcoes e responsabilidades

Data Architect, Stewardship & Governance Tech Lead (Viki P. Sitzer, @mvikips):

- Custodia a integridade, procedencia e confidencialidade dos dados e da documentacao.
- Recebe e avalia os reportes.
- Define a severidade e os prazos.
- Coordena a correcao e a divulgacao.
- Registra a rastreabilidade de cada mudanca derivada de um reporte.

As responsabilidades de stewardship incluem verificar que as fontes citadas continuem acessiveis, que as cifras publicadas coincidam com as fontes oficiais, e que nenhum dado pessoal de terceiros fique exposto no repositorio ou em seu historico.

## Referencias cruzadas

- Politica de dados pessoais: docs/issues #9 (A08).
- Governanca OSS (NOTICE, CITATION, CONTRIBUTING): #10 (A10).
- Catalogo de fontes e procedencia: docs/data-sources.md.
- Codificacao UTF-8 sem BOM: docs/adr/ADR-001-encoding-pt.md.
- Documentacao trilingue: docs/adr/ADR-002-multilingue-pt.md.
- Branch protection e protecao de tags: docs/conventions/branch-protection-pt.md e docs/conventions/tags-pt.md.

## Alteracoes a este documento

Uma alteracao no escopo, nos prazos ou no canal de reporte requer PR com justificativa. Mantem-se em tres idiomas (es, pt, en) conforme ADR-002. A versao que o GitHub mostra na aba Security e SECURITY.md (espanhol).