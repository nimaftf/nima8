local function rmmsg (arg,data)
for k,v in pairs(data.messages_) do
tg.deleteMessages(v.chat_id_,{[0] = v.id_})
end
end
local function run(msg, matches)
local group = load_data('bot/group.json')
local addgroup = group[tostring(msg.chat_id)]
    if matches[1] == 'rmsg' then
    --if msg.chat_id_:match("^-40") then
       if is_sudo(msg) or is_owner(msg) and addgroup then
          if tonumber(matches[2]) > 40 or tonumber(matches[2]) < 1 then
             pm = '<b>More than</b> <code>1</code> <b>and less than</b> <code>40</code>'
             --tg.sendMessage(msg.chat_id_, msg.id_, 1, pm, 1, 'html')
             tg.sendMessage(msg.chat_id_, 0, 1, pm, 1, 'html')
             else
          tdcli_function ({
    ID = "GetChatHistory",
    chat_id_ = msg.chat_id_,
    from_message_id_ = 0,
    offset_ = 0,
    limit_ = tonumber(matches[2]) - 1
  }, rmmsg, nil)
              local id1 = msg.id_ - 1
        for i= id1 - matches[2] , id1 do
		local w = i -1			
		tg.deleteMessages(msg.chat_id_, {[0] = w })  
	end				
             --pm ='<code>'..matches[2]..'</code> <b>Last Msgs Has Been Removed</b>'
             pm ='<b>Message Has Been Removed</b>'   
             --tg.sendMessage(msg.chat_id_, msg.id_, 1, pm, 1, 'html')
             tg.sendMessage(msg.chat_id_, 0, 1, pm, 1, 'html')
         end
     end
--end
end
end

return {
    patterns = {
        '^[!#/]([Rr]msg) (%d+)$'
        --'^[!#/]([Rr]msg)$'
    },
    run = run
}
