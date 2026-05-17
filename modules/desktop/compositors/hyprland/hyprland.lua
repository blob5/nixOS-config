-- =============================================================================
-- Hyprland 0.55 Lua Configuration (UWSM Compliant)
-- =============================================================================

-- --- Variables ---
local terminal = "kitty"
local fileManager = "nautilus"
local menu = "rofi -show drun -show-icons"
local calc = "rofi -show calc -modi calc -no-show-match -no-sort -reuse-result -automatic-save-to-history"
local lock = "waylock"

-- --- Monitors ---
hl.monitor({
    output = "",
    mode = "preferred",
    position = "auto",
    scale = 1,
})

-- --- Startup Executions (Hyprland Event Hook) ---
hl.on("hyprland.start", function()
    hl.exec_cmd("swww-daemon")
    hl.exec_cmd("noctalia-shell")
    hl.exec_cmd("spotify", { workspace = "2" })
    hl.exec_cmd("vesktop", { workspace = "2" })
    hl.exec_cmd("steam -silent")
    hl.exec_cmd("kdeconnectd")
end)


-- --- Main Configuration Block ---
hl.config({
    general = {
        gaps_in = 0,
        gaps_out = 0,
        border_size = 2,
        ["col.active_border"] = { 
            colors = { "rgba(cba6f7ff)", "rgba(89b4faff)", "rgba(94e2d5ff)" },
            angle = 10
        },
        ["col.inactive_border"] = { colors = { "rgba(595959aa)" } },
        resize_on_border = false,
        allow_tearing = false,
        layout = "dwindle",
    },

    group = {
        groupbar = {
            enabled = true,
            render_titles = false,
        },
    },

    decoration = {
        rounding = 10,
        active_opacity = 1.0,
        inactive_opacity = 1.0,
        blur = {
            enabled = true,
            size = 8,
            passes = 2,
            ignore_opacity = true,
            vibrancy = 0.1696,
        },
    },

    dwindle = {
        preserve_split = true,
    },

    master = {
        new_status = "master",
    },

    render = {
        cm_auto_hdr = 0,
    },

    misc = {
        force_default_wallpaper = 1,
        disable_hyprland_logo = true,
        vrr = false,
    },

    windowrulev2 = {
        "float, class:^(waypaper)$",
        "stayfocused, class:^(pinentry-).*",
        "float, class:^(org\\.gnome\\.Calculator)$",
        "size 360 616, class:^(org\\.gnome\\.Calculator)$",
        "move 50% 50%, class:^(org\\.gnome\\.Calculator)$",        
    }
})

-- ====================
-- ANIMATIONS & BEZIERS
-- ====================

-- -- Bezier Curves --
hl.curve("overshot", { type = "bezier", points = { {0.1, 0.9}, {0.2, 1.05} } })
hl.curve("fluid", { type = "bezier", points = { {0.3, 1.0}, {0.1, 1.0} } })
hl.curve("snap", { type = "bezier", points = { {0.6, 0.9}, {0.2, 1.03} } })
hl.curve("menu_decel", { type = "bezier", points = { {0.15, 1.0}, {0.0, 1.0} } })
hl.curve("liner", { type = "bezier", points = { {1.0, 1.0}, {1.0, 1.0} } })

-- -- Window Animations --
hl.animation({ leaf = "windowsIn", enabled = true, speed = 4, bezier = "overshot", style = "popin 85%" })
hl.animation({ leaf = "windowsOut", enabled = true, speed = 3, bezier = "snap", style = "popin 85%" })
hl.animation({ leaf = "windowsMove", enabled = true, speed = 5, bezier = "overshot", style = "slide" })
hl.animation({ leaf = "border", enabled = true, speed = 1, bezier = "liner" })
hl.animation({ leaf = "borderangle", enabled = true, speed = 25, bezier = "liner", style = "once" })
hl.animation({ leaf = "fade", enabled = true, speed = 3, bezier = "fluid" })
hl.animation({ leaf = "layersIn", enabled = true, speed = 4, bezier = "overshot", style = "popin 75%" })
hl.animation({ leaf = "layersOut", enabled = false }) -- Omit trailing config if enabled is false
hl.animation({ leaf = "fadeLayersIn", enabled = true, speed = 3, bezier = "menu_decel" })
hl.animation({ leaf = "fadeLayersOut", enabled = true, speed = 3, bezier = "menu_decel" })
hl.animation({ leaf = "workspaces", enabled = true, speed = 5, bezier = "overshot", style = "slidevert" })
hl.animation({ leaf = "specialWorkspace", enabled = true, speed = 5, bezier = "overshot", style = "slidevert" })

-- --- Gestures ---
hl.gesture({ fingers = 3, direction = "vertical", action = "workspace" })

-- --- Keybindings ---

-- Application / Window controls
hl.bind("SUPER + Q", hl.dsp.exec_cmd(terminal))
hl.bind("SUPER + C", hl.dsp.window.close())
hl.bind("SUPER + M", hl.dsp.exit())
hl.bind("SUPER + E", hl.dsp.exec_cmd(fileManager))
hl.bind("SUPER + V", hl.dsp.window.float({ action = "toggle" }))
hl.bind("SUPER + R", hl.dsp.exec_cmd(menu))
hl.bind("SUPER + G", hl.dsp.exec_cmd(calc))
hl.bind("SUPER + F", hl.dsp.window.fullscreen({ action = "toggle" }))
hl.bind("SUPER + SHIFT + L", hl.dsp.exec_cmd(lock))
hl.bind("SUPER + backspace", hl.dsp.exec_cmd(terminal))

-- Window Group Management
hl.bind("SUPER + T", hl.dsp.group.toggle())
hl.bind("SUPER + Tab", hl.dsp.group.next())
hl.bind("SUPER + SHIFT + Tab", hl.dsp.group.prev())

-- Move focus
hl.bind("SUPER + left",  hl.dsp.focus({ direction = "l" }))
hl.bind("SUPER + right", hl.dsp.focus({ direction = "r" }))
hl.bind("SUPER + up",    hl.dsp.focus({ direction = "u" }))
hl.bind("SUPER + down",  hl.dsp.focus({ direction = "d" }))
hl.bind("SUPER + H",     hl.dsp.focus({ direction = "l" }))
hl.bind("SUPER + L",     hl.dsp.focus({ direction = "r" }))
hl.bind("SUPER + K",     hl.dsp.focus({ direction = "u" }))
hl.bind("SUPER + J",     hl.dsp.focus({ direction = "d" }))

-- Workspaces (Switching & Moving windows)
for i = 1, 9 do
    hl.bind("SUPER + " .. i, hl.dsp.focus({ workspace = tostring(i) }))
    hl.bind("SUPER + SHIFT + " .. i, hl.dsp.window.move({ workspace = tostring(i) }))
end
hl.bind("SUPER + 0", hl.dsp.focus({ workspace = "10" }))
hl.bind("SUPER + SHIFT + 0", hl.dsp.window.move({ workspace = "10" }))

-- Mouse wheel workspace scrolling
hl.bind("SUPER + mouse_down", hl.dsp.focus({ workspace = "e-1" }))
hl.bind("SUPER + mouse_up",   hl.dsp.focus({ workspace = "e+1" }))

-- Mouse dragging / resizing
hl.bind("SUPER + mouse:272", hl.dsp.window.drag(), { mouse = true })
hl.bind("SUPER + mouse:273", hl.dsp.window.resize(), { mouse = true })

-- --- Screenshot and OCR Utilities ---
hl.bind("SUPER + SHIFT + S", hl.dsp.exec_cmd([[sh -c 'geom=$(slurp) || exit; grim -g "$geom" - | wl-copy -t image/png && notify-send "Screenshot copied"']]))
hl.bind("SUPER + SHIFT + A", hl.dsp.exec_cmd([[sh -c 'geom=$(slurp) || exit; txt=$(grim -g "$geom" - | tesseract stdin stdout -l eng 2>/dev/null); if [ -n "$txt" ]; then printf "%s" "$txt" | wl-copy && notify-send "OCR copied" "${txt:0:100}"; else notify-send "OCR failed" "No text detected"; fi']]))
hl.bind("SUPER + SHIFT + D", hl.dsp.exec_cmd([[sh -c 'geometry=$(slurp) || exit 1; grim -g "$geometry" - | wl-copy -t image/png && xdg-open "https://lens.google.com/upload" && notify-send "Google Lens" "Paste with Ctrl+V"']]))