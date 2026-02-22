" Compiler plugin for Compact (Midnight smart contract language)
" This file is part of compact.vim
" SPDX-License-Identifier: Apache-2.0

if exists('current_compiler')
  finish
endif
let current_compiler = 'compact'

let s:binary = get(g:, 'compact_compiler_binary', 'compactc')
let s:options = get(g:, 'compact_compiler_options', '--vscode --skip-zk')

execute 'CompilerSet makeprg=' . escape(s:binary . ' ' . s:options . ' %:S %:h:S', ' ')
" TODO: compactc stops at the first parse error; support multiple errors if
" a future compiler version adds error recovery.
CompilerSet errorformat=Exception:\ %.%#\ line\ %l\ char\ %c:\ %m,%-G%.%#
