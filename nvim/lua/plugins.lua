return {
  'numToStr/Comment.nvim',
  'nmac427/guess-indent.nvim',
  'nvim-treesitter/nvim-treesitter',
  'saghen/blink.cmp',
  'mason-org/mason.nvim',
  'mason-org/mason-lspconfig.nvim',
  'neovim/nvim-lspconfig',
  'nvim-telescope/telescope.nvim',
  'nvim-tree/nvim-web-devicons',
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
    config = function()
      require("nvim-tree").setup()
    end,
  },
}
