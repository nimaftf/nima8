--[[function kick_user(user_id, chat_id)
if not tonumber(user_id) then
return false
end
  tg.changeChatMemberStatus(chat_id, user_id, 'Kicked', dl_cb1, nil)
end]]

--[[function kick_user(user_id, chat_id)
if not tonumber(user_id) then
return false
end 
tg.changeChatMemberStatus(chat_id, user_id, 'Kicked')
end]]

local function pre_process(msg)
	if not is_momod(msg) or not is_owner(msg) then 
	function del_bots(arg, data)
		if data.username_ then
			if string.sub(data.username_:lower(), -3) == 'bot' then
				--kick_user(data.id_, arg.chat_id)
				tg.deleteMessages(msg.chat_id_, {[0] = msg.id_ })	
				--chat_del_user(msg.chat_id_, msg.sender_user_id_) 
			end
		end
		end
	end
	
	local is_bot_msg = msg.text:match("!!!tdservice:")
	if is_bot_msg then
		local group = load_data('bot/group.json')
		local lock_bots = group[tostring(msg.chat_id_)]["settings"]["lock_bot"] 
		if lock_bots == 'yes' then
			tdcli_function ({
			ID = "GetUser",
			user_id_ = is_bot_msg 
			}, del_bots, {chat_id=msg.chat_id_})
		end
	end	
	
    --[[if msg.content_.text_ then
		 local group = load_data('bot/group.json')
		 local lock_bots = group[tostring(msg.chat_id_)]["settings"]["lock_bots"] 
		 if lock_bots == 'yes' then
			 tdcli_function ({
			 ID = "GetUser",
			 user_id_ = msg.sender_user_id_
			 }, del_bots, {chat_id=msg.chat_id_})
		 end
	    end]]	
end

return { 
patterns = {},
 pre_process = pre_process
}
