" Filetype plugin for Compact (Midnight smart contract language)
" Targets Compact compiler 0.31.1 / language version 0.23.0.
" This file is part of compact.vim
" SPDX-License-Identifier: Apache-2.0

if exists('b:did_ftplugin')
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

" Don't spell-check source identifiers
setlocal nospell

" File navigation (gf on bare import paths)
setlocal suffixesadd=.compact

" Match pairs for % navigation
setlocal matchpairs+=<:>

" Keyword characters (for word motions). Compact identifiers may contain
" underscores and dollar signs (e.g. Runner$start).
setlocal iskeyword+=_,$

" Import navigation (gf / [i / :checkpath on import paths)
" Handles all 0.23.0 import forms:
"   import Name;
"   import "path/to/Module";
"   import { a, b as c } from "Module";
"   import Name<Args> prefix P;
let &l:include = '\(\<import\>\|\<from\>\)\s*'
let &l:includeexpr = 'CompactIncludeExpr(v:fname)'

" Compiler
compiler compact

" Format options
setlocal formatoptions-=t  " Don't auto-wrap text
setlocal formatoptions+=c  " Auto-wrap comments
setlocal formatoptions+=r  " Continue comments on Enter
setlocal formatoptions+=o  " Continue comments with o/O
setlocal formatoptions+=q  " Allow formatting comments with gq
setlocal formatoptions+=l  " Don't break long lines in insert mode

" Resolve an import target to a file path.
" Prefers a quoted path, then the module after `from`, then the name after
" `import`.  Falls back to the name Vim found.
function! CompactIncludeExpr(fname) abort
  let l:line = getline('.')

  " import "path" / from "path"
  let l:path = matchstr(l:line, '"[^"]*"')
  if empty(l:path)
    " import { a, b } from Name
    let l:path = matchstr(l:line, '\vfrom\s+\zs[a-zA-Z_$][a-zA-Z0-9_$]*')
  endif
  if empty(l:path)
    " import Name / import Name<...>
    let l:path = matchstr(l:line, '\v(import|from)\s+\zs[a-zA-Z_$][a-zA-Z0-9_$]*')
  endif
  if empty(l:path)
    let l:path = a:fname
  endif

  " Strip surrounding quotes
  let l:path = substitute(l:path, '^["'']', '', '')
  let l:path = substitute(l:path, '["'']$', '', '')
  " Strip leading ./
  let l:path = substitute(l:path, '^\.\/', '', '')
  return l:path
endfunction

" Undo ftplugin settings when switching filetypes (single line: line
" continuation is unavailable in Vi-compatible mode).
let b:undo_ftplugin = 'setlocal commentstring< comments< expandtab< shiftwidth< softtabstop< tabstop< suffixesadd< matchpairs< iskeyword< formatoptions< makeprg< errorformat< include< includeexpr< spell< | unlet! b:current_compiler'
