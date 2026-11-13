# Main branch protection convention

## Purpose

Documents the protection configuration applied to the main branch of the 30kT repository, the justification of each rule, and the verification and change procedures.

## Current state

Protection is applied through two coexisting mechanisms:

- Repository ruleset identified as main, target branch, enforcement active, created on 2026-11-01.
- Classic branch protection on main, applied via API on 2026-11-04.

Coexistence is inherited from repository evolution. Consolidation into a single mechanism (rulesets) is addressed in A07 (#8). Meanwhile, both configurations are active and complement each other.

## Applied rules

Each row indicates the rule, its current value, and justification.

| Rule | Value | Justification |
|---|---|---|
| Pull request required | yes | No direct push to main, including the maintainer. |
| enforce_admins | true | No administrative bypass. The maintainer is subject to the same rules. |
| Required approvals | 0 | Bootstrap while a single verifiable maintainer exists. Restoring to 1 is debt D1. |
| dismiss_stale_reviews | true | Approvals discarded on new commit. No effect with 0 required, but kept for future consistency. |
| require_code_owner_reviews | false | No CODEOWNERS defined. Re-evaluation in A05 (#6) is debt D3. |
| require_last_push_approval | false | Would block the flow with a single maintainer. Re-evaluate with D1. |
| required_linear_history | true | Squash or rebase required. Linear history facilitates audit and revert. |
| allow_force_pushes | false | Prevents history rewrite. |
| allow_deletions | false | Prevents main deletion. |
| required_conversation_resolution | true | Conversations resolved before merge. |
| required_status_checks | null | Pending B02 (#12). CI job context is added when it exists. Debt D2. |
| lock_branch | false | No freezing. Re-evaluate if freeze is required before release. |
| allow_fork_syncing | false | No synchronized forks. No practical effect while no forks exist. |

## Justification of critical decisions

### enforce_admins true

A research repository that publishes verifiable results needs auditable history without exceptions. If the maintainer can bypass protection, the guarantee is conditional on their judgment. With enforce_admins true, every change to main, including the maintainer's, is mediated by a PR and the configured checks. Protection stops depending on discipline and starts depending on the system.

### Zero approvals by bootstrap

GitHub does not allow self-approving PRs. With a single maintainer and required_approving_review_count greater than 0, the repository enters deadlock: there is no way to merge the first PR. Restoring to 1 requires a second person with write permissions. Closure condition in debt D1.

### Linear history

Merge commits add parallel branches to the graph that hinder audit. Squash or rebase produce linear history where each commit in main corresponds to a merged PR. This is especially relevant for a repository whose artifacts are evidence of a procedure: traceability between commit and PR is direct.

### Conversation resolution

A PR may remain open with pending comments. The flag forces resolution before merge. Without it, open conversations are buried by the merge and lost.

## Documented debt

### D1. Required approvals

State: 0. Closure condition: existence of a second person with write permissions.

Action: change required_approving_review_count to 1 and require_last_push_approval to true. Document the change in this file and in A11 (#11).

### D2. Required status checks

State: null. Closure condition: CI workflow with identifiable job (B02 #12).

Action: add required_status_checks.contexts with the job name.

### D3. CODEOWNERS

State: not defined. Closure condition: file ownership structure (A05 #6 or later ADR).

Action: define CODEOWNERS, enable require_code_owner_reviews.

### D4. Mechanism consolidation

State: ruleset main and classic branch protection coexist. Closure condition: full migration to rulesets.

Action: A07 (#8) consolidates into rulesets, which are the mechanism recommended by GitHub since 2023.

## Verification

To verify classic configuration:

```bash
gh api repos/NepoPetro/30kT/branches/main/protection
```
It must show enforce_admins enabled, required_linear_history enabled, allow_force_pushes disabled, allow_deletions disabled, required_conversation_resolution enabled, required_approving_review_count 0.

To verify the ruleset:

```bash
gh api repos/NepoPetro/30kT/rulesets | ConvertFrom-Json | Select-Object id, name, target, enforcement
```
It must show at least one rule with target branch and enforcement active.

To verify that protection rejects direct push to main (destructive test, do not run without understanding):

```bash
git push origin main:main --force
```
It must fail with a protected branch error. Do not run unless confirmation of rejection is needed.

## Configuration change
A change in protection configuration requires:

- PR to this file with justification.
- Written justification of the change and its impact on auditability.
- Record of the change in the corresponding issue.
- Post-change verification with the corresponding GET.

Changes must be reversible. Any unprotection, even temporary, is documented with reason, duration and restoration.

## References
- ADR-001: docs/adr/ADR-001-encoding-en.md.
- ADR-002: docs/adr/ADR-002-multilingue-en.md.
- Tag convention: docs/conventions/tags-en.md.
- A06 (#7): branch protection and repository security.
- A07 (#8): CI hygiene, includes consolidation to rulesets.
- A11 (#11): project acceptance criteria.
- SECURITY.md: vulnerability reporting channel. (SECURITY-en.md)