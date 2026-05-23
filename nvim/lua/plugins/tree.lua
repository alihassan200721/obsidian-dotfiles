return {
  {
    "nvim-tree/nvim-tree.lua",
    dependencies = { "nvim-tree/nvim-web-devicons" },
    config = function()
      -- Disable netrw (nvim-tree replaces it)
      vim.g.loaded_netrw = 1
      vim.g.loaded_netrwPlugin = 1

      require("nvim-tree").setup({
        view = {
          width = 30,          -- sidebar width (like VS Code)
          side = "left",
        },
        renderer = {
          group_empty = true,  -- collapse empty folders
          icons = {
            show = {
              file = true,
              folder = true,
              folder_arrow = true,
            },
          },
        },
        filters = {
          dotfiles = false,    -- show hidden files
        },
        actions = {
          open_file = {
            quit_on_open = false, -- keep tree open after opening file
          },
        },
        on_attach = function(bufnr)
          local api = require("nvim-tree.api")
          -- Default mappings
          api.config.mappings.default_on_attach(bufnr)
        end,
      })

      -- Keymaps
      vim.keymap.set("n", "<leader>e",  ":NvimTreeToggle<CR>",  { desc = "Toggle file tree" })
      vim.keymap.set("n", "<leader>ef", ":NvimTreeFocus<CR>",   { desc = "Focus file tree"  })
    end,
  },
}
