-----------------------
-- WINDOW MANAGEMENT --
-----------------------
DEMO_WIDTH = 1920
DEMO_HEIGHT = 1080
units = {
  left3     = { x = 0, y = 0, w = 1 / 3, h = 1.00 },
  mid3      = { x = 1 / 3, y = 0, w = 1 / 3, h = 1.00 },
  right3    = { x = 2 / 3, y = 0, w = 1 / 3, h = 1.00 },
  righttop6 = { x = 2 / 3, y = 0, w = 1 / 3, h = 0.5 },
  rightbot6 = { x = 2 / 3, y = 1 / 2, w = 1 / 3, h = 0.5 },
  left23    = { x = 0, y = 0, w = 2 / 3, h = 1 },
  right23   = { x = 1 / 3, y = 0, w = 2 / 3, h = 1 },
  mid23     = { x = 1 / 6, y = 0, w = 2 / 3, h = 1 },
  full      = { x = 0, y = 0, w = 1, h = 1 },
  lefthalf  = { x = 0, y = 0, w = 1 / 2, h = 1 },
  righthalf = { x = 1 / 2, y = 0, w = 1 / 2, h = 1 },
  zoom      = { x = 1 / 6, y = 0, w = 1 / 3, h = 1 },
  demo      = { w = DEMO_WIDTH, h = DEMO_HEIGHT },
}

-- ⇧ ⌥ ⌃ ⌘
hs.window.animationDuration = 0
mod = { '⌃', '⌥' }
extraMod = { '⌃', '⌥', '⌘' }
hs.hotkey.bind(mod, 'd', function() hs.window.focusedWindow():move(units.left3, nil, true) end)
hs.hotkey.bind(mod, 'f', function() hs.window.focusedWindow():move(units.mid3, nil, true) end)
hs.hotkey.bind(mod, 'g', function() hs.window.focusedWindow():move(units.right3, nil, true) end)
hs.hotkey.bind(mod, 'right', function() hs.window.focusedWindow():move(units.righttop6, nil, true) end)
hs.hotkey.bind(mod, 'e', function() hs.window.focusedWindow():move(units.left23, nil, true) end)
hs.hotkey.bind(mod, 'r', function() hs.window.focusedWindow():move(units.right23, nil, true) end)
hs.hotkey.bind(mod, 't', function() hs.window.focusedWindow():move(units.mid23, nil, true) end)
hs.hotkey.bind(mod, 'q', function() hs.window.focusedWindow():move(units.lefthalf, nil, true) end)
hs.hotkey.bind(mod, 'w', function() hs.window.focusedWindow():move(units.righthalf, nil, true) end)
hs.hotkey.bind(mod, 'z', function() hs.window.focusedWindow():move(units.zoom, nil, true) end)
hs.hotkey.bind(extraMod, 'right', function() hs.window.focusedWindow():move(units.rightbot6, nil, true) end)
hs.hotkey.bind(extraMod, 'm', function() hs.window.focusedWindow():move(units.full, nil, true) end)
hs.hotkey.bind(extraMod, 'd',
  function()
    hs.window.focusedWindow():setSize(units.demo)
    hs.window.focusedWindow():centerOnScreen()
  end)

----------------------
-- Typing shortcuts --
----------------------

p = hs.chooser.new(function(data)
  if data then
    hs.eventtap.keyStrokes(data['subText'])
  end
end):choices({
  { text = 'shrug', subText = '¯\\_(ツ)_/¯' },
  { text = 'table', subText = '(╯°□°)╯︵ ┻━┻' },
  { text = 'date', subText = os.date('%Y-%m-%d') },
  { text = 'cry', subText = '༼ ༎ຶ ෴ ༎ຶ༽' },
  { text = 'celebrate', subText = '“ヽ(´▽｀)ノ”' },
  { text = 'celebrate2', subText = '\\(• ◡ •)/' },
  { text = 'dead', subText = '✖_✖' },
  { text = 'lolsob', subText = '¯\\_(⊙︿⊙)_/¯' },
  { text = 'worried', subText = '(´･_･`)' },
  { text = 'disappoint', subText = '(҂◡_◡)' },
  { text = '32', subText = '00000000000000000000000000000000' },
  { text = 'rockon', subText = '+:rockon:' },
  { text = 'thumbsup', subText = '+:+1:' },
  { text = 'thanks', subText = '+:thank_you:' },
  { text = 'plusone', subText = '+:plusone:' },
}):width(10):rows(5)

hs.hotkey.bind({ '⌘', '⌃' }, '`', function() p:show() end)

----------------------
-- Scroll Direction --
----------------------

scroll_script = [[
try
do shell script "open x-apple.systempreferences:com.apple.Trackpad-Settings.extension"
delay 2
tell application "System Events"
	tell process "System Settings"
		click radio button 2 of tab group 1 of group 1 of group 2 of splitter group 1 of group 1 of window "Trackpad"
		delay 0.5
		click checkbox "Natural scrolling" of group 1 of scroll area 1 of group 1 of group 2 of splitter group 1 of group 1 of window "Trackpad"
	end tell
end tell
delay 0.5
tell application "System Settings" to quit
end try
]]

hs.hotkey.bind({ '⌥', '⌃', '⌘' }, '4', function() hs.osascript.applescript(scroll_script) end)

----------------------------
-- Screen Saver Preventer --
----------------------------

caffeine = hs.menubar.new()
function setCaffeineDisplay(state)
  if state then
    caffeine:setTitle("🖥️☀️")
  else
    caffeine:setTitle("🖥️🌙")
  end
end

function caffeineClicked()
  setCaffeineDisplay(hs.caffeinate.toggle("displayIdle"))
end

if caffeine then
  caffeine:setClickCallback(caffeineClicked)
  setCaffeineDisplay(hs.caffeinate.get("displayIdle"))
end

---------------------------
-- Quick password typing --
---------------------------

function type_password()
  local f = io.open("password", "r") -- this is in the ~/.hammerspoon directory, maybe move this if I bring this command back
  local t = f:read("*line")
  hs.eventtap.keyStrokes("cjohnson")
  hs.eventtap.keyStroke({}, "tab")
  hs.eventtap.keyStrokes(t)
end

-- hs.hotkey.bind({ '⌥', '⌃', '⌘' }, '5', type_password)
