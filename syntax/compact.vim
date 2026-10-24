" Vim syntax file for Compact (Midnight smart contract language)
" Targets Compact compiler 0.31.1 / language version 0.23.0.
" This file is part of compact.vim
" SPDX-License-Identifier: Apache-2.0

if exists('b:current_syntax')
  finish
endif

" ---------------------------------------------------------------------------
" Keywords: modules, imports, declarations
" ---------------------------------------------------------------------------
syn keyword compactKeyword pragma import export include from
syn keyword compactKeyword ledger constructor prefix as new
syn keyword compactKeyword circuit witness nextgroup=compactFunctionDef skipwhite
syn keyword compactKeyword struct enum contract module type nextgroup=compactTypeDef skipwhite
syn keyword compactModifier pure sealed

" Control flow
syn keyword compactConditional if else
syn keyword compactRepeat for of
syn keyword compactStatement return const

" Built-in operations and expressions
syn keyword compactBuiltin map fold disclose pad assert slice default

" Built-in data types
syn keyword compactType Boolean Field Uint Bytes Opaque Vector

" Standard-library types (ledger ADTs and kernel)
syn keyword compactType Kernel Counter Set Map List MerkleTree HistoricMerkleTree

" Boolean literals
syn keyword compactBoolean true false

" Keywords reserved for future use (JavaScript/TypeScript words)
syn keyword compactFutureReservedWord await break case catch class continue debugger delete do extends finally function implements in instanceof interface let null package private protected public static super switch this throw try typeof var void while with yield

" ---------------------------------------------------------------------------
" Numbers and version literals
" ---------------------------------------------------------------------------
syn match compactNumber "\<0[xX][0-9a-fA-F]\+\>"
syn match compactNumber "\<0[bB][01]\+\>"
syn match compactNumber "\<0[oO]\?[0-7]\+\>"
syn match compactNumber "\<\d\+\>"
syn match compactVersion "\<\d\+\.\d\+\(\.\d\+\)*\>"

" ---------------------------------------------------------------------------
" Strings
" ---------------------------------------------------------------------------
syn region compactString start=+"+ skip=+\\\\\|\\"+ end=+"+

" ---------------------------------------------------------------------------
" Comments
" ---------------------------------------------------------------------------
syn keyword compactTodo contained TODO FIXME XXX NOTE
syn region compactBlockComment start="/\*" end="\*/" contains=compactTodo
syn match compactComment "//.*$" contains=compactTodo
syn region compactDocComment start="/\*\*" end="\*/" contains=compactTodo

" ---------------------------------------------------------------------------
" Operators, delimiters, brackets
" ---------------------------------------------------------------------------
syn match compactOperator "=>"
syn match compactOperator "=="
syn match compactOperator "!="
syn match compactOperator "<="
syn match compactOperator ">="
syn match compactOperator "&&"
syn match compactOperator "||"
syn match compactOperator "+="
syn match compactOperator "-="
syn match compactOperator "\.\.\."
syn match compactOperator "\.\."
syn match compactOperator "[=+\-*<>!?:.]"

syn match compactDelimiter "[;,]"
syn match compactBracket "[(){}\[\]]"

" ---------------------------------------------------------------------------
" Generic (size/type) parameters, e.g. <#n, T>
" ---------------------------------------------------------------------------
syn match compactTypeParam "#[a-zA-Z_$][a-zA-Z0-9_$]*"

" ---------------------------------------------------------------------------
" Declared names (highlighted via nextgroup on the introducing keyword)
" ---------------------------------------------------------------------------
syn match compactFunctionDef "[a-zA-Z_$][a-zA-Z0-9_$]*" contained
syn match compactTypeDef "[a-zA-Z_$][a-zA-Z0-9_$]*" contained

" ---------------------------------------------------------------------------
" Highlight links
" ---------------------------------------------------------------------------
hi def link compactKeyword Keyword
hi def link compactModifier StorageClass
hi def link compactConditional Conditional
hi def link compactRepeat Repeat
hi def link compactStatement Statement
hi def link compactBuiltin Function
hi def link compactType Type
hi def link compactBoolean Boolean
hi def link compactFutureReservedWord Keyword
hi def link compactNumber Number
hi def link compactVersion Number
hi def link compactString String
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

let b:current_syntax = 'compact'
