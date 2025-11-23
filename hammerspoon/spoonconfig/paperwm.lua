return {
  setup = function(mods)
    PaperWM = hs.loadSpoon("PaperWM")
    local paperWmMod = mods.paperWmMod
    local paperWmMoveMod = mods.paperWmMoveMod

    PaperWM.window_ratios = { 1 / 3, 1 / 2, 2 / 3 }
    PaperWM:bindHotkeys({
      -- switch to a new focused window in tiled grid
      focus_left = { paperWmMod, "left" },
      focus_right = { paperWmMod, "right" },
      focus_up = { paperWmMod, "up" },
      focus_down = { paperWmMod, "down" },

      -- switch windows by cycling forward/backward
      -- (forward = down or right, backward = up or left)
      focus_prev = { paperWmMod, "k" },
      focus_next = { paperWmMod, "j" },

      -- move windows around in tiled grid
      swap_left = { paperWmMoveMod, "left" },
      swap_left = { paperWmMoveMod, "h" },
      swap_right = { paperWmMoveMod, "right" },
      swap_right = { paperWmMoveMod, "l" },
      swap_up = { paperWmMoveMod, "up" },
      swap_up = { paperWmMoveMod, "k" },
      swap_down = { paperWmMoveMod, "down" },
      swap_down = { paperWmMoveMod, "j" },

      -- alternative: swap entire columns, rather than
      -- individual windows (to be used instead of
      -- swap_left / swap_right bindings)
      -- swap_column_left = {{"alt", "cmd", "shift"}, "left"},
      -- swap_column_right = {{"alt", "cmd", "shift"}, "right"},

      -- position and resize focused window
      center_window = { paperWmMod, "c" },
      full_width = { paperWmMod, "f" },
      cycle_width = { paperWmMod, "r" },
      reverse_cycle_width = { paperWmMoveMod, "r" },

      -- increase/decrease width
      increase_width = { paperWmMod, "l" },
      decrease_width = { paperWmMod, "h" },

      -- move focused window into / out of a column
      slurp_in = { paperWmMod, "i" },
      barf_out = { paperWmMod, "o" },

      -- move the focused window into / out of the tiling layer
      toggle_floating = { { "alt", "cmd", "shift" }, "escape" },

      -- move focused window to a new space and tile
      move_window_1 = { paperWmMoveMod, "1" },
      move_window_2 = { paperWmMoveMod, "2" },
      move_window_3 = { paperWmMoveMod, "3" },
      move_window_4 = { paperWmMoveMod, "4" },
      move_window_5 = { paperWmMoveMod, "5" },
      move_window_6 = { paperWmMoveMod, "6" },
      move_window_7 = { paperWmMoveMod, "7" },
      move_window_8 = { paperWmMoveMod, "8" },
      move_window_9 = { paperWmMoveMod, "9" },
    })
    PaperWM:start()

    local set_window_width = function(width)
      local old_ratios = PaperWM.window_ratios
      PaperWM.window_ratios = { width }
      PaperWM.windows.cycleWindowSize(PaperWM.windows.Direction.WIDTH, PaperWM.windows.Direction.ASCENDING)
      PaperWM.window_ratios = old_ratios
    end

    -- set to equal size
    hs.hotkey.bind(paperWmMod, "=", function()
      set_window_width(1 / 2)
    end)
  end,
}
