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

-- Register the tree-sitter parser config so `:TSInstall compact` can find it.
-- Safe no-op when nvim-treesitter is not installed.
pcall(function()
	require("compact").setup()
end)

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
