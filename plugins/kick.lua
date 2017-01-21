local function run(msg, matches)
  if matches[1] == 'kick' and is_momod(msg) then
    if msg.reply_to_message_id_ then
      tg.changeChatMemberStatus(msg.chat_id_, msg.reply_to_message_id_, 'Kicked') 
      tg.sendMessage(msg.chat_id_, 0, 0, 1, nil, '<b>User Kicked!</b>', 1, 'html')
    end
  end
  if matches[1] == 'kick' and is_momod(msg) then
    tg.changeChatMemberStatus(msg.chat_id_, matches[2] , 'Kicked') 
    tg.sendMessage(msg.chat_id_, 0, 0, 1, nil, '<b>User '..matches[2]..' Kicked!</b>', 1, 'html')
  end
  if matches[1] == 'ban' and is_momod(msg) then
    if msg.reply_to_message_id_ then
      tg.changeChatMemberStatus(msg.chat_id_, msg.reply_to_message_id_, 'Banned') 
      tg.sendMessage(msg.chat_id_, 0, 0, 1, nil, '<b>User Banned!</b>', 1, 'html')
    end
  end
  if matches[1] == 'ban' and is_momod(msg) then
    tg.changeChatMemberStatus(msg.chat_id_, matches[2] , 'Banned') 
    tg.sendMessage(msg.chat_id_, 0, 0, 1, nil, '<b>User '..matches[2]..' Banned!</b>', 1, 'html')
  end


  if matches[1] == 'invite' and is_sudo(msg) then
    tg.addChatMember(msg.chat_id_, matches[2])
  end
end
return {
  pattern = {
    "^[/#!](kick)$",
    "^[/#!](kick) (.*)$",
    "^[/#!](ban)$",
    "^[/#!](ban) (.*)$",
    
    
    "^[/#!](invite) (.*)$",
    },
  run = run,
}
