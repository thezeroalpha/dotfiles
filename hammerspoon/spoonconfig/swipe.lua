-- use three finger swipe to focus nearby window
local key = hs.eventtap.keyStroke
local current_id, threshold
Swipe = hs.loadSpoon("Swipe")
Swipe:start(3, function(direction, distance, id)
  if id == current_id then
    if distance > threshold then
      threshold = math.huge -- only trigger once per swipe

      -- use "natural" scrolling
      if direction == "left" then
        key({ "ctrl", "shift" }, "tab")
      elseif direction == "right" then
        key({ "ctrl" }, "tab")
      elseif direction == "up" then
        key({ "cmd" }, "t")
      elseif direction == "down" then
        key({ "cmd" }, "w")
      end
    end
  else
    current_id = id
    threshold = 0.2 -- swipe distance > 10% of trackpad
  end
end)
