return {
  -- Tokyonight theme (night variant matches your palette perfectly)
  {
    "folke/tokyonight.nvim",
    lazy = false,       -- load immediately
    priority = 1000,    -- load before other plugins
    config = function()
      require("tokyonight").setup({
        style = "night",        -- dark blue, matches #0d1520 palette
        transparent = true,     -- transparent bg (compositor handles it)
        terminal_colors = true,
        styles = {
          comments    = { italic = true },
          keywords    = { italic = true },
          functions   = {},
          variables   = {},
          sidebars    = "transparent",
          floats      = "transparent",
        },
      })
      vim.cmd("colorscheme tokyonight-night")
    end,
  },

  -- Lualine: VS Code-style statusline at the bottom
  {
    "nvim-lualine/lualine.nvim",
    dependencies = { "nvim-tree/nvim-web-devicons" },
    config = function()
      require("lualine").setup({
        options = {
          theme = "tokyonight",
          component_separators = { left = "", right = "" },
          section_separators   = { left = "", right = "" },
        },
        sections = {
          lualine_a = { "mode"     },
          lualine_b = { "branch", "diff", "diagnostics" },
          lualine_c = { { "filename", path = 1 } },  -- show relative path
          lualine_x = { "encoding", "fileformat", "filetype" },
          lualine_y = { "progress" },
          lualine_z = { "location" },
        },
      })
    end,
  },

  -- Indent guides (vertical lines like VS Code)
  {
    "lukas-reineke/indent-blankline.nvim",
    main = "ibl",
    config = function()
      require("ibl").setup({
        indent = {
          char = "│",             -- vertical bar character
        },
        scope = {
          enabled = true,         -- highlight current scope
        },
      })
    end,
  },

  -- Treesitter: better syntax highlighting
  {
    "nvim-treesitter/nvim-treesitter",
    build = ":TSUpdate",
    config = function()
      require("nvim-treesitter.configs").setup({
        ensure_installed = { "python", "lua", "bash", "json", "yaml" },
        highlight = { enable = true },
        indent    = { enable = true },  -- treesitter-based indentation
        auto_install = true,
      })
    end,
  },
    -- Auto close brackets, quotes, parentheses
{
  "windwp/nvim-autopairs",
  event = "InsertEnter",
  config = function()
    require("nvim-autopairs").setup({
      check_ts = true,  -- use treesitter for smarter pairing
    })
    -- Make it work with nvim-cmp
    local cmp_autopairs = require("nvim-autopairs.completion.cmp")
    local cmp = require("cmp")
    cmp.event:on("confirm_done", cmp_autopairs.on_confirm_done())
  end,
},
-- VS Code style bottom terminal
{
  "akinsho/toggleterm.nvim",
  version = "*",
  config = function()
  require("toggleterm").setup({
    size = 12,
    open_mapping = [[<C-`>]],
    direction = "horizontal",  -- bottom terminal
    shade_terminals = true,
  })
  end,
},
}
