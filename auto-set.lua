-- Automatically sets loop-file=inf if duration <= given length
-- or pause if path has no duration (image file).

require "mp.options"

local opts = {

	-- Maximum duration of files to auto-loop.
    	length = 20,

    	-- Ignore script if string matches path.
    	ignore = {
		-- "://",	-- Never auto-loop network paths.
		-- "%.jpg$",    -- Never auto-pause jpg files.
    		-- "/pix/",	-- Ignore script when playing files in the /pix/ directory.
		},

}

read_options(opts)

local function auto_set()
    	local path = mp.get_property_native("path")
    	local duration = mp.get_property_native("duration")

    	-- Checks if script should be ignored.
    	for x,pattern in pairs(opts.ignore) do
        	if path:find(pattern) then
            		return
        	end
    	end

    	-- Pauses if path has no duration.
    	if not duration then
        	mp.set_property_native("pause", true)
		mp.msg.log("info", "file paused")
        	return
    	end

    	-- Gets loop status.
    	local looping = mp.get_property_native("loop-file")
    	-- Enables looping.
    	if not looping and duration <= opts.length then
        	mp.set_property_native("loop-file", true)
		mp.msg.log("info", "looping enabled")
    	-- Disables looping.
    	elseif looping and duration > opts.length then
        	mp.set_property_native("loop-file", false)
		mp.msg.log("info", "looping disabled")
    	end
end

mp.register_event("file-loaded", auto_set)
