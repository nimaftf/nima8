local function run(msg, matches)
local addgroup = group[tostring(msg.chat_id)]
if addgroup and is_momod(msg) or is_owner(msg) then
     local group = load_data('bot/group.json')
   local chat = msg.chat_id_
   local user = msg.sender_user_id_

--------------------- Welcome -----------------------
	if matches[1] == "welcome" and is_momod(msg) or is_owner(msg) then
		if matches[2] == "on" then
			welcome = group[tostring(chat)]['settings']['welcome']
			if welcome == "yes" then
               pm = "*Group welcome is already enabled*"
			   tg.sendMessage(msg.chat_id_, 0, 1, pm, 1, 'md')
			else
		group[tostring(chat)]['settings']['welcome'] = "yes"
	    save_data(_config.group.data, group)
                pm1 = "*Group welcome has been enabled*"
                tg.sendMessage(msg.chat_id_, 0, 1, pm1, 1, 'md')
            end
		end
		
		if matches[2] == "off" then
			welcome = group[tostring(chat)]['settings']['welcome']
			if welcome == "no" then
                pm2 = "*Group Welcome is already disabled*"
                tg.sendMessage(msg.chat_id_, 0, 1, pm2, 1, 'md')
            else
		group[tostring(chat)]['settings']['welcome'] = "no"
	    save_data(_config.group.data, group)
                pm3 = "*Group welcome has been disabled*"
                tg.sendMessage(msg.chat_id_, 0, 1, pm3, 1, 'md')
			end
		end
	end
	if matches[1] == "setwelcome" and matches[2] and is_momod(msg) or is_owner(msg) then
		group[tostring(chat)]['setwelcome'] = matches[2]
	    save_data(_config.group.data, group)
        pm4 = "Welcome Message Has Been Set To :_\n*"..matches[2].."\n\n`{name}` ➣ *New Member First Name*\n`{username}` ➣ *New Member Username*"
        tg.sendMessage(msg.chat_id_, 0, 1, pm4, 1, 'md')
	end
end
end
-----------------------------------------------------
local function pre_process(msg)
   local chat = msg.chat_id_
   local user = msg.sender_user_id_
 local group = load_data('bot/group.json')
	local function welcome_cb(arg, data)
	    group = load_data('bot/group.json')
    if group[arg.chat_id]['setwelcome'] then
     welcome = group[arg.chat_id]['setwelcome']
	 tg.sendMessage(msg.chat_id_, 0, 1, welcome, 1, 'md')
    else
     welcome = "*Welcome {name}*"
	 tg.sendMessage(msg.chat_id_, 0, 1, welcome, 1, 'md')
    end

if data.username_ then
user_name = "@"..check_markdown(data.username_)
else
user_name = ""
end
		--local welcome = welcome:gsub("{rules}", rules)
		local welcome = welcome:gsub("{name}", check_markdown(data.first_name_))
		local welcome = welcome:gsub("{username}", user_name)
		tg.sendMessage(arg.chat_id, arg.msg_id, 0, welcome, 0, "md")
	end
	local addgroup = group[tostring(msg.chat_id)]
	if addgroup and group[tostring(chat)]['settings'] then
	local is_add_user = msg.text:match("!!!tdservice:")
	if is_add_user then
		welcome = group[tostring(msg.chat_id_)]['settings']['welcome']
		if welcome == "yes" then
			tdcli_function ({
	      ID = "GetUser",
      	user_id_ = is_add_user
    	}, welcome_cb, {chat_id=chat,msg_id=msg.id_})
		else
			return false
		end
	end
	local is_join_by_link = msg.text:match("!!!tddservice:")
	if is_join_by_link then
		welcome = group[tostring(msg.chat_id_)]['settings']['welcome']
		if welcome == "yes" then
			tdcli_function ({
	      ID = "GetUser",
      	user_id_ = is_join_by_link
    	}, welcome_cb, {chat_id=chat,msg_id=msg.id_})
		else
			return false
        end
		end
	end
 end
return {
patterns ={
"^[!/#]([Ss]etwelcome) (.*)",
"^[!/#]([Ww]elcome) (.*)$"

},
run=run,
pre_process = pre_process
}


pm = '<b>SuperGroup settings</b>\n-------------------------------------------'
pm = pm..'\n1- <code>Lock Links</code> : '..group[tostring(target)]['settings']['lock_link']..''
pm = pm..'\n2- <code>Lock Username</code> : '..group[tostring(target)]['settings']['lock_username']..''
pm = pm..'\n3- <code>Lock Tag</code> : '..group[tostring(target)]['settings']['lock_tag']..''
pm = pm..'\n4- <code>Lock Edit</code> : '..group[tostring(target)]['settings']['lock_edit']..''
pm = pm..'\n5- <code>Lock Fwd</code> : '..group[tostring(target)]['settings']['lock_fwd']..''
--pm = pm..'\n5- <code>Lock Flood</code> : '..group[tostring(target)]['settings']['lock_flood']..''
pm = pm..'\n6- <code>Lock Fosh</code> : '..group[tostring(target)]['settings']['lock_fosh']..''
pm = pm..'\n7- <code>Lock Tgservice</code> : '..group[tostring(target)]['settings']['lock_tgservice']..''
pm = pm..'\n8- <code>Lock Sticker</code> : '..group[tostring(target)]['settings']['lock_sticker']..''
pm = pm..'\n- <code>Lock Contact</code> : '..group[tostring(target)]['settings']['lock_contact']..''
pm = pm..'\n- <code>Lock Location</code> : '..group[tostring(target)]['settings']['lock_location']..''
pm = pm..'\n- <code>Lock Game</code> : '..group[tostring(target)]['settings']['lock_game']..''
pm = pm..'\n12- <code>Lock Bot</code> : '..group[tostring(target)]['settings']['lock_bot']..''
pm = pm..'\n13- <code>Lock Inline</code> : '..group[tostring(target)]['settings']['lock_inline']..''
pm = pm..'\n14- <code>Lock Spam</code> : '..group[tostring(target)]['settings']['lock_spam']..''
pm = pm..'\n15- <code>Lock English</code> : '..group[tostring(target)]['settings']['lock_english']..''
pm = pm..'\n16- <code>Lock Arabic</code> : '..group[tostring(target)]['settings']['lock_persian']..''
--pm = pm..'\n     ًں”§<b>Mute</b>ًں”§'
pm = pm..'\n17- <code>Lock Gifs</code> : '..group[tostring(target)]['settings']['mute_gif']..''
pm = pm..'\n18- <code>Lock Photo</code> : '..group[tostring(target)]['settings']['mute_photo']..''
pm = pm..'\n19- <code>Lock Video</code> : '..group[tostring(target)]['settings']['mute_video']..''
pm = pm..'\n20- <code>Lock Voice</code> : '..group[tostring(target)]['settings']['mute_voice']..''
pm = pm..'\n21- <code>Lock Document</code> : '..group[tostring(target)]['settings']['mute_document']..''
pm = pm..'\n22- <code>Lock Audio</code> : '..group[tostring(target)]['settings']['mute_audio']..'\n-------------------------------------------'
pm = pm..'\n23- <code>Mute All</code> : '..group[tostring(target)]['settings']['mute_all']..''
pm = pm..'\n24- <code>Welcome</code> : '..group[tostring(chat)]['settings']['welcome']..''


