# Architecture decision records

This directory contains the ADRs (Architecture Decision Records) of the 30kT project.

## Format

Each ADR follows the standard Nygard format: Status, Context, Decision, Consequences, Discarded alternatives, References.

## Naming

- ADR-NNN-slug.md for Spanish (primary language).
- ADR-NNN-slug-pt.md for Portuguese.
- ADR-NNN-slug-en.md for English.

The number is correlative and three digits. The slug is short, lowercase, hyphen-separated.

## Index

- ADR-001-encoding.md: UTF-8 encoding without BOM as mandatory.
- ADR-002-multilingue.md: trilingual documentation and docs/ structure.

## Process

A new ADR is proposed in a PR. The PR includes the three versions (es, pt, en). It is accepted by PR merge after review. If rejected, the ADR remains as rejected in the same directory with an explicit status, it is not removed.

A decision made in an ADR is not modified: it is superseded by a later ADR. The previous ADR remains with status Superseded by ADR-NNN.

## References

- ADR-001-encoding.md.
- ADR-002-multilingue.md.
- docs/conventions/language.md.