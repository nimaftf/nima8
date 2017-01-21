local function run(msg, matches)
local group = load_data('bot/group.json')	
local addgroup = group[tostring(msg.chat_id)]	
if addgroup then
		
if matches[1] == 'link' and is_owner(msg) or is_momod(msg) then
link1 = redis:get('link'..msg.chat_id_)
if not link1 then 
tg.sendMessage(msg.chat_id_, 0, 1, '<b>please First set a link for group with using ~></b> /setlink link \n<b>Instead <code>\'link\'</code>, Put your link group</b>' , 1, 'html')
else
tg.sendMessage(msg.chat_id_, 0, 1, '<b>Group Link :</b>\n'..link1 , 1, 'html')
end 
end

end
end
return {
  patterns = {
		"^[/#!](link)$",
 },
  run = run
}
