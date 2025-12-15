" Indent file for Compact (Midnight smart contract language)
" This file is part of compact.vim
" SPDX-License-Identifier: Apache-2.0

if exists("b:did_indent")
  finish
endif
let b:did_indent = 1

setlocal indentexpr=GetCompactIndent()
setlocal indentkeys=0{,0},0),0],!^F,o,O,e

if exists("*GetCompactIndent")
  finish
endif

function! GetCompactIndent()
  let lnum = prevnonblank(v:lnum - 1)

  " Start of file
  if lnum == 0
    return 0
  endif

  let prev = getline(lnum)
  let curr = getline(v:lnum)
  let ind = indent(lnum)

  " Increase indent after { [ (
  if prev =~ '[{[(]\s*$'
    let ind += &shiftwidth
  endif

  " Decrease indent for } ] )
  if curr =~ '^\s*[}\])]'
    let ind -= &shiftwidth
  endif

  " Handle else
  if curr =~ '^\s*else\>'
    if prev !~ '}\s*$'
      let ind -= &shiftwidth
    endif
  endif

  return ind
endfunction

let b:undo_indent = "setlocal indentexpr< indentkeys<"
