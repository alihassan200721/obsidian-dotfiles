return {
	"nvim-treesitter/nvim-treesitter",
	event = { "BufReadPre", "BufNewFile" },
	branch = "main",
	build = ":TSUpdate",
	config = function()
		-- CHANGED: Use the singular 'config' module instead of 'configs'
		local config = require("nvim-treesitter.config")

		config.setup({
			-- Enable syntax highlighting
			highlight = {
				enable = true,
			},
			-- Enable treesitter-based indentation
			indent = {
				enable = true,
			},
			-- Automatically install missing parsers when entering a buffer
			auto_install = true,
			-- Ensure these specific language parsers are always installed
			ensure_installed = {
				"html",
				"css",
				"javascript",
				"typescript",
				"tsx",
				"c",
				"cpp",
				"python",
				"json",
				"csv",
				"lua",
				"yaml",
				"prisma",
				"markdown",
				"markdown_inline",
				"svelte",
				"graphql",
				"bash",
				"vim",
				"dockerfile",
				"gitignore",
				"query",
				"vimdoc",
			},
			-- Smart incremental selection
			incremental_selection = {
				enable = true,
				keymaps = {
					init_selection = "<C-space>",
					node_incremental = "<C-space>",
					scope_incremental = false,
					node_decremental = "<bs>",
				},
			},
		})

		-- Map zsh files to use the bash parser
		vim.treesitter.language.register("bash", "zsh")
	end,
}
