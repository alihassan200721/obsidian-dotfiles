return {
	{
		"folke/todo-comments.nvim",
		dependencies = { "nvim-lua/plenary.nvim" },
		event = "BufReadPost",
		config = function()
			require("todo-comments").setup({
				signs = true,
				keywords = {
					FIX = { icon = " ", color = "error", alt = { "FIXME", "BUG", "FIXIT", "ISSUE" } },
					TODO = { icon = " ", color = "info" },
					HACK = { icon = " ", color = "warning" },
					WARN = { icon = " ", color = "warning", alt = { "WARNING", "XXX" } },
					NOTE = { icon = " ", color = "hint", alt = { "INFO" } },
				},
				highlight = {
					before = "",
					keyword = "wide_bg",
					after = "fg",
					pattern = [[.*<(KEYWORDS)\s*:]],
				},
				colors = {
					error = { "#ff5555" },
					warning = { "#ffb86c" },
					info = { "#d4a373" }, -- your amber accent
					hint = { "#7a5cff" }, -- your purple accent
					default = { "#d4a373" },
				},
			})

			vim.keymap.set("n", "]t", function()
				require("todo-comments").jump_next()
			end, { desc = "Next TODO" })
			vim.keymap.set("n", "[t", function()
				require("todo-comments").jump_prev()
			end, { desc = "Prev TODO" })
			vim.keymap.set("n", "<leader>ft", "<cmd>TodoTelescope<cr>", { desc = "Find TODOs" })
		end,
	},
}
