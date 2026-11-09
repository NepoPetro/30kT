# Codereview A04 - Per-file review

## Identification

- Issue: #5
- Date: 2026-11-09
- Branch: a04-adr-conventions
- Author and reviewer: Viki P. Sitzer (@mvikips). Roles: Data Architect, Stewardship & Governance Tech Lead.

## PR files (24)

### docs/adr/

- ADR-001-encoding.md, -pt.md, -en.md: UTF-8 without BOM encoding decision. Evidence from three incidents. Discarded alternatives. Verified: complete Nygard structure, cross-references to A07 and A02/A06.
- ADR-002-multilingue.md, -pt.md, -en.md: trilingual documentation and docs/ structure decision. Includes naming convention, directory structure, publication plan, generator, wiki mirror and retroactivity.
- README.md, -pt.md, -en.md: ADR directory index with format, naming, process and state of the two current ADRs.

### docs/

- index.md, -pt.md, -en.md: navigable home with links to subdirectories, reference to GitHub Pages and links to ADR-001 and ADR-002.

### docs/conventions/

- language.md, -pt.md, -en.md: language, encoding, naming, writing style, code blocks without comments, verification, exceptions.
- attribution.md, -pt.md, -en.md: project authorship, roles (Data Architect, Stewardship, Governance Tech Lead), authorship citation per document type, external contributions, changes.

### docs/reviews/

- 2026-11-09-codereview-A04.md, -pt.md, -en.md: main PR codereview, with decisions, risks R1-R5, debt D1-D5.
- 2026-11-09-codereview-A04-por-archivo.md, -pt.md, -en.md: this document.

## Per-file verification

Each of the 24 files:

- UTF-8 without BOM encoding. Verified by reading first three bytes.
- No emojis.
- No comments inside code blocks.
- Complete trilingual naming for each base document.
- Consistent cross-references: ADRs reference conventions and A07; index references ADRs and conventions; this document references the 24 PR files.

## Files not modified but affected

### docs/reviews/2026-11-04-codereview-A02.md

Contains code blocks with internal comments. Under the new rule, it should be cleaned. Remains as debt D5.

### docs/reviews/2026-11-04-codereview-A06.md

Already cleaned by PR #14. Complies with the new rule.

### Repository root README.md

Not modified in this PR. Reference to SECURITY.md and the governance section are updated in A10 (#10) and A14 (#16).

## Approval

Review and approval by the author in her roles of Data Architect, Stewardship & Governance Tech Lead.

Date: 2026-11-09.