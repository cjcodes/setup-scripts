-- Menu bar toggle that prevents the display from sleeping.

local caffeine = hs.menubar.new()

local function setCaffeineDisplay(state)
  if state then
    caffeine:setTitle('☀️')
  else
    caffeine:setTitle('🌙')
  end
end

local function caffeineClicked()
  setCaffeineDisplay(hs.caffeinate.toggle('displayIdle'))
end

if caffeine then
  caffeine:setClickCallback(caffeineClicked)
  setCaffeineDisplay(hs.caffeinate.get('displayIdle'))
end

return { menu = caffeine }
