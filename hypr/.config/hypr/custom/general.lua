hl.gesture({
	fingers = 4,
	direction = "swipe",
	action = "move",
})
hl.gesture({
	fingers = 3,
	direction = "pinch",
	action = "float",
})
hl.gesture({
	fingers = 3,
	direction = "horizontal",
	action = "workspace",
})
hl.gesture({
	fingers = 3,
	direction = "down",
	action = function()
		hl.dispatch(hl.dsp.global("quickshell:overviewWorkspacesToggle"))
	end,
})
hl.gesture({
	fingers = 3,
	direction = "up",
	action = function()
		hl.dispatch(hl.dsp.global("quickshell:overviewWorkspacesClose"))
	end,
})

hl.config({
	gestures = {
		workspace_swipe_distance = 10,
		workspace_swipe_cancel_ratio = 0.2,
		workspace_swipe_min_speed_to_force = 3,
		workspace_swipe_direction_lock = true,
		workspace_swipe_direction_lock_threshold = 10,
		workspace_swipe_create_new = true,
	},
	input = {
		kb_layout = "us,ara",
		kb_options = "grp:win_space_toggle , caps:escape",
		numlock_by_default = true,
		repeat_delay = 250,
		repeat_rate = 35,
		force_no_accel = true,
		follow_mouse = 1,
		sensitivity = -1,
		touchpad = {
			natural_scroll = true,
			disable_while_typing = true,
			clickfinger_behavior = true,
			scroll_factor = 1,
		},
	},
})
-- Dynamically extract Material You colors from illogical-impulse's generated colors.lua
local function get_ii_colors()
	local c = {
		active = "rgba(c2c6d6AA)", -- Accent fallback (from pin rule)
		border = "rgba(47464877)", -- Active border fallback
		inactive = "rgba(1b1b1d33)", -- Inactive border fallback
		bg = "rgba(131315FF)", -- Surface background fallback
	}

	local path = os.getenv("HOME") .. "/.config/hypr/hyprland/colors.lua"
	local f = io.open(path, "r")
	if f then
		local content = f:read("*a")
		f:close()

		local active_b = content:match('active_border%s*=%s*"(rgba%([^"]+%)%)"')
		local inactive_b = content:match('inactive_border%s*=%s*"(rgba%([^"]+%)%)"')
		local bg_col = content:match('background_color%s*=%s*"(rgba%([^"]+%)%)"')
		local accent_col = content:match('border_color%s*=%s*"(rgba%([^"]+%)%)')

		if active_b then
			c.border = active_b
		end
		if inactive_b then
			c.inactive = inactive_b
		end
		if bg_col then
			c.bg = bg_col
		end
		if accent_col then
			c.active = accent_col
		end
	end
	return c
end

local ii = get_ii_colors()

hl.config({
	group = {
		col = {
			border_active = ii.border,
			border_inactive = ii.inactive,
		},
		groupbar = {
			enabled = true,
			font_family = "Google Sans Flex",
			font_size = 11,
			height = 22,
			render_titles = true,
			scrolling = true,
			gradients = true,
			rounding = 10,
			gaps_in = 4,
			gaps_out = 2,
			text_color = ii.bg,
			text_color_inactive = ii.active,
			col = {
				active = ii.active,
				inactive = ii.inactive,
				locked_active = ii.active,
				locked_inactive = ii.inactive,
			},
		},
	},
})
