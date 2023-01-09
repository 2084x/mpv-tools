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
   	c = check_clip(u, '"')

   	if not c then return end

      	return c
end

local function append()
   	local p = get_clip()
   	if not p then return end
      	mp.osd_message("Appended: "..p)
      	mp.commandv("loadfile", p, "append")
end

local function put()
   	local p = get_clip()
   	if not p then return end
      	mp.osd_message("Playing: "..p)
      	mp.commandv("loadfile", p, "append")
        mp.commandv("playlist-move", mp.get_property("playlist-count")-1, mp.get_property("playlist-pos-1"))
  	mp.commandv("playlist-next")
end

local function yank()
   	local p = mp.get_property("path")
   	local c = io.popen("xclip -i -selection clipboard", "w")
   	c:write(p)
   	c:close()
   	mp.osd_message("Yanked: "..p)
end

mp.add_key_binding("y", yank)
mp.add_key_binding("a", append)
mp.add_key_binding("P", put)
