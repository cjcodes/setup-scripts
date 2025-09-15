local keymap = {
  ['<c-d>'] = function(buf)
    require('telescope.actions').delete_buffer(buf)
  end,
}

local find_in_dir = function()
  local node = require('nvim-tree.api').tree.get_node_under_cursor()
  local path = node.absolute_path

  -- if it's a file, strip to its parent dir
  local stat = vim.loop.fs_stat(path)
  if stat and stat.type == 'file' then
    path = vim.fn.fnamemodify(path, ':h')
  end

  local display_path = path:gsub('^' .. vim.pesc(vim.fn.getcwd()) .. '/?', './')

  require('telescope.builtin').live_grep({
    cwd = path,
    prompt_title = 'Live grep: ' .. display_path,
  })
end

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
        i = keymap,
        n = keymap,
      },
    },
  },
  keys = {
    { '<leader>f<cr>', '<cmd>Telescope<cr>', desc = 'Open Telescope' },
    { '<leader>ff', '<cmd>Telescope find_files hidden=true<cr>', desc = 'Telescope find files' },
    { '<leader>fg', '<cmd>Telescope live_grep<cr>', desc = 'Telescope live grep' },
    { '<leader>fs', '<cmd>Telescope git_status<cr>', desc = 'Telescope git status' },
    { '<leader>fb', '<cmd>Telescope buffers<cr>', desc = 'Telescope buffers' },
    -- { "<leader>fh", "<cmd>Telescope help_tags<cr>", desc = "Telescope help tags" },
    { '<leader>fh', '<cmd>Telescope oldfiles<cr>', desc = 'Telescope recent files' },
    { '<leader>fr', '<cmd>Telescope lsp_references<cr>', desc = 'Telescope lsp references' },
    { '<leader>ft', '<cmd>TodoTelescope<cr>', desc = 'Telescope todos' },
    { '<leader>fd', find_in_dir, desc = 'Find in current dir' },
  },
}
