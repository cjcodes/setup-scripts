-- Window management hotkeys.

local shared = require('modules.shared')
local mod = shared.mod
local extraMod = shared.extraMod

local DEMO_WIDTH = 1920
local DEMO_HEIGHT = 1080
local units = {
  left3 = { x = 0, y = 0, w = 1 / 3, h = 1.00 },
  mid3 = { x = 1 / 3, y = 0, w = 1 / 3, h = 1.00 },
  right3 = { x = 2 / 3, y = 0, w = 1 / 3, h = 1.00 },
  righttop6 = { x = 2 / 3, y = 0, w = 1 / 3, h = 0.5 },
  rightbot6 = { x = 2 / 3, y = 1 / 2, w = 1 / 3, h = 0.5 },
  left23 = { x = 0, y = 0, w = 2 / 3, h = 1 },
  right23 = { x = 1 / 3, y = 0, w = 2 / 3, h = 1 },
  mid23 = { x = 1 / 6, y = 0, w = 2 / 3, h = 1 },
  full = { x = 0, y = 0, w = 1, h = 1 },
  lefthalf = { x = 0, y = 0, w = 1 / 2, h = 1 },
  righthalf = { x = 1 / 2, y = 0, w = 1 / 2, h = 1 },
  zoom = { x = 1 / 6, y = 0, w = 1 / 3, h = 1 },
  centre = { x = 0.05, y = 0.05, w = 0.9, h = 0.9 },
  demo = { w = DEMO_WIDTH, h = DEMO_HEIGHT },
  toast = { w = 0.7, h = 0.75, x = 0, y = 0.125 },
}

-- ⇧ ⌥ ⌃ ⌘
hs.window.animationDuration = 0
hs.hotkey.bind(mod, 'd', function()
  hs.window.focusedWindow():move(units.left3, nil, true)
end)
hs.hotkey.bind(mod, 'f', function()
  hs.window.focusedWindow():move(units.mid3, nil, true)
end)
hs.hotkey.bind(mod, 'g', function()
  hs.window.focusedWindow():move(units.right3, nil, true)
end)
hs.hotkey.bind(mod, 'right', function()
  hs.window.focusedWindow():move(units.righttop6, nil, true)
end)
hs.hotkey.bind(mod, 'e', function()
  hs.window.focusedWindow():move(units.left23, nil, true)
end)
hs.hotkey.bind(mod, 'r', function()
  hs.window.focusedWindow():move(units.right23, nil, true)
end)
hs.hotkey.bind(mod, 't', function()
  hs.window.focusedWindow():move(units.mid23, nil, true)
end)
hs.hotkey.bind(mod, 'q', function()
  hs.window.focusedWindow():move(units.lefthalf, nil, true)
end)
hs.hotkey.bind(mod, 'w', function()
  hs.window.focusedWindow():move(units.righthalf, nil, true)
end)
hs.hotkey.bind(mod, 'z', function()
  hs.window.focusedWindow():move(units.zoom, nil, true)
end)
hs.hotkey.bind(extraMod, 'right', function()
  hs.window.focusedWindow():move(units.rightbot6, nil, true)
end)
hs.hotkey.bind(extraMod, 'm', function()
  hs.window.focusedWindow():move(units.full, nil, true)
end)
hs.hotkey.bind(extraMod, 'c', function()
  local w = hs.window.focusedWindow()
  local mode = w:screen():currentMode()

  if mode.w / mode.h > 2.1 then
    w:move({
      w = 0.6,
      h = units.centre.h,
      x = 0.2,
      y = 0.1,
    })
  else
    w:move(units.centre)
  end
end)
hs.hotkey.bind(extraMod, 'd', function()
  hs.window.focusedWindow():setSize(units.demo)
  hs.window.focusedWindow():centerOnScreen()
end)
hs.hotkey.bind(extraMod, 't', function()
  hs.window.focusedWindow():move(units.toast)
  -- hs.window.focusedWindow():centerOnScreen()
  -- hs.window.focusedWindow():move({ x = 0 }, nil, true)
end)
