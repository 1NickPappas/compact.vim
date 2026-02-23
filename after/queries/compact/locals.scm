; This file is part of compact.vim
; SPDX-License-Identifier: Apache-2.0

; Scopes
(cdefn) @local.scope
(wdecl) @local.scope
(mdefn) @local.scope
(lconstructor) @local.scope
(block) @local.scope
(for_stmt) @local.scope

; Definitions
(cdefn id: (function_name) @local.definition)
(wdecl id: (function_name) @local.definition)
(arg id: (id) @local.definition)
(parg pattern: (pattern (id) @local.definition))
(const_stmt pattern: (pattern (id) @local.definition))
(for_stmt counter: (id) @local.definition)
(ldecl name: (id) @local.definition)

; References
(id) @local.reference
