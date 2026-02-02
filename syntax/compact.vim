" Vim syntax file for Compact (Midnight smart contract language)
" This file is part of compact.vim
" SPDX-License-Identifier: Apache-2.0

if exists("b:current_syntax")
  finish
endif

" Keywords
syn keyword compactKeyword pragma import export module include
syn keyword compactKeyword ledger circuit witness contract struct enum
syn keyword compactKeyword constructor prefix
syn keyword compactModifier pure sealed

" Control flow
syn keyword compactConditional if else
syn keyword compactRepeat for of
syn keyword compactStatement return assert const default

" Built-in functions
syn keyword compactBuiltin map fold disclose pad

" Built-in types
syn keyword compactType Boolean Field Uint Bytes Opaque Vector

" Boolean literals
syn keyword compactBoolean true false

" Numbers (natural numbers, hex)
syn match compactNumber "\<\d\+\>"
syn match compactNumber "\<0x[0-9a-fA-F]\+\>"

" Version numbers (e.g., 0.27.0)
syn match compactVersion "\<\d\+\.\d\+\(\.\d\+\)*\>"

" Strings
syn region compactString start='"' end='"' skip='\\"'

" File paths (in include statements)
syn region compactFile start="<" end=">" contained

" Comments
syn match compactComment "//.*$"
syn region compactBlockComment start="/\*" end="\*/" contains=compactTodo
syn region compactDocComment start="/\*\*" end="\*/" contains=compactTodo

" Highlight TODO/FIXME in comments
syn keyword compactTodo contained TODO FIXME XXX NOTE

" Operators
syn match compactOperator "="
syn match compactOperator "+="
syn match compactOperator "-="
syn match compactOperator "=="
syn match compactOperator "!="
syn match compactOperator "<="
syn match compactOperator ">="
syn match compactOperator "&&"
syn match compactOperator "||"
syn match compactOperator "=>"
syn match compactOperator "\.\."
syn match compactOperator "\.\.\."
syn match compactOperator "[+\-*<>!?:]"

" Delimiters
syn match compactDelimiter "[;,]"
syn match compactBracket "[(){}\[\]]"

" Type parameters (generic)
syn match compactTypeParam "#\w\+"

" Function definitions - highlight the name after circuit/witness
syn match compactFunctionDef "\v(circuit|witness)\s+\zs\w+"

" Struct/enum/contract names
syn match compactTypeDef "\v(struct|enum|contract|module)\s+\zs\w+"

" Highlighting links
hi def link compactKeyword Keyword
hi def link compactModifier StorageClass
hi def link compactConditional Conditional
hi def link compactRepeat Repeat
hi def link compactStatement Statement
hi def link compactBuiltin Function
hi def link compactType Type
hi def link compactBoolean Boolean
hi def link compactNumber Number
hi def link compactVersion Number
hi def link compactString String
hi def link compactFile String
hi def link compactComment Comment
hi def link compactBlockComment Comment
hi def link compactDocComment SpecialComment
hi def link compactTodo Todo
hi def link compactOperator Operator
hi def link compactDelimiter Delimiter
hi def link compactBracket Delimiter
hi def link compactTypeParam Type
hi def link compactFunctionDef Function
hi def link compactTypeDef Type

let b:current_syntax = "compact"
