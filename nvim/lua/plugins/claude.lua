return {
  'greggh/claude-code.nvim',
  dependencies = {
    'nvim-lua/plenary.nvim', -- Required for git operations
  },
  opts = {
    window = {
      position = 'float',
    },
    keymaps = {
      toggle = {
        normal = '<A-\\>',
        terminal = '<A-\\>',
      },
    },
  },
}
