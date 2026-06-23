return {
  "stevearc/conform.nvim",
  event = { "BufReadPre", "BufNewFile" },

  config = function()
    local conform = require("conform")

    conform.setup({
      formatters_by_ft = {
        -- Web
        javascript = { "prettier" },
        typescript = { "prettier" },
        javascriptreact = { "prettier" },
        typescriptreact = { "prettier" },
        html = { "prettier" },
        css = { "prettier" },

        -- Data formats
        json = { "prettier" },

        -- Lua (Neovim config)
        lua = { "stylua" },

        -- Python
        python = { "black", "isort" },

        -- Shell (bash)
        sh = { "shfmt" },
        bash = { "shfmt" },

        -- C / C++
        c = { "clang_format" },
        cpp = { "clang_format" },
      },

      format_on_save = {
        lsp_fallback = true,
        async = false,
        timeout_ms = 3000,
      },
    })

    -- Manual format keybind
    vim.keymap.set({ "n", "v" }, "<leader>mp", function()
      conform.format({
        lsp_fallback = true,
        async = false,
        timeout_ms = 1000,
      })
    end, { desc = "Format file or selection" })
  end,
}
