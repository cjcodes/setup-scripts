local opts = {
  number = true,

  shiftwidth = 2,
  tabstop = 2,
  softtabstop = 2,
  expandtab = true,
  autoindent = true,
  smartindent = true,

  clipboard = 'unnamedplus',
  mouse = 'a',
  cursorline = true,
  termguicolors = true,

  backup = false,
  swapfile = false,
  undofile = true,
  undodir = vim.fn.stdpath('data') .. '/undo',
  undolevels = 10000,
  showcmd = false,
  showmode = false,
  splitbelow = true,
  splitright = true,
  ignorecase = true,
  smartcase = true,
}

for k, v in pairs(opts) do
  vim.opt[k] = v
end

vim.cmd('colorscheme catppuccin')

vim.api.nvim_create_autocmd({ "VimEnter" }, { callback = require('nvim-tree.api').tree.open })
vim.api.nvim_create_autocmd({ "BufReadPre" }, { callback = require('nvim-tree.api').tree.find_file })
