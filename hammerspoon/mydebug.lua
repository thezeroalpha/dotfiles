local eventtap = hs.eventtap
local events = hs.eventtap.event.types
local eventProps = hs.eventtap.event.properties
local log = hs.logger.new("init", "debug")

local monitorKeys = function()
  eventtap
    .new(
      { events.keyDown, events.otherMouseDown },
      function(event) --watch the keyDown event, trigger the function every time there is a keydown
        local evtype = event:getType()
        if evtype == events.keyDown then
          log.i(events[evtype], event:getUnicodeString(), event:getKeyCode())
        elseif evtype == events.otherMouseDown then
          log.i(events[evtype], event:getProperty(eventProps.mouseEventButtonNumber))
        end
        return false --keeps the event propagating
      end
    )
    :start() --start our watcher
end
return {
  monitorKeys = function()
    monitorKeys()
  end,
}
