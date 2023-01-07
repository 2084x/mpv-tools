-- Toggles redshift when using mpv.
-- Assumes that redshift is running.

rs_on = true
on = false

function rs_toggle()
	os.execute("pkill -x -USR1 redshift")
end

function turn_on()
    	on = true
    	mp.osd_message("[rs-toggle] on")

    	function rs_disable()
        	if rs_on then
            		rs_toggle()
            		rs_on = false
            		print("disabling redshift")
        	end
    	end

    	function rs_enable()
        	if not rs_on then
            		rs_toggle()
            		rs_on = true
            		print("reenabling redshift")
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
        	if value then
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
	on = false
    	mp.osd_message("[rs-toggle] off")

    	if not rs_on then
        	rs_toggle()
        	rs_on = true
        	print("reenabling redshift")
    	end

    	mp.unregister_event(rs_handler)
    	mp.unregister_event(rs_enable)
    	mp.unobserve_property(on_pause_change)
end

function toggle()
    	if on then
        	turn_off()
    	else
        	turn_on()
    	end
end

mp.add_key_binding("r", "redshift-toggle", toggle)
