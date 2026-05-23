-- Bootstrap lazy.nvim (auto-installs itself)
local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not vim.loop.fs_stat(lazypath) then
  vim.fn.system({
    "git", "clone", "--filter=blob:none",
    "https://github.com/folke/lazy.nvim.git",
    "--branch=stable", lazypath,
  })
end
vim.opt.rtp:prepend(lazypath)

-- Load all plugin modules
require("lazy").setup({
  { import = "plugins.ui"   },
  { import = "plugins.tree" },
  { import = "plugins.lsp"  },
  { import = "plugins.cmp"  },
  { import = "plugins.extras" },
  { import = "plugins.dap"    },
  { import = "plugins.telescope" },
})

