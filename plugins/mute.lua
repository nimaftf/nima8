local function run(msg, matches)
if not msg.chat_id_ and redis:get('muteuser2') then
msg.chat_id_ = redis:get('muteuser2')
end
local group = load_data('bot/group.json')
local addgroup = group[tostring(msg.chat_id_)]
local muteuser = redis:get('muteuser'..msg.chat_id_..msg.chat_id_)
if addgroup then
if muteuser then
redis:del('muteuser'..msg.chat_id_..msg.chat_id_ ,true)
local user_id = msg.from_id
if is_muted_user(msg.chat_id_, user_id) then   
unmute_user(msg.chat_id_, user_id)
tg.sendMessage(msg.chat_id_, 0, 1,"[ "..user_id.." ] <b>removed from the muted users list</b>", 1, 'html')
else 
mute_user(msg.chat_id_, user_id)
tg.sendMessage(msg.chat_id_, 0, 1,'[ '..user_id..' ] <b>added to the muted user list</b>', 1, 'html')  
end
end
if matches[1] == 'ownerset2' then
if redis:get('muteuser'..msg.chat_id_) then  
redis:del('muteuser'..msg.chat_id_,true)

redis:del('muteuser2',true)  
local user_id = msg.from_id
tg.sendMessage(msg.chat_id_, 0, 1,"[ "..user_id.." ] <b>removed from the muted users list</b>", 1, 'html') 
else 
mute_user(msg.chat_id_, user_id)
tg.sendMessage(msg.chat_id_, 0, 1,'[ '..user_id..' ] <b>added to the muted user list</b>', 1, 'html')  
end 
end
end
if matches[1] == 'muteuser' and is_momod(msg) then
if msg.reply_to_message_id_ ~= 0 then
tg.getMessage(msg.chat_id_,msg.reply_to_message_id_)
redis:set('muteuser'..msg.chat_id_..msg.chat_id_,msg.from_id)  
redis:set('message:tg','setowner')
elseif msg.text:match("@(.*)") then  
redis:set('muteuser'..msg.chat_id_,'yes')
redis:set('muteuser2',msg.chat_id_)  
redis:set('message:tg','setowner')
tg.searchPublicChat(matches[2]) 
elseif tonumber(matches[2]) then  
local user_id = matches[2]
if is_muted_user(msg.chat_id_, user_id) then   
unmute_user(msg.chat_id_, user_id)
tg.sendMessage(msg.chat_id_, 0, 1,"[ "..user_id.." ] <b>removed from the muted users list</b>", 1, 'html') 
else
mute_user(msg.chat_id_, user_id)
tg.sendMessage(msg.chat_id_, 0, 1,'[ '..user_id..' ] <b>added to the muted user list</b>', 1, 'html')  
end 
end 
end
end
return {
 patterns = {
"^[#!/](muteuser)$", 
"^[#!/](muteuser) (.+)$",
"^[#!/](muteuser) (.*)$",
--"^(ownerset)$",
"^!!(ownerset2)!!$",
},
 run = run
}
