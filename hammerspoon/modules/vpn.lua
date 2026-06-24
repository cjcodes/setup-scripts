-- Menu bar VPN indicator: flashes a Pritunl icon while the VPN is disconnected.

local shared = require('modules.shared')
local Timers = shared.Timers

local vpnInterface = 'utun4'
local vpnMenu = hs.menubar.new()
local vpnIconA = hs.image.imageFromPath(hs.configdir .. '/pritunl.png'):setSize({ w = 18, h = 18 })
local vpnIconB = hs.image.imageFromPath(hs.configdir .. '/pritunl-inverted.png'):setSize({ w = 18, h = 18 })
local vpnIconToggle = false

local function flashVpnIcon()
  vpnIconToggle = not vpnIconToggle
  vpnMenu:setIcon(vpnIconToggle and vpnIconB or vpnIconA, false)
end

local function showVpnIcon()
  if Timers.vpnFlash then
    return
  end
  vpnMenu:setIcon(vpnIconA, false)
  vpnMenu:setClickCallback(function()
    hs.application.open('Pritunl')
  end)
  vpnIconToggle = false
  Timers.vpnFlash = hs.timer.doEvery(0.8, flashVpnIcon)
end

local function hideVpnIcon()
  if Timers.vpnFlash then
    Timers.vpnFlash:stop()
    Timers.vpnFlash = nil
  end
  vpnMenu:removeFromMenuBar()
end

local function checkVpnStatus()
  local _, status, _, _ = hs.execute('ifconfig ' .. vpnInterface .. ' 2>/dev/null')

  if not status then
    if not Timers.vpnFlash then
      vpnMenu:returnToMenuBar()
      showVpnIcon()
    end
  else
    hideVpnIcon()
  end
end

-- Check every n seconds
Timers.vpn = hs.timer.doEvery(30, checkVpnStatus)
checkVpnStatus()

-- Anchor the menu bar item AND the icon images against garbage collection.
-- The icons are module locals whose only live reference is flashVpnIcon's
-- closure, kept reachable by Timers.vpnFlash. When the VPN connects,
-- hideVpnIcon() stops that timer and clears Timers.vpnFlash, dropping the last
-- anchor on the images. A later GC cycle then collects them, so the next time
-- the VPN drops, setIcon() is handed a dead hs.image and nothing renders --
-- the icon "disappears hours after a reload". Holding the icons in the
-- returned table (kept alive via Modules.vpn) keeps them valid for the
-- process lifetime.
return { menu = vpnMenu, iconA = vpnIconA, iconB = vpnIconB }
