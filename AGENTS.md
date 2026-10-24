# AGENTS.md

Guidance for AI coding agents working in this repository. Humans should read
[CONTRIBUTING.md](CONTRIBUTING.md) first.

## What this is

`compact.vim` is Vim/Neovim support for the [Compact](https://docs.midnight.network/develop/reference/compact/lang-ref)
smart-contract language. It is a plain plugin with no build step: Vimscript under
`ftdetect/ syntax/ ftplugin/ indent/ compiler/`, Lua under `lua/ plugin/`, and
tree-sitter queries under `queries/compact/`.

## Pinned language target — do not drift

The plugin targets the **mainnet-supported** Compact line:

| Component | Version |
|-----------|---------|
| Compiler  | **0.31.1** |
| Language  | **0.23.0** |
| Runtime   | 0.16.0    |
| Ledger    | 8         |

Canonical compiler source: [`LFDT-Minokawa/compact`](https://github.com/LFDT-Minokawa/compact)
at tag `compactc-v0.31.1` (grammar/keyword references live in `doc/`).

**Do not add post-0.23.0 constructs** — e.g. `emit`, `event`, `log`,
`arguments`, `eval`, `keccak256`, `sha512`, `PublicAddress`, `Secp256r1*`,
`Curve25519*`. When in doubt, check `doc/compact-grammar.mdx` and
`doc/compact-keywords.mdx` at that tag. See
[`docs/migration-0.31.1.md`](docs/migration-0.31.1.md).

## Tree-sitter

- Grammar: [`1NickPappas/compact-tree-sitter`](https://github.com/1NickPappas/compact-tree-sitter)
  (branch `main`, grammar `0.2.0`). The old `midnightntwrk/compact-tree-sitter`
  is **archived** — do not point at or reference it as current.
- The grammar ships its own `highlights.scm`. This plugin only ships
  `queries/compact/{folds,indents,locals,textobjects}.scm`.
- Queries **must** live under `queries/`, **not** `after/queries/` —
  `vim.treesitter.query.get` does not search `after/queries/`.
- When the grammar renames/removes nodes, update the queries and validate them
  against the grammar's `src/node-types.json` before committing.

## Vimscript style

- Prefer single-quoted strings (`'...'`).
- Use case-sensitive operators: `=~#` / `!~#`.
- Keep `undo_ftplugin` on a single line (line continuation is unavailable in
  Vi-compatible mode).
- 2-space indent, LF, UTF-8, no trailing whitespace (see `.editorconfig`).
- Keep every file mode `644`.
- **`vint` must pass** — CI enforces it with no suppression. Run locally:
  `vint ftdetect/ syntax/ ftplugin/ indent/ compiler/`.

## Verifying changes

1. `vint ftdetect/ syntax/ ftplugin/ indent/ compiler/`
2. Load in both editors, e.g.
   `nvim --headless -u NONE -c "set rtp+=$(pwd)" -c "filetype plugin indent on" -c "syntax on"`
   (and the Vim 9 equivalent).
3. Confirm `:set ft?`, `:setlocal iskeyword?`, `:setlocal spell?`, `:compiler`.
4. `gf` must resolve all four import forms; `:make` quickfix must parse
   `Exception: <file> line <l> char <c>: <msg>` (no comma, includes the file).

## Releases

Changelog-driven and tag-driven:

1. Move `[Unreleased]` entries under a new `## [X.Y.Z] - YYYY-MM-DD` in
   [`CHANGELOG.md`](CHANGELOG.md), refresh the compare links, and keep an empty
   `[Unreleased]` on top.
2. Commit, then create an annotated tag: `git tag -a vX.Y.Z -m "Release vX.Y.Z"`.
3. `git push origin main --follow-tags`.
4. `.github/workflows/release.yml` creates a GitHub Release from the matching
   changelog section. Note: the workflow must exist at the tagged commit, so new
   workflows cannot retroactively release older tags.

## License

MIT — see [`LICENSE`](LICENSE). Some files may carry Apache-2.0 SPDX headers
inherited from upstream Compact sources; reconcile these before relicensing.
