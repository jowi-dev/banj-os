-- Import necessary libraries and variables
  local awful = require("awful")
  local gears = require("gears")
  local wibox = require("wibox")
  local beautiful = require("beautiful")

  -- Themes define colors, icons, font, and wallpapers
  beautiful.init("~/.config/awesome/themes/custom/theme.lua")

  -- Variable declaration
  local terminal = "urxvt"
  local editor = os.getenv("EDITOR") or "nvim"
  local screenshot_cmd = "flameshot gui"

  -- Set up tags
  awful.screen.connect_for_each_screen(function(s)
    -- Each screen has its own tag table
    awful.tag({ "1", "2", "3", "4", "5", "6", "7", "8", "9" }, s, awful.layout.layouts[1])
  end)

  -- CPU and memory monitoring
  local cpu_widget = wibox.widget {
      widget = wibox.widget.textbox,
      align = 'right',
      text = "CPU: ",
  }

  local memory_widget = wibox.widget {
      widget = wibox.widget.textbox,
      align = 'right',
      text = "Mem: ",
  }

  gears.timer {
      timeout = 5,
      autostart = true,
      callback = function()
          local status = io.popen('top -b -n 1'):read('*all')
          local cpu = status:match("%%Cpu%s+:%s+(%d+%.%d+)")
          local mem = status:match("MiB Mem :(%d+)")

          cpu_widget.text = "CPU: " .. cpu .. "%"
          memory_widget.text = "Mem: " .. mem .. "MiB"
      end
  }

  -- Keybindings
  awful.keyboard.append_global_keybindings({
      awful.key({ modkey, "Shift" }, "Return", function() awful.spawn(terminal) end,
                {description = "open a terminal", group = "launcher"}),

      awful.key({modkey, "Shift" }, "r", awesome.restart,
                { description = "reload awesome", group = "awesome"}),

      awful.key({modkey, "Shift" }, "q", awesome.quit,
                { description = "quit awesome", group = "awesome"}),

      awful.key({ modkey }, "r", function() awful.spawn(terminal) end,
                { description = "run prompt", group = "launcher"}),

      -- Add more keybindings according to your needs
  })
