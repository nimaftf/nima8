local function run(msg, matches)
local group = load_data('bot/group.json')	
local addgroup = group[tostring(msg.chat_id)]
if matches[1] == 'clean' and matches[2] == 'link' then
redis:set('link'..msg.chat_id_,nil) 
tg.sendMessage(msg.chat_id_, 0, 1, '<b>Link Deleted</b>' , 1, 'html')
end      
if matches[1] == 'setlink' and is_owner(msg) or is_momod(msg) and addgroup then
--local is_link = msg.text:match("^([https?://w]*.?telegram.me/joinchat/%S+)$") or msg.text.match("^([https?://w]*.?t.me/joinchat/%S+)$")   
--matches[2] = is_link
redis:set('link'..msg.chat_id_,'https://telegram.me/joinchat/'..matches[2] or 'https://t.me/joinchat/'..matches[2])
--if matches[2] then
tg.sendMessage(msg.chat_id_, 0, 1, '<b>Group Link Saved</b>', 1, 'html')
else                        
--if matches[2] == not is_link then
tg.sendMessage(msg.chat_id_, 0, 1, '<b>Not Link</b>', 1, 'html')
--end	
--end      
end    
end
return {
  patterns = {
--"^[/#!](setlink) (.*)$",
"^[#!/](setlink) https://telegram.me/joinchat/(.*)$",
"^[#!/](setlink) https://t.me/joinchat/(.*)$",    
"^[/#!](clean) (.*)$",            
--"^([https?://w]*.?t.me/joinchat/%S+)$",
--"^([https?://w]*.?telegram.me/joinchat/%S+)$",
 },
  run = run
}
