-- Automatically skips chapters based on their title.

local opts = {

	-- If false, shows osd message when chapter is skipped.
	silent = true,

	-- Chapter title patterns to skip.
	patterns = {
		"^OP$","[Oo]pening$", "^[Oo]pening:", "[Oo]pening [Cc]redits",
        	"^ED$","[Ee]nding$", "^[Ee]nding:", "[Ee]nding [Cc]redits",
        	"[Pp]review$",
		"^%[SponsorBlock%]",
	},

}

on = true

function check_chapter(_, chapter)
	if not on or not chapter then return end

    	for _, p in pairs(opts.patterns) do
        	if string.match(chapter, p) then
            		if opts.silent then
				print("skipping chapter:", chapter)
			else
            			mp.osd_message("[auto-skip] skipping chapter: " ..chapter)
			end

            		mp.command("no-osd add chapter 1")
            		return
        	end
    	end
end

function toggle()
	if on then
		mp.unobserve_property(check_chapter)
		mp.osd_message("[auto-skip] off")
		on = false
		return
    	end

	mp.observe_property("chapter-metadata/by-key/title", "string", check_chapter)
    	mp.osd_message("[auto-skip] on")
    	on = true
end

mp.observe_property("chapter-metadata/by-key/title", "string", check_chapter)
mp.add_key_binding("F2", "auto-skip", toggle)
