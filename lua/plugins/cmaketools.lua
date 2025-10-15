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
