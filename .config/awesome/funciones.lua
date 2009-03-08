function dbg(cadena)
	naughty.notify({text = cadena , timeout = 3})
end

keybinding({ modkey }, "Menu", function() 
	local allclients = client.get()
	local screen = mouse.screen
	local tag = awful.tag.selected()
	local clientExist =0
	for i,v in ipairs(allclients) do
		 local ctags = v:tags()
		 if v.instance == "movil" then
				if tag == ctags[1] then
					  awful.client.movetotag(tags[screen][1],v)
						v.floating = false 
				else
					awful.client.movetotag(tag,v)
					v.floating = true
					client.focus=v
				end
				clientExist = 1
		 end
	end	
	if clientExist == 0 then
		 awful.util.spawn("xterm -g 144x20 -name movil -e screen")
--		 if  not tags[mouse.screen][1].selected   then
--				for i,v in ipairs(allclients) do
--					 if v.instance == "movil" then
--							v.floating = true
--							client.focus = v
--					 end 
--				end
--		 end
	end 
end):add()
