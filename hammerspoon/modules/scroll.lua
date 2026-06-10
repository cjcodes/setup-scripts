-- Toggle natural scrolling via System Settings UI automation.

local scroll_script = [[
try
do shell script "open x-apple.systempreferences:com.apple.Trackpad-Settings.extension"
delay 1.5
tell application "System Events"
	tell process "System Settings"
    click radio button 2 of tab group 1 of group 1 of group 3 of splitter group 1 of group 1 of window "Trackpad"
		delay 0.5
    click checkbox "Natural scrolling" of group 1 of scroll area 1 of group 1 of group 3 of splitter group 1 of group 1 of window "Trackpad"
	end tell
end tell
delay 0.5
tell application "System Settings" to quit
end try
]]

hs.hotkey.bind({ '⌥', '⌃', '⌘' }, '4', function()
  hs.osascript.applescript(scroll_script)
end)
