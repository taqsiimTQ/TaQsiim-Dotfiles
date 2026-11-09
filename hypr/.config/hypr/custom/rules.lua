-- Enable blur for all windows
hl.window_rule({ match = { class = ".*" }, no_blur = false })

-- Group Zathura windows into tabs
hl.window_rule({
	name = "zathura-tabbed",
	match = { class = "^(org.pwmt.zathura)$" },
	group = "set",
})

-- Auto-focus existing Zathura window to merge tabs
hl.on("window.open_early", function(win)
	if win.class ~= "org.pwmt.zathura" then
		return
	end

	for _, existing in ipairs(hl.get_windows()) do
		if existing.class == "org.pwmt.zathura" and existing.address ~= win.address then
			hl.dispatch(hl.dsp.focus({ window = existing }))
			break
		end
	end
end)
