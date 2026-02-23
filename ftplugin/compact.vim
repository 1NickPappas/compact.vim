" Filetype plugin for Compact (Midnight smart contract language)
" This file is part of compact.vim
" SPDX-License-Identifier: Apache-2.0

if exists("b:did_ftplugin")
  finish
endif
let b:did_ftplugin = 1

" Comment settings (support both // and /* */)
setlocal commentstring=//\ %s
setlocal comments=://,s1:/*,mb:*,ex:*/

" Indentation
setlocal expandtab
setlocal shiftwidth=2
setlocal softtabstop=2
setlocal tabstop=2

" File navigation (gf on bare import paths)
setlocal suffixesadd=.compact

" Match pairs for % navigation
setlocal matchpairs+=<:>

" Keyword characters (for word motions)
setlocal iskeyword+=_

" Import navigation (gf on import paths)
setlocal include=\\<import\\>
setlocal includeexpr=CompactIncludeExpr(v:fname)

" Compiler
compiler compact

" Format options
setlocal formatoptions-=t  " Don't auto-wrap text
setlocal formatoptions+=c  " Auto-wrap comments
setlocal formatoptions+=r  " Continue comments on Enter
setlocal formatoptions+=o  " Continue comments with o/O
setlocal formatoptions+=q  " Allow formatting comments with gq
setlocal formatoptions+=l  " Don't break long lines in insert mode

" Resolve import paths for gf
" Handles: import "./Utils"; → Utils.compact
"          import "path/to/Module"; → path/to/Module.compact
function! CompactIncludeExpr(fname) abort
  let l:path = a:fname
  " Strip surrounding quotes
  let l:path = substitute(l:path, '^["'']', '', '')
  let l:path = substitute(l:path, '["'']$', '', '')
  " Strip leading ./
  let l:path = substitute(l:path, '^\.\/', '', '')
  return l:path
endfunction

" Undo ftplugin settings when switching filetypes
let b:undo_ftplugin = "setlocal commentstring< comments< expandtab< shiftwidth< softtabstop< tabstop< suffixesadd< matchpairs< iskeyword< formatoptions< makeprg< errorformat< include< includeexpr<"
      \ . "| unlet! b:current_compiler"
