-- Blackout / boss key for vo=gpu-next.

assdraw = require "mp.assdraw"

active = false

function toggle()

	if not active then
		active = true
		dim = 1
		mp.set_property_native("mute", true)
            	mp.commandv("script-message", "osc-visibility", "never", "no-osd")
	elseif active then
		active = false
		dim = 0
		mp.set_property_native("mute", false)
		mp.set_property_native("pause", false)
            	mp.commandv("script-message", "osc-visibility", "auto", "no-osd")
	end

	local ass = assdraw.ass_new()
        local w, h = mp.get_osd_size()
        local alpha = 255 - math.ceil(255 * dim)

        ass.text = string.format("{\\pos(0,0)\\rDefault\\an7\\1c&H000000&\\alpha&H%X&}", alpha)
        ass:draw_start()
        ass:rect_cw(0, 0, w, h)
        ass:draw_stop()
        ass:new_event()

        mp.set_osd_ass(w, h, ass.text)
end

mp.add_key_binding("b", "blackout", toggle)
