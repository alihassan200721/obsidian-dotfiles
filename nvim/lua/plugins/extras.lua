return {
  -- VS Code style notifications
  {
    "rcarriga/nvim-notify",
    config = function()
      require("notify").setup({
        background_colour = "#0d1520",
        timeout = 3000,
        max_width = 50,
        stages = "fade_in_slide_out",
      })
      vim.notify = require("notify")
    end,
  },


  -- Shows keybindings popup when you press Space
  {
    "folke/which-key.nvim",
    event = "VeryLazy",
    config = function()
        local wk = require("which-key")

        wk.setup({
            win = {
                border = "rounded",
            },
        })

        wk.add({
            {"<leader>f", group = "Find"},
            {"<leader>g", group = "Git"},
            {"<leader>o", group = "Outline"},
        })
    end,
  },

  -- Git signs in the gutter
  {
    "lewis6991/gitsigns.nvim",
    config = function()
      require("gitsigns").setup({
        signs = {
          add          = { text = "▎" },
          change       = { text = "▎" },
          delete       = { text = "" },
          topdelete    = { text = "" },
          changedelete = { text = "▎" },
        },
        on_attach = function(bufnr)
          local gs = package.loaded.gitsigns
          vim.keymap.set("n", "]g", gs.next_hunk,   { buffer = bufnr, desc = "Next git change" })
          vim.keymap.set("n", "[g", gs.prev_hunk,   { buffer = bufnr, desc = "Prev git change" })
          vim.keymap.set("n", "<leader>gb", gs.blame_line, { buffer = bufnr, desc = "Git blame line" })
          vim.keymap.set("n", "<leader>gp", gs.preview_hunk, { buffer = bufnr, desc = "Preview git change" })
          vim.keymap.set("n", "<leader>gs", gs.stage_hunk,   { buffer = bufnr, desc = "Stage hunk" })
          vim.keymap.set("n", "<leader>gu", gs.undo_stage_hunk, { buffer = bufnr, desc = "Undo stage hunk" })
        end,
      })
    end,
  },
-- Smooth cursor animation
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
      disable_float_win = false,
    })
    vim.cmd("SmoothCursorStart")
  end,
},
-- Symbols outline (functions, classes viewer)
{
  "stevearc/aerial.nvim",
  dependencies = {
    "nvim-treesitter/nvim-treesitter",
    "nvim-tree/nvim-web-devicons",
  },
  config = function()
    require("aerial").setup({
      layout = {
        default_direction = "right",  -- opens on the right side
        width = 35,
      },
      show_guides = true,
      attach_mode = "global",
      backends = { "treesitter", "lsp" },
      filter_kind = {
        "Class",
        "Constructor",
        "Enum",
        "Function",
        "Interface",
        "Method",
        "Module",
        "Struct",
      },
    })

    -- Toggle with Ctrl+o like VS Code outline
    vim.keymap.set("n", "<leader>o", "<cmd>AerialToggle<CR>", { desc = "Toggle symbols outline" })
  end,
},
}
