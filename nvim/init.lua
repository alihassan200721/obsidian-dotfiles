-- Core settings
vim.opt.number = true             -- line numbers
vim.opt.relativenumber = true     -- relative line numbers
vim.opt.expandtab = true          -- spaces instead of tabs
vim.opt.tabstop = 4               -- 4 spaces per tab
vim.opt.shiftwidth = 4            -- indent width
vim.opt.autoindent = true         -- copy indent from current line
vim.opt.smartindent = true        -- smart auto-indenting
vim.opt.wrap = false              -- no line wrap
vim.opt.termguicolors = true      -- 24-bit color (needed for theme)
vim.opt.signcolumn = "yes"        -- always show sign column
vim.opt.updatetime = 250          -- faster CursorHold
vim.opt.splitright = true         -- new splits go right
vim.opt.splitbelow = true         -- new splits go below
vim.opt.clipboard = "unnamedplus" -- system clipboard

-- Leader key
vim.g.mapleader = " "
vim.g.maplocalleader = " "

-- Save with Ctrl+S
vim.keymap.set("n", "<C-s>", ":w<CR>",       { desc = "Save file" })
vim.keymap.set("i", "<C-s>", "<Esc>:w<CR>a", { desc = "Save file" })

-- Select all with Ctrl+A
vim.keymap.set("n", "<C-a>", "ggVG", { desc = "Select all" })

-- Run Python with Ctrl+Enter
vim.keymap.set("n", "<C-Return>", ":w<CR>:split | terminal python3 %<CR>", { desc = "Run Python" })

-- Exit terminal mode with Esc
vim.keymap.set("t", "<Esc>", "<C-\\><C-n>", { desc = "Exit terminal mode" })

-- Auto save on leaving insert mode or changing text
vim.api.nvim_create_autocmd({ "InsertLeave", "TextChanged" }, {
    pattern = "*",
    command = "silent! w",
})
-- Smooth blinking cursor
vim.opt.guicursor = "n-v-c:block,i-ci-ve:ver25,r-cr:hor20,o:hor50"
  .. ",a:blinkwait700-blinkoff400-blinkon250-Cursor/lCursor"
  .. ",sm:block-blinkwait175-blinkoff150-blinkon175"

-- Load plugins
require("plugins")
