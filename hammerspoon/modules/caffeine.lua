-- Menu bar toggle that prevents the display from sleeping.

Caffeine = hs.menubar.new()

local function setCaffeineDisplay(state)
  if state then
    Caffeine:setTitle('☀️')
  else
    Caffeine:setTitle('🌙')
  end
end

local function caffeineClicked()
  setCaffeineDisplay(hs.caffeinate.toggle('displayIdle'))
end

if Caffeine then
  Caffeine:setClickCallback(caffeineClicked)
  setCaffeineDisplay(hs.caffeinate.get('displayIdle'))
end
