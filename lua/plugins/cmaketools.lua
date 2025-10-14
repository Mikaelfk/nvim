return {
  {
    "Civitasv/cmake-tools.nvim",
    event = "VeryLazy", -- loads when needed
    dependencies = {
      "nvim-lua/plenary.nvim",
      "nvim-telescope/telescope.nvim", -- optional but useful for project selection
      "nvim-lualine/lualine.nvim",     -- optional: statusline integration
    },
    config = function()
      local ok, cmake = pcall(require, "cmake-tools")
      if not ok then
        vim.notify("CMake Tools not found!", vim.log.levels.ERROR)
        return
      end

      cmake.setup({
        cmake_command = "cmake", -- Path to cmake executable
        cmake_build_directory = "build", -- Directory for build files
        cmake_build_type = "Debug", -- Build type: Debug, Release, etc.
        cmake_generate_options = { "-G", "Ninja" }, -- Generator options
        cmake_soft_link_compile_commands = true, -- Symlink compile_commands.json
        cmake_compile_commands_from_lsp = true,
        cmake_regenerate_on_save = true,
        cmake_console_size = 10, -- terminal window height
        cmake_console_position = "belowright", -- position of terminal
        cmake_show_console = "always", -- when to show console (always, only_on_error, never)

        -- Optional integrations
        lsp = {
          auto_attach = true,
        },
      })

      ----------------------------------------------------------------
      -- 🧰 Keymaps for convenience
      ----------------------------------------------------------------
      local map = vim.keymap.set
      local opts = { noremap = true, silent = true }

      map("n", "<leader>cg", "<cmd>CMakeGenerate<CR>", vim.tbl_extend("force", opts, { desc = "CMake: Generate project" }))
      map("n", "<leader>cb", "<cmd>CMakeBuild<CR>", vim.tbl_extend("force", opts, { desc = "CMake: Build project" }))
      map("n", "<leader>cr", "<cmd>CMakeRun<CR>", vim.tbl_extend("force", opts, { desc = "CMake: Run target" }))
      map("n", "<leader>ct", "<cmd>CMakeSelectBuildType<CR>", vim.tbl_extend("force", opts, { desc = "CMake: Select build type" }))
      map("n", "<leader>cc", "<cmd>CMakeClean<CR>", vim.tbl_extend("force", opts, { desc = "CMake: Clean project" }))
      map("n", "<leader>cx", "<cmd>CMakeClose<CR>", vim.tbl_extend("force", opts, { desc = "CMake: Close terminal" }))

      ----------------------------------------------------------------
      -- 🧠 Optional: Lualine status integration
      ----------------------------------------------------------------
      local lualine_ok, lualine = pcall(require, "lualine")
      if lualine_ok then
        local config = lualine.get_config()
        local function cmake_status()
          local type = cmake.get_build_type() or "?"
          local target = cmake.get_build_target() or "?"
          return string.format("🛠 %s | 🎯 %s", type, target)
        end
        table.insert(config.sections.lualine_x, cmake_status)
        lualine.setup(config)
      end
    end,
  },
}
