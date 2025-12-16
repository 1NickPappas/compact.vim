# compact.vim

[![License: MIT](https://img.shields.io/badge/License-MIT-blue.svg)](LICENSE)
[![CI](https://github.com/1NickPappas/compact.vim/actions/workflows/ci.yml/badge.svg)](https://github.com/1NickPappas/compact.vim/actions/workflows/ci.yml)

Vim and Neovim support for the [Compact](https://docs.midnight.network/develop/reference/compact/lang-ref) smart contract language used on the [Midnight](https://midnight.network) blockchain.

## Features

- **Syntax highlighting** — Full regex-based highlighting for Vim and Neovim
- **Tree-sitter support** — Native tree-sitter integration for Neovim (via nvim-treesitter)
- **Filetype detection** — Automatic detection for `.compact` files
- **Smart indentation** — Context-aware indentation for blocks, functions, and structs
- **Comment support** — Single-line (`//`) and block comments (`/* */`)
- **Editor integration** — Proper settings for `matchpairs`, `formatoptions`, and `iskeyword`

## Requirements

- Vim 8.0+ or Neovim 0.5+
- (Optional) [nvim-treesitter](https://github.com/nvim-treesitter/nvim-treesitter) for tree-sitter highlighting
- (Optional) [compact-lsp](https://github.com/1NickPappas/compact-lsp) for full IDE features

## Installation

### [lazy.nvim](https://github.com/folke/lazy.nvim)

```lua
{
    "1NickPappas/compact.vim",
    ft = "compact",
}
```

### [packer.nvim](https://github.com/wbthomason/packer.nvim)

```lua
use {
    "1NickPappas/compact.vim",
    ft = "compact",
}
```

### [vim-plug](https://github.com/junegunn/vim-plug)

```vim
Plug '1NickPappas/compact.vim'
```

### [Vundle](https://github.com/VundleVim/Vundle.vim)

```vim
Plugin '1NickPappas/compact.vim'
```

### Native Package Manager (Vim 8+ / Neovim)

```bash
# Neovim
git clone https://github.com/1NickPappas/compact.vim \
    ~/.local/share/nvim/site/pack/plugins/start/compact.vim

# Vim
git clone https://github.com/1NickPappas/compact.vim \
    ~/.vim/pack/plugins/start/compact.vim
```

## Tree-sitter Support (Neovim)

For enhanced syntax highlighting using tree-sitter in Neovim:

1. Install [nvim-treesitter](https://github.com/nvim-treesitter/nvim-treesitter)
2. Install the Compact parser:

```vim
:TSInstall compact
```

The tree-sitter queries are included in this plugin and will be used automatically once the parser is installed.

## Language Server

For full IDE features (diagnostics, completion, go-to-definition, hover, etc.), use [compact-lsp](https://github.com/1NickPappas/compact-lsp).

## Related Projects

| Project | Description |
|---------|-------------|
| [compact-lsp](https://github.com/1NickPappas/compact-lsp) | Language Server Protocol implementation |
| [compact-tree-sitter](https://github.com/midnightntwrk/compact-tree-sitter) | Tree-sitter grammar for Compact |

## Contributing

Contributions are welcome! Please see [CONTRIBUTING.md](CONTRIBUTING.md) for guidelines.

## License

[MIT](LICENSE)
