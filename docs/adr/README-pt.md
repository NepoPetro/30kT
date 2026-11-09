# Registro de decisoes arquiteturais

Este diretorio contem os ADRs (Architecture Decision Records) do projeto 30kT.

## Formato

Cada ADR segue o formato Nygard padrao: Status, Contexto, Decisao, Consequencias, Alternativas descartadas, Referencias.

## Nomenclatura

- ADR-NNN-slug.md para espanhol (idioma principal).
- ADR-NNN-slug-pt.md para portugues.
- ADR-NNN-slug-en.md para ingles.

O numero e correlativo e de tres digitos. O slug e curto, em minusculas, com hifens.

## Indice

- ADR-001-encoding.md: codificacao UTF-8 sem BOM como obrigatoria.
- ADR-002-multilingue.md: documentacao trilingue e estrutura docs/.

## Processo

Um novo ADR e proposto em um PR. O PR inclui as tres versoes (es, pt, en). E aceito por merge do PR apos revisao. Se rejeitado, o ADR permanece como rejeitado no mesmo diretorio com status explicito, nao e removido.

Uma decisao tomada em um ADR nao e modificada: e substituida por um ADR posterior que a supersede. O ADR anterior permanece com o status Substituido por ADR-NNN.

## Referencias

- ADR-001-encoding.md.
- ADR-002-multilingue.md.
- docs/conventions/language.md.