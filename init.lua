-----------------------
-- WINDOW MANAGEMENT --
-----------------------
units = {
  left3       = { x = 0,   y = 0,   w = 1/3, h = 1.00 },
  mid3        = { x = 1/3, y = 0,   w = 1/3, h = 1.00 },
  right3      = { x = 2/3, y = 0,   w = 1/3, h = 1.00 },
  righttop6   = { x = 2/3, y = 0,   w = 1/3, h = 0.5  },
  rightbot6   = { x = 2/3, y = 1/2, w = 1/3, h = 0.5  },
  left23      = { x = 0,   y = 0,   w = 2/3, h = 1    },
  right23     = { x = 1/3, y = 0,   w = 2/3, h = 1    },
  mid23       = { x = 1/6, y = 0,   w = 2/3, h = 1    },
  full        = { x = 0,   y = 0,   w = 1,   h = 1    },
  lefthalf    = { x = 0,   y = 0,   w = 1/2, h = 1    },
  righthalf   = { x = 1/2, y = 0,   w = 1/2, h = 1    },
}

-- ⇧ ⌥ ⌃ ⌘
hs.window.animationDuration = 0
mod = { '⌃', '⌥' }
hs.hotkey.bind(mod, 'd', function() hs.window.focusedWindow():move(units.left3, nil, true) end)
hs.hotkey.bind(mod, 'f', function() hs.window.focusedWindow():move(units.mid3, nil, true) end)
hs.hotkey.bind(mod, 'g', function() hs.window.focusedWindow():move(units.right3, nil, true) end)
hs.hotkey.bind(mod, 'right', function() hs.window.focusedWindow():move(units.righttop6, nil, true) end)
hs.hotkey.bind({ '⌃', '⌥', '⌘' }, 'right', function() hs.window.focusedWindow():move(units.rightbot6, nil, true) end)
hs.hotkey.bind({ '⌃', '⌥', '⌘' }, 'm', function() hs.window.focusedWindow():move(units.full, nil, true) end)
hs.hotkey.bind(mod, 'e', function() hs.window.focusedWindow():move(units.left23, nil, true) end)
hs.hotkey.bind(mod, 'r', function() hs.window.focusedWindow():move(units.right23, nil, true) end)
hs.hotkey.bind(mod, 't', function() hs.window.focusedWindow():move(units.mid23, nil, true) end)
hs.hotkey.bind(mod, 'q', function() hs.window.focusedWindow():move(units.lefthalf, nil, true) end)
hs.hotkey.bind(mod, 'w', function() hs.window.focusedWindow():move(units.righthalf, nil, true) end)

--------------------------------
-- Ethernet Loss Notification --
--------------------------------

local interface = hs.network.interfaceName()

hs.timer.doEvery(30, function ()
  if hs.network.interfaceName() ~= interface then
    interface = hs.network.interfaceName()
    hs.notify.new({
      withdrawAfter = 0,
      title = 'Network interface change',
      informativeText = interface
    }):send()
  end
end)

---------
-- VPN --
---------

-- tell application "Viscosity" to connect "Twilio Engineering VPN 2022"
-- tell application "Viscosity" to disconnectall

engvpn = 'tell application "Viscosity" to connect "Twilio Engineering VPN 2022 Q4"'
oncallvpn = 'tell application "Viscosity" to connect "Twilio Engineering On-Call 2022 Q4"'
disconnect = 'tell application "Viscosity" to disconnectall'

hs.hotkey.bind({'⌥', '⌃', '⌘'}, '1', function () hs.osascript.applescript(disconnect) end)
hs.hotkey.bind({'⌥', '⌃', '⌘'}, '2', function () hs.osascript.applescript(engvpn) end)
hs.hotkey.bind({'⌥', '⌃', '⌘'}, '3', function () hs.osascript.applescript(oncallvpn) end)

----------------------
-- Typing shortcuts --
----------------------

p = hs.chooser.new(function (data)
  if data then
    hs.eventtap.keyStrokes(data['subText'])
  end
end):choices({
  { text = 'shrug', subText = '¯\\_(ツ)_/¯' },
  { text = 'table', subText = '(╯°□°)╯︵ ┻━┻' },
  { text = 'date', subText = os.date('%Y-%m-%d')},
  { text = 'cry', subText = '༼ ༎ຶ ෴ ༎ຶ༽' },
  { text = 'celebrate', subText = '“ヽ(´▽｀)ノ”' },
  { text = 'lolsob', subText = '¯\\_(⊙︿⊙)_/¯'},
  { text = 'worried', subText = '(´･_･`)'},
  { text = 'disappoint', subText = '(҂◡_◡)'},
  { text = '32', subText = '00000000000000000000000000000000'},
}):width(10):rows(5)

hs.hotkey.bind({'⌘', '⌃'}, '`', function () p:show() end)

----------
-- Mute --
----------

-- listener = hs.eventtap.new({ hs.eventtap.event.types.systemDefined }, function(event)
--   if event:systemKey().key == "SOUND_UP" and event:systemKey().down and not event:getFlags():contain({ 'ctrl' }) then
--     hs.eventtap.keyStroke({'cmd', 'shift'}, 'a', 200000, hs.application.get('zoom.us'))
--     return true
--   end
-- end):start()

----------------------
-- Scroll Direction --
----------------------

scroll_script = [[
try
tell application "System Preferences"
  activate
  set current pane to pane "com.apple.preference.trackpad"
end tell
delay 0.5
tell application "System Events"
  tell process "System Preferences"
    click radio button "Scroll & Zoom" of tab group 1 of window "Trackpad"
    click checkbox 1 of tab group 1 of window "Trackpad"
    tell application "System Preferences" to quit
  end tell
end tell
end try
]]

hs.hotkey.bind({'⌥', '⌃', '⌘'}, '4', function () hs.osascript.applescript(scroll_script) end)
