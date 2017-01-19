local function run(msg, matches)
local group = load_data('bot/group.json')	
local addgroup = group[tostring(msg.chat_id)]
if matches[1] == 'setlink' and is_owner(msg) or is_momod(msg) and addgroup then
if msg.content_.text_ then
local is_link = msg.content_.text_:match("^([https?://w]*.?telegram.me/joinchat/%S+)$") or msg.content_.text_:match("^([https?://w]*.?t.me/joinchat/%S+)$")    
matches[2] = is_link
redis:set('link'..msg.chat_id_,matches[2])
tg.sendMessage(msg.chat_id_, 0, 1, '<b>Group Link Saved</b>', 1, 'html')
end	
end    
end
return {
  patterns = {
"^[/#!](setlink) (.*)$",
"^([https?://w]*.?t.me/joinchat/%S+)$",
"^([https?://w]*.?telegram.me/joinchat/%S+)$",
 },
  run = run
}
