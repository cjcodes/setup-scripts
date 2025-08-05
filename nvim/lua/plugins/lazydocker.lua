return {
  'mgierada/lazydocker.nvim',
  dependencies = { 'akinsho/toggleterm.nvim' },
  config = true,
  keys = {
    { '<leader>ld', '<cmd>Lazydocker<cr>', desc = 'Open LazyDocker' },
  },
}
