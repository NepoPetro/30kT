# Registro de decisiones arquitectonicas

Este directorio contiene los ADRs (Architecture Decision Records) del proyecto 30kT.

## Formato

Cada ADR sigue el formato Nygard estandar: Estado, Contexto, Decision, Consecuencias, Alternativas descartadas, Referencias.

## Nomenclatura

- ADR-NNN-slug.md para espanol (idioma principal).
- ADR-NNN-slug-pt.md para portugues.
- ADR-NNN-slug-en.md para ingles.

El numero es correlativo y de tres digitos. El slug es corto, en minusculas, con guiones.

## Indice

- ADR-001-encoding.md: codificacion UTF-8 sin BOM como obligatoria.
- ADR-002-multilingue.md: documentacion multilingue y estructura docs/.

## Proceso

Un ADR nuevo se propone en un PR. El PR incluye las tres versiones (es, pt, en). Se acepta por merge del PR tras revision. Si se rechaza, el ADR queda como rechazado en el mismo directorio con el estado explicito, no se elimina.

Una decision tomada en un ADR no se modifica: se reemplaza por un ADR posterior que la supersede. El ADR anterior queda con el estado Reemplazado por ADR-NNN.

## Referencias

- ADR-001-encoding.md.
- ADR-002-multilingue.md.
- docs/conventions/language.md.