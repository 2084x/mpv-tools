-- Yanks, appends and puts links.

local function check_clip(s)
	if string.find(u, "://") == nil then
      		return
   	else
      		return (s:gsub("^%s*(%S+)%s*", "%1"))
   	end
end

local function get_clip()
	subprocess = {
   	name = "subprocess",
   	args = { "xclip", "-o","-selection","clipboard"},
   	playback_only = false,
   	capture_stdout = true,
   	capture_stderr = true
			}

   	v = mp.command_native(subprocess)

   	if v.status < 0 then
      		mp.osd_message("Failed getting clipboard data")
      		print("Error(string): "..v.error_string)
      		print("Error(stderr): "..v.stderr)
   	end

   	u = v.stdout

   	if not u then
      		mp.osd_message("Clipboard empty")
      		return
   	end

   	u = check_clip(u)

   	if not u then
      		mp.osd_message("Not a valid link")
      		return
   	else
      		return u
   	end
end

local function append()
   	local u = get_clip()

   	if not u then return end

      	mp.osd_message("Added to playlist: "..u)
      	mp.commandv("loadfile", u, "append")
end

local function put()
   	local u = get_clip()

   	if not u then return end

      	mp.osd_message("Opening: "..u)
      	mp.commandv("loadfile", u, "replace")
end

local function yank()
   	local p = mp.get_property("path")
   	local c = io.popen("xclip -i -selection clipboard", "w")
   	c:write(p)
   	c:close()
   	mp.osd_message("Copied to clipboard: "..p)
end

mp.add_key_binding("y", yank)
mp.add_key_binding("a", append)
mp.add_key_binding("P", put)
