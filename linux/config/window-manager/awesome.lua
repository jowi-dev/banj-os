-- {{{ License
--
-- Awesome configuration
--
-- This work is licensed under the Creative Commons Attribution-Share
-- Alike License: http://creativecommons.org/licenses/by-sa/3.0/
-- based off Adrian C. <anrxc@sysphere.org>'s rc.lua and Tony N
-- }}}


-- {{{ Libraries
local awful = require("awful")
local beautiful = require("beautiful")
local widget = require("awful")
local timer = require("gears.timer")
local wibox = require("wibox")
local textbox = require("wibox.widget.textbox")
local imagebox = require("wibox.widget.imagebox")
require("awful.rules")
require("awful.autofocus")
require("naughty")
-- User libraries
--require("vicious")
--require("helpers")
-- }}}

-- {{{ Default configuration
local modkey = "Mod4"

local terminal = 'alacritty' -- also accepts full path
--editor_cmd = terminal .. " -e " .. editor


local cpugraph_enable = true -- Show CPU graph

local membar_enable = true -- Show memory bar



-- Create personal.lua in this same directory to override these defaults


-- }}}

-- {{{ Variable definitions
local exec   = awful.util.spawn

-- Beautiful theme
beautiful.init(awful.util.getdir("config") .. "/themes/iceland/iceland.lua")

-- Window management layouts
layouts =
{
    awful.layout.suit.tile,
    awful.layout.suit.tile.left,
    awful.layout.suit.tile.bottom,
    awful.layout.suit.tile.top,
    awful.layout.suit.floating,
    awful.layout.suit.fair,
    awful.layout.suit.fair.horizontal,
    awful.layout.suit.spiral,
    awful.layout.suit.spiral.dwindle,
    awful.layout.suit.max,
    awful.layout.suit.max.fullscreen,
    awful.layout.suit.magnifier
}
-- }}}

-- {{{ Tags
tags = {
   names  = { "term", "code", "web", "im", "media", "time", 7, 8, 9 },
   layout = { layouts[1], layouts[1], layouts[1], layouts[1],
              layouts[4], layouts[1], layouts[1], layouts[1],
              layouts[1] }
    }
for s = 1, screen.count() do
    tags[s] = awful.tag(tags.names, s, tags.layout)
end
-- }}}

-- {{{ Wibox
--
-- {{{ Widgets configuration
--
-- {{{ Reusable separator
separator = imagebox
--separator.image = image(beautiful.widget_sep)

spacer = textbox
spacer.width = 3
-- }}}

-- {{{ CPU usage

-- cpu icon
cpuicon = imagebox
--cpuicon.image = image(beautiful.widget_cpu)

-- check for cpugraph_enable == true in config
if cpugraph_enable then
	-- Initialize widget
	cpugraph  = awful.widget.graph()

	-- Graph properties
	cpugraph:set_width(40)
  cpugraph:set_height(16)
	cpugraph:set_background_color(beautiful.fg_off_widget)
	--cpugraph:set_gradient_angle(0)
--  cpugraph:set_gradient_colors({
--	   beautiful.fg_end_widget, beautiful.fg_center_widget, beautiful.fg_widget
--	})

	-- Register graph widget
	--vicious.register(cpugraph,  vicious.widgets.cpu,      "$1")
end

-- cpu text widget
cpuwidget = textbox
--vicious.register(cpuwidget, vicious.widgets.cpu, cputext_format, 3) -- register

-- temperature
tzswidget = textbox
--vicious.register(tzswidget, vicious.widgets.thermal,
--	function (widget, args)
--		if args[1] > 0 then
--			tzfound = true
--			return " " .. args[1] .. "C°"
--		else return "" 
--		end
--	end
--	, 19, "thermal_zone0")

-- }}}


-- {{{ Battery state

-- Initialize widget
batwidget = textbox
baticon = imagebox

-- Register widget
--vicious.register(batwidget, vicious.widgets.bat,
--	function (widget, args)
--		if args[2] == 0 then return ""
--		else
--			baticon.image = image(beautiful.widget_bat)
--			return "<span color='white'>".. args[2] .. "%</span>"
--		end
--	end, 61, "BAT0"
--)
-- }}}


-- {{{ Memory usage

-- icon
local memicon = wibox.widget.imagebox
--memicon.image = image(beautiful.widget_mem)

if membar_enable then
	-- Initialize widget
	local membar = wibox.widget.progressbar
	-- Pogressbar properties
	--membar:set_vertical(true)
  membar.ticks = true
	--membar:set_height(16)
  --membar:set_width(8)
  membar.ticks_size = 2
	membar.background_color = beautiful.fg_off_widget
--	membar:set_gradient_colors({ beautiful.fg_widget,
--	   beautiful.fg_center_widget, beautiful.fg_end_widget
--	}) -- Register widget
	--vicious.register(membar, vicious.widgets.mem, "$1", 13)
end

-- mem text output
local memtext = textbox
--vicious.register(memtext, vicious.widgets.mem, memtext_format, 13)
-- }}}

-- {{{ File system usage
fsicon = imagebox
--fsicon.image = image(beautiful.widget_fs)
-- Initialize widgets
local fs = {
  r = wibox.widget.progressbar,
  s = wibox.widget.progressbar
}
-- Progressbar properties
for _, w in pairs(fs) do
  --w:set_vertical(true)
  w.ticks=true
  --w:set_height(16)
  --w:set_width(5)
  w.ticks_size=2
  w.border_color=beautiful.border_widget
  w.background_color=beautiful.fg_off_widget
--  w:set_gradient_colors({ beautiful.fg_widget,
--     beautiful.fg_center_widget, beautiful.fg_end_widget
--  }) -- Register buttons
  --w:add_button( awful.button({ }, 1, function () exec("dolphin", false) end))
end -- Enable caching
--vicious.cache(vicious.widgets.fs)
-- Register widgets
--vicious.register(fs.r, vicious.widgets.fs, "${/ used_p}",            599)
--vicious.register(fs.s, vicious.widgets.fs, "${/media/files used_p}", 599)
-- }}}

-- {{{ Network usage
local function print_net(name, down, up)
	return '<span color="'
	.. beautiful.fg_netdn_widget ..'">' .. down .. '</span> <span color="'
	.. beautiful.fg_netup_widget ..'">' .. up  .. '</span>'
end

local dnicon = imagebox
local upicon = imagebox

-- Initialize widget
netwidget = textbox
-- Register widget
--vicious.register(netwidget, vicious.widgets.net,
--	function (widget, args)
--		for _,device in pairs(networks) do
--			if tonumber(args["{".. device .." carrier}"]) > 0 then
--				netwidget.found = true
--				dnicon.image = image(beautiful.widget_net)
--				upicon.image = image(beautiful.widget_netup)
--				return print_net(device, args["{"..device .." down_kb}"], args["{"..device.." up_kb}"])
--			end
--		end
--	end, 3)
-- }}}



-- {{{ Volume level
local volicon = imagebox
--volicon.image = image(beautiful.widget_vol)
-- Initialize widgets
local volbar    = wibox.widget.progressbar
local volwidget = textbox
-- Progressbar properties
--volbar:set_vertical(true)
volbar.ticks=true
--volbar:set_height(16)
--volbar:set_width(8)
volbar.ticks_size=2
volbar.background_color=beautiful.fg_off_widget
--volbar:set_gradient_colors({ beautiful.fg_widget,
--   beautiful.fg_center_widget, beautiful.fg_end_widget
--}) -- Enable caching
--vicious.cache(vicious.widgets.volume)
-- Register widgets
--vicious.register(volbar,    vicious.widgets.volume,  "$1",  2, "PCM")
--vicious.register(volwidget, vicious.widgets.volume, " $1%", 2, "PCM")
-- Register buttons
--volbar:add_button( awful.button({ }, 1, function () exec("kmix") end))
   --awful.button({ }, 4, function () exec("amixer -q set PCM 2dB+", false) vicious.force({volbar, volwidget}) end),
   --awful.button({ }, 5, function () exec("amixer -q set PCM 2dB-", false) vicious.force({volbar, volwidget}) end)
-- Register assigned buttons
--volwidget:add_button(volbar:buttons())
-- }}}

-- {{{ Date and time
local dateicon = imagebox
--dateicon.image = image(beautiful.widget_date)
-- Initialize widget
local datewidget = textbox
-- Register widget
--vicious.register(datewidget, vicious.widgets.date, date_format, 61)
-- }}}

-- {{{ mpd

--if whereis_app('curl') and whereis_app('mpd') then
--	mpdwidget = widget({ type = "textbox" })
	--vicious.register(mpdwidget, vicious.widgets.mpd,
--		function (widget, args)
--			if args["{state}"] == "Stop" or args["{state}"] == "Pause" or args["{state}"] == "N/A"
--				or (args["{Artist}"] == "N/A" and args["{Title}"] == "N/A") then return ""
--			else return '<span color="white">музыка:</span> '..
--			     args["{Artist}"]..' - '.. args["{Title}"]
--			end
--		end
--	)
--end

-- }}}


-- {{{ System tray
local systray = wibox.widget.systray
-- }}}
-- }}}

-- {{{ Wibox initialisation
promptbox = {}
local layoutbox = awful.widget.layoutbox
local taglist   = awful.widget.taglist
taglist.buttons = awful.util.table.join(
    awful.button({ },        1, awful.tag.viewonly),
    awful.button({ modkey }, 1, awful.client.movetotag),
    awful.button({ },        3, awful.tag.viewtoggle),
    awful.button({ modkey }, 3, awful.client.toggletag),
    awful.button({ },        4, awful.tag.viewnext),
    awful.button({ },        5, awful.tag.viewprev
))

mytasklist = {}
mytasklist.buttons = awful.util.table.join(
                     awful.button({ }, 1, function (c)
                                              if c == client.focus then
                                                  c.minimized = true
                                              else
                                                  if not c:isvisible() then
                                                      awful.tag.viewonly(c:tags()[1])
                                                  end
                                                  -- This will also un-minimize
                                                  -- the client, if needed
                                                  client.focus = c
                                                  c:raise()
                                              end
                                          end),
                     awful.button({ }, 3, function ()
                                              if instance then
                                                  instance:hide()
                                                  instance = nil
                                              else
                                                  instance = awful.menu.clients({ width=250 })
                                              end
                                          end),
                     awful.button({ }, 4, function ()
                                              awful.client.focus.byidx(1)
                                              if client.focus then client.focus:raise() end
                                          end),
                     awful.button({ }, 5, function ()
                                              awful.client.focus.byidx(-1)
                                              if client.focus then client.focus:raise() end
                                          end))


for s = 1, screen.count() do
    -- Create a promptbox
    promptbox[s] = awful.widget.prompt({ layout = awful.widget.layout.horizontal.leftright })
    -- Create a layoutbox
    layoutbox[s] = awful.widget.layoutbox(s)
    layoutbox[s]:buttons(awful.util.table.join(
        awful.button({ }, 1, function () awful.layout.inc(layouts,  1) end),
        awful.button({ }, 3, function () awful.layout.inc(layouts, -1) end),
        awful.button({ }, 4, function () awful.layout.inc(layouts,  1) end),
        awful.button({ }, 5, function () awful.layout.inc(layouts, -1) end)
    ))

    -- Create the taglist
    taglist[s] = awful.widget.taglist(s, awful.widget.taglist.label.all, taglist.buttons)

    -- Create tasklist
    mytasklist[s] = awful.widget.tasklist(function(c)
                                              return awful.widget.tasklist.label.currenttags(c, s)
                                          end, mytasklist.buttons)

    -- Create the wibox
    wibox[s] = awful.wibox({      screen = s,
        fg = beautiful.fg_normal, height = 16,
        bg = beautiful.bg_normal, position = "top",
        border_color = beautiful.border_normal,
        border_width = beautiful.border_width
    })
    -- Add widgets to the wibox
    wibox[s].widgets = {
        {   taglist[s], layoutbox[s], separator, promptbox[s],
            mpdwidget and spacer, mpdwidget or nil,
            ["layout"] = awful.widget.layout.horizontal.leftright
        },
        --s == screen.count() and systray or nil, -- show tray on last screen
        s == 1 and systray or nil, -- only show tray on first screen
        s == 1 and separator or nil, -- only show on first screen
        datewidget, dateicon,
        baticon.image and separator, batwidget, baticon or nil,
        separator, volwidget,  volbar.widget, volicon,
        dnicon.image and separator, upicon, netwidget, dnicon or nil,
        separator, fs.r.widget, fs.s.widget, fsicon,
        separator, memtext, membar_enable and membar.widget or nil, memicon,
        separator, tzfound and tzswidget or nil,
        cpugraph_enable and cpugraph.widget or nil, cpuwidget, cpuicon,
        mytasklist[s],
        ["layout"] = awful.widget.layout.horizontal.rightleft
    }
end
-- }}}
-- }}}


-- {{{ Mouse bindings
root.buttons(awful.util.table.join(
    awful.button({ }, 4, awful.tag.viewnext),
    awful.button({ }, 5, awful.tag.viewprev)
))

-- Client bindings
clientbuttons = awful.util.table.join(
    awful.button({ },        1, function (c) client.focus = c; c:raise() end),
    awful.button({ modkey }, 1, awful.mouse.client.move),
    awful.button({ modkey }, 3, awful.mouse.client.resize)
)
-- }}}


-- {{{ Key bindings
globalkeys = awful.util.table.join(
    awful.key({ modkey,           }, "Left",   awful.tag.viewprev       ),
    awful.key({ modkey,           }, "Right",  awful.tag.viewnext       ),
    awful.key({ modkey,           }, "Escape", awful.tag.history.restore),

    awful.key({ modkey,           }, "j",
        function ()
            awful.client.focus.byidx( 1)
            if client.focus then client.focus:raise() end
        end),
    awful.key({ modkey,           }, "k",
        function ()
            awful.client.focus.byidx(-1)
            if client.focus then client.focus:raise() end
        end),
    awful.key({ modkey,           }, "w", function () mymainmenu:show({keygrabber=true}) end),

    -- Layout manipulation
    awful.key({ modkey, "Shift"   }, "j", function () awful.client.swap.byidx(  1)    end),
    awful.key({ modkey, "Shift"   }, "k", function () awful.client.swap.byidx( -1)    end),
    awful.key({ modkey, "Control" }, "j", function () awful.screen.focus_relative( 1) end),
    awful.key({ modkey, "Control" }, "k", function () awful.screen.focus_relative(-1) end),
    awful.key({ modkey,           }, "u", awful.client.urgent.jumpto),
    awful.key({ modkey,           }, "Tab",
        function ()
            awful.client.focus.history.previous()
            if client.focus then
                client.focus:raise()
            end
        end),

    -- Standard program
    awful.key({ modkey,           }, "Return", function () awful.util.spawn(terminal) end),
    awful.key({ modkey, "Control" }, "r", awesome.restart),
    awful.key({ modkey, "Shift"   }, "q", awesome.quit),

    awful.key({ modkey,           }, "l",     function () awful.tag.incmwfact( 0.05)    end),
    awful.key({ modkey,           }, "h",     function () awful.tag.incmwfact(-0.05)    end),
    awful.key({ modkey,           }, ",",     function () awful.tag.incnmaster( 1)      end),
    awful.key({ modkey,           }, ".",     function () awful.tag.incnmaster(-1)      end),
    awful.key({ modkey, "Control" }, "h",     function () awful.tag.incncol( 1)         end),
    awful.key({ modkey, "Control" }, "l",     function () awful.tag.incncol(-1)         end),
    awful.key({ modkey,           }, "space", function () awful.layout.inc(layouts,  1) end),
    awful.key({ modkey, "Shift"   }, "space", function () awful.layout.inc(layouts, -1) end),

    awful.key({ modkey }, "b", function ()
         wibox[mouse.screen].visible = not wibox[mouse.screen].visible
    end),

    -- Prompt
    awful.key({ modkey },            "r",     function () promptbox[mouse.screen]:run() end),

    awful.key({ modkey }, "x",
              function ()
                  awful.prompt.run({ prompt = "Run Lua code: " },
                  mypromptbox[mouse.screen].widget,
                  awful.util.eval, nil,
                  awful.util.getdir("cache") .. "/history_eval")
              end),

    -- screen lock
    awful.key({ modkey,           }, "F12",    function () awful.util.spawn_with_shell("xlock -mode tetris") end)
)

clientkeys = awful.util.table.join(
    awful.key({ modkey,           }, "f",      function (c) c.fullscreen = not c.fullscreen  end),
    awful.key({ modkey, "Shift"   }, "c",      function (c) c:kill()                         end),
    awful.key({ modkey,           }, "t",  awful.client.floating.toggle                     ),
    awful.key({ modkey,           }, "Return", function (c) c:swap(awful.client.getmaster()) end),
    awful.key({ modkey,           }, "o",      awful.client.movetoscreen                        ),
    awful.key({ modkey, "Shift"   }, "r",      function (c) c:redraw()                       end),
    awful.key({ modkey,           }, "m",
        function (c)
            c.maximized_horizontal = not c.maximized_horizontal
            c.maximized_vertical   = not c.maximized_vertical
        end)
)

-- Compute the maximum number of digit we need, limited to 9
keynumber = 0
for s = 1, screen.count() do
   keynumber = math.min(9, math.max(#tags[s], keynumber));
end

-- Bind all key numbers to tags.
-- Be careful: we use keycodes to make it works on any keyboard layout.
-- This should map on the top row of your keyboard, usually 1 to 9.
for i = 1, keynumber do
    globalkeys = awful.util.table.join(globalkeys,
        awful.key({ modkey }, "#" .. i + 9,
                  function ()
                        local screen = mouse.screen
                        if tags[screen][i] then
                            awful.tag.viewonly(tags[screen][i])
                        end
                  end),
        awful.key({ modkey, "Control" }, "#" .. i + 9,
                  function ()
                      local screen = mouse.screen
                      if tags[screen][i] then
                          awful.tag.viewtoggle(tags[screen][i])
                      end
                  end),
        awful.key({ modkey, "Shift" }, "#" .. i + 9,
                  function ()
                      if client.focus and tags[client.focus.screen][i] then
                          awful.client.movetotag(tags[client.focus.screen][i])
                      end
                  end),
        awful.key({ modkey, "Control", "Shift" }, "#" .. i + 9,
                  function ()
                      if client.focus and tags[client.focus.screen][i] then
                          awful.client.toggletag(tags[client.focus.screen][i])
                      end
                  end))
end

clientbuttons = awful.util.table.join(
    awful.button({ }, 1, function (c) client.focus = c; c:raise() end),
    awful.button({ modkey }, 1, awful.mouse.client.move),
    awful.button({ modkey }, 3, awful.mouse.client.resize))

-- Set keys
root.keys(globalkeys)
-- }}}


-- {{{ Rules
awful.rules.rules = {
    { rule = { }, properties = {
      focus = true,      size_hints_honor = false,
      keys = clientkeys, buttons = clientbuttons,
      border_width = beautiful.border_width,
      border_color = beautiful.border_normal }
    },
    { rule = { class = "MPlayer" },
      properties = { floating = true } },
    { rule = { class = "gimp" },
      callback   = awful.titlebar.add,
      properties = { floating = true } },
    { rule = { class = "Pidgin" },
      properties = { tag = tags[1][4],switchtotag = false } },
    { rule = { class = "Chromium" },
      properties = { tag = tags[1][3],switchtotag = false } },
    { rule = { class = "Hamster-time-tracker" },
      properties = { tag = tags[1][6],switchtotag = false } }
}
-- }}}


-- {{{ Signals
--
-- {{{ Manage signal handler
client.add_signal("manage", function (c, startup)
    -- Add titlebar to floaters, but remove those from rule callback
    -- if awful.client.floating.get(c)
    -- or awful.layout.get(c.screen) == awful.layout.suit.floating then
    --     if   c.titlebar then awful.titlebar.remove(c)
    --     else awful.titlebar.add(c, {modkey = modkey}) end
    -- end

    -- Enable sloppy focus
    c:add_signal("mouse::enter", function (c)
        if  awful.layout.get(c.screen) ~= awful.layout.suit.magnifier
        and awful.client.focus.filter(c) then
            client.focus = c
        end
    end)

    -- Client placement
    if not startup then
        awful.client.setslave(c)

        if  not c.size_hints.program_position
        and not c.size_hints.user_position then
            awful.placement.no_overlap(c)
            awful.placement.no_offscreen(c)
        end
    end
end)
-- }}}

-- {{{ Focus signal handlers
client.add_signal("focus",   function (c) c.border_color = beautiful.border_focus  end)
client.add_signal("unfocus", function (c) c.border_color = beautiful.border_normal end)
-- }}}

-- {{{ Arrange signal handler
for s = 1, screen.count() do screen[s]:add_signal("arrange", function ()
    local clients = awful.client.visible(s)
    local layout = awful.layout.getname(awful.layout.get(s))

    for _, c in pairs(clients) do -- Floaters are always on top
        if   awful.client.floating.get(c) or layout == "floating"
        then if not c.fullscreen then c.above       =  true  end
        else                          c.above       =  false end
    end
  end)
end
-- }}}
-- }}}

x = 0

-- setup the timer
mytimer = timer { timeout = x }
mytimer:add_signal("timeout", function()

  -- stop the timer (we don't need multiple instances running at the same time)
  mytimer:stop()

  -- define the interval in which the next wallpaper change should occur in seconds
  -- (in this case anytime between 10 and 20 minutes)
  x = math.random( 600, 1200)

  --restart the timer
  mytimer.timeout = x
  mytimer:start()
end)

-- initial start when rc.lua is first run
mytimer:start()

require_safe('autorun')
