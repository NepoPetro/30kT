# Security policy

## Vulnerability reporting

Single channel: GitHub Security Advisories of the repository.

Create a private advisory at:

https://github.com/NepoPetro/30kT/security/advisories/new

The channel is private between the reporter and the maintainer. Vulnerability reports are not accepted through public issues, PRs, comments or social media, because accidental disclosure before correction exposes third parties.

Communications within the advisory stay in the same thread. Information is not requested through external channels.

## Scope

This repository contains research documentation, data source catalogs, governance conventions and verification scripts. The attack surface is not that of a production web application, but the repository handles information whose integrity, provenance and confidentiality matter.

Any of the following cases is considered a vulnerability.

### 1. Personal data exposure

- Personal data of any person in versioned files, issues, PRs, wiki, comments or discussions. Includes full name combined with ID, address, phone, personal email, date of birth, health data, biometric data or any category that allows identification.
- Personal data of third parties without consent, even if public in another source.
- Aggregated data that allows re-identification by combination with other sources.
- Screenshots, PDFs or images containing unredacted personal data.
- File metadata (author, local path, embedded comments) revealing personal information.

### 2. Data integrity

- Alteration of datasets, source catalogs or result documents without record in git history.
- Silent file corruption by encoding (injected BOM, mojibake, undeclared conversion).
- Modification of figures or citations without change traceability.
- Evidence suppression (file deletion, force push, history rewrite) that prevents auditing the previous state.
- Inconsistency between a document and its version in another language that alters meaning.

### 3. Provenance and attribution

- Sources cited incorrectly or without verifiable URL.
- False or incomplete authorship attribution.
- Data catalogs including unverified sources or sources removed without leaving a record.
- Absence of consultation date or source version on a cited datum.
- Use of secondary sources presented as primary.

### 4. Credentials and secrets

- Tokens, API keys, passwords, private keys or certificates in any commit, current or historical.
- Secrets in configuration files, workflows, versioned environment variables or the wiki.
- Secrets in CI logs, artifacts or bot comments.
- Patterns suggesting leakage: keys with recognizable format, URLs with authentication parameters, unusually long base64 strings in suspicious context.

### 5. CI/CD and supply chain

- GitHub Actions workflows with excessive permissions over the repository or organization.
- Use of third-party actions not pinned by commit SHA.
- Command injection in workflows through controllable fields (issue titles, PRs, branch names, commit messages).
- Dependencies with known CVEs or abandoned.
- Typosquatting risk in package or action names.
- Malicious PRs seeking to introduce unreviewed changes (for example, workflow changes that self-approve).

### 6. Code and scripts

- Command injection in PowerShell, bash or Python scripts of the repository.
- Arbitrary code execution through unvalidated inputs.
- Path traversal in scripts that manipulate files.
- Race conditions in verification or generation scripts.
- Scripts writing outside the repository or with elevated privileges without justification.

### 7. Documentation and content

- Instructions that, followed literally, expose personal data, credentials or allow unintentional code execution.
- Links to external resources that may change destination and affect content integrity (link rot with malicious replacement).
- Copyable code blocks including comments executable by mistake.
- Omission of warnings about risks when running destructive commands.

### 8. Access and permissions

- Branch protection or ruleset configuration allowing control bypass.
- Required approvals disabled without justification.
- Administrator bypass when not appropriate.
- Write permissions granted to collaborators without need.

## Threat model

Actors considered:

- Malicious external contributor: seeks to introduce unreviewed changes, exfiltrate information or degrade repository integrity.
- Good-faith reporter who discloses inappropriately: publishes details before correction.
- Account compromise: unauthorized access to the maintainer account or organization.
- Compromised dependency: third-party package or action that changes behavior.
- Altered data source: an external official source that modifies its content after citation.

Plausible motivations: discredit the research, manipulate figures, expose persons mentioned in the data, obtain credit without work, reputational damage.

Attack surface:

- Repository (versioned files and history).
- Issues, PRs, wiki, discussions.
- GitHub Actions workflows.
- Third-party dependencies.
- External cited sources.

## Out of scope

- Vulnerabilities in GitHub infrastructure (reported to GitHub, not to this repository).
- Vulnerabilities in external official sources (reported to each agency).
- Typographical or style errors without impact on integrity, provenance or confidentiality.
- Feature requests or editorial content changes (go through normal issues).
- Methodological discussions about the data (go through issues, not advisory).
- Physical attacks or social engineering outside the repository.

## Response times

- Acknowledgment of report: 48 hours.
- Initial assessment (confirmation that it is in scope): 5 business days.
- Resolution by severity:
  - Critical (personal data exposed, compromised credentials): 7 days.
  - High (altered data integrity, false provenance): 30 days.
  - Medium (weak configuration, risky documentation): 90 days.
  - Low (practice improvement, no immediate impact): next release.

Times are targets, not guarantees. If a deadline cannot be met, it is communicated within the advisory with justification and a new estimated date.

## Responsible disclosure

- 90-day embargo from acknowledgment, or until correction publication, whichever comes first.
- If correction requires more time, an extension is agreed with the reporter.
- If the reporter wishes to disclose before the deadline, it is coordinated. No retaliation for coordinated disclosure.
- The correction is published with reference to the advisory and acknowledgment to the reporter if authorized.

## Acknowledgment

Reporters who wish are credited in the advisory and in the correction commit. If they prefer anonymity, it is respected.

There is no monetary reward. Acknowledgment is reputational.

## Roles and responsibilities

Data Architect, Stewardship & Governance Tech Lead (Viki P. Sitzer, @mvikips):

- Safeguards the integrity, provenance and confidentiality of data and documentation.
- Receives and evaluates reports.
- Defines severity and deadlines.
- Coordinates correction and disclosure.
- Records traceability of each change derived from a report.

Stewardship responsibilities include verifying that cited sources remain accessible, that published figures match official sources, and that no third-party personal data is exposed in the repository or its history.

## Cross references

- Personal data policy: issue #9 (A08).
- OSS governance (NOTICE, CITATION, CONTRIBUTING): #10 (A10).
- Source catalog and provenance: docs/data-sources.md.
- UTF-8 without BOM encoding: docs/adr/ADR-001-encoding-en.md.
- Trilingual documentation: docs/adr/ADR-002-multilingue-en.md.
- Branch protection and tag protection: docs/conventions/branch-protection-en.md and docs/conventions/tags-en.md.

## Changes to this document

A change to scope, deadlines or reporting channel requires a PR with justification. Maintained in three languages (es, pt, en) per ADR-002. The version GitHub shows in the Security tab is SECURITY.md (Spanish).