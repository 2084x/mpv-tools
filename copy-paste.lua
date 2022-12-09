-- Checks if clipboard contents is a link.
function check_clip(s)
	if string.find(url, "://") == nil then
      		return
   	else
      		-- Trims trailing white space.
      		return (s:gsub("^%s*(%S+)%s*", "%1"))
   	end
end

-- Gets clipboard contents.
function get_clip()

	subprocess = {
   	name = "subprocess",
   	args = { "xclip", "-o","-selection","clipboard"},
   	playback_only = false,
   	capture_stdout = true,
   	capture_stderr = true
			}

   	v = mp.command_native(subprocess)

   	-- Checks if getting clipboard data failed.
   	if v.status < 0 then
      		mp.osd_message("Failed getting clipboard data")
      		print("Error(string): "..v.error_string)
      		print("Error(stderr): "..v.stderr)
   	end

   	url = v.stdout

   	if not url then
      		mp.osd_message("Clipboard empty")
      		return
   	end

   	url = check_clip(url)

   	if not url then
      		mp.osd_message("Not a valid link")
      		return
   	else
      		return url
   	end
end

-- Appends link to playlist.
function append_link()
   	local url = get_clip()

   	if not url then
      		return
   	else
      		mp.osd_message("Added to playlist:\n"..url)
      		mp.commandv("loadfile", url, "append")
   	end
end

-- Loads link.
function load_link()
   	local url = get_clip()

   	if not url then
      		return
   	else
      		mp.osd_message("Opening:\n"..url)
      		mp.commandv("loadfile", url, "replace")
   	end
end

-- Copies path of current file to clipboard.
function copy_path()
   	local path = mp.get_property("path")
   	local p = string.format(path)
   	local c = io.popen("xclip -i -selection clipboard", "w")
   	c:write(p)
   	c:close()
   	mp.osd_message("Copied to clipboard:\n"..path)
end

mp.add_key_binding("y", copy_path)
mp.add_key_binding("alt+v", append_link)
mp.add_key_binding("ctrl+v", load_link)
