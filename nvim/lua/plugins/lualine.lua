return {
  'nvim-lualine/lualine.nvim',
  dependencies = {
    'nvim-tree/nvim-web-devicons',
    'catppuccin/nvim',
  },
  opts = {
    options = {
      disabled_filetypes = {
        'NvimTree',
        'trouble',
      },
      theme = 'catppuccin',
      section_separators = '',
    },
    sections = {
      lualine_a = { 'mode' },
      lualine_b = { 'branch', 'diff', 'diagnostics' },
      lualine_c = { 'filename' },
      lualine_x = { },
      lualine_y = { 'lsp_status' },
      lualine_z = { 'location' },
    },
    extensions = {
      'lazy',
      'trouble',
    }
  },
  config = function(_, opts)
    local lazy_status = require('lazy.status')
    local p = require("catppuccin.palettes").get_palette()

    require('lualine').setup(vim.tbl_deep_extend('force', opts, {
      sections = {
        lualine_x = {
          {
            lazy_status.updates,
            cond = lazy_status.has_updates,
            color = {
              bg = p.peach,
            },
          },
        },
      },
    }))
  end
}
