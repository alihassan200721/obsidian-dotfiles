return {
	"folke/tokyonight.nvim",
	lazy = false,
	priority = 1000,
	config = function()
		require("tokyonight").setup({
			style = "night", -- choosing the 'night' variant
			transparent = true, -- Enables transparency for the main window background
			styles = {
				-- You can also make sidebars and floating windows transparent if you like
				sidebars = "transparent",
				floats = "transparent",
			},
		})

		-- Load the colorscheme after setting up options
		vim.cmd.colorscheme("tokyonight-night")
	end,
}
