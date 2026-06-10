-- Reload the Hammerspoon config.

local shared = require('modules.shared')

hs.hotkey.bind(shared.extraMod, 'r', hs.reload)
