-- ~/.config/nvim/lua/ali/plugins/smoothcursor.lua
return {
	{
		"gen740/SmoothCursor.nvim",
		config = function()
			require("smoothcursor").setup({
				autostart = true,
				cursor = "▷",
				texthl = "SmoothCursor",
				linehl = nil,
				type = "default",
				fancy = {
					enable = true,
					head = { cursor = "▷", texthl = "SmoothCursor", linehl = nil },
					body = {
						{ cursor = "●", texthl = "SmoothCursorRed" },
						{ cursor = "●", texthl = "SmoothCursorOrange" },
						{ cursor = "●", texthl = "SmoothCursorYellow" },
						{ cursor = "●", texthl = "SmoothCursorGreen" },
						{ cursor = "●", texthl = "SmoothCursorAqua" },
						{ cursor = "●", texthl = "SmoothCursorBlue" },
						{ cursor = "●", texthl = "SmoothCursorPurple" },
					},
					tail = { cursor = nil, texthl = "SmoothCursor" },
				},
				speed = 15,
				intervals = 25,
				priority = 10,
				timeout = 3000,
				threshold = 3,
				disable_float_win = true,
			})

			-- Amber theme colors for the trail
			vim.api.nvim_set_hl(0, "SmoothCursor", { fg = "#d4a373" })
			vim.api.nvim_set_hl(0, "SmoothCursorRed", { fg = "#d4a373" })
			vim.api.nvim_set_hl(0, "SmoothCursorOrange", { fg = "#c49060" })
			vim.api.nvim_set_hl(0, "SmoothCursorYellow", { fg = "#b47d4d" })
			vim.api.nvim_set_hl(0, "SmoothCursorGreen", { fg = "#946a3a" })
			vim.api.nvim_set_hl(0, "SmoothCursorAqua", { fg = "#745727" })
			vim.api.nvim_set_hl(0, "SmoothCursorBlue", { fg = "#544414" })
			vim.api.nvim_set_hl(0, "SmoothCursorPurple", { fg = "#342100" })

			vim.cmd("SmoothCursorStart")
		end,
	},
}
