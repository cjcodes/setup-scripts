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
          package_installed = '✓',
          package_pending = '➜',
          package_uninstalled = '✗',
        },
      },
    },
    lspconfig = {
      automatic_enable = true,
      ensure_installed = lsps,
    },
    tools = {
      ensure_installed = tools,
      lazy = true,
    },
  },
  config = function(_, opts)
    vim.env.NODE_OPTIONS = '--max-old-space-size=8192'

    vim.lsp.config('vtsls', {
      cmd_env = { NODE_OPTIONS = '--max-old-space-size=8192' },
      settings = {
        typescript = {
          tsserver = {
            maxTsServerMemory = 8192,
            pluginPaths = { './node_modules' },
          },
          preferences = { includeInlayParameterNameHints = 'none' },
        },
        javascript = {
          preferences = { includeInlayParameterNameHints = 'none' },
        },
        vtsls = {
          autoUseWorkspaceTsdk = true,
          experimental = { completion = { enableServerSideFuzzyMatch = false } },
        },
      },
    })

    vim.lsp.config('lua_ls', {
      settings = {
        Lua = {
          diagnostics = {
            globals = {
              'vim', -- for nvim configs
              'hs', -- for hammerspoon
            },
          },
        },
      },
    })

    vim.lsp.config('ts_ls', {
      cmd = {
        'typescript-language-server',
        '--stdio',
      },
      flags = {
        debouce_text_changes = 2000,
      },
      settings = {
        run = 'onSave',
      },
    })

    vim.lsp.config('eslint', {
      settings = {
        run = 'onSave',
      },
    })

    require('mason').setup(opts.mason)
    require('mason-lspconfig').setup(opts.lspconfig)
    require('mason-tool-installer').setup(opts.tools)

    vim.diagnostic.config({
      virtual_lines = false,
      virtual_text = true,
      update_in_insert = false,
    })

    vim.keymap.set('n', '<leader>dl', function()
      local lines = vim.diagnostic.config().virtual_lines

      vim.diagnostic.config({
        virtual_lines = not lines,
        virtual_text = lines,
      })
    end, { desc = 'Toggle diagnostic virtual_lines' })

    vim.keymap.set('n', '<leader>dt', function()
      vim.diagnostic.config({ virtual_text = not vim.diagnostic.config().virtual_text })
    end, { desc = 'Toggle diagnostic virtual_text' })

    vim.keymap.set('n', '<leader>dd', function()
      vim.diagnostic.config({
        virtual_text = false,
        virtual_lines = false,
      })
    end, { desc = 'Turn off diagnostic text' })
  end,
}
