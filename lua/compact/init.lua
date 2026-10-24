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

	-- Try to configure nvim-treesitter if available.
	-- Uses the community-maintained fork, which targets Compact 0.31.1 /
	-- language 0.23.0 (the upstream midnightntwrk/compact-tree-sitter is archived).
	local ok, parsers = pcall(require, "nvim-treesitter.parsers")
	if ok and parsers.get_parser_configs then
		local config_ok, parser_config = pcall(parsers.get_parser_configs)
		if config_ok and type(parser_config) == "table" then
			-- Configure the compact parser
			parser_config.compact = {
				install_info = {
					url = opts.grammar_path or "https://github.com/1NickPappas/compact-tree-sitter",
					files = { "src/parser.c" },
					branch = "main",
				},
				filetype = "compact",
			}
		end
	end

	-- If a local parser path is provided, use it
	if opts.parser_path then
		-- Add parser directory to runtimepath so it can find the .so
		local parser_dir = vim.fn.fnamemodify(opts.parser_path, ":h")
		if not vim.tbl_contains(vim.opt.runtimepath:get(), parser_dir) then
			vim.opt.runtimepath:append(parser_dir)
		end
	end

	-- Register the language with vim.treesitter
	pcall(vim.treesitter.language.register, "compact", "compact")
end

return M
