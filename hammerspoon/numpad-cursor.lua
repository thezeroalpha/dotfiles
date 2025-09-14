local icons = {
  [[ASCII:
2.................3
...................
...................
...................
...................
...................
...................
...................
...................
1.................4]],
}

local keypad_cursor = hs.hotkey.modal.new({}, 71)

-- When enabling, show a menubar icon
function keypad_cursor:entered()
  keypad_cursor._menubar_icon = hs.menubar.new()
  keypad_cursor._menubar_icon:setTitle("NK")
  keypad_cursor._menubar_icon:setIcon(icons[1])
end

-- When disabling, hide the menubar icon
function keypad_cursor:exited()
  keypad_cursor._menubar_icon:delete()
end

local keyNoDelay = function(modifiers, character)
  hs.eventtap.event.newKeyEvent(modifiers, string.lower(character), true):post()
  hs.eventtap.event.newKeyEvent(modifiers, string.lower(character), false):post()
end

local binds = {
  [86] = function()
    keyNoDelay({}, "left")
  end,
  [91] = function()
    keyNoDelay({}, "up")
  end,
  [88] = function()
    keyNoDelay({}, "right")
  end,
  [84] = function()
    keyNoDelay({}, "down")
  end,
  [89] = function()
    keyNoDelay({}, "home")
  end,
  [83] = function()
    keyNoDelay({}, "end")
  end,
  [71] = function()
    keypad_cursor:exit()
  end,
}

for k, f in pairs(binds) do
  keypad_cursor:bind({}, k, f, nil, f)
end
