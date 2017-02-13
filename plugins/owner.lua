local function run(msg, matches)
	if not msg.chat_id_ and redis:get('setowneruser2') then
		msg.chat_id_ = redis:get('setowneruser2')
	end
	local group = load_data('bot/group.json')
	local addgroup = group[tostring(msg.chat_id_)]
	local setowner = redis:get('setowner'..msg.chat_id_) 
	if addgroup then
		if matches[1] == 'owner' then
			pm = group[tostring(msg.chat_id_)]['set_owner']
			tg.sendMessage(msg.chat_id_, 0, 1,'<b>owner:</b>[ '..pm..' ]', 1, 'html')
		end
		if setowner then
			group[tostring(msg.chat_id_)]['set_owner'] = tostring(msg.from_id)
			save_data(_config.group.data, group)
			tg.sendMessage(msg.chat_id, 0, 0,  '[ '..msg.from_id..' ] <b>added as owner</b>', 0)
			redis:del('setowner'..msg.chat_id_ ,true)
		end
		if matches[1] == 'setowner' and is_owner(msg) then
			if msg.reply_to_message_id_ ~= 0 then
				tg.getMessage(msg.chat_id_,msg.reply_to_message_id_)
				redis:set('setowner'..msg.chat_id_,msg.from_id)
				redis:set('message:tg','setowner')
			elseif msg.text:match("@(.*)") then
				redis:set('setowneruser'..msg.chat_id_,'yes')
				redis:set('setowneruser2',msg.chat_id_)
				redis:set('message:tg','setowner')
				tg.searchPublicChat(matches[2])
			elseif tonumber(matches[2]) then
				group[tostring(msg.chat_id_)]['set_owner'] = matches[2]
				save_data(_config.group.data, group)
				tg.sendMessage(msg.chat_id, 0, 0,  '[ '..matches[2]..' ] <b>added as owner</b>', 0)
			end
		end
		if matches[1] == 'ownerset2' then	
			if redis:get('setowneruser'..msg.chat_id_) then
				redis:del('setowneruser'..msg.chat_id_,true)
				redis:del('setowneruser2',true)
				local user_id = msg.from_id
				group[tostring(msg.chat_id_)]['set_owner'] = user_id
				save_data(_config.group.data, group)
				tg.sendMessage(msg.chat_id_, 0, 1,'[ '..msg.from_id..' ] <b>added as owner</b>', 1, 'html')
			end
		end
	end
end
return {
	patterns = {
		"^[#!/](setowner)$",
		"^[#!/](owner)$",
		"^[#!/](setowner) (.*)$",	
		"^(ownerset)$",
		"^!!(ownerset2)!!$",
	},
	run = run
}
