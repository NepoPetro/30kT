# Language and encoding convention

## Language

Primary language: Spanish. Every Markdown document has Portuguese (-pt) and English (-en) versions.

Full rule in ADR-002: docs/adr/ADR-002-multilingue-en.md.

## Encoding

All files are saved in UTF-8 without BOM. The full rule is in ADR-001: docs/adr/ADR-001-encoding-en.md.

## File naming

- file.md: Spanish (primary).
- file-pt.md: Portuguese.
- file-en.md: English.

## Writing style

- No emojis in code, text, issues, PRs, comments or documentation.
- No comments in code. Explanation goes in prose outside the code block.
- Dates in ISO 8601 format: YYYY-MM-DD.
- Codes, technical identifiers and slugs in ASCII. Accents only in body text.
- Issue titles, PR titles and commit messages in ASCII.

## Code blocks

Code blocks in Markdown do not include comments. All clarification goes in prose before or after the block. This rule applies to languages where comments are syntactically valid (PowerShell, bash, Python, YAML, JSON, JavaScript, SQL) and to languages where comments are conventional (Markdown, HTML).

Reason: comments in code blocks within documentation are sometimes copied as executable commands. A comment starting with # or // in PowerShell, bash or YAML may be executed as a command if pasted incorrectly.

## Verification

Before each commit:

- Verify that new files have their -pt and -en equivalents.
- Verify absence of BOM in each new file.
- Verify absence of emojis in the diff.
- Verify absence of comments inside code blocks in Markdown.

Automation of these verifications is incorporated in A07 (#8).

## Exceptions

A file may be published in Spanish only, temporarily, if it meets all three conditions:

- It is a script-generated file and not versioned as source.
- It is a working file on a branch not merged into main.
- It is a technical configuration file whose version in other languages adds no value.

In all cases, the exception is documented in the PR with justification.

## References

- ADR-001: docs/adr/ADR-001-encoding-en.md.
- ADR-002: docs/adr/ADR-002-multilingue-en.md.
- Issue #8 (A07): CI hygiene includes verification of these rules.