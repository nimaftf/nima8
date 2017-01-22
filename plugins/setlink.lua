local function run(msg, matches)
local group = load_data('bot/group.json')	
local addgroup = group[tostring(msg.chat_id)]
if matches[1] == 'clean' and matches[2] == 'link' then
redis:get('link'..msg.chat_id_) = nil
tg.sendMessage(msg.chat_id_, 0, 1, '<b>Link Deleted</b>' , 1, 'html')
end      
if matches[1] == 'setlink' and is_owner(msg) or is_momod(msg) and addgroup then
redis:set('link'..msg.chat_id_,'https://'..matches[2])
tg.sendMessage(msg.chat_id_, 0, 1, '<b>Group Link Saved</b>', 1, 'html')
end    
--[[local is_links = 'https://'..matches[2]  
if matches[2] == not is_links then
tg.sendMessage(msg.chat_id_, 0, 1, '<b>Not Link</b>', 1, 'html')
end]]    
end
return {
  patterns = {
"^[/#!](setlink) https://(.*)$",
--"^[#!/](setlink) https://telegram.me/joinchat/(.*)$",
--"^[#!/](setlink) https://t.me/joinchat/(.*)$",    
"^[/#!](clean) (.*)$",            
--"^([https?://w]*.?t.me/joinchat/%S+)$",
--"^([https?://w]*.?telegram.me/joinchat/%S+)$",
 },
  run = run
}
