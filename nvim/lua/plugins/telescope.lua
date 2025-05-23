return {
  'nvim-telescope/telescope.nvim',
  dependencies = {
    'nvim-tree/nvim-web-devicons',
  },
  lazy = true,
  opts = {
    defaults = {
      file_ignore_patterns = {
        'node_modules',
        '.git',
      },
      mappings = {
        i = {
          ['<c-d>'] = function(buf) require('telescope.actions').delete_buffer(buf) end, -- Needs to be a function, else installation fails because telescope not installed yet
        },
      },
    },
  },
  keys = {
    { '<leader>f<cr>', '<cmd>Telescope<cr>', desc = 'Open Telescope' },
    { '<leader>ff', '<cmd>Telescope find_files hidden=true<cr>', desc = 'Telescope find files' },
    { '<leader>fg', '<cmd>Telescope live_grep<cr>', desc = 'Telescope live grep' },
    { '<leader>fs', '<cmd>Telescope git_status<cr>', desc = 'Telescope git status' },
    { '<leader>fb', '<cmd>Telescope buffers<cr>', desc = 'Telescope buffers' },
    { '<leader>fh', '<cmd>Telescope help_tags<cr>', desc = 'Telescope help tags' },
    { '<leader>fr', '<cmd>Telescope oldfiles<cr>', desc = 'Telescope recent files' },
    { '<leader>ft', '<cmd>TodoTelescope<cr>', desc = "Telescope todos" },
  },
}
