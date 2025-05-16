return {
  'saghen/blink.cmp',
  version = '1.*',
  event = 'InsertEnter',
  dependencies = {
    'fang2hou/blink-copilot',
  },
  opts = {
    enabled = function()
      return not vim.tbl_contains({}, vim.bo.filetype)
        and vim.bo.buftype ~= "nofile"
        and vim.bo.buftype ~= "prompt"
        and vim.b.completion ~= false
    end,
    sources = {
      default = { 'lsp', 'path', 'copilot', 'buffer' },
      providers = {
        copilot = {
          name = 'copilot',
          module = 'blink-copilot',
          score_offset = 100,
          async = true,
        },
      },
    },
    completion = {
      menu = {
        auto_show = true,
      },
      documentation = {
        auto_show = true,
        auto_show_delay_ms = 500,
      },
    },
    keymap = {
      ['<CR>'] = { 'accept', 'fallback' },
    },
  },
}
