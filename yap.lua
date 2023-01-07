-- Yanks, appends and puts paths / links.

local function check_clip(s, e)
	if string.find(u, "://") ~= nil then
      		return (s:gsub("^%s*(%S+)%s*", "%1"))
	elseif string.find(u, "/home/") ~= nil then
		return string.gsub(s, e, '\\'..e)
   	end
end

local function get_clip()
	subprocess = {
   	name = "subprocess",
   	args = { "xclip", "-o","-selection","clipboard"},
   	playback_only = false,
   	capture_stdout = true
		}

   	v = mp.command_native(subprocess)
   	u = v.stdout

   	if not u then
      		return mp.osd_message("Clipboard empty")
   	end

   	c = check_clip(u, '"')

   	if not c then
      		return mp.osd_message("Not a valid link")
   	end

      	return c
end

local function append()
   	local p = get_clip()
   	if not p then return end
      	mp.osd_message("Added to playlist: "..u)
      	mp.commandv("loadfile", u, "append")
end

local function put()
   	local p = get_clip()
   	if not p then return end
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
