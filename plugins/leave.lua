function chat_leave (chat_id,user_id)
   changeChatMemberStatus(chat_id, user_id, "Left")
end
local function run(msg, matches)
local group = load_data('bot/group.json')
local addgroup = group[tostring(msg.chat_id)]
bot_id = 288058778
	if matches[1] == 'leave' and is_sudo(msg) and addgroup or not addgroup then
	     chat_leave(msg.chat_id_, bot_id)
    end
end	
return {
  patterns = {
   
	"^[/#!](leave)$",
  },
  run = run
}
