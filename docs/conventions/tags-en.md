# Tag convention

## Purpose

Defines the tag-based versioning scheme of the 30kT repository and the protection rules applied to them.

## Format

v<major>.<minor>.<patch>-<milestone>

- v: mandatory literal prefix.
- major: integer, incremented on incompatible structure or data change.
- minor: integer, incremented on new compatible functionality.
- patch: integer, incremented on compatible fix.
- milestone: origin milestone letter in lowercase (a, b, c, d, e, f, g).

## Valid examples

- v0.1.0-a02
- v0.1.0-a06
- v0.1.0-a16
- v0.2.0-a07
- v1.0.0-g01

## Invalid examples

- 0.1.0-a02 (missing v prefix)
- v0.1-a02 (missing patch)
- v0.1.0 (missing milestone)
- v0.1.0-A02 (uppercase milestone)
- v0.1.0-a (empty milestone)
- v0.1.0-a02-hotfix (suffix not allowed)

## Relationship with milestones

Each tag closes the repository state at the end of a milestone. The suffix indicates the corresponding milestone according to the project naming:

- a: Initial organization and scope.
- b: Primary source and documentary framework.
- c: Architecture and traceability.
- d: Notebook and mathematical backup.
- e: Results and communication.
- f: Interdisciplinary documents.
- g: Publication and closure.

A tag is created when the last issue of the milestone is closed. No per-issue tag is created.

## Creation

The tag is created on a main commit, never on a working branch nor on an unmerged commit.

```bash
git tag -a v0.1.0-a02 -m "Milestone A closure"
git push origin v0.1.0-a02
```
The message follows the format "Milestone X closure" where X is the uppercase letter.

## Protection
Tags matching the v* pattern are protected against deletion and modification. Protection is applied via the GitHub API and verified in this document.

## Configuration:

```bash
gh api repos/NepoPetro/30kT/tags/protection
```
It must return the rule covering v*.

If protection is missing or must be restored:

```bash
gh api -X POST repos/NepoPetro/30kT/tags/protection -f pattern="v*"
```
The operation requires repository administration permissions.

## Verification
To verify that an existing tag is intact:

``` bash
git ls-remote --tags origin
```
The output must list the expected tags. A created tag must not be modified. If something must be fixed in an already tagged release, a new tag with incremented patch is created, the previous one is not rewritten.

## References
- ADR-001: docs/adr/ADR-001-encoding-en.md
- ADR-002: docs/adr/ADR-002-multilingue-en.md
- A13 (#15)
- A06 (#7)
- A10 (#10): release policy.

## Historical exceptions

The tag v.0001 was created before the adoption of this convention and does not comply with the format. It was deleted on 2026-11-11 without replacement. No equivalent tag is created because it does not correspond to a milestone closure. The rule applies going forward.