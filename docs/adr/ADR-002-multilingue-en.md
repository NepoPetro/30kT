# ADR-002: Trilingual documentation and docs/ structure

## Status

Accepted.

## Date

2026-11-09.

## Author

Viki P. Sitzer (@mvikips). Roles in docs/conventions/attribution.md.

## Context

The 30kT project produces technical, methodological and governance documentation. The audience includes Spanish, Portuguese and English speaking researchers. Until now, documents were written only in Spanish.

Needed:

- Define a primary language and its equivalents.
- Establish a directory structure that allows publishing documents as navigable HTML from an index, served by GitHub Pages.
- Synchronize repository documentation with the GitHub wiki, keeping the wiki as a navigable mirror.

## Decision

Primary language: Spanish. Every Markdown document has two additional versions: Portuguese and English. Naming is:

- file.md for Spanish.
- file-pt.md for Portuguese.
- file-en.md for English.

This rule applies to every Markdown file in the repository: ADRs, conventions, reviews, wiki mirror, index, result documents.

Directory structure:

```text
docs/
  index.md, index-pt.md, index-en.md
  adr/
    ADR-001-encoding.md, -pt, -en
    ADR-002-multilingue.md, -pt, -en
    README.md, -pt, -en
  conventions/
    language.md, -pt, -en
    attribution.md, -pt, -en
  reviews/
    2026-11-04-codereview-A02.md, -pt, -en
    2026-11-04-codereview-A06.md, -pt, -en
    2026-11-09-codereview-A04.md, -pt, -en
  wiki/
    Home.md, -pt, -en

## Publication:

GitHub Pages is configured in Settings, Pages, with source Deploy from branch, branch main, folder docs. The publication URL is https://nepopetro.github.io/30kT/.

The docs/index.html generated file serves as home. Relative links between file.html, file-pt.html and file-en.html resolve within the same tree.

## HTML generation:

The static generator is chosen in a later issue (see A07 #8). Candidates evaluated: MkDocs Material with i18n plugin, Eleventy with i18n collections, custom script. The generator decision does not affect the source structure: the source files are the .md listed above.

## Synchronization with GitHub wiki:

The GitHub wiki is a navigable mirror of docs/wiki/. The source of truth is docs/wiki/ in the repository. The synchronization direction is repository to wiki. The wiki does not receive direct edits: any change is made in docs/wiki/ and reflected to the wiki by a manual or automated process to be defined in A07.

## Retroactivity:

Documents created before this ADR (codereviews A02 and A06) are translated in an immediate backfill issue (A15, to be created). New documents (A04 onwards) are born trilingual in their original PR.

## Consequences

### Positive:

- Audience expanded to the three research languages.
- Single structure facilitates HTML generation and navigation from the index.
- Forced discipline: every new PR includes its three versions.
- The wiki mirror is versioned and survives wiki deactivation.

### Negative:

- Triples the Markdown file volume.
- Requires translation discipline. A monolingual PR breaks the convention.
- Maintaining three versions may cause drift if one is updated and the others are not.

## Mitigation:

CI verification that each new file has its two equivalents (A07 #8).
Translation process documented in docs/conventions/language.md.
Drift marking: if a version is not updated, an Outdated relative to X header is added to the file until synchronized.

## Discarded alternatives
Spanish only: excludes international audience, reduces project reach.
English only: excludes Spanish-speaking audience, primary language of the research.
Out-of-band translation in separate repository: duplicates management and diverges.
Language folders: relative paths become complex and structure duplicates directories. The -pt, -en suffix convention is simpler and generator-friendly.

## References
ADR-001: UTF-8 encoding without BOM.
docs/conventions/language.md.
Issue #5 (A04).
Issue #8 (A07): CI hygiene includes translation verification.