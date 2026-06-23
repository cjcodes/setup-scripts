-- Hammerspoon config. Each piece of functionality lives in modules/.
--
-- Module contract: every module returns a table. Modules that own a long-lived
-- object (menu bar item, chooser, timer) put it in that table; pure-hotkey
-- modules return {}. We keep every return in Modules so a live reference always
-- exists; otherwise Lua garbage-collects the locals once require() returns and
-- the menu bar items vanish.
Modules = {}

local MODULES = {
  'reload',
  'window',
  'typing',
  'scroll',
  'caffeine',
  'scrcpy',
  'glean',
  'gpt',
  'battery',
  'vpn',
  'reviews',
}

for _, name in ipairs(MODULES) do
  Modules[name] = require('modules.' .. name)
end
