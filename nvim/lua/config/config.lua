local opts = {
  number = true,
  relativenumber = true,
  signcolumn = 'yes',

  shiftwidth = 2,
  tabstop = 2,
  softtabstop = 2,
  expandtab = true,
  autoindent = true,
  smartindent = true,

  mouse = 'a',
  cursorline = true,
  termguicolors = true,
  showmode = false,
  splitbelow = true,
  splitright = true,
  showcmd = false,

  backup = false,
  swapfile = false,
  undofile = true,
  undodir = vim.fn.stdpath('data') .. '/undo',
  undolevels = 10000,

  ignorecase = true,
  smartcase = true,
  backspace = 'indent,eol,start',
}

for k, v in pairs(opts) do
  vim.opt[k] = v
end

vim.opt.clipboard:append('unnamedplus')
