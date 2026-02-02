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
setlocal shiftwidth=4
setlocal softtabstop=4
setlocal tabstop=4

" Match pairs for % navigation
setlocal matchpairs+=<:>

" Keyword characters (for word motions)
setlocal iskeyword+=_

" Format options
setlocal formatoptions-=t  " Don't auto-wrap text
setlocal formatoptions+=c  " Auto-wrap comments
setlocal formatoptions+=r  " Continue comments on Enter
setlocal formatoptions+=o  " Continue comments with o/O
setlocal formatoptions+=q  " Allow formatting comments with gq
setlocal formatoptions+=l  " Don't break long lines in insert mode

" Undo ftplugin settings when switching filetypes
let b:undo_ftplugin = "setlocal commentstring< comments< expandtab< shiftwidth< softtabstop< tabstop< matchpairs< iskeyword< formatoptions<"
