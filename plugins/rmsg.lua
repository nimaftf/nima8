local function delmsg (arg,data)
    for k,v in pairs(data.messages_) do
        tg.deleteMessages(v.chat_id_,{[0] = v.id_}, dl_cb, cmd)
    end
end
local function run(msg, matches)
    local chat_id = msg.chat_id_
    local msg_id = msg.id_
    if matches[1] == 'rmsg' then
    local group = load_data('bot/group.json')
    local addgroup = group[tostring(msg.chat_id)]
        if addgroup and is_owner(msg) and momod(msg) then 
                if tonumber(matches[2]) > 40 or tonumber(matches[2]) < 1 then
                    pm = '<b>More than</b> <code>1</code> <b>and less than</b> <code>40</code>'
                    tg.sendMessage(msg.chat_id_, 0, 1, pm, 1, 'html') 
                else
                    tg.getChatHistory(chat_id, msg_id, 0, tonumber(matches[2]), delmsg, nil)
                    pm ='<b>Message Has Been Removed</b>'
                    tg.sendMessage(msg.chat_id_, 0, 1, pm, 1, 'html')
                end
        end
    end
end

return {
    patterns = {
        '^[!#/]([Rr]msg) (%d*)$',
    },
    run = run
}
