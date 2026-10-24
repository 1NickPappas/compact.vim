" Compiler plugin for Compact (Midnight smart contract language)
" Targets Compact compiler 0.31.1 / language version 0.23.0.
" This file is part of compact.vim
" SPDX-License-Identifier: Apache-2.0

if exists('current_compiler')
  finish
endif
let current_compiler = 'compact'

" Use the supported `compact compile` front door by default.  Set
" g:compact_compiler_binary to a raw compiler (e.g. 'compactc') to bypass the
" devtools CLI, or g:compact_compiler_options to change the flags.
let s:binary  = get(g:, 'compact_compiler_binary', 'compact')
let s:options = get(g:, 'compact_compiler_options', '--vscode --skip-zk')

" `compact` is the devtools CLI and reaches the compiler via `compile`.
" A raw compiler binary takes the source and target paths directly.
if fnamemodify(s:binary, ':t') ==# 'compact'
  let s:command = s:binary . ' compile'
else
  let s:command = s:binary
endif
let s:command .= ' ' . s:options . ' %:S %:h:S'

execute 'CompilerSet makeprg=' . escape(s:command, ' ')

" Error messages look like:
"   Exception: <file> line <l> char <c>: <message>
"   Exception in <pass>: (internal error) <message>
" The compiler stops at the first parse error.
CompilerSet errorformat=Exception:\ %f\ line\ %l\ char\ %c:\ %m,Exception\ in\ %.%#:\ (internal\ error)\ %m,%+G%.%#
