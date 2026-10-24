# Changelog

All notable changes to this project will be documented in this file.

The format is based on [Keep a Changelog](https://keepachangelog.com/en/1.1.0/),
and this project adheres to [Semantic Versioning](https://semver.org/spec/v2.0.0.html).

## [Unreleased]

### Added
- Migration documentation for Compact compiler 0.31.1 / language 0.23.0 (`docs/migration-0.31.1.md`).
- Highlighting for language 0.23.0 keywords (`as`, `from`, `new`, `type`, `slice`),
  standard-library types (`Kernel`, `Counter`, `Set`, `Map`, `List`, `MerkleTree`,
  `HistoricMerkleTree`), and the future reserved-word set.
- Binary and octal integer literals.
- `nospell` for Compact buffers.

### Changed
- `:make` now drives the supported `compact compile` front door (`compactc` can
  still be selected via `g:compact_compiler_binary`).
- Import navigation (`gf`, `[i`, `:checkpath`) now handles all four 0.23.0 import
  forms: `import Name;`, `import "path";`, `import { a, b as c } from "M";`,
  and `import Name<...> prefix P;`.
- `$` is now part of Compact identifier word motions.
- Tree-sitter support now targets the community-maintained grammar
  [1NickPappas/compact-tree-sitter](https://github.com/1NickPappas/compact-tree-sitter)
  (grammar 0.2.0), which supports Compact 0.31.1 / language 0.23.0. The upstream
  `midnightntwrk/compact-tree-sitter` is archived.
- Dropped the plugin's forked `highlights.scm` in favour of the grammar's own
  maintained query; folds/indents/locals/textobjects updated for the grammar's
  renamed nodes (`edecl` removed, `const_binding`, `type_alias_declaration`).
- Moved the tree-sitter queries from `after/queries/compact/` to `queries/compact/`
  so Neovim's query loader finds them without relying on the `after/` directory
  being on `runtimepath`.

### Fixed
- Quickfix entries now include the source file; the `errorformat` never captured a
  file name and used the wrong separator.
- `plugin/compact.lua` now registers the tree-sitter parser config automatically,
  so `:TSInstall compact` can find it.

## [0.1.0] - 2025-01-XX

### Added
- Initial release
- File type detection for `.compact` files
- Syntax highlighting (regex-based for Vim, tree-sitter for Neovim)
- Indentation rules
- Tree-sitter query support for Neovim
- LSP client configuration helper
