-- Downloads current video with yt-dlp.

local function log(event)
	local success = string.match(event.text, "%[Merger%]")
	local exists = string.match(event.text, "has already been downloaded")
	local failed = string.match(event.text, "error") or string.match(event.text, "failed")

	if success then
		mp.unregister_event(log)
		mp.osd_message("Download complete")
	elseif exists then
		mp.unregister_event(log)
		mp.osd_message("Already downloaded")
	elseif failed then
		mp.unregister_event(log)
		mp.osd_message("Download failed or experienced errors, check log for details", 3)
	end
end

local function dl()
   	local p = mp.get_property("path")
   	local l = string.format(p)

   	if string.find(l, "://") == nil then
		mp.osd_message("Cannot download local files")
		return
	else
		mp.enable_messages("info")
		mp.register_event("log-message", log)
		mp.osd_message("Downloading:\n"..l)

		mp.command_native_async({
			name="subprocess",
		-- Additional flags can be placed here or in ~/.config/yt-dlp/config.
			args = {"yt-dlp", l},
			playback_only = false
			}, function() end)
	end
end

mp.add_key_binding("ctrl+d", "download-video", dl)
