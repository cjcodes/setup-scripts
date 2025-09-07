vim.g.loaded_netrw = 1
vim.g.loaded_netrwPlugin = 1
vim.g.mapleader = ' '
vim.g.maplocalleader = '\\'

-- Use OSC52 clipboard provider only when in an SSH session
local function is_ssh()
  return (vim.env.SSH_TTY and vim.env.SSH_TTY ~= '')
    or (vim.env.SSH_CONNECTION and vim.env.SSH_CONNECTION ~= '')
    or (vim.env.SSH_CLIENT and vim.env.SSH_CLIENT ~= '')
end

if is_ssh() then
  vim.g.clipboard = 'osc52'
end
