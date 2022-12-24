-- Automatically sets loop-file=inf if duration <= given length
-- or pause if path has no duration (image file).

local opts = {

	-- Maximum duration of files to auto-loop.
    	length = 20,

    	-- Ignore script if string matches path.
    	ignore = {
        	"://",
		".mp3$", ".flac$", ".wav$", ".m4a$", ".opus$",
		},

}

local function auto_set()
    	local path = mp.get_property_native("path")
    	local duration = mp.get_property_native("duration")
    	local looping = mp.get_property_native("loop-file")

    	for x,pattern in pairs(opts.ignore) do
        	if path:find(pattern) then
			if looping then
        			mp.set_property_native("loop-file", false)
				print("looping disabled")
			end
            		return
        	end
    	end

    	if not duration then
        	mp.set_property_native("pause", true)
		print("file paused")
        	return
    	end

    	if not looping and duration <= opts.length then
        	mp.set_property_native("loop-file", true)
		print("looping enabled")
    	elseif looping and duration > opts.length then
        	mp.set_property_native("loop-file", false)
		print("looping disabled")
    	end
end

mp.register_event("file-loaded", auto_set)
