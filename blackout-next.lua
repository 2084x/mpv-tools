-- Blackout / boss key for vo=gpu-next.

assdraw = require "mp.assdraw"

local function toggle()
	if not on then
		on = true
		mp.set_property_native("mute", true)
            	mp.commandv("script-message", "osc-visibility", "never", "no-osd")
		local ass = assdraw.ass_new()
        	local w, h = mp.get_osd_size()
        	local alpha = 255 - math.ceil(255 * 1)
        	ass.text = string.format("{\\pos(0,0)\\rDefault\\an7\\1c&H000000&\\alpha&H%X&}", alpha)
        	ass:draw_start()
        	ass:rect_cw(0, 0, w, h)
        	ass:draw_stop()
        	ass:new_event()
        	mp.set_osd_ass(w, h, ass.text)
	elseif on then
		on = false
		mp.set_property_native("mute", false)
            	mp.commandv("script-message", "osc-visibility", "auto", "no-osd")
        	mp.set_osd_ass(0, 0, "")
	end
end

mp.add_key_binding("b", "blackout", toggle)
