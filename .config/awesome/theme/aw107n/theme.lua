theme                               = {}

themes_dir                          = os.getenv("HOME") .. "/.config/awesome/theme/aw107n"
theme.wallpaper                     = themes_dir .. "/wall.png"
theme.font                          = "Roboto 10"
theme.fg_normal                     = "#8A8A8A"
theme.fg_focus                      = "#D7D4D4"
theme.fg_urgent                     = "#CC9393"
theme.bg_normal                     = "#1A1A1A"
theme.bg_focus                      = "#1A1A1A"
theme.bg_urgent                     = "#1A1A1A"
theme.border_width                  = "2"
theme.border_normal                 = "#1A1A1A"
theme.border_focus                  = "#1A1A1A"
theme.border_marked                 = "#518FF5"
theme.titlebar_bg_focus             = "#FFFFFF"
theme.titlebar_bg_normal            = "#FFFFFF"
theme.taglist_fg_focus              = "#F55151"
theme.tasklist_bg_focus             = "#1A1A1A"
theme.tasklist_fg_focus             = "#D4D7D6"
theme.textbox_widget_margin_top     = 1
theme.notify_fg                     = theme.fg_normal
theme.notify_bg                     = theme.bg_normal
theme.notify_border                 = theme.border_focus
theme.awful_widget_height           = 14
theme.awful_widget_margin_top       = 2
theme.mouse_finder_color            = "#CC9393"

theme.submenu_icon                  = themes_dir .. "/icons/submenu.png"
theme.taglist_squares_sel           = themes_dir .. "/icons/square_sel.png"
theme.taglist_squares_unsel         = themes_dir .. "/icons/square_unsel.png"
theme.layout_tile                   = themes_dir .. "/icons/tile.png"
theme.layout_tilebottom             = themes_dir .. "/icons/tilebottom.png"
theme.layout_max                    = themes_dir .. "/icons/max.png"
theme.layout_floating               = themes_dir .. "/icons/floating.png"
theme.pic_spr_small                 = themes_dir .. "/icons/pic_spr_small.png"
theme.pic_spr_middle                = themes_dir .. "/icons/pic_spr_middle.png"
theme.widget_ac                     = themes_dir .. "/icons/ac.png"
theme.widget_battery_full           = themes_dir .. "/icons/battery_full.png"
theme.widget_battery_high           = themes_dir .. "/icons/battery_high.png"
theme.widget_battery_mid            = themes_dir .. "/icons/battery_mid.png"
theme.widget_battery_low            = themes_dir .. "/icons/battery_low.png"
theme.widget_battery_empty          = themes_dir .. "/icons/battery_empty.png"
theme.widget_vol_max                = themes_dir .. "/icons/vol_max.png"
theme.widget_vol_mid                = themes_dir .. "/icons/vol_mid.png"
theme.widget_vol_low                = themes_dir .. "/icons/vol_low.png"
theme.widget_vol_min                = themes_dir .. "/icons/vol_min.png"
theme.widget_vol_mute               = themes_dir .. "/icons/vol_mute.png"

theme.tasklist_disable_icon         = true
theme.tasklist_floating             = ""
theme.tasklist_maximized_horizontal = ""
theme.tasklist_maximized_vertical   = ""

return theme
