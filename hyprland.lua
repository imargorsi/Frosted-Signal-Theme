-- Frosted Signal — Hyprland 0.55+ (Lua) theme surface.
--
-- Art direction: glass held up against the night. Windows sit behind a soft
-- frost — blurred, never fully opaque — and one signal color cuts through the
-- chrome to mark whatever currently has focus. Everything else recedes.
--
-- Theme-scoped: visual values only. Layout, binds, and input stay upstream.

-- Palette (mirrors colors.toml)
local acid = "a8be4a" -- signal green / accent / focus
local amber = "e6b14a" -- warm secondary signal
local peri = "6e72c6" -- night indigo
local slat = "2b3068" -- unlit surface
local night = "0b0e20" -- bg
local scramble = "272b5e" -- selection field

-- The focused window carries the signal: green shifting through amber into
-- indigo. With `borderangle` looping below, the three stops rotate
-- continuously and the border never settles on one color.
local active_border_color = {
	colors = { "rgba(" .. acid .. "ee)", "rgba(" .. amber .. "dd)", "rgba(" .. peri .. "ee)" },
	angle = 90,
}
local inactive_border_color = "rgba(" .. slat .. "aa)"

-- A locked group stops shifting. It has settled on one color.
local locked_border_color = {
	colors = { "rgba(" .. acid .. "ee)", "rgba(" .. acid .. "88)" },
	angle = 90,
}

hl.config({
	general = {
		-- Windows float with real breathing room instead of tiling edge to edge.
		gaps_in = 10,
		gaps_out = 22,
		border_size = 2,
		col = {
			active_border = active_border_color,
			inactive_border = inactive_border_color,
		},
	},

	group = {
		col = {
			border_active = active_border_color,
			border_inactive = inactive_border_color,
			border_locked_active = locked_border_color,
			border_locked_inactive = inactive_border_color,
		},

		groupbar = {
			font_family = "monospace",
			font_size = 11,
			font_weight_active = "bold",
			font_weight_inactive = "normal",
			height = 22,
			indicator_height = 2,
			gradient_rounding = 6,
			gradients = true,
			text_color = "rgba(0b0e20ff)",
			text_color_inactive = "rgba(8a8cd4ff)",
			col = {
				active = "rgba(" .. acid .. "dd)",
				inactive = "rgba(" .. slat .. "cc)",
				locked_active = "rgba(" .. amber .. "dd)",
				locked_inactive = "rgba(" .. slat .. "cc)",
			},
		},
	},

	decoration = {
		-- Soft rounding, not machined edges.
		rounding = 10,

		-- Unfocused windows recede behind the frost.
		dim_inactive = true,
		dim_strength = 0.24,

		-- A soft, slightly noisy frost — richer than a neutral blur, never
		-- washed out.
		blur = {
			enabled = true,
			size = 6,
			passes = 3,
			noise = 0.055,
			contrast = 1.05,
			brightness = 0.78,
			vibrancy = 0.36,
			vibrancy_darkness = 0.22,
			popups = true,
		},

		-- Cold spill on the wall behind each window, offset down and slightly
		-- right.
		shadow = {
			enabled = true,
			range = 26,
			render_power = 3,
			offset = "3 6",
			color = "rgba(050610cc)",
			color_inactive = "rgba(05061088)",
		},
	},

	animations = {
		enabled = true,
	},
})

-- Motion language: interpolation. Movement eases in from nothing and drifts
-- to a stop, never a servo hitting a limit.
hl.curve("fsTrace", { type = "bezier", points = { { 0.16, 1.00 }, { 0.30, 1.00 } } })
hl.curve("fsDrift", { type = "bezier", points = { { 0.25, 0.10 }, { 0.25, 1.00 } } })
hl.curve("fsFade", { type = "bezier", points = { { 0.33, 0.00 }, { 0.20, 1.00 } } })
hl.curve("fsLinear", { type = "bezier", points = { { 0.00, 0.00 }, { 1.00, 1.00 } } })

hl.animation({ leaf = "global", enabled = true, speed = 7, bezier = "fsTrace" })
hl.animation({ leaf = "border", enabled = true, speed = 4, bezier = "fsDrift" })
-- The signal cycling: one full rotation of the border gradient every ten
-- seconds, the slowest Hyprland allows. This is the theme's signature and it
-- costs a continuous redraw of the focused border; set enabled = false here
-- when on battery.
hl.animation({ leaf = "borderangle", enabled = true, speed = 100, bezier = "fsLinear", style = "loop" })
hl.animation({ leaf = "windows", enabled = true, speed = 4.5, bezier = "fsTrace", style = "slide" })
hl.animation({ leaf = "windowsIn", enabled = true, speed = 4.5, bezier = "fsTrace", style = "popin 90%" })
-- Closing windows do not snap shut; the fade lags a frame behind.
hl.animation({ leaf = "windowsOut", enabled = true, speed = 3.2, bezier = "fsFade", style = "popin 94%" })
hl.animation({ leaf = "windowsMove", enabled = true, speed = 4.5, bezier = "fsTrace" })
hl.animation({ leaf = "fade", enabled = true, speed = 4, bezier = "fsTrace" })
hl.animation({ leaf = "fadeIn", enabled = true, speed = 3.4, bezier = "fsTrace" })
hl.animation({ leaf = "fadeOut", enabled = true, speed = 2.4, bezier = "fsFade" })
hl.animation({ leaf = "layers", enabled = true, speed = 4, bezier = "fsTrace" })
hl.animation({ leaf = "layersIn", enabled = true, speed = 4, bezier = "fsTrace", style = "fade" })
hl.animation({ leaf = "layersOut", enabled = true, speed = 2.6, bezier = "fsFade", style = "fade" })
-- Workspaces pan like a camera move rather than cutting.
hl.animation({ leaf = "workspaces", enabled = true, speed = 5, bezier = "fsDrift", style = "slidefade 15%" })
hl.animation({ leaf = "specialWorkspace", enabled = true, speed = 4.5, bezier = "fsTrace", style = "slidevert" })

-- Overlays are readouts, not part of the frost. Keep them sharp and full-power.
hl.window_rule({
	name = "frosted-signal-walker-readout",
	no_blur = true,
	no_dim = true,
	match = { class = "^(walker)$" },
})

hl.window_rule({
	name = "frosted-signal-swayosd-readout",
	no_blur = true,
	no_dim = true,
	match = { class = "^(swayosd)$" },
})

-- Anything playing a picture keeps full signal even when it is not the
-- window being watched.
hl.window_rule({
	name = "frosted-signal-media-full-signal",
	no_dim = true,
	opacity = "1.0 override 1.0 override",
	match = {
		class = "(brave|chromium|google-chrome|firefox|mpv|vlc).*",
		title = ".*(YouTube|Netflix|Prime Video|Hulu|Twitch).*",
	},
})
