return {
  {
    "williamboman/mason-lspconfig.nvim",
    opts = {
      ensure_installed = {
        -- Web / JS / TS
        "ts_ls",
        "html",
        "cssls",
        "emmet_ls",

        -- Lua (Neovim config)
        "lua_ls",

        -- Python
        "pyright",

        -- C / C++
        "clangd",

        -- JSON
        "jsonls",
      },
    },
    dependencies = {
      {
        "williamboman/mason.nvim",
        opts = {
          ui = {
            icons = {
              package_installed = "✓",
              package_pending = "➜",
              package_uninstalled = "✗",
            },
          },
        },
      },
      "neovim/nvim-lspconfig",
    },
  },

  {
    "WhoIsSethDaniel/mason-tool-installer.nvim",
    opts = {
      ensure_installed = {
        -- Formatters
        "prettier", -- JS/TS/HTML/CSS formatter
        "stylua",   -- Lua formatter
        "black",    -- Python formatter
        "isort",    -- Python imports formatter

        -- Linter
        "pylint",

        -- Optional (only useful if you actually use JS heavily)
        -- "eslint_d",
      },
    },
    dependencies = {
      "williamboman/mason.nvim",
    },
  },
}
