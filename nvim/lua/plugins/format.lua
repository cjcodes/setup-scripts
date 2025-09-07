return {
  'stevearc/conform.nvim',
  event = { 'BufReadPre', 'BufNewFile' },
  opts = {
    formatters_by_ft = {
      javascript = { 'prettier', 'eslint_d' },
      typescript = { 'prettier', 'eslint_d' },
      javascriptreact = { 'prettier', 'eslint_d' },
      typescriptreact = { 'prettier', 'eslint_d' },
      css = { 'prettier' },
      html = { 'prettier' },
      json = { 'prettier' },
      yaml = { 'prettier' },
      markdown = { 'prettier' },
      graphql = { 'prettier' },
      lua = { 'stylua' },
      python = { 'isort', 'black' },
      php = { 'php_cs_fixer' },
    },
    format_after_save = {
      lsp_format = 'fallback',
      async = true,
      timeout_ms = 10000,
    },
  },
}
