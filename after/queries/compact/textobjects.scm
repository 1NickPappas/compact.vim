; This file is part of compact.vim
; SPDX-License-Identifier: Apache-2.0

; Functions — circuits and witnesses
(cdefn) @function.outer
(cdefn body: (block) @function.inner)

(lconstructor) @function.outer
(lconstructor body: (block) @function.inner)

(wdecl) @function.outer

; Classes — structs and enums
(struct) @class.outer

(enumdef) @class.outer

; Comments
(comment) @comment.outer

; Parameters
(arg) @parameter.inner
(parg) @parameter.inner
