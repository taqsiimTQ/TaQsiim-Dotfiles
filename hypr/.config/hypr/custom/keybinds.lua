-- Quick configuration shortcuts
hl.bind(
	"CTRL + SUPER + Slash",
	hl.dsp.exec_cmd("xdg-open ~/.config/illogical-impulse/config.json"),
	{ description = "Edit shell config" }
)
hl.bind(
	"CTRL + SUPER + ALT + Slash",
	hl.dsp.exec_cmd("xdg-open ~/.config/hypr/custom/keybinds.conf"),
	{ description = "Edit extra keybinds" }
)

-- Unbind default shortcuts
hl.unbind("SUPER + B")
hl.unbind("SUPER + W")
hl.unbind("CTRL + SUPER + T")
hl.unbind("SUPER + C")
hl.unbind("CTRL + SHIFT + Escape")
hl.unbind("SUPER + Q")

-- Application launchers
hl.bind("SUPER + B", hl.dsp.exec_cmd(browser), { description = "Browser" })
hl.bind("CTRL + SHIFT + Escape", hl.dsp.exec_cmd(taskManager), { description = "Task manager" })
hl.bind("SUPER + C", hl.dsp.exec_cmd(codeEditor))

-- Quickshell wallpaper and session controls
hl.bind(
	"CTRL + SUPER + W",
	hl.dsp.global("quickshell:wallpaperSelectorToggle"),
	{ description = "Toggle wallpaper selector" }
)
hl.bind("SUPER + F4", hl.dsp.global("quickshell:sessionToggle"), { description = "Shell: Toggle session menu" })
hl.bind(
	"CTRL + SUPER + ALT + W",
	hl.dsp.global("quickshell:wallpaperSelectorRandom"),
	{ description = "Select random wallpaper" }
)
hl.bind(
	"CTRL + SUPER + W",
	hl.dsp.exec_cmd(
		"qs -c $qsConfig ipc call TEST_ALIVE || ~/.config/quickshell/$qsConfig/scripts/colors/switchwall.sh"
	),
	{ description = "Change wallpaper" }
)

-- Window management
hl.bind("ALT + F4", hl.dsp.window.close(), { description = "Close active window" })
hl.bind("ALT + SHIFT + F4", hl.dsp.exec_cmd("hyprctl kill"), { description = "Force kill" })
hl.bind("SUPER + SHIFT + F", hl.dsp.window.float({ action = "toggle" }), { description = "Toggle float" })

-- Resize window split ratios
hl.bind("CTRL + SUPER + SHIFT + Left", hl.dsp.layout("splitratio -0.1"), { repeating = true })
hl.bind("CTRL + SUPER + SHIFT + Right", hl.dsp.layout("splitratio +0.1"), { repeating = true })

-- Window focus cycling
hl.bind("ALT + Tab", hl.dsp.window.cycle_next(), { description = "Cycle next" })
hl.bind("ALT + Tab", hl.dsp.window.bring_to_top(), { description = "Bring to top" })

-- Tabbed window group navigation
hl.bind("SUPER + Tab", hl.dsp.group.next())
hl.bind("SUPER + SHIFT + Tab", hl.dsp.group.prev())

-- Move window to workspaces (1-10)
for i = 1, 10 do
	hl.bind("SUPER + SHIFT + " .. (i % 10), function()
		hl.dispatch(hl.dsp.window.move({ workspace = workspace_in_group(i) }))
	end, { description = "Window: Send to workspace " .. i })
end

-- Disable default SUPER + Space
hl.bind("SUPER + Space", hl.dsp.no_op())
