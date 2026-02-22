; This file is part of compact.vim
; SPDX-License-Identifier: Apache-2.0

; Blocks (circuit bodies, constructors, for/if blocks)
(block) @indent.begin

; Module bodies
(mdefn) @indent.begin

; Struct bodies
(struct) @indent.begin

; Enum bodies
(enumdef) @indent.begin

; Contract bodies
(ecdecl) @indent.begin

; Closing braces
"}" @indent.end @indent.branch

; Parenthesized expressions and argument lists
"(" @indent.begin
")" @indent.end @indent.branch

; Bracket expressions (tuples, arrays)
"[" @indent.begin
"]" @indent.end @indent.branch
