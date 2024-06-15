return {
  {
    "lewis6991/gitsigns.nvim",
    opts = function()
      require('gitsigns').setup({
          signs = {
            add = {text = '▎'},
            change = {text = '▎'},
            delete = {text = '➤'},
            topdelete = {text = '➤'},
            changedelete = {text = '▎'},
        }
      })
    end,
  },
}

