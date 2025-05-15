local opts = require('opts')

return {
  "zbirenbaum/copilot.lua",
  enabled = opts.llm == 'copilot',
  event = { "BufReadPre", "BufNewFile" },
  opts = {
    suggestion = { enabled = false },
    panel = { enabled = false },
  },
}
