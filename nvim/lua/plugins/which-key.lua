return {
  'folke/which-key.nvim',
  event = 'VeryLazy',
  opts = {
    delay = 600,
    preset = "helix",
  },
  keys = {
    {
      '<leader>?',
      function()
        require('which-key').show({ global = false })
      end,
      desc = 'Buffer Local Keymaps (which-key)',
    },
  },
  config = function(_, opts)
    local w = require('which-key')
    w.add({
      { '<leader>x', group = 'trouble' },
      { '<leader>d', group = 'diagnostics' },
      { '<leader>f', group = 'telescope' },
      { '<leader>e', group = 'tree' },
      { '<leader>g', group = 'CopilotChat' },
    })
    w.setup(opts)
  end
}
