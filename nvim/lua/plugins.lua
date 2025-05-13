return {
  'numToStr/Comment.nvim',
  'nmac427/guess-indent.nvim',
  {
    'nvim-treesitter/nvim-treesitter',
    build = ':TSUpdate',
    config = function () 
      local configs = require("nvim-treesitter.configs")

      configs.setup({
        auto_install = true,
        highlight = {
          enable = true,
        },
        indent = {
          enable = true,
        },
      })
    end
  },
  {
    'mason-org/mason.nvim',
    lazy = false,
    opts = {},
  },
  'mason-org/mason-lspconfig.nvim',
  'neovim/nvim-lspconfig',
  'nvim-tree/nvim-web-devicons',
  {
    'saghen/blink.cmp',
    version = '1.*',
    opts = {
      completion = {
        menu = {
          auto_show = true,
        },
      },
    },
  },
  {
    'nvim-telescope/telescope.nvim',
    config = function()
      require('telescope').setup({
        defaults = {
          mappings = {
            n = {
              ['<bs>'] = require('telescope.actions').delete_buffer
            },
          },
        },
      })
    end,
  },
  {
    'catppuccin/nvim',
    name = 'catppuccin',
    priority = 1000,
    opts = {
      integrations = {
        blink_cmp = true,
        treesitter = true,
        notify = true,
        mason = true,
        telescope = {
          enabled = true
        },
        which_key = true,
      }
    }
  },
  {
    'windwp/nvim-autopairs',
    event = 'InsertEnter',
    config = true,
  },
  {
    'folke/which-key.nvim',
    event = 'VeryLazy',
    keys = {
      {
        '<leader>?',
        function()
          require('which-key').show({ global = false })
        end,
        desc = 'Buffer Local Keymaps (which-key)',
      },
    },
  },
  {
    "nvim-tree/nvim-tree.lua",
    lazy = false,
    dependencies = {
      "nvim-tree/nvim-web-devicons",
    },
    opts = {
      view = {
        width = 60,
      },
    },
  },
}
