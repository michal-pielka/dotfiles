# Global rules

## Responses
- Short, concise, packed with information. Simple language.
- No filler, no repeating what I said.
- Never use em-dashes (—), use a regular hyphen (-) instead.
- Report failures and blockers plainly. Never claim success you haven't verified.

## Tools
- Use `rg` instead of `grep`.
- Use `fd` instead of `find`.
- Use `jq` to read and query JSON. Don't use it to edit files, it rewrites their formatting.
- Use `gh` for GitHub (PRs, issues, CI runs).
- Use `uv` for Python: `uv run`, `uv add`, `uvx`. Never use bare `pip`.

## Code
- Change only what the task needs. Don't refactor or reformat unrelated code.
- Write simple, clean, production-grade code. Readability and maintainability first: clear names, small functions, no needless abstraction.
- Fewer lines is better, as long as the code stays clear. No clever one-liners that are hard to read.
- Follow the project's existing style, patterns, and structure. They come before these rules.
- Follow the project's linters and formatters (ruff, clippy, eslint, etc.). Fix only what they flag in lines you touched.
- When a language has a standard format (rustfmt, gofmt), follow it even if the project has no config.
- Prefer the standard library. Add a dependency only when it saves real work.
- Don't add features or error handling for cases that can't happen.
- Naming: kebab-case for files and directories, snake_case in code.

## Verification
- Before claiming a task is done: build or type-check and lint the code you changed. Say what ran and whether it passed.
- If the project has tests, run the ones that cover your change.
- Never weaken, skip, or delete a test to make it pass.
- Use only APIs, functions, and flags you have verified exist in the repo or its dependencies.

## Secrets
- Never print or commit secret values (tokens, keys, passwords, cookies, .env contents). Redact them in output.
- Read secrets from env vars or ignored config files, never hardcode them.

## Comments
- Keep them minimal. Only comment where the code isn't obvious.
- Describe what the code does or why. Usually 1 line, at most 3. Simple language.
- A short `TODO:` marker for a known gap is fine.
- Never mention tasks, PRs, history, or plans (e.g. "added for X", "will be introduced in a future PR").

## Commits
- Don't commit, push, or change git history unless I ask.
- Keep commits small: one change per commit.
- Conventional Commits: `feat:`, `fix:`, `chore:`, `refactor:`, `docs:`, `test:`, etc. Subject lowercase, imperative, short (e.g. `fix: handle empty config`).
- Body optional: 1-3 short sentences, only when the subject can't carry the why.
- Never sign commits or add trailers (`Co-authored-by`, "Generated with", etc.).
