# Codereview A04 - ADRs, conventions and docs/ structure

## Identification

- Issue: #5
- Date: 2026-11-09
- Branch: a04-adr-conventions
- Base: main @ 1fff4de
- Author and reviewer: Viki P. Sitzer (@mvikips). Roles: Data Architect, Stewardship & Governance Tech Lead.

## Scope

This document covers the A04 PR (#5), which introduces:

- ADR-001: UTF-8 encoding without BOM.
- ADR-002: trilingual documentation and docs/ structure.
- Language and encoding convention.
- Attribution and roles convention.
- Navigation index for docs/.
- This codereview and its per-file version.

Does not cover: GitHub Pages configuration (debt D1), backfill of A02 and A06 translations (debt D2), automated CI verification (debt D3), wiki synchronization (debt D4).

## Incorporated decisions

### ADR-001: UTF-8 without BOM

Mandatory encoding for every file in the repository. Evidence: three recorded incidents (m11 from A02, R3 from A06, incident #2). The ADR documents decision, consequences, discarded alternatives and references.

### ADR-002: trilingual and docs/ structure

Primary language Spanish, -pt and -en versions for each document. docs/ structure with subdirectories adr/, conventions/, reviews/, wiki/. Compatible with GitHub Pages publication with source in docs/.

The decision self-instantiates: this PR is born trilingual, complying with the ADR itself.

## Risks identified and treatment

### R1. Translation drift

With three versions per document, updating only one generates inconsistency. ADR-002 acknowledges this and proposes drift marking with an Outdated relative to X header until synchronized.

Treatment: the language convention and ADR-002 spell out the mechanism. Automated verification remains as debt D3.

### R2. HTML generator not chosen

GitHub Pages requires a generator to turn .md into navigable .html. ADR-002 lists candidates (MkDocs Material, Eleventy, custom script) but does not choose one.

Treatment: debt D1. The generator decision does not affect the source structure, so the PR is valid without choosing it. Resolved in A07 (#8).

### R3. Backfill of existing documents

Codereviews A02 and A06 are Spanish-only. Under ADR-002 they should have -pt and -en versions. The PR does not translate them.

Treatment: debt D2. Issue A15 for immediate backfill is created after A04 merge. Codereview A02 also contains code blocks with internal comments (debt D5).

### R4. No-comments-in-code rule vs previous documents

The language and encoding convention states that code blocks in Markdown carry no comments. Codereviews A02 and A06 were written before the rule and contain blocks with comments.

Treatment: debt D5. Not retroactively modified because codereviews are historical record. The rule applies forward. Codereview A06 was cleaned by PR #14, but lines remain in A02.

### R5. PowerShell 5.1 tooling

The local authoring environment uses PowerShell 5.1, which corrupts non-ASCII arguments passed to gh. ADR-001 and the language convention document the mitigation: ASCII titles, bodies with --body-file, title editing with accents via API with JSON file.

Treatment: mitigation incorporated into conventions. No technical debt in the repository, the rule lives in the convention.

## Documented debt

### D1. HTML generator and Pages configuration

GitHub Pages is not configured yet. ADR-002 specifies source in docs/, but effective Settings configuration and static generator choice are missing.

Closure condition: Pages settings configured and first successful build.

Action: A05 (#6) may include configuration. Generator choice goes to A07 (#8).

### D2. Backfill A02 and A06 translations

Codereviews A02 and A06 lack -pt and -en versions.

Closure condition: eight new files (four per codereview, excluding existing ones).

Action: create issue A15 immediately after A04 merge.

### D3. Automated convention verification

ADR-001 (no BOM) and ADR-002 (translations) rules do not self-verify. CI verification is missing.

Closure condition: workflow that rejects PRs with files missing -pt/-en counterparts and files with BOM.

Action: A07 (#8).

### D4. Wiki synchronization

ADR-002 establishes docs/wiki/ as source of truth and the wiki as mirror. Neither docs/wiki/ nor the sync process exists.

Closure condition: docs/wiki/ created with at least Home in three languages, sync process defined.

Action: A07 (#8) or new issue.

### D5. Codereview A02 with comments in code blocks

Codereview A02 contains code blocks with internal comments, against the language and encoding convention.

Closure condition: A02 revision without comments in blocks.

Action: may be resolved together with D2 (translation backfill) in the same PR.

## Verification

The 24 files of the PR comply with:

- UTF-8 without BOM encoding, verified by reading the first three bytes in each file.
- No emojis in text.
- No comments in code blocks.
- Trilingual naming (base, -pt, -en) across all documents.
- Consistent cross-references among ADRs, conventions, index and this codereview.

## Approval

Review and approval by the author in her roles of Data Architect, Stewardship & Governance Tech Lead.

Date: 2026-11-09.