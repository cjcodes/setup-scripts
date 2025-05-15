local opts = require('opts')

return {
  'nomnivore/ollama.nvim',
  enabled = opts.llm == 'ollama',
  dependencies = { 'nvim-lua/plenary.nvim' },
  opts = {
    model = 'qwen2.5-coder',
    serve = {
      on_start = true,
    },
  },
  keys = {
    {
      '<leader>oo',
      ':<c-u>lua require("ollama").prompt()<cr>',
      mode = { 'n', 'v' },
    },
    {
      '<leader>og',
      ':<c-u>lua require("ollama").prompt("Generate_Code")<cr>',
      mode = { 'n', 'v' },
    },
    {
      '<leader>om',
      ':<c-u>lua require("ollama").prompt("Modify_Code")<cr>',
      mode = { 'n', 'v' },
    },
  },
}
