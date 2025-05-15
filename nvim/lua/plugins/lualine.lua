return {
  'nvim-lualine/lualine.nvim',
  dependencies = {
    'nvim-tree/nvim-web-devicons',
    'catppuccin/nvim',
  },
  opts = {
    disabled_filetypes = {
      'NvimTree',
    },
    theme = 'catppuccin',
  },
  config = function(_, opts)
    local lazy_status = require('lazy.status')

    require('lualine').setup({
      options = opts,
      sections = {
        lualine_x = {
          {
            lazy_status.updates,
            cond = lazy_status.has_updates,
            -- FIXME: add a color for this
          },
        },
      },
    })
  end
}
