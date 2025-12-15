-- Compact language support for Neovim
-- This file is part of compact.vim
-- SPDX-License-Identifier: Apache-2.0

local M = {}

-- Get the plugin's root directory
local function get_plugin_root()
	local source = debug.getinfo(1, "S").source:sub(2)
	return vim.fn.fnamemodify(source, ":h:h:h")
end

-- Setup function to configure tree-sitter for Compact
function M.setup(opts)
	opts = opts or {}

	-- Register the filetype (in case ftdetect wasn't loaded)
	vim.filetype.add({
		extension = {
			compact = "compact",
		},
	})

	-- Try to configure nvim-treesitter if available
	local ok, parsers = pcall(require, "nvim-treesitter.parsers")
	if ok then
		local parser_config = parsers.get_parser_configs()

		-- Configure the compact parser
		parser_config.compact = {
			install_info = {
				url = opts.grammar_path or "https://github.com/midnight-ntwrk/tree-sitter-compact",
				files = { "src/parser.c" },
				branch = "main",
			},
			filetype = "compact",
		}

		-- If a local parser path is provided, use it
		if opts.parser_path then
			vim.treesitter.language.register("compact", "compact")
			-- Add parser directory to runtimepath so it can find the .so
			local parser_dir = vim.fn.fnamemodify(opts.parser_path, ":h")
			if not vim.tbl_contains(vim.opt.runtimepath:get(), parser_dir) then
				vim.opt.runtimepath:append(parser_dir)
			end
		end
	end

	-- Register the language with vim.treesitter
	pcall(vim.treesitter.language.register, "compact", "compact")
end

return M
