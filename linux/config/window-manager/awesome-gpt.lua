-- Standard awesome library
  local gears = require("gears")
  local awful = require("awful")
  local hotkeys_popup = require("awful.hotkeys_popup")
  require("awful.autofocus")

  -- Theme handling library
  local beautiful = require("beautiful")
  local xresources = require("beautiful.xresources")
  
  -- Notification library
  local naughty = require("naughty")
  
  -- Set the theme
  beautiful.init(gears.filesystem.get_configuration_dir() .. "theme.lua")
  
  -- Error handling
  if awesome.startup_errors then
      naughty.notify({ preset = naughty.config.presets.critical,
                       title = "There were errors during startup!",
                       text = awesome.startup_errors })
  end
  do
      local in_error = false
      awesome.connect_signal("debug::error", function (err)
          if in_error then return end
          in_error = true
  
          naughty.notify({ preset = naughty.config.presets.critical,
                           title = "An error happened!",
                           text = tostring(err) })
          in_error = false
      end)
  end
  
  -- Variable definitions
  local modkey = "Mod4"
  
  -- Table of layouts
  awful.layout.layouts = {
      awful.layout.suit.tile,
      awful.layout.suit.floating,
  }
  
  -- Setup screen
  awful.screen.connect_for_each_screen(function(s)
      -- Wallpaper
      gears.wallpaper.set("#000000")
  
      -- Each screen has its own tag table.
      awful.tag({ "1", "2", "3", "4", "5" }, s, awful.layout.layouts[1])
  end)
  
  -- Key bindings
  globalkeys = gears.table.join(
      awful.key({ modkey,           }, "s",      hotkeys_popup.show_help,
                {description="show help", group="awesome"}),
      awful.key({ modkey,           }, "Left",   awful.tag.viewprev,
                {description = "view previous", group = "tag"}),
      awful.key({ modkey,           }, "Right",  awful.tag.viewnext,
                {description = "view next", group = "tag"})
  )
  
  root.keys(globalkeys)
  
  -- Rules
  awful.rules.rules = {
      -- All clients will match this rule.
      { rule = { },
        properties = { border_width = beautiful.border_width,
                       border_color = beautiful.border_normal,
                       focus = awful.client.focus.filter,
                       raise = true,
                       keys = clientkeys,
                       buttons = clientbuttons,
                       screen = awful.screen.preferred,
                       placement = awful.placement.no_overlap+awful.placement.no_offscreen }
      }
  }
  
  -- Signals
  client.connect_signal("focus", function(c) c.border_color = beautiful.border_focus end)
  client.connect_signal("unfocus", function(c) c.border_color = beautiful.border_normal end)
