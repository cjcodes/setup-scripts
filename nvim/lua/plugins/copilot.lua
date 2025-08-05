local opts = require('opts')

local function copy_commit_message()
  local chatParent = require('CopilotChat')
  local chat = chatParent.chat

  if chat:get_closest_section().answer then
    local t = vim.loop.new_timer()
    t:start(500, 0, vim.schedule_wrap(copy_commit_message))
  else
    local answer = chat:get_closest_section('answer').content
    local msg = ''
    for line in answer:gmatch('([^\n]*)\n?') do
      if not line:match('^```') then
        msg = msg .. line .. '\n'
      end
    end
    vim.fn.setreg('*', msg)
    vim.notify('Copied commit message to clipboard')
    chatParent.close()
  end
end

local function create_commit_message()
  local chat = require('CopilotChat')
  local commitPrompt = chat.config.prompts.Commit
  chat.open()
  chat.ask(commitPrompt.prompt, commitPrompt)
  copy_commit_message()
end

return {
  {
    'zbirenbaum/copilot.lua',
    enabled = opts.llm == 'copilot',
    event = { 'InsertEnter' },
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
      { '<leader>gc', create_commit_message, desc = 'CopilotChat Create commit message' },
    },
  },
}
