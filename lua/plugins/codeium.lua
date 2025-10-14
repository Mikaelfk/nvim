return 
{
  {
    "Exafunction/codeium.nvim",
    dependencies = {
      "nvim-lua/plenary.nvim",
      "hrsh7th/nvim-cmp",
      "nvim-lualine/lualine.nvim", -- add lualine as dependency if not already loaded
    },
    config = function()
      local ok, codeium = pcall(require, "codeium")
      if not ok then
        vim.notify("Codeium not found!", vim.log.levels.ERROR)
        return
      end

      codeium.setup({
        enable_chat = true,
      })

      -- Optional: integrate Codeium with nvim-cmp
      local cmp_ok, cmp = pcall(require, "cmp")
      if cmp_ok then
        cmp.setup({
          sources = cmp.config.sources({
            { name = "codeium" },

          }, cmp.get_config().sources),
        })
      end
    end
  },
}
