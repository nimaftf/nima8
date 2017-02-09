local function run(msg, matches)
local addgroup = group[tostring(msg.chat_id)]
if addgroup and not is_owner(msg) or not is_momod(msg) then
if is_momod(msg) or is_robot(msg) then
return false
else
local group = load_data('bot/group.json')
local group_fwd_lock = group[tostring(msg.chat_id)]['settings']['lock_fwd']
if group_fwd_lock == 'yes' and msg.forward_info_ then
tg.deleteMessages(msg.chat_id_, {[0] = msg.id_ })
end
local group_welcome = group[tostring(msg.chat_id)]['settings']['welcome']
local set_welcome = group[msg.chat_id_)]['setwelcome'] 
local is_add_user = msg.text:match("!!!tdservice:")
local is_join_by_link = msg.text:match("!!!tddservice:") 
if group_welcome == 'yes' and is_add_user or is_join_by_link then
if group[msg.chat_id_)]['setwelcome'] then
tg.sendMessage(msg.chat_id_, 0, 1, set_welcome , 1, 'md')
else
textt = "*Welcome {name}*"
tg.sendMessage(msg.chat_id_, 0, 1, textt, 1, 'md')
end 
end      
end
end
end
return {
  patterns = {
    "^(.*)$",
  },
  run = run
}
