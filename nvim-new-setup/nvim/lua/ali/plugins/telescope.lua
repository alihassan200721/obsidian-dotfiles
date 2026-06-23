return {
    "nvim-telescope/telescope.nvim",

    dependencies = {
        {
            "nvim-lua/plenary.nvim",
            version = false, -- always latest
        },
    },

    config = function()
        local telescope = require("telescope")
        local builtin = require("telescope.builtin")
        local actions = require("telescope.actions")

        telescope.setup({
            defaults = {
                prompt_prefix = "🔍 ",
                selection_caret = "➤ ",

                -- Ctrl + j / k inside Telescope
                mappings = {
                    i = {
                        ["<C-j>"] = actions.move_selection_next,
                        ["<C-k>"] = actions.move_selection_previous,
                        ["<C-q>"] = actions.send_to_qflist + actions.open_qflist,
                    },

                    n = {
                        ["<C-j>"] = actions.move_selection_next,
                        ["<C-k>"] = actions.move_selection_previous,
                    },
                },

                layout_config = {
                    horizontal = {
                        preview_width = 0.55,
                    },
                },
            },
        })

        -- Keymaps
        vim.keymap.set("n", "<leader>ff", builtin.find_files, {
            desc = "Find Files",
        })

        vim.keymap.set("n", "<leader>fg", builtin.live_grep, {
            desc = "Live Grep",
        })

        vim.keymap.set("n", "<leader>fr", builtin.oldfiles, {
            desc = "Recent Files",
        })

        vim.keymap.set("n", "<leader>fb", builtin.buffers, {
            desc = "Buffers",
        })
    end,
}
