local function run(msg, matches)
local group = load_data('bot/group.json')
local addgroup = group[tostring(msg.chat_id)]
  	if matches[1] == 'rmsg' --[[and is_momod(msg.sender_user_id_, msg.chat_id_)]] and addgroup and is_owner(msg) or is_momod(msg) then
--       local delnumb = {string.match(text, "^[#/!](del) (%d+)$")} 
	   if tonumber(matches[2]) > 40 then
--			send(msg.chat_id_, msg.id_, 1, 'Error\nuse /del [1-40]', 1, 'md')
            pm = '<b>More than</b> <code>1</code> <b>and less than</b> <code>40</code>'
			tg.sendMessage(msg.chat_id_, 0, 1, pm , 1, 'html')
else
       local id = msg.id_ - 1
        for i= id - matches[2] , id do 
--        delete_msg(msg.chat_id_,{[0] = i})
		tg.deleteMessages(msg.chat_id_, {[0] = i })
        end
			tg.sendMessage(msg.chat_id_, msg.id_, 1, '<code>'..matches[2]..'</code> <b>Last Msgs Has Been Removed</b>', 1, 'html')
--			tg.sendMessage(msg.chat_id_, 0, 1, matches[2]..' Last Msgs Has Been Removed.' , 1, 'html')
    end
	end
	if matches[1] == 'leave' and is_sudo(msg) and addgroup or not addgroup then
	     chat_leave(msg.chat_id_, robot)
    end
end	
return {
  patterns = {
    "^[/#!](rmsg) (%d*)$",
	"^[/#!](leave)$",
  },
  run = run
}
