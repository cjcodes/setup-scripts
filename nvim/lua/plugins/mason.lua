local lsps = require('opts').lsps
local tools = require('opts').lsp_tools

return {
  'mason-org/mason.nvim',
  lazy = false,
  dependencies = {
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
    require('mason').setup(opts.mason)
    require('mason-lspconfig').setup(opts.lspconfig)
    require('mason-tool-installer').setup(opts.tools)
  end
}
