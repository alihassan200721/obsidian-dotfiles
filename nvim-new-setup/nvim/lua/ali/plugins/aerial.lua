return {
	"stevearc/aerial.nvim",
	dependencies = {
		"nvim-treesitter/nvim-treesitter",
		"nvim-tree/nvim-web-devicons",
	},
	config = function()
		require("aerial").setup({
			layout = {
				width = 35,
				default_direction = "right",
			},
			show_guides = true,
			attach_mode = "global",
		})

		vim.keymap.set("n", "<leader>o", "<cmd>AerialToggle<CR>", { desc = "Toggle Outline (Aerial)" })
	end,
}
