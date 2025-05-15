return {
  'nvim-telescope/telescope.nvim',
  dependencies = {
    'nvim-tree/nvim-web-devicons',
  },
  opts = {
    -- path_display = { 'smart' },
  },
  config = function(_, opts)
    local defaults = {
      defaults = {
        file_ignore_patterns = {
          'node_modules',
          '.git',
        },
        mappings = {
          i = {
            ['<c-d>'] = require('telescope.actions').delete_buffer
          },
        },
      },
    }

    for k,v in pairs(opts) do defaults.defaults[k] = v end
    require('telescope').setup(defaults)

    local builtin = require('telescope.builtin')

    vim.keymap.set('n', '<leader>ff', function () builtin.find_files({hidden=true}) end, { desc = 'Telescope find files' })
    vim.keymap.set('n', '<leader>fg', builtin.live_grep, { desc = 'Telescope live grep' })
    vim.keymap.set('n', '<leader>fb', builtin.buffers, { desc = 'Telescope buffers' })
    vim.keymap.set('n', '<leader>fh', builtin.help_tags, { desc = 'Telescope help tags' })
    vim.keymap.set('n', '<leader>fr', builtin.oldfiles, { desc = 'Telescope recent files' })
    vim.keymap.set("n", "<leader>ft", "<cmd>TodoTelescope<cr>", { desc = "Telescope todos" })
  end,
}
