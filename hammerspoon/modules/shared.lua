-- Shared values and helpers used across modules.

local M = {}

M.log = hs.logger.new('cjcodes', 'info')

M.mod = { '⌃', '⌥' }
M.extraMod = { '⌃', '⌥', '⌘' }

-- Holds long-lived timers so they aren't garbage collected.
Timers = Timers or {}
M.Timers = Timers

-- Opens a URL in a small, self-contained webview window. Links and new-window
-- requests are handed off to the default browser instead of navigating inside
-- the webview.
function M.openWindow(url)
  local m = hs.webview.windowMasks

  local view = hs.webview
    .new({
      w = 750,
      h = 800,
    })
    :url(url)
    :deleteOnClose(true)
    :windowStyle(m.closable + m.utility + m.titled + m.texturedBackground)
    :allowNewWindows(false)
    :closeOnEscape(true)
    :allowTextEntry(true)
    :policyCallback(function(action, webview, details)
      if
        ((action == 'navigationAction' and details.navigationType == 'linkActivated') or action == 'newWindow')
        and details.request
        and details.request.URL
      then
        hs.urlevent.openURL(details.request.URL)
        webview:delete()
        return false
      end
      return true
    end)
    :show()

  view:hswindow():centerOnScreen()
end

return M
