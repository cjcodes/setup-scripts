return {
  'nvim-treesitter/nvim-treesitter',
  build = ':TSUpdate',
  main = 'nvim-treesitter.configs',
  dependencies = {
    'nvim-tree/nvim-web-devicons',
    'windwp/nvim-ts-autotag',
  },
  opts = {
    auto_install = true,
    highlight = {
      enable = true,
    },
    indent = {
      enable = true,
    },
    autotag = {
      enable = true,
    },
    incremental_selection = {
      enable = true,
      keymaps = {
        init_selection = '<C-space>',
        node_incremental = '<C-space>',
        scope_incremental = false,
        node_decremental = '<bs>',
      }
    }
  },
  config = function (_, opts)
    require('nvim-treesitter.configs').setup(opts)
  end
}
