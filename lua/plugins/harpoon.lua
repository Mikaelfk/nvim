return {
  {
    "ThePrimeagen/harpoon",
    branch = "harpoon2",
    dependencies = { "nvim-lua/plenary.nvim" },
    opts = function()
      local harpoon = require("harpoon")

      harpoon:setup()
      -- basic telescope configuration
      local conf = require("telescope.config").values
      local function toggle_telescope(harpoon_files)
        local file_paths = {}
        for _, item in ipairs(harpoon_files.items) do
          table.insert(file_paths, item.value)
        end

        require("telescope.pickers").new({}, {
          prompt_title = "Harpoon",
          finder = require("telescope.finders").new_table({
            results = file_paths,
          }),
          previewer = conf.file_previewer({}),
          sorter = conf.generic_sorter({}),
        }):find()
      end

      vim.keymap.set("n", "<C-r>", function() toggle_telescope(harpoon:list()) end,
      { desc = "Open harpoon window" })

      vim.keymap.set("n", "<leader>a", function() harpoon:list():add() end)

      vim.keymap.set("n", "<C-y>", function() harpoon:list():select(1) end)
      vim.keymap.set("n", "<C-u>", function() harpoon:list():select(2) end)
      vim.keymap.set("n", "<C-i>", function() harpoon:list():select(3) end)
      vim.keymap.set("n", "<C-o>", function() harpoon:list():select(4) end)
      vim.keymap.set("n", "<leader><C-y>", function() harpoon:list():replace_at(1) end)
      vim.keymap.set("n", "<leader><C-u>", function() harpoon:list():replace_at(2) end)
      vim.keymap.set("n", "<leader><C-i>", function() harpoon:list():replace_at(3) end)
      vim.keymap.set("n", "<leader><C-o>", function() harpoon:list():replace_at(4) end)

      -- Toggle previous & next buffers stored within Harpoon list
      vim.keymap.set("n", "<C-K>", function() harpoon:list():prev() end)
      vim.keymap.set("n", "<C-J>", function() harpoon:list():next() end)
    end,
  },
}
