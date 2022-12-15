-- Downloads current video with yt-dlp.

local function log(event)
	local success = string.match(event.text, "%[Merger%]")
	local exists = string.match(event.text, "has already been downloaded")
	local failed = string.match(event.text, "ERROR")

	if success then
		mp.osd_message("[yt-dl] download complete")
	elseif exists then
		mp.osd_message("[yt-dl] already downloaded")
	elseif failed then
		mp.osd_message("[yt-dl] download experienced errors, check log for details")
	end

	if success or exists or failed then
		mp.unregister_event(log)
		active = false
	end
end

local function dl()
	if active then
		mp.osd_message("[yt-dl] download in progress")
		return
	end

   	local p = mp.get_property("path")

   	if string.find(p, "://") == nil then
		mp.osd_message("[yt-dl] cannot download local files")
		return
	end

	active = true
	mp.enable_messages("info")
	mp.register_event("log-message", log)
	mp.osd_message("[yt-dl] download started")

	mp.command_native_async({
		name="subprocess",
	-- Additional flags can be placed here or in ~/.config/yt-dlp/config.
		args = {"yt-dlp", p},
		playback_only = false
		}, function() end)
end

mp.add_key_binding("D", "yt-dl", dl)
