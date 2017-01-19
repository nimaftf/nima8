local function modlist(msg)
     local i = 1

  local message = '<b>List of moderators :</b> \n'
  for k,v in pairs(group[tostring(msg.chat_id_)]['moderators']) do
    message = message ..i.. '- '..v..' [' ..k.. '] \n'
   i = i + 1
end
  tg.sendMessage(msg.chat_id_, 0, 1, message , 1, 'html') 
end
local function run(msg, matches)
local group = load_data('bot/group.json')
local addgroup = group[tostring(msg.chat_id_)]
if addgroup then
if matches[1] == 'modlist' then               
return modlist(msg)
end
end               
end
return {
 patterns = {
"^[#!/](modlist)$",
},
 run = run
}
