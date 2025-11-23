local hyper = { "alt", "cmd", "shift", "ctrl" }
local eventtap = hs.eventtap
local events = hs.eventtap.event.types
local eventProps = hs.eventtap.event.properties
local spaces = hs.spaces
local bindkey = hs.hotkey.bind

-- Mouse events
local mouse = {
  l = eventtap.leftClick,
  r = eventtap.rightClick,
  pos = hs.mouse.absolutePosition,
}

-- Press a key
local key = eventtap.keyStroke

-- Set up WM
require("spoonconfig.paperwm").setup({
  paperWmMod = { "alt", "shift" },
  paperWmMoveMod = { "alt", "ctrl", "shift" },
})

hs.loadSpoon("ClipboardTool")
spoon.ClipboardTool:bindHotkeys({
  show_clipboard = { hyper, "c" },
})
spoon.ClipboardTool.show_copied_alert = false
spoon.ClipboardTool:start()

require("spoonconfig.swipe")

require("numpad-cursor")

-- Automatically switch vertical/horizontal tabs in Brave
require("auto-toggle-vertical-horizontal-tabs")

bindkey(hyper, "r", function()
  hs.reload()
  hs.notify.show("Config reloaded", "New config applied", "")
end)

bindkey({}, "f3", hs.spaces.toggleMissionControl)
bindkey({}, "f4", hs.spaces.toggleLaunchPad)

-- Copy current mouse position
bindkey(hyper, "m", function()
  local pos = mouse.pos()
  hs.pasteboard.setContents(string.format("{x = %f, y = %f}", pos.x, pos.y))
end)

-- "fn" is actually needed for this to work for some reason
-- https://github.com/Hammerspoon/hammerspoon/issues/1946#issuecomment-449604954
bindkey({}, "f6", function()
  key({ "fn", "ctrl" }, "right")
end)
bindkey({}, "f5", function()
  key({ "fn", "ctrl" }, "left")
end)

-- Toggle terminal
bindkey({ "alt" }, "space", function()
  local appName = "Alacritty"
  local runningApp = hs.application.get(appName)
  if runningApp ~= nil and runningApp:isFrontmost() then
    runningApp:hide()
  else
    hs.application.open(appName)
  end
end)

-- Emacs
bindkey(hyper, "e", function()
  hs.application.open("Emacs")
end)

-- Play/pause mpd
bindkey({}, 100, function()
  hs.execute("/usr/local/bin/mpc toggle")
end)

-- bind other keyboard keys
Kbd_tap = eventtap.new({ hs.eventtap.event.types.systemDefined }, function(ev)
  -- http://www.hammerspoon.org/docs/hs.eventtap.event.html#systemKey
  ev = ev:systemKey()
  -- http://stackoverflow.com/a/1252776/1521064
  local next = next
  -- Check empty table
  if next(ev) then
    if ev.key == "EJECT" and ev.down then
      hs.execute("/run/current-system/sw/bin/alacritty -e /usr/local/bin/ncmpcpp")
    end
  end
end)
Kbd_tap:start()

-- bind mouse keys
Mousebtn_tap = eventtap.new({ events.otherMouseDown }, function(ev)
  local mouseBtn = ev:getProperty(eventProps.mouseEventButtonNumber)
  if mouseBtn == 3 then
    spaces.toggleLaunchPad()
    return true
  elseif mouseBtn == 4 then
    spaces.toggleMissionControl()
    return true
  end
  return false
end)
Mousebtn_tap:start()

-- require("mydebug"):monitorKeys()
