theme                               = {}

theme.confdir                       = os.getenv("HOME") .. "/.config/awesome/themes/multicolor"
theme.wallpaper                     = theme.confdir .. "/wall-3.png"

theme.font                          = "Ubuntu Mono 10"
--theme.taglist_font                =
theme.menu_bg_normal                = "#00000000"
theme.menu_bg_focus                 = "#00000000"
theme.bg_normal                     = "#00000000"
theme.bg_focus                      = "#00000000"
theme.bg_urgent                     = "#000000"
theme.fg_normal                     = "#8e8e8e"
theme.fg_focus                      = "#D4D7D6"
theme.fg_urgent                     = "#af1d18"
theme.fg_minimize                   = "#ffffff"
theme.fg_black                      = "#424242"
theme.fg_red                        = "#ce5666"
theme.fg_green                      = "#80a673"
theme.fg_yellow                     = "#ffaf5f"
theme.fg_blue                       = "#7788af"
theme.fg_magenta                    = "#94738c"
theme.fg_cyan                       = "#778baf"
theme.fg_white                      = "#aaaaaa"
theme.fg_blu                        = "#8ebdde"
theme.border_width                  = "0"
theme.border_normal                 = "#1c2022"
theme.border_focus                  = "#606060"
theme.border_marked                 = "#3ca4d8"
theme.menu_width                    = "130"
theme.menu_border_width             = "0"
theme.menu_fg_normal                = "#8e8e8e"
theme.menu_fg_focus                 = "#D4D7D6"
theme.menu_bg_normal                = "#111219"
theme.menu_bg_focus                 = "#111219"

theme.submenu_icon                  = theme.confdir .. "/icons/submenu.png"
theme.widget_note                   = theme.confdir .. "/icons/note.png"
theme.widget_note_on                = theme.confdir .. "/icons/note_on.png"

theme.taglist_squares_sel           = theme.confdir .. "/icons/square_sel.png"
theme.taglist_squares_unsel         = theme.confdir .. "/icons/square_unsel.png"

theme.tasklist_disable_icon         = true
theme.tasklist_floating             = ""
theme.tasklist_maximized_horizontal = ""
theme.tasklist_maximized_vertical   = ""

theme.widget_vol_max                = theme.confdir .. "/icons/vol_max.png"
theme.widget_vol_mid                = theme.confdir .. "/icons/vol_mid.png"
theme.widget_vol_low                = theme.confdir .. "/icons/vol_low.png"
theme.widget_vol_min                = theme.confdir .. "/icons/vol_min.png"
theme.widget_vol_mute               = theme.confdir .. "/icons/vol_mute.png"
theme.widget_ac                     = theme.confdir .. "/icons/ac.png"
theme.widget_battery_full           = theme.confdir .. "/icons/battery_full.png"
theme.widget_battery_high           = theme.confdir .. "/icons/battery_high.png"
theme.widget_battery_mid            = theme.confdir .. "/icons/battery_mid.png"
theme.widget_battery_low            = theme.confdir .. "/icons/battery_low.png"
theme.widget_battery_empty          = theme.confdir .. "/icons/battery_empty.png"

theme.layout_tile                   = theme.confdir .. "/icons/tile.png"
theme.layout_tilebottom             = theme.confdir .. "/icons/tilebottom.png"
theme.layout_max                    = theme.confdir .. "/icons/max.png"
theme.layout_floating               = theme.confdir .. "/icons/floating.png"


return theme
