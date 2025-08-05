return {
  'catppuccin/nvim',
  name = 'catppuccin',
  priority = 1000,
  opts = {
    integrations = {
      blink_cmp = true,
      treesitter = true,
      notify = true,
      mason = true,
      noice = true,
      telescope = {
        enabled = true,
      },
      which_key = true,
    },
  },
  config = function(_, opts)
    require('catppuccin').setup(opts)
    vim.cmd('colorscheme catppuccin')
  end,
}
