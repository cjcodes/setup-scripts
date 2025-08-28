return {
  'nvim-tree/nvim-tree.lua',
  lazy = false,
  dependencies = {
    'nvim-tree/nvim-web-devicons',
  },
  opts = {
    view = {
      width = '25%',
      relativenumber = true,
    },
    renderer = {
      indent_markers = {
        enable = true,
      },
    },
    git = {
      ignore = false,
    },
  },
  config = function(_, opts)
    require('nvim-tree').setup(opts)

    local nvimTree = require('nvim-tree.api')
    local nvimTreeFocusOrToggle = function()
      local currentBuf = vim.api.nvim_get_current_buf()
      local currentBufFt = vim.api.nvim_get_option_value('filetype', {
        buf = currentBuf,
      })
      if currentBufFt == 'NvimTree' then
        nvimTree.tree.toggle()
      else
        nvimTree.tree.focus()
      end
    end

    vim.keymap.set('n', '<leader>ee', nvimTreeFocusOrToggle, { desc = 'Toggle nvim-tree' })
    vim.keymap.set('n', '<leader>ef', nvimTree.tree.find_file, { desc = 'Find this file in nvim-tree' })
    vim.keymap.set('n', '<leader>er', nvimTree.tree.reload, { desc = 'Reload nvim-tree' })

    vim.api.nvim_create_autocmd({ 'VimEnter' }, { callback = nvimTree.tree.open })
    vim.api.nvim_create_autocmd({ 'BufReadPre' }, { callback = nvimTree.tree.find_file })
  end,
}
