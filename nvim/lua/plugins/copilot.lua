local opts = require('opts')

return {
  {
    'zbirenbaum/copilot.lua',
    enabled = opts.llm == 'copilot',
    event = { "BufReadPre", "BufNewFile" },
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
    opts = {

    },
    config = true,
  },
}
