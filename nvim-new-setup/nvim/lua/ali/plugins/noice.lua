return {
	{
		"folke/noice.nvim",
		event = "VeryLazy",
		dependencies = {
			"MunifTanjim/nui.nvim",
			"rcarriga/nvim-notify",
		},
		config = function()
			require("noice").setup({
				lsp = {
					override = {
						["vim.lsp.util.convert_input_to_markdown_lines"] = true,
						["vim.lsp.util.stylize_markdown"] = true,
						["cmp.entry.get_documentation"] = true,
					},
					hover = { enabled = true },
					signature = { enabled = true },
				},
				presets = {
					bottom_search = true, -- search bar at the bottom
					command_palette = true, -- command line at the top center
					long_message_to_split = true, -- long messages go to a split
					lsp_doc_border = true, -- border on hover docs
				},
				views = {
					cmdline_popup = {
						border = { style = "rounded" },
						win_options = {
							winhighlight = "NormalFloat:NormalFloat,FloatBorder:FloatBorder",
						},
					},
				},
			})

			vim.keymap.set("n", "<leader>nd", "<cmd>NoiceDismiss<cr>", { desc = "Dismiss notifications" })
		end,
	},
}
