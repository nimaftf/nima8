local function run(msg, matches)
local group = load_data('bot/group.json')	
local addgroup = group[tostring(msg.chat_id)]	
if addgroup then
		
if matches[1] == 'link' and is_owner(msg) or is_momod(msg) then
link1 = redis:get('link'..msg.chat_id_)
tg.sendMessage(msg.chat_id_, 0, 1, '<b>Group Link :</b>\n'..link1 , 1, 'html')
end
if matches[1] == 'rules' and is_owner(msg) or is_momod(msg) then
rules1 = redis:get('rules'..msg.chat_id_)
tg.sendMessage(msg.chat_id_, 0, 1, '<b>Group Rules :</b>\n'..rules1 , 1, 'html')
end		
end
end
return {
  patterns = {
		"^[/#!](rules)$",
		"^[/#!](link)$",
 },
  run = run
}
