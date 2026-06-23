return {
	"neovim/nvim-lspconfig",

	dependencies = {
		"williamboman/mason-lspconfig.nvim",
		"hrsh7th/cmp-nvim-lsp",
	},

	config = function()
		local capabilities = require("cmp_nvim_lsp").default_capabilities()

		local on_attach = function(_, bufnr)
			local opts = { buffer = bufnr, silent = true }

			vim.keymap.set("n", "gd", vim.lsp.buf.definition, opts)
			vim.keymap.set("n", "gr", vim.lsp.buf.references, opts)
			vim.keymap.set("n", "K", vim.lsp.buf.hover, opts)
			vim.keymap.set("n", "<leader>rn", vim.lsp.buf.rename, opts)
			vim.keymap.set("n", "<leader>ca", vim.lsp.buf.code_action, opts)
		end

		local servers = {
			ts_ls = {},
			html = {},
			cssls = {},
			emmet_ls = {
				filetypes = { "html", "css", "javascriptreact", "typescriptreact" },
			},
			pyright = {},
			clangd = {},
			jsonls = {},

			lua_ls = {
				-- Modern root_dir filter inside the new vim.lsp.config system
				root_dir = function(fname)
					-- Falls back to standard git or json root detection
					local root = vim.fs.root(fname, { ".luarc.json", ".git" })
					if root == "/home/obsidian" then
						return nil
					end
					-- Fallback to the file's directory if no root found
					return root or vim.fs.dirname(fname)
				end,
				settings = {
					Lua = {
						diagnostics = { globals = { "vim" } },
						workspace = {
							library = vim.api.nvim_get_runtime_file("", true),
						},
						telemetry = { enable = false },
					},
				},
			},
		}

		-- Modern Setup Loop using the brand new native API
		for server, config in pairs(servers) do
			vim.lsp.config(
				server,
				vim.tbl_deep_extend("force", {
					capabilities = capabilities,
					on_attach = on_attach,
				}, config)
			)

			vim.lsp.enable(server)
		end
	end,
}
