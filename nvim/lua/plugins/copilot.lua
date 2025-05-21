local opts = require('opts')

return {
  {
    'zbirenbaum/copilot.lua',
    enabled = opts.llm == 'copilot',
    event = { "InsertEnter" },
    opts = {
      suggestion = {
        -- enabled = false,
        auto_trigger = false,
      },
    },
  },
  {
    'CopilotC-Nvim/CopilotChat.nvim',
    dependencies = {
      'zbirenbaum/copilot.lua',
      'nvim-lua/plenary.nvim',
    },
    build = 'make tiktoken',
    config = true,
    lazy = true,
    keys = {
      { '<leader>gg', '<cmd>CopilotChatToggle<cr>', desc = 'CopilotChat' },
      { '<leader>gc', '<cmd>CopilotChatCommit<cr>', desc = 'CopilotChat Create commit message' },
    },
  },
}
