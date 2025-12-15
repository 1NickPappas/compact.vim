# compact.vim

[![License: MIT](https://img.shields.io/badge/License-MIT-blue.svg)](LICENSE)
[![CI](https://github.com/midnightntwrk/compact.vim/actions/workflows/ci.yml/badge.svg)](https://github.com/midnightntwrk/compact.vim/actions/workflows/ci.yml)

Vim/Neovim support for the [Compact](https://docs.midnight.network/develop/reference/compact/lang-ref) smart contract language (Midnight network).

## Features

- Syntax highlighting (traditional Vim + Tree-sitter for Neovim)
- Filetype detection for `.compact` files
- Comment support (`//`)
- Indentation
- Integration with nvim-treesitter

## Installation

### lazy.nvim

```lua
{
    dir = "~/Documents/midnight/lsp/compact.vim",
    ft = "compact",
}
```

Or from GitHub (when published):

```lua
{
    "midnight-ntwrk/compact.vim",
    ft = "compact",
}
```

### vim-plug

```vim
Plug '~/Documents/midnight/lsp/compact.vim'
```

### Manual

Clone to your pack directory:

```bash
# Neovim
git clone https://github.com/midnight-ntwrk/compact.vim \
    ~/.local/share/nvim/site/pack/plugins/start/compact.vim

# Vim
git clone https://github.com/midnight-ntwrk/compact.vim \
    ~/.vim/pack/plugins/start/compact.vim
```

## Tree-sitter (Neovim)

For tree-sitter highlighting in Neovim, install the parser:

```vim
:TSInstall compact
```

Or install manually from the [tree-sitter-compact](https://github.com/midnight-ntwrk/tree-sitter-compact) repository.

## Related

- [compact-lsp](../compact-lsp) - Language Server Protocol implementation
- [tree-sitter-compact](https://github.com/midnight-ntwrk/tree-sitter-compact) - Tree-sitter grammar

## License

MIT
