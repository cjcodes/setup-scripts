-- non-plugin-specific keybindings

vim.keymap.set({ 'n', 'v' }, '<leader>q', '<cmd>qa<cr>', { desc = 'quit' })
vim.keymap.set({ 'n', 'v' }, '<leader>w', '<cmd>w<cr>', { desc = 'write' })
vim.keymap.set({ 'n', 'v' }, '<leader>a', vim.lsp.buf.code_action, { desc = 'Show code actions' })
vim.keymap.set({ 'n', 'v' }, '<leader><tab>', '<cmd>b#<cr>', { desc = 'Switch to last buffer' })
