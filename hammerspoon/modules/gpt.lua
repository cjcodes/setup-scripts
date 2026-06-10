-- Prompt for a ChatGPT query and open it in a webview.

local shared = require('modules.shared')

local function openGPT()
  local button, search = hs.dialog.textPrompt('Ask GPT', '', '', 'Open', 'Cancel')

  if button == 'Open' then
    search = hs.http.encodeForQuery(search)
    shared.openWindow('https://chatgpt.com/?q=' .. search)
  end
end

hs.hotkey.bind('⌥', 'space', openGPT)
