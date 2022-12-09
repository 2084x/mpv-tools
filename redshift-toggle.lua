-- Toggle redshift when using mpv.
-- Assumes that redshift is running.

rs_enabled = true
active = false

function rs_toggle()
	os.execute("pkill -x -USR1 redshift")
end

function turn_on()

    	active = true
    	mp.osd_message("Redshift toggling activated")

    	function rs_disable()
        	if rs_enabled then
            		rs_toggle()
            		rs_enabled = false
            		mp.msg.log("info", "Disabling redshift")
        	end
    	end

    	function rs_enable()
        	if not rs_enabled then
            		rs_toggle()
            		rs_enabled = true
            		mp.msg.log("info", "Reenabling redshift")
        	end
    	end

    	function rs_handler()
        	if mp.get_property("video") ~= "no" then
            		rs_disable()
        	else
            		rs_enable()
        	end
    	end

    	function on_pause_change(name, value)
        	if value then  --pause started
            		rs_enable()
        	else
            		rs_disable()
        	end
    	end

    	mp.register_event("file-loaded", rs_handler)
    	mp.register_event("shutdown", rs_enable)
    	mp.observe_property("pause", "bool", on_pause_change)

end

function turn_off()

	active = false
    	mp.osd_message("Redshift toggling deactivated")

    	if not rs_enabled then
        	rs_toggle()
        	rs_enabled = true
        	mp.msg.log("info", "Reenabling redshift")
    	end

    	mp.unregister_event(rs_handler)
    	mp.unregister_event(rs_enable)
    	mp.unobserve_property(on_pause_change)

end

function toggle()
    	if active then
        	turn_off()
    	else
        	turn_on()
    	end
end

mp.add_key_binding("F1", "redshift-toggle", toggle)
