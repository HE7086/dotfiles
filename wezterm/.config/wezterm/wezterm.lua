local wezterm = require("wezterm")

return {
    audible_bell = "Disabled",
    initial_rows = 40,
    initial_cols = 100,

    -- font
    font = wezterm.font_with_fallback {
        "Iosevka HE7086",
        "Noto Sans CJK SC"
    },
    font_size = 16,

    -- tab
    hide_tab_bar_if_only_one_tab = true,
    use_fancy_tab_bar = false,
    -- tab_bar_at_bottom = true,

    -- window
    -- window_decorations = "TITLE",
    window_padding = {
        left = 0,
        right = 0,
        top = 0,
        bottom = 0,
    },

    -- color
    force_reverse_video_cursor = true,
    colors = {
        -- Breeze from Konsole
        background = "#232627",
        foreground = "#fcfcfc",

        ansi = {
            "#232627",
            "#ed1515",
            "#11d116",
            "#f67400",
            "#1d99f3",
            "#9b59b6",
            "#1abc9c",
            "#fcfcfc",
        },
        brights = {
            "#7f8c8d",
            "#c0392b",
            "#1cdc9a",
            "#fdbc4b",
            "#3daee9",
            "#8e44ad",
            "#16a085",
            "#ffffff",
        },

        selection_fg = "none",
        selection_bg = "#31363b",

        cursor_border = "#ffffff",
    },

    keys = {
        {
            key = "(",
            mods = "CTRL|SHIFT",
            action = wezterm.action.SplitPane {
                direction = "Right",
                size = { Percent = 50 }
            },
        },
        {
            key = ")",
            mods = "CTRL|SHIFT",
            action = wezterm.action.SplitPane {
                direction = "Down",
                size = { Percent = 50 }
            },
        },
        {
            key = "h",
            mods = "ALT",
            action = wezterm.action.ActivatePaneDirection "Left",
        },
        {
            key = "j",
            mods = "ALT",
            action = wezterm.action.ActivatePaneDirection "Down",
        },
        {
            key = "k",
            mods = "ALT",
            action = wezterm.action.ActivatePaneDirection "Up",
        },
        {
            key = "l",
            mods = "ALT",
            action = wezterm.action.ActivatePaneDirection "Right",
        },
        {
            key = "R",
            mods = "CTRL|SHIFT",
            action = wezterm.action.RotatePanes "Clockwise",
        },
    },

}
