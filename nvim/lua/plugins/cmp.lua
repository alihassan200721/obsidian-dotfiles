return {
  -- Snippet engine
  {
    "L3MON4D3/LuaSnip",
    version = "v2.*",
    build = "make install_jsregexp",
  },
  -- Completion sources
  { "hrsh7th/cmp-nvim-lsp"  }, -- LSP suggestions
  { "hrsh7th/cmp-buffer"    }, -- words in current file
  { "hrsh7th/cmp-path"      }, -- file paths
  { "saadparwaiz1/cmp_luasnip" }, -- snippets

  -- The main completion engine
  {
    "hrsh7th/nvim-cmp",
    dependencies = {
      "L3MON4D3/LuaSnip",
      "hrsh7th/cmp-nvim-lsp",
      "hrsh7th/cmp-buffer",
      "hrsh7th/cmp-path",
      "saadparwaiz1/cmp_luasnip",
    },
    config = function()
      local cmp     = require("cmp")
      local luasnip = require("luasnip")

      cmp.setup({
        snippet = {
          expand = function(args)
            luasnip.lsp_expand(args.body)
          end,
        },
        mapping = cmp.mapping.preset.insert({
          ["<Tab>"]   = cmp.mapping(function(fallback)
            if cmp.visible() then
              cmp.select_next_item()           -- Tab = next item
            elseif luasnip.expand_or_jumpable() then
              luasnip.expand_or_jump()
            else
              fallback()
            end
          end, { "i", "s" }),
          ["<S-Tab>"] = cmp.mapping(function(fallback)
            if cmp.visible() then
              cmp.select_prev_item()           -- Shift+Tab = prev item
            elseif luasnip.jumpable(-1) then
              luasnip.jump(-1)
            else
              fallback()
            end
          end, { "i", "s" }),
          ["<CR>"]    = cmp.mapping.confirm({ select = true }), -- Enter = confirm
          ["<C-Space>"] = cmp.mapping.complete(),               -- Ctrl+Space = open menu
          ["<C-e>"]   = cmp.mapping.abort(),                    -- Ctrl+e = close menu
          ["<C-d>"]   = cmp.mapping.scroll_docs(-4),
          ["<C-f>"]   = cmp.mapping.scroll_docs(4),
        }),
        sources = cmp.config.sources({
          { name = "nvim_lsp" },  -- LSP first
          { name = "luasnip"  },  -- then snippets
          { name = "buffer"   },  -- then buffer words
          { name = "path"     },  -- then file paths
        }),
        window = {
          completion    = cmp.config.window.bordered(),
          documentation = cmp.config.window.bordered(),
        },
      })
    end,
  },
}
