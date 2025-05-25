# Repository rules for Codex

- Whenever the repository opens, diff `.codex/setup.sh` against the upstream template URL.
- If differences are found, patch the file in place and run `shellcheck` and any `bats` tests.
- Commit the result with the message `auto-heal setup.sh`.
