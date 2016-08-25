local gears     = require("gears")
local wibox     = require("wibox")
local beautiful = require("beautiful")
local naughty   = require("naughty")
local drop      = require("scratchdrop")
local lain      = require("lain")
local awful     = require("awful")
awful.rules     = require("awful.rules")
                  require("awful.autofocus")

if awesome.startup_errors then
    naughty.notify({ preset = naughty.config.presets.critical,
                     title = "Oops, there were errors during startup!",
                     text = awesome.startup_errors })
end

do
    local in_error = false
    awesome.connect_signal("debug::error", function (err)
        if in_error then return end
        in_error = true
        naughty.notify({ preset = naughty.config.presets.critical,
                         title = "Oops, an error happened!",
                         text = err })
        in_error = false
    end)
end

beautiful.init(os.getenv("HOME") .. "/.config/awesome/theme/aw107n/theme.lua")
modkey        = "Mod4"
altkey        = "Mod1"

terminal      = "xfce4-terminal" or "xterm"
firefox_s     = "firefox -p secure"
firefox_f     = "firefox -p free"
firefox_d     = "firefox -p develop"
chrome        = "google-chrome"
file_manager  = "thunar"
text_editor   = "atom"
git_manager   = "qgit"
graphics      = "pinta"
mail          = "thunderbird"
torrent       = "deluge"
music_player  = "exaile"
yum_extender  = "yumex --root"
customize_lnf = "lxappearance"
office_writer = "libreoffice --writer"
office_calc   = "libreoffice --calc"
vol_control   = "pavucontrol -m"
wine_manager  = "playonlinux"
netw_manager  = "nm-connection-editor"
sys_shutdown  = "shutdown -h now"

local layouts = {
    awful.layout.suit.floating,
    awful.layout.suit.max,
    awful.layout.suit.tile,
    awful.layout.suit.tile.bottom,}

if beautiful.wallpaper then
    for s = 1, screen.count() do
        gears.wallpaper.maximized(beautiful.wallpaper, s, true)
    end
end

tags = { names = {"     ", "     ", "     ", "     "} }
for s = 1, screen.count() do
   tags[s] = awful.tag(tags.names, s, tags.layout)
end

browser_menu = {
  {"firefox -secure", firefox_s},
  {"firefox -free", firefox_f},
  {"chrome", chrome}}

dev_menu = {
  {"atom", text_editor},
  {"qgit", git_manager},
  {"firefox -dev", firefox_d}}

wine_menu = {
  {"playonlinux", wine_manager}}

tools_menu = {
  {"thunar", file_manager},
  {"exaile", music_player},
  {"pinta", graphics},
  {"thunderbird", mail},
  {"deluge", torrent},
  {"libreoffice -w", office_writer},
  {"libreoffice -c", office_calc}}

settings_menu = {
  {"yumex", yum_extender},
  {"network", netw_manager},
  {"lxappearance", customize_lnf},
  {"pulse audio", vol_control}}

system_menu = {
  {"shutdown", sys_shutdown}}

mymainmenu = awful.menu({ items = { {"terminal", terminal},
                                    {"browser", browser_menu},
                                    {"develop", dev_menu},
                                    {"wine", wine_menu},
                                    {"tools", tools_menu},
                                    {"settings", settings_menu},
                                    {"system", system_menu} },
                          theme = { height = 18, width = 110 } })

markup = lain.util.markup
separators = lain.util.separators

mytextclock = lain.widgets.abase({
    timeout  = 60,
    cmd      = "date +'%A %d %B %R'",
    settings = function()
      local t_output = ""
      local o_it = string.gmatch(output, "%S+")
      for i=1,3 do t_output = t_output .. " " .. o_it(i) end
      widget:set_markup(markup("#00D7FF", t_output) .. " " .. markup("#00D7FF", o_it(1)) .. " ")
  end})

baticon = wibox.widget.imagebox(beautiful.widget_battery)
batwidget = lain.widgets.bat({
    settings = function()
        if bat_now.perc == " N/A " then
            widget:set_markup(" AC ")
            baticon:set_image(beautiful.widget_ac)
            return
        elseif tonumber(bat_now.perc) <= 7 then
            baticon:set_image(beautiful.widget_battery_empty)
        elseif tonumber(bat_now.perc) <= 19 then
            baticon:set_image(beautiful.widget_battery_low)
        elseif tonumber(bat_now.perc) <= 59 then
            baticon:set_image(beautiful.widget_battery_mid)
        elseif tonumber(bat_now.perc) <= 89 then
            baticon:set_image(beautiful.widget_battery_high)
        else
            baticon:set_image(beautiful.widget_battery_full)
        end
        widget:set_markup(" " .. bat_now.perc .. "% ")
    end})

volicon = wibox.widget.imagebox(beautiful.widget_vol)
volumewidget = lain.widgets.alsa({
    settings = function()
        if volume_now.status == "off" or tonumber(volume_now.level) == 0 then
            volicon:set_image(beautiful.widget_vol_mute)
        elseif tonumber(volume_now.level) <= 14 then
            volicon:set_image(beautiful.widget_vol_min)
        elseif tonumber(volume_now.level) <= 44 then
            volicon:set_image(beautiful.widget_vol_low)
        elseif tonumber(volume_now.level) <= 74 then
            volicon:set_image(beautiful.widget_vol_mid)
        else
            volicon:set_image(beautiful.widget_vol_max)
        end
        widget:set_text(" " .. volume_now.level .. "% ")
    end})

spr = wibox.widget.textbox(' ')
pic_spr_small = wibox.widget.imagebox()
pic_spr_small:set_image(beautiful.pic_spr_small)
pic_spr_middle = separators.arrow_left(beautiful.bg_focus, "alpha")

mywibox = {}
mypromptbox = {}
mylayoutbox = {}
mytaglist = {}
mytaglist.buttons = awful.util.table.join(
                    awful.button({ }, 1, awful.tag.viewonly),
                    awful.button({ modkey }, 1, awful.client.movetotag),
                    awful.button({ }, 3, awful.tag.viewtoggle),
                    awful.button({ modkey }, 3, awful.client.toggletag),
                    awful.button({ }, 4, function(t) awful.tag.viewnext(awful.tag.getscreen(t)) end),
                    awful.button({ }, 5, function(t) awful.tag.viewprev(awful.tag.getscreen(t)) end) )
mytasklist = {}
mytasklist.buttons = awful.util.table.join(
                     awful.button({ }, 1, function (c)
                                              if c == client.focus then
                                                  c.minimized = true
                                              else
                                                  -- Without this, the following
                                                  c.minimized = false
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

    mypromptbox[s] = awful.widget.prompt()
    mylayoutbox[s] = awful.widget.layoutbox(s)
    mylayoutbox[s]:buttons(awful.util.table.join(
                            awful.button({ }, 1, function () awful.layout.inc(layouts, 1) end),
                            awful.button({ }, 3, function () awful.layout.inc(layouts, -1) end),
                            awful.button({ }, 4, function () awful.layout.inc(layouts, 1) end),
                            awful.button({ }, 5, function () awful.layout.inc(layouts, -1) end)))

    mytaglist[s] = awful.widget.taglist(s, awful.widget.taglist.filter.all, mytaglist.buttons)
    mytasklist[s] = awful.widget.tasklist(s, awful.widget.tasklist.filter.currenttags, mytasklist.buttons)
    mywibox[s] = awful.wibox({ position = "top", screen = s, height = 24 })

    local left_layout = wibox.layout.fixed.horizontal()
    left_layout:add(spr)
    left_layout:add(mytaglist[s])
    left_layout:add(mypromptbox[s])
    left_layout:add(spr)

    local right_layout_toggle = false
    local function right_layout_add (...)
        local arg = {...}
        if right_layout_toggle then
            right_layout:add(pic_spr_middle)
            for i, n in pairs(arg) do
                right_layout:add(wibox.widget.background(n ,beautiful.bg_focus))
            end
        else
            right_layout:add(pic_spr_middle)
            for i, n in pairs(arg) do
                right_layout:add(n)
            end
        end
        right_layout_toggle = not right_layout_toggle
    end

    right_layout = wibox.layout.fixed.horizontal()
    if s == 1 then right_layout:add(wibox.widget.systray()) end
    right_layout:add(spr)
    right_layout:add(pic_spr_small)
    right_layout_add(volicon, volumewidget)
    right_layout_add(baticon, batwidget, spr)
    right_layout_add(mylayoutbox[s])
    right_layout_add(mytextclock, spr)
    right_layout:add(spr)

    local layout = wibox.layout.align.horizontal()
    layout:set_left(left_layout)
    layout:set_middle(mytasklist[s])
    layout:set_right(right_layout)
    mywibox[s]:set_widget(layout)

end

root.buttons(awful.util.table.join(
    awful.button({ }, 3, function () mymainmenu:toggle() end),
    awful.button({ }, 4, awful.tag.viewnext),
    awful.button({ }, 5, awful.tag.viewprev) ))

globalkeys = awful.util.table.join(

    awful.key({ modkey }, "Left",   awful.tag.viewprev       ),
    awful.key({ modkey }, "Right",  awful.tag.viewnext       ),

    awful.key({ altkey }, "Left", function () lain.util.tag_view_nonempty(-1) end),
    awful.key({ altkey }, "Right", function () lain.util.tag_view_nonempty(1) end),

    awful.key({ altkey }, "k",
        function ()
            awful.client.focus.byidx( 1)
            if client.focus then client.focus:raise() end
        end),
    awful.key({ altkey }, "j",
        function ()
            awful.client.focus.byidx(-1)
            if client.focus then client.focus:raise() end
        end),

    awful.key({ modkey }, "j",
        function()
            awful.client.focus.bydirection("down")
            if client.focus then client.focus:raise() end
        end),
    awful.key({ modkey }, "k",
        function()
            awful.client.focus.bydirection("up")
            if client.focus then client.focus:raise() end
        end),
    awful.key({ modkey }, "h",
        function()
            awful.client.focus.bydirection("left")
            if client.focus then client.focus:raise() end
        end),
    awful.key({ modkey }, "l",
        function()
            awful.client.focus.bydirection("right")
            if client.focus then client.focus:raise() end
        end),

    awful.key({ modkey }, "w",
        function ()
            mymainmenu:show({ keygrabber = true })
        end),

    awful.key({ modkey }, "b", function ()
        mywibox[mouse.screen].visible = not mywibox[mouse.screen].visible
    end),

    awful.key({ modkey, "Shift"   }, "j", function () awful.client.swap.byidx(  1)    end),
    awful.key({ modkey, "Shift"   }, "k", function () awful.client.swap.byidx( -1)    end),
    awful.key({ modkey, "Control" }, "j", function () awful.screen.focus_relative( 1) end),
    awful.key({ modkey, "Control" }, "k", function () awful.screen.focus_relative(-1) end),
    awful.key({ modkey,           }, "u", awful.client.urgent.jumpto),
    awful.key({ modkey,           }, "Tab",
        function ()
            awful.client.focus.byidx( 1)
            if client.focus then
                client.focus:raise()
            end
        end),
    awful.key({ altkey, "Shift"   }, "l",      function () awful.tag.incmwfact( 0.05)     end),
    awful.key({ altkey, "Shift"   }, "h",      function () awful.tag.incmwfact(-0.05)     end),
    awful.key({ modkey, "Shift"   }, "l",      function () awful.tag.incnmaster(-1)       end),
    awful.key({ modkey, "Shift"   }, "h",      function () awful.tag.incnmaster( 1)       end),
    awful.key({ modkey, "Control" }, "l",      function () awful.tag.incncol(-1)          end),
    awful.key({ modkey, "Control" }, "h",      function () awful.tag.incncol( 1)          end),
    awful.key({ modkey,           }, "space",  function () awful.layout.inc(layouts,  1)  end),
    awful.key({ modkey, "Shift"   }, "space",  function () awful.layout.inc(layouts, -1)  end),
    awful.key({ modkey, "Control" }, "n",      awful.client.restore),

    awful.key({ modkey,           }, "Return", function () awful.util.spawn(terminal) end),
    awful.key({ modkey, "Control" }, "r",      awesome.restart),
    awful.key({ modkey, "Shift"   }, "q",      awesome.quit),

    awful.key({ modkey,	          }, "z",      function () drop(terminal) end),

    awful.key({ altkey,           }, "c",      function () lain.widgets.calendar:show(7) end),
    awful.key({ altkey,           }, "h",      function () fswidget.show(7) end),

        awful.key({}, "XF86AudioRaiseVolume",
            function ()
                os.execute(string.format("amixer set %s 1%%+", volumewidget.channel))
                volumewidget.update()
            end),
        awful.key({}, "XF86AudioLowerVolume",
            function ()
                os.execute(string.format("amixer set %s 1%%-", volumewidget.channel))
                volumewidget.update()
            end),
        awful.key({}, "XF86AudioMute",
            function ()
                os.execute(string.format("amixer set %s toggle", volumewidget.channel))
                volumewidget.update()
            end),

    awful.key({ modkey }, "c", function () os.execute("xsel -p -o | xsel -i -b") end),

    awful.key({ modkey }, "r", function () mypromptbox[mouse.screen]:run() end),
    awful.key({ modkey }, "x",
              function ()
                  awful.prompt.run({ prompt = "Run Lua code: " },
                  mypromptbox[mouse.screen].widget,
                  awful.util.eval, nil,
                  awful.util.getdir("cache") .. "/history_eval")
              end))

clientkeys = awful.util.table.join(
    awful.key({ modkey,           }, "f",      function (c) c.fullscreen = not c.fullscreen  end),
    awful.key({ modkey, "Shift"   }, "c",      function (c) c:kill()                         end),
    awful.key({ modkey, "Control" }, "space",  awful.client.floating.toggle                     ),
    awful.key({ modkey, "Control" }, "Return", function (c) c:swap(awful.client.getmaster()) end),
    awful.key({ modkey,           }, "o",      awful.client.movetoscreen                        ),
    awful.key({ modkey,           }, "t",      function (c) c.ontop = not c.ontop            end),
    awful.key({ modkey,           }, "n",
        function (c)
            c.minimized = true
        end),
    awful.key({ modkey,           }, "m",
        function (c)
            c.maximized_horizontal = not c.maximized_horizontal
            c.maximized_vertical   = not c.maximized_vertical
        end))

for i = 1, 9 do
    globalkeys = awful.util.table.join(globalkeys,
        awful.key({ modkey }, "#" .. i + 9,
                  function ()
                        local screen = mouse.screen
                        local tag = awful.tag.gettags(screen)[i]
                        if tag then
                           awful.tag.viewonly(tag)
                        end
                  end),
        awful.key({ modkey, "Control" }, "#" .. i + 9,
                  function ()
                      local screen = mouse.screen
                      local tag = awful.tag.gettags(screen)[i]
                      if tag then
                         awful.tag.viewtoggle(tag)
                      end
                  end),
        awful.key({ modkey, "Shift" }, "#" .. i + 9,
                  function ()
                      if client.focus then
                          local tag = awful.tag.gettags(client.focus.screen)[i]
                          if tag then
                              awful.client.movetotag(tag)
                          end
                     end
                  end),
        awful.key({ modkey, "Control", "Shift" }, "#" .. i + 9,
                  function ()
                      if client.focus then
                          local tag = awful.tag.gettags(client.focus.screen)[i]
                          if tag then
                              awful.client.toggletag(tag)
                          end
                      end
                  end))
end

clientbuttons = awful.util.table.join(
    awful.button({ }, 1, function (c) client.focus = c; c:raise() end),
    awful.button({ modkey }, 1, awful.mouse.client.move),
    awful.button({ modkey }, 3, awful.mouse.client.resize))

root.keys(globalkeys)

awful.rules.rules = {
    { rule = { },
      properties = { border_width = beautiful.border_width,
                     border_color = beautiful.border_normal,
                     focus = awful.client.focus.filter,
                     keys = clientkeys,
                     buttons = clientbuttons,
	                   size_hints_honor = false } }, }

local sloppyfocus_last = {c=nil}
client.connect_signal("manage", function (c, startup)
    client.connect_signal("mouse::enter", function(c)
         if awful.layout.get(c.screen) ~= awful.layout.suit.magnifier
            and awful.client.focus.filter(c) then
             if c ~= sloppyfocus_last.c then
                 client.focus = c
                 sloppyfocus_last.c = c
             end
         end
     end)

    local titlebars_enabled = false
    if titlebars_enabled and (c.type == "normal" or c.type == "dialog") then
        local buttons = awful.util.table.join(
                awful.button({ }, 1, function()
                    client.focus = c
                    c:raise()
                    awful.mouse.client.move(c)
                end),
                awful.button({ }, 3, function()
                    client.focus = c
                    c:raise()
                    awful.mouse.client.resize(c)
                end))

        local right_layout = wibox.layout.fixed.horizontal()
        right_layout:add(awful.titlebar.widget.floatingbutton(c))
        right_layout:add(awful.titlebar.widget.maximizedbutton(c))
        right_layout:add(awful.titlebar.widget.stickybutton(c))
        right_layout:add(awful.titlebar.widget.ontopbutton(c))
        right_layout:add(awful.titlebar.widget.closebutton(c))

        local middle_layout = wibox.layout.flex.horizontal()
        local title = awful.titlebar.widget.titlewidget(c)
        title:set_align("center")
        middle_layout:add(title)
        middle_layout:buttons(buttons)

        local layout = wibox.layout.align.horizontal()
        layout:set_right(right_layout)
        layout:set_middle(middle_layout)

        awful.titlebar(c,{size=16}):set_widget(layout)
    end
end)

client.connect_signal("focus",
    function(c)
        if c.maximized_horizontal == true and c.maximized_vertical == true then
            c.border_color = beautiful.border_normal
        else
            c.border_color = beautiful.border_focus
        end
    end)
client.connect_signal("unfocus", function(c) c.border_color = beautiful.border_normal end)

for s = 1, screen.count() do screen[s]:connect_signal("arrange", function ()
        local clients = awful.client.visible(s)
        local layout  = awful.layout.getname(awful.layout.get(s))
      end)
end
