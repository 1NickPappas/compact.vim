" Filetype detection for Compact (Midnight smart contract language)
" This file is part of compact.vim
" SPDX-License-Identifier: Apache-2.0

augroup compact_ftdetect
  autocmd!
  autocmd BufNewFile,BufRead *.compact setfiletype compact
augroup END
