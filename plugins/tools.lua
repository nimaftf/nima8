local function run(msg, matches)
local group = load_data('bot/group.json')	
local addgroup = group[tostring(msg.chat_id)]	
if matches[1] == 'echo' and matches[2] and is_sudo(msg) then		
pm = matches[2]
tg.sendMessage(msg.chat_id_, 0, 1, pm, 1, 'html')
end	
if matches[1] == 'git pull' and is_sudo(msg) then
  io.popen("git pull")
  tg.sendMessage(msg.chat_id_, 0, 1, '✅✅✅git pull✅✅✅', 1, 'md')
end	


if matches[1] == 'ids' and addgroup and is_owner(msg) or is_momod(msg) then
if msg.reply_to_message_id_ ~= 0 then
tg.getMessage(msg.chat_id_,msg.reply_to_message_id_)
tg.sendMessage(msg.chat_id_, 0, 1,'<b>ID: </b>[ '..msg.sender_user_id_..' ]', 1, 'html')
end
		
end
--[[if text_msg == "del" and msg.msg.reply_to_message_id_ ~= 0 and addgroup and is_owner(msg) or is_momod(msg)  then
deleteMessages(msg.chat_id_, {[0] = msg.id_,msg.reply_to_message_id_})	
end
	
if matches[1] == 'invite' and is_sudo(msg) then
tg.addChatMember(msg.chat_id_, string.sub(input, 9), 20)
end]]	
if matches[1] == 'setrules' and is_owner(msg) or is_momod(msg) and addgroup then
text = matches[2]
pmm = text 
tg.sendMessage(msg.chat_id_, 0, 1, '<b>Rules supergroup </b>[ <code>'..msg.chat_id_..'</code> ]<b> saved</b>' , 1, 'html')
elseif matches[1] == 'rules' and is_owner(msg) or is_momod(msg) and addgroup then
--if pmm == nil then
--tg.sendMessage(msg.chat_id_, 0, 1, '<b>rules not exist</b>' , 1, 'html')
--else
tg.sendMessage(msg.chat_id_, 0, 1,'<b>Rules supergroup </b>[ <code>'..msg.chat_id_..'</code> ]: \n'..pmm, 1, 'html')
--end
end	
	
end	
	
return {
  patterns = {
		"^[/#!](git pull)$",
		"^[/#!](echo) (.*)$",
		--"^[/#!](invite)$",
		"^[/#!](rules)$",
		"^[/#!](setrules) (.*)$",	
		--"^[/#!](del)$",
		"^[/#!](ids)$",
  },
  run = run
}
