hs.loadSpoon("SpoonInstall")

hyper = { "ctrl", "cmd", "alt" }
super = { "ctrl", "cmd"}

hs.hotkey.bindSpec({hyper, "r"}, hs.reload)

-- Launching Specific Apps
spoon.SpoonInstall:andUse("AppLauncher", {
  config = { modifiers = {"ctrl", "cmd"} },
  hotkeys = {
    q = "Finder",
    w = "iTerm",
    e = "Brave Browser",
    a = "Microsoft Remote Desktop",
    s = "Parallels Desktop",
    d = "Microsoft Teams",
  },
})

-- window management
hs.window.animationDuration = 0

spoon.SpoonInstall:andUse("WindowHalfsAndThirds", {
  hotkeys = {
    left_half = { {"ctrl", "cmd"}, "h"},
    right_half = { {"ctrl", "cmd"}, "l"},
    bottom_half = { {"ctrl", "cmd"}, "j"},
    top_half = { {"ctrl", "cmd"}, "k"},
    max = { {"ctrl", "cmd"}, "return"},
    top_left = { {"ctrl", "cmd"}, "u"},
    top_right = { {"ctrl", "cmd"}, "o"},
    bottom_left = { {"ctrl", "cmd"}, "m"},
    bottom_right = { {"ctrl", "cmd"}, "."},
  },
})

spoon.SpoonInstall:andUse("WindowScreenLeftAndRight", {
  config = { animationDuration = 0 },
  hotkeys = {
   screen_left = { {"ctrl", "cmd"}, "1" },
    screen_right= { {"ctrl", "cmd"}, "2" },
  },
})

-- HANDLE SCROLLING WITH MOUSE BUTTON PRESSED
local scrollMouseButton = 2
local deferred = false

overrideOtherMouseDown =
  hs.eventtap.new(
  {hs.eventtap.event.types.rightMouseDown},
  function(e)
    deferred = true
    return true
  end
)

overrideOtherMouseUp =
  hs.eventtap.new(
  {hs.eventtap.event.types.rightMouseUp},
  function(e)
    if (deferred) then
      overrideOtherMouseDown:stop()
      overrideOtherMouseUp:stop()
      hs.eventtap.rightClick(e:location(), pressedMouseButton)
      overrideOtherMouseDown:start()
      overrideOtherMouseUp:start()
      return true
    end
    return false
  end
)

local oldmousepos = {}
local scrollmult = -2.5 -- negative multiplier makes mouse work like traditional scrollwheel, for macOS, use positive number.

dragOtherToScroll =
  hs.eventtap.new(
  {hs.eventtap.event.types.rightMouseDragged},
  function(e)
    deferred = false
    oldmousepos = hs.mouse.absolutePosition()
    local dx = e:getProperty(hs.eventtap.event.properties["mouseEventDeltaX"])
    local dy = e:getProperty(hs.eventtap.event.properties["mouseEventDeltaY"])
    local scroll = hs.eventtap.event.newScrollEvent({dx * scrollmult, dy * scrollmult}, {}, "pixel")
    -- put the mouse back
    hs.mouse.absolutePosition(oldmousepos)
    return true, {scroll}
  end
)

overrideOtherMouseDown:start()
overrideOtherMouseUp:start()
dragOtherToScroll:start()
