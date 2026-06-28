return {
	"akinsho/toggleterm.nvim",
	version = "*",
	config = function()
		require("toggleterm").setup({
			size = 12,
			open_mapping = [[<C-\>]], -- we'll override this below
			direction = "horizontal",
			shade_terminals = true,
			persist_size = true,
			close_on_exit = true,
		})

		-- Shift + ` (tilde key) to toggle
		vim.keymap.set({ "n", "t" }, "~", "<cmd>ToggleTerm<CR>", { desc = "Toggle Terminal" })
	end,
}
