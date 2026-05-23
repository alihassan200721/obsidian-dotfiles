-- lua/plugins/dap.lua
return {
  -- Core debugger
  {
    "mfussenegger/nvim-dap",
    dependencies = {
      "rcarriga/nvim-dap-ui",
      "nvim-neotest/nvim-nio",
    },
    config = function()
      local dap = require("dap")
      local dapui = require("dapui")

      -- C / C++ debugger via codelldb
      local mason_path = vim.fn.stdpath("data") .. "/mason/packages/codelldb/extension/"
      local codelldb_path = mason_path .. "adapter/codelldb"
      local liblldb_path  = mason_path .. "lldb/lib/liblldb.so"

      dap.adapters.codelldb = {
        type = "server",
        port = "${port}",
        executable = {
          command = codelldb_path,
          args    = { "--liblldb", liblldb_path, "--port", "${port}" },
        },
      }

      dap.configurations.c = {
        {
          name    = "Launch (C)",
          type    = "codelldb",
          request = "launch",
          program = function()
            return vim.fn.input("Path to executable: ", vim.fn.getcwd() .. "/", "file")
          end,
          cwd         = "${workspaceFolder}",
          stopOnEntry = false,
          terminal    = "integrated",
        },
      }

      dap.configurations.cpp = dap.configurations.c

      -- Auto open/close UI when debugging starts/ends
      dap.listeners.after.event_initialized["dapui_config"] = function() dapui.open() end
      dap.listeners.before.event_terminated["dapui_config"] = function() dapui.close() end
      dap.listeners.before.event_exited["dapui_config"]     = function() dapui.close() end

      -- Keymaps
      vim.keymap.set("n", "<F5>",       dap.continue,          { desc = "Debug: Start/Continue" })
      vim.keymap.set("n", "<F10>",      dap.step_over,         { desc = "Debug: Step over" })
      vim.keymap.set("n", "<F11>",      dap.step_into,         { desc = "Debug: Step into" })
      vim.keymap.set("n", "<F12>",      dap.step_out,          { desc = "Debug: Step out" })
      vim.keymap.set("n", "<leader>b",  dap.toggle_breakpoint, { desc = "Toggle breakpoint" })
      vim.keymap.set("n", "<leader>B",  function()
        dap.set_breakpoint(vim.fn.input("Breakpoint condition: "))
      end, { desc = "Conditional breakpoint" })
      vim.keymap.set("n", "<leader>du", dapui.toggle,          { desc = "Toggle debugger UI" })
    end,
  },
  -- DAP UI panels
  {
    "rcarriga/nvim-dap-ui",
    dependencies = { "nvim-neotest/nvim-nio" },
    config = function()
      require("dapui").setup()
    end,
  },
  -- Python debugger
  {
    "mfussenegger/nvim-dap-python",
    dependencies = { "mfussenegger/nvim-dap" },
    config = function()
      require("dap-python").setup("python3")
      vim.keymap.set("n", "<leader>dm", require("dap-python").test_method, { desc = "Debug Python method" })
      vim.keymap.set("n", "<leader>dc", require("dap-python").test_class,  { desc = "Debug Python class" })
    end,
  },
}
