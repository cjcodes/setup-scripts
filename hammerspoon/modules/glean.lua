-- Prompt for a Glean search and open the results in a webview.

local shared = require('modules.shared')

local function openGlean()
  local button, search = hs.dialog.textPrompt('Search Glean', '', '', 'Open', 'Cancel')

  if button == 'Open' then
    search = hs.http.encodeForQuery(search)
    shared.openWindow('https://app.glean.com/search?q=' .. search)
  end
end

hs.hotkey.bind('⌃', 'space', openGlean)
