return {
	{
		"lewis6991/gitsigns.nvim",
		config = function()
			require("gitsigns").setup({
				signs = {
					add = { text = "▎" },
					change = { text = "▎" },
					delete = { text = "" },
					topdelete = { text = "" },
					changedelete = { text = "▎" },
				},
				on_attach = function(bufnr)
					local gs = package.loaded.gitsigns
					vim.keymap.set("n", "]g", gs.next_hunk, { buffer = bufnr, desc = "Next git change" })
					vim.keymap.set("n", "[g", gs.prev_hunk, { buffer = bufnr, desc = "Prev git change" })
					vim.keymap.set("n", "<leader>gb", gs.blame_line, { buffer = bufnr, desc = "Git blame line" })
					vim.keymap.set("n", "<leader>gp", gs.preview_hunk, { buffer = bufnr, desc = "Preview git change" })
					vim.keymap.set("n", "<leader>gs", gs.stage_hunk, { buffer = bufnr, desc = "Stage hunk" })
					vim.keymap.set("n", "<leader>gu", gs.undo_stage_hunk, { buffer = bufnr, desc = "Undo stage hunk" })
				end,
			})
		end,
	},
}
