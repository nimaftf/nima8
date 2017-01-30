local function run(msg, matches)
local group = load_data('bot/group.json')	
local addgroup = group[tostring(msg.chat_id)]
--[[if matches[1] == 'clean' and matches[2] == 'link' then
redis:get('link'..msg.chat_id_) = nil
tg.sendMessage(msg.chat_id_, 0, 1, '<b>Link Deleted</b>' , 1, 'html')
end      ]]
--[[local linkk = 'https://'..matches[2]  
if matches[1] == 'setlink' and is_owner(msg) or is_momod(msg) and addgroup then

redis:set('link'..msg.chat_id_,linkk)    
tg.sendMessage(msg.chat_id_, 0, 1, '<b>Group Link Saved</b>', 1, 'html')
end    ]]
--redis:set('link'..msg.chat_id_,'waiting')
--save_data(_config.group.data, group)
if matches[1] == 'setlink' and is_owner(msg) or is_momod(msg) and addgroup then  
--if msg.content_.text_ then
local is_links = msg.text:match("[Hh][Tt][Tt][Pp][Ss].//[Tt][Ee][Ll][Ee][Gg][Rr][Aa][Mm].[Mm][Ee]/") or msg.text:match("[Hh][Tt][Tt][Pp].//[Tt][Ee][Ll][Ee][Gg][Rr][Aa][Mm].[Mm][Ee]/") or msg.text:match("[Hh][Tt][Tt][Pp][Ss].//[Tt].[Mm][Ee]/") or msg.text:match("[Hh][Tt][Tt][Pp].//[Tt].[Mm][Ee]/")
if matches[2] == is_links --[[and redis:set('link'..msg.chat_id_,'waiting')]] then
redis:set('link'..msg.chat_id_, matches[2] )
save_data(_config.group.data, group)
tg.sendMessage(msg.chat_id_, 0, 1, '<b>Group Link Saved</b>', 1, 'html')
else
redis:set('link'..msg.chat_id_, nil )
save_data(_config.group.data, group)
tg.sendMessage(msg.chat_id_, 0, 1, '<b>Not link</b>', 1, 'html')
end
--end
end    
end
return {
  patterns = {
"^[/#!](setlink) [Hh]ttp(.*)$",
--"^[#!/](setlink) https://telegram.me/joinchat/(.*)$",
--"^[#!/](setlink) https://t.me/joinchat/(.*)$",    
--"^[/#!](clean) (.*)$",            
--"^([https?://w]*.?t.me/joinchat/%S+)$",
--"^([https?://w]*.?telegram.me/joinchat/%S+)$",
 },
  run = run
}
