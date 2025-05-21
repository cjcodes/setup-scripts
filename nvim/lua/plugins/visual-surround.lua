return {
  'NStefan002/visual-surround.nvim',
  event = { "BufReadPre", "BufNewFile" },
  opts = {
    enable_wrapped_deletion = true,
    exit_visual_mode = false,
  },
}
