return {
  {
    'akinsho/toggleterm.nvim', 
    version = "*", 
    opts = function()
      require("toggleterm").setup{
        open_mapping = '<C-g>',
          direction = 'horizontal',
          shade_terminals = true
      }
    end,
  },
}
