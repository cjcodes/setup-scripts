-- Typing shortcuts: a chooser that types the selected snippet.

local p = hs.chooser
  .new(function(data)
    if data then
      hs.eventtap.keyStrokes(data['subText'])
    end
  end)
  :choices({
    { text = 'shrug', subText = '¯\\_(ツ)_/¯' },
    { text = 'table', subText = '(╯°□°)╯︵ ┻━┻' },
    { text = 'date', subText = os.date('%Y-%m-%d') },
    { text = 'cry', subText = '༼ ༎ຶ ෴ ༎ຶ༽' },
    { text = 'celebrate', subText = '“ヽ(´▽｀)ノ”' },
    { text = 'celebrate2', subText = '\\(• ◡ •)/' },
    { text = 'dead', subText = '✖_✖' },
    { text = 'lolsob', subText = '¯\\_(⊙︿⊙)_/¯' },
    { text = 'worried', subText = '(´･_･`)' },
    { text = 'disappoint', subText = '(҂◡_◡)' },
    { text = '32', subText = '00000000000000000000000000000000' },
    { text = 'rockon', subText = '+:rockon:' },
    { text = 'thumbsup', subText = '+:+1:' },
    { text = 'thanks', subText = '+:thank_you:' },
    { text = 'plusone', subText = '+:plusone:' },
    { text = 'tm', subText = '™' },
    { text = 'copy', subText = '©' },
  })
  :width(10)
  :rows(5)

hs.hotkey.bind({ '⌘', '⌃' }, '`', function()
  p:show()
end)
