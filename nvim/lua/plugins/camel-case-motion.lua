return {
  {
    'bkad/CamelCaseMotion',
    lazy = false, -- load on startup so motions work immediately
    config = function()
      local opts = { silent = true, remap = true }

      -- override default word motions
      vim.keymap.set({ 'n', 'x', 'o' }, 'w', '<Plug>CamelCaseMotion_w', opts)
      vim.keymap.set({ 'n', 'x', 'o' }, 'b', '<Plug>CamelCaseMotion_b', opts)
      vim.keymap.set({ 'n', 'x', 'o' }, 'e', '<Plug>CamelCaseMotion_e', opts)
      vim.keymap.set({ 'n', 'x', 'o' }, 'ge', '<Plug>CamelCaseMotion_ge', opts)

      -- optional: camelCase text objects
      vim.keymap.set({ 'x', 'o' }, 'ic', '<Plug>CamelCaseMotion_ie', opts) -- inner camel
      vim.keymap.set({ 'x', 'o' }, 'ac', '<Plug>CamelCaseMotion_ae', opts) -- a camel
    end,
  },
}
