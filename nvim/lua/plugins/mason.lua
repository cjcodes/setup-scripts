local lsps = require('opts').lsps
local tools = require('opts').lsp_tools

return {
  'mason-org/mason.nvim',
  lazy = false,
  dependencies = {
    'neovim/nvim-lspconfig',
    'mason-org/mason-lspconfig.nvim',
    'WhoIsSethDaniel/mason-tool-installer.nvim',
  },
  opts = {
    mason = {
      ui = {
        icons = {
          package_installed = "✓",
          package_pending = "➜",
          package_uninstalled = "✗",
        },
      },
    },
    lspconfig = {
      automatic_enable = true,
      ensure_installed = lsps,
    },
    tools = {
      ensure_installed = tools,
    },
  },
  config = function(_, opts)
    require('lspconfig')['lua_ls'].setup({
      settings = {
        Lua = {
          diagnostics = {
            globals = { "vim" },
          },
        },
      },
    })
    require('mason').setup(opts.mason)
    require('mason-lspconfig').setup(opts.lspconfig)
    require('mason-tool-installer').setup(opts.tools)
  end
}
