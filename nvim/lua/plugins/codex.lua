local function toggle()
  require('codex').toggle()
end

local desc = 'Toggle Codex popup'

return {
  'johnseth97/codex.nvim',
  lazy = true,
  keys = {
    {
      '<A-\\>',
      toggle,
      desc = desc,
    },
    {
      '<A-tab>',
      toggle,
      desc = desc,
    },
  },
  opts = {
    autoinstall = true,
    keymaps = {
      quit = '<A-\\>',
    },
  },
}
