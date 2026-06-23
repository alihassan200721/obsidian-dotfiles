return {
  "windwp/nvim-autopairs",
  event = "InsertEnter",
  dependencies = {
    "hrsh7th/nvim-cmp",
  },
  config = function()
    local ok, autopairs = pcall(require, "nvim-autopairs")
    if not ok then
      return
    end

    autopairs.setup({
      check_ts = true,
      disable_filetype = { "TelescopePrompt", "vim" },
    })

    -- safely connect with nvim-cmp
    local cmp_ok, cmp = pcall(require, "cmp")
    if cmp_ok then
      local cmp_autopairs = require("nvim-autopairs.completion.cmp")
      cmp.event:on("confirm_done", cmp_autopairs.on_confirm_done())
    end
  end,
} 
