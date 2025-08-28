return {
  'johnseth97/codex.nvim',
  lazy = true,
  keys = {
    {
      '<A-\\>',
      function()
        require('codex').toggle()
      end,
      desc = 'Toggle Codex popup',
    },
  },
  opts = {
    autoinstall = true,
    keymaps = {
      quit = '<A-\\>',
    },
  },
}
