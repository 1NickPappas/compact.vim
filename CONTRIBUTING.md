# Contributing to compact.vim

Thank you for your interest in contributing to compact.vim! This document provides guidelines for contributing.

## Getting Started

1. Fork the repository
2. Clone your fork
3. Create a branch for your changes

## Development

### Structure

```
compact.vim/
├── ftdetect/compact.vim    # File type detection
├── syntax/compact.vim      # Syntax highlighting (regex-based)
├── ftplugin/compact.vim    # Filetype settings
├── indent/compact.vim      # Indentation rules
├── lua/compact/            # Lua modules for Neovim
├── plugin/compact.lua      # Plugin entry point
└── after/queries/compact/  # Tree-sitter queries
```

### Testing

Test your changes with both Vim and Neovim:

```bash
# Neovim
nvim test.compact

# Vim
vim test.compact
```

## Submitting Changes

1. Ensure your code follows the existing style
2. Test with both Vim and Neovim if possible
3. Update documentation as needed
4. Open a Pull Request with a clear description

## Code Style

- Use 2 spaces for indentation in Vimscript and Lua
- Follow existing naming conventions
- Add comments for complex logic

## Reporting Issues

When reporting issues, please include:

- Vim/Neovim version
- Operating system
- Steps to reproduce
- Expected vs actual behavior

## Questions?

Feel free to open an issue for questions about contributing.
