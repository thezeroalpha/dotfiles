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
  [86] = "left",
  [91] = "up",
  [88] = "right",
  [84] = "down",
  [89] = "home",
  [83] = "end",
}

local modifiers = { {}, { "shift" } }

for k, c in pairs(binds) do
  for _, mod in pairs(modifiers) do
    local f = function()
      keyNoDelay(mod, c)
    end
    keypad_cursor:bind(mod, k, f, nil, f)
  end
end

keypad_cursor:bind(
  {},
  71,
  function()
    keypad_cursor:exit()
  end,
  nil,
  function()
    keypad_cursor:exit()
  end
)
