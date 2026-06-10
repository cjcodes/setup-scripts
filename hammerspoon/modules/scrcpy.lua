-- Remote access to an Android phone via scrcpy.

local shared = require('modules.shared')
local log = shared.log

-- local task
-- PhoneIcon = hs.menubar.new()

local function logOut(_, stdOut, stdErr)
  if stdErr ~= nil then
    log:e(stdErr)
  end

  log:i(stdOut)
end

local function toggleScrCpy()
  if task ~= nil and task:isRunning() then
    hs.task.new('/opt/homebrew/bin/adb', logOut, { 'shell', 'input', 'keyevent', 'KEYCODE_WAKEUP' })
    hs.application.applicationForPID(task:pid()):activate()
    return
  end

  task = hs.task
    .new('/opt/homebrew/bin/scrcpy', logOut, { '--turn-screen-off', '--no-audio', '--max-fps=60', '--video-buffer=10' })
    :setEnvironment({ ADB = '/opt/homebrew/bin/adb' })
    :start()

  hs.task.new('/opt/homebrew/bin/adb', logOut, { 'shell', 'input', 'keyevent', 'KEYCODE_WAKEUP' }):start()
end

-- if PhoneIcon then
--   PhoneIcon:setClickCallback(toggleScrCpy):setTitle('📱')
-- end
