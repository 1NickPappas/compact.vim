# Migration plan: Compact compiler 0.31.1 (language 0.23.0)

Status: **implemented**
Owner: compact.vim maintainers
Last updated: 2026-10-22

> Implementation verified with `vint` (clean), Vim 9.1 and Neovim 0.12 headless
> load tests, `gf` import navigation on all four import forms, and a `:make`
> quickfix run against `compact 0.31.1` (language 0.23.0).
>
> Still open (maintainer decision): reconcile the Apache-2.0 SPDX headers with the
> repository's MIT `LICENSE`.

This document records what must change in `compact.vim` to align with the
Compact toolchain **0.31.1** / language version **0.23.0**, which is the
current stable (pinned) line for SDK 4.1.x on Midnight Mainnet.

It is both the investigation record and the migration checklist.

---

## 1. Target and sources

| Item | Value |
|---|---|
| Compact toolchain | **0.31.1** |
| Compact language version | **0.23.0** |
| Compact runtime version | **0.16.0** |
| Midnight ledger | 8 |
| Release tag | `compactc-v0.31.1` |

Reference sources (all under `github.com/LFDT-Minokawa/compact` at
`compactc-v0.31.1` unless noted):

- Language grammar: `doc/compact-grammar.mdx`
- Keyword list: `doc/compact-keywords.mdx`
- Language reference: `doc/compact-reference.mdx`
- Official Vim syntax: `editor-support/vim/syntax/compact.vim`
- Official VS Code grammar: `editor-support/vsc/compact/syntaxes/compact.tmLanguage.json`
- Release notes: `doc/release-notes/toolchain-0.29.0.md`, `toolchain-0.30.0.md`, `toolchain-0.31.0.md`
- Tree-sitter grammar: `github.com/midnightntwrk/compact-tree-sitter` (`main`)

> **Version pinning rule.** Language 0.23.0 is the target. Do **not** backport
> constructs introduced after it (languages 0.24–0.27): `emit`, `event`, `log`,
> `arguments`, `eval`, `keccak256`, `sha512`, `PublicAddress`, `Secp256r1*`,
> `Curve25519*`, `jubjubSchnorrVerify`, `ecNeg`, etc.

### Version history relevant to this migration

| Toolchain | Language | Notable changes |
|---|---|---|
| 0.29.0 | 0.21.0 | `constructNativePoint`; `NativePointX/Y` → `nativePointX/Y`; external circuit syntax removed |
| 0.30.0 | 0.22.0 | Targets ledger 8; `--ledger-version`/`--runtime-version`; `--compact-path`/`--trace-search`; `NativePoint` → `JubjubPoint`; hashing opaque values is now an error; new include/import search order |
| 0.31.0 | 0.23.0 | Untaken-branch proof workarounds; generic `for` bounds; ledger layout in `contract-info.json`; `convertBytesToUint` `maxval` now `bigint` |
| 0.31.1 | 0.23.0 | Patch release; no language change |

---

## 2. Language 0.23.0 conformance checklist

### 2.1 Keywords and reserved words

Canonical 0.23.0 lists (`doc/compact-keywords.mdx`).

**Module-related:** `export`, `from`, `import`, `module`, `prefix`

**Statement / expression:** `as`, `assert`, `circuit`, `const`, `constructor`,
`contract`, `default`, `disclose`, `else`, `enum`, `fold`, `for`, `if`,
`include`, `ledger`, `map`, `new`, `of`, `pad`, `pragma`, `pure`, `return`,
`sealed`, `slice`, `struct`, `type`, `witness`

**Built-in data types:** `Boolean`, `Bytes`, `Field`, `Opaque`, `Uint`, `Vector`

**Boolean literals:** `false`, `true`

**Reserved for future use:** `await`, `break`, `case`, `catch`, `class`,
`continue`, `debugger`, `delete`, `do`, `extends`, `finally`, `function`,
`implements`, `in`, `instanceof`, `interface`, `let`, `null`, `package`,
`private`, `protected`, `public`, `static`, `super`, `switch`, `this`, `throw`,
`try`, `typeof`, `var`, `void`, `while`, `with`, `yield`

**Standard-library types** highlighted by the official editor support:
`Kernel`, `Counter`, `Set`, `Map`, `List`, `MerkleTree`, `HistoricMerkleTree`

### 2.2 Syntax constructs that must be highlighted

- Casts: `expr as Type`
- Type aliases: `[export] [new] type Name<...> = Type;`
- Slices: `slice<k>(expr, index)`
- Assertions: `assert(expr, message)` (an **expression**, not a statement)
- Imports: `import Name;`, `import "path";`, `import { a, b as c } from M;`, `import M<...> prefix P;`
- Struct spread: `...expr`
- Identifier charset: first char alphabetic | `$` | `_`; subsequent alphabetic | digit | `$` | `_`

---

## 3. Current `compact.vim` baseline

| File | Role |
|---|---|
| `syntax/compact.vim` | Regex highlighting (Vim + Neovim fallback) |
| `ftdetect/compact.vim` | `*.compact` filetype detection |
| `ftplugin/compact.vim` | Comments, indent, `gf` navigation, `compiler compact` |
| `compiler/compact.vim` | `:make` → `compactc --vscode --skip-zk` |
| `indent/compact.vim` | Expression-based indentation |
| `queries/compact/*.scm` | Tree-sitter folds/indents/locals/textobjects (highlights come from the grammar) |
| `lua/compact/init.lua`, `plugin/compact.lua` | Neovim tree-sitter wiring |

The plugin currently reflects roughly language 0.15–0.17.

---

## 4. Gap analysis and required changes

### 4.1 `syntax/compact.vim`

| Gap | Action |
|---|---|
| Missing keywords `as`, `from`, `new`, `type`, `slice` | Add to appropriate groups |
| Missing entire future-reserved-word group | Add `compactFutureReservedWord` |
| Missing stdlib types `Kernel Counter Set Map List MerkleTree HistoricMerkleTree` | Add to `compactType` |
| `assert` treated as a statement | Move to builtin/expression group |
| No `$` identifier support | Add identifier rule / `iskeyword` |
| Line comment lacks `contains=compactTodo` | Add |
| Dead `compactFile` rule (never contained) | Remove or wire into `include` |
| Block vs doc comment precedence unverified | Verify/simplify |
| String escape `skip='\\"'` imprecise | Use `skip="\\\\\|\\\""` |
| SPDX header says Apache-2.0, repo `LICENSE` is MIT | Reconcile |

### 4.2 `ftdetect/compact.vim`

- Add `autocmd FileType compact setlocal nospell` (matches official editor support).

### 4.3 `ftplugin/compact.vim`

- Add `$` to `iskeyword`.
- Extend `include` / `includeexpr` to resolve all four 0.23.0 import forms
  (especially `import { a, b as c } from "Module"`).
- Verify `gf` / `[I` on each form.

### 4.4 `compiler/compact.vim`

- Default to the supported front door `compact compile` (devtools CLI), while
  keeping `compactc` overridable via `g:compact_compiler_binary`.
- Fix `errorformat` to capture the file path. Canonical pattern (from the VS Code
  `ErrorMatcher.test.ts`):
  `^Exception: (.*?) line (\d+), char (\d+): (.*)$`
  → errorformat: `Exception:\ %f\ line\ %l,\ char\ %c:\ %m`
- Add patterns for internal errors (`Exception in <pass>: (internal error) ...`)
  and `... command not found: ...`.

### 4.5 Tree-sitter queries

- **The upstream grammar is archived.** GitHub reports
  `midnightntwrk/compact-tree-sitter` as `archived: true` (last commit
  2026-04-08), with no official successor (the `LFDT-Minokawa` org has no
  tree-sitter repo and nvim-treesitter ships no `compact` parser config).
- **The plugin now targets the community-maintained fork**
  **`1NickPappas/compact-tree-sitter`** (grammar `0.2.0`), which explicitly targets
  Compact **language 0.23.0 / toolchain 0.31.1** and fixes the old grammar's gaps:
  type aliases, `assert(expr, msg)`, `$` identifiers, `slice`, `new`/`type`, import
  selections, and spread elements. It ships an up-to-date `queries/highlights.scm`.
- **Breaking node changes** in the fork required query updates:
  - `edecl` removed → dropped from `folds.scm`; added `type_alias_declaration`.
  - `assert_stmt` removed (use `assert_term`), `slice_term`/`type_name`/`const_binding`
    added.
  - `struct_named_filed_initializer` → `struct_named_field_initializer` (typo fix).
  - `const_stmt`'s `pattern` field moved to the new `const_binding` node →
    `locals.scm` updated.
  - The plugin's forked `highlights.scm` was **deleted** in favour of the grammar's
    own maintained `queries/highlights.scm`.
- The plugin retains `folds.scm`, `indents.scm`, `locals.scm`, and `textobjects.scm`
  (the grammar does not ship these).
- **Query location fix:** these moved from `after/queries/compact/` to
  `queries/compact/`. `vim.treesitter.query.get` searches `queries/` but **not**
  `after/queries/`, so the `after/` copies only worked when a plugin manager added
  the plugin's `after/` directory to `runtimepath`; base queries belong in `queries/`.
  (The `highlights.scm` override that belonged in `after/` is gone.)
- **Parser-registration gap (fixed):** `plugin/compact.lua` only called
  `vim.treesitter.start()`; the `parser_config.compact` entry lived in
  `lua/compact/init.lua#M.setup()`, which was never invoked automatically, so
  `:TSInstall compact` had nothing to install. `plugin/compact.lua` now
  auto-invokes `require('compact').setup()`.

### 4.6 Metadata

- README: state supported compiler 0.31.1 / language 0.23.0.
- `CHANGELOG.md`: populate `[Unreleased]`.
- Normalize file modes to `644` (all files are currently `755`).

---

## 5. Migration steps

1. **Create this document** (`docs/migration-0.31.1.md`).
2. **`syntax/compact.vim`** — re-base keyword, type, and reserved-word lists on the
   official 0.31.1 syntax; fix `assert`, comments, dead rules, and `$`.
3. **`ftdetect/compact.vim`** — add `nospell`.
4. **`ftplugin/compact.vim`** — `iskeyword` `$`; import-aware `includeexpr`.
5. **`compiler/compact.vim`** — `compact compile` front door; corrected
   `errorformat`.
6. **Tree-sitter** — fix grammar URL; validate/adjust `highlights.scm`; file
   upstream grammar issues (type alias, modern `assert`, `$` identifiers). Keyword
   additions for `from`/`new`/`slice` are blocked pending the grammar fix.
7. **Metadata** — README version statement; CHANGELOG; file modes.
8. **Verify** — see section 6.

---

## 6. Verification

- `vint ftdetect/ syntax/ ftplugin/ indent/ compiler/`
- Load in Neovim and open a 0.23.0 sample contract exercising:
  type alias / `new type`, `as` cast, `slice<>`, `assert(expr, msg)`,
  import selections / `as` / `prefix`, and `$` identifiers.
- Confirm tree-sitter highlighting, indent, folds, and text objects on the sample.
- Confirm `:make` populates the quickfix list with correct file/line/column and
  jumps correctly.
- Optionally compile the sample with `compact compile +0.31.1` to validate syntax.

---

## 7. Tree-sitter resolution

Resolved by adopting the community-maintained fork
[`1NickPappas/compact-tree-sitter`](https://github.com/1NickPappas/compact-tree-sitter):

- Targets Compact language 0.23.0 / toolchain 0.31.1.
- Grammar `0.2.0` aligns node names with the compiler AST and removes legacy
  syntax (body-less `edecl`, old `assert_stmt`).
- Validated against the compiler corpus by the fork's `conformance.sh`.
- Licensed Apache-2.0, same as upstream, with attribution in `NOTICE`.

The plugin registers this grammar URL in `lua/compact/init.lua`. If the fork ever
moves, update that single default (or pass `grammar_path` to `require('compact').setup()`).

Separately worth reporting to `github.com/LFDT-Minokawa/compact` (docs):

- `doc/api/CompactStandardLibrary/exports.md` at `compactc-v0.31.1` appears stale
  (lists `NativePoint`, renamed to `JubjubPoint` in 0.30.0).

---

## 8. Appendix: official 0.31.1 Vim syntax keyword groups

For reference, the canonical file classifies tokens as follows:

- `compactKeyword`: `as assert circuit constructor contract default disclose enum export from import include ledger module new pad pragma prefix pure return sealed slice struct type witness`
- `compactBoolean`: `true false`
- `compactType`: `Boolean Bytes Opaque Field Vector Uint`
- `compactType` (stdlib): `Kernel Counter Set Map List MerkleTree HistoricMerkleTree`
- `compactConditional`: `if else`
- `compactStorageClass`: `const`
- `compactFutureReservedWord`: `this await break case catch class continue debugger delete do extends finally function in instanceof null super switch throw try typeof var void while with yield implements interface package private protected public let static`
- `compactRepeat`: `map fold for of`
- Identifiers: `[a-zA-Z_$][a-zA-Z0-9_$]*`

Note: `emit` is **not** part of 0.23.0 despite appearing in `main`.
