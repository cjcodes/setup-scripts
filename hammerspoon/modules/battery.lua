-- Menu bar battery indicator: time remaining on battery, percentage when charging.

local shared = require('modules.shared')
local Timers = shared.Timers

local batteryMenu = hs.menubar.new()

local function updateBatteryMenu()
  local amperage = math.abs(hs.battery.amperage())

  if hs.battery.powerSource() == 'Battery Power' and amperage > 0 then
    local minutesRemaining = hs.battery.timeRemaining()
    local hours = math.floor(minutesRemaining / 60)
    local minutes = math.floor(minutesRemaining % 60)
    batteryMenu:setTitle(string.format('🔋 %d:%02d', hours, minutes))
  else
    local percent = hs.battery.percentage()
    batteryMenu:setTitle(string.format('🔌 %d%%', percent))
  end
end

Timers.battery = hs.timer.doEvery(30, updateBatteryMenu)
updateBatteryMenu()
