return {
  {
    "mfussenegger/nvim-dap",
    event = "VeryLazy",
    dependencies = {
      "nvim-neotest/nvim-nio",
      "rcarriga/nvim-dap-ui",          -- Pretty UI for nvim-dap
      "theHamsta/nvim-dap-virtual-text", -- Inline variable display
      "nvim-telescope/telescope.nvim", -- Optional: debug pickers
      "jay-babu/mason-nvim-dap.nvim",
      "williamboman/mason.nvim",          -- Mason core
    },
    config = function()
      -- Make sure codelldb is installed
      require("mason-nvim-dap").setup({
        ensure_installed = { "codelldb" },
        automatic_installation = true,
      })

      local dap = require("dap")
      local dapui = require("dapui")

      ----------------------------------------------------------------
      -- 🔧 C++ Adapter configuration (uses lldb-vscode)
      ----------------------------------------------------------------
      dap.adapters.lldb = {
        type = "executable",
        command = "codelldb", -- Make sure this is in your PATH
        name = "lldb",
      }

      dap.configurations.cpp = {
        {
          name = "Launch file",
          type = "lldb",
          request = "launch",
          program = function()
            return vim.fn.input("Path to executable: ", vim.fn.getcwd() .. "/", "file")
          end,
          cwd = "${workspaceFolder}",
          stopOnEntry = false,
          args = {},
          runInTerminal = false,
        },
      }

      -- You can reuse the same config for C and Rust:
      dap.configurations.c = dap.configurations.cpp
      dap.configurations.rust = dap.configurations.cpp

      ----------------------------------------------------------------
      -- 🧠 nvim-dap-ui setup
      ----------------------------------------------------------------
      dapui.setup()

      require("nvim-dap-virtual-text").setup({
        commented = true,
      })

      ----------------------------------------------------------------
      -- ⚡ Auto-open UI when debugging starts
      ----------------------------------------------------------------
      dap.listeners.after.event_initialized["dapui_config"] = function()
        dapui.open()
      end
      dap.listeners.before.event_terminated["dapui_config"] = function()
        dapui.close()
      end
      dap.listeners.before.event_exited["dapui_config"] = function()
        dapui.close()
      end

    end,
  },
}
