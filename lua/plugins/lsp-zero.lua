return {
  {
    "VonHeikemen/lsp-zero.nvim",
    dependencies = {
      'williamboman/mason.nvim',
      'williamboman/mason-lspconfig.nvim',
      'neovim/nvim-lspconfig',
      'hrsh7th/cmp-nvim-lsp',
      'hrsh7th/nvim-cmp',
      'L3MON4D3/LuaSnip',
    },
    opts = function()
      local lsp_zero = require('lsp-zero')

      lsp_zero.on_attach(function(client, bufnr)
        -- see :help lsp-zero-keybindings
        lsp_zero.default_keymaps({buffer = bufnr})
      end)

      -- lsp_zero.setup_servers({'clangd'})

      require('mason').setup({})
      require('mason-lspconfig').setup({
        ensure_installed = { "clangd", "gopls", "zls" },
        handlers = {
          function(clangd)
            require('lspconfig')[clangd].setup({})
          end,
          function(gopls)
            require('lspconfig')[gopls].setup({})
          end,
          function(zls)
            require('lspconfig')[zls].setup({})
          end,
        }
      })
    end,
  },
}
