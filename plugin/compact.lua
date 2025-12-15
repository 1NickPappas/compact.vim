-- Auto-setup for Compact language support
-- This file is part of compact.vim
-- SPDX-License-Identifier: Apache-2.0

if vim.g.loaded_compact then
	return
end
vim.g.loaded_compact = true

-- Register the filetype
vim.filetype.add({
	extension = {
		compact = "compact",
	},
})

-- Auto-setup tree-sitter if available
vim.api.nvim_create_autocmd("FileType", {
	pattern = "compact",
	callback = function()
		-- Try to enable tree-sitter highlighting if the parser is available
		pcall(function()
			vim.treesitter.start()
		end)
	end,
	once = false,
})
