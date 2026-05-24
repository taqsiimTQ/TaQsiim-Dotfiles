hl.on("hyprland.start", function ()
    hl.exec_cmd("kdeconnect-indicator")
    hl.exec_cmd("sh -c 'sleep 5 && env QT_QPA_PLATFORM=xcb /usr/lib/pentablet/PenTablet.sh /mini'")
end)
