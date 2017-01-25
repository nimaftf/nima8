do

function run(msg, matches)
    if matches[1] == 'linkpv' and is_sudo(msg) or is_owner(msg) then   
    local group = load_data('bot/group.json')
      local linkgp = redis:get('link'..msg.chat_id_)
       if not linkgp then 
        pm = '<b>Link Group is not set</>'
        tg.sendMessage(msg.chat_id_, 0, 1, pm , 1, 'html')
       end
          local text = "<b>Group Link :</b>\n"..linkgp
		   tdcli.sendMessage(msg.sender_user_id_, 0, 1, text, 1, 'html')
           pm1 = '<b>Link Group has been Sent in PV ✅</b>'
           tg.sendMessage(msg.chat_id_, 0, 1, pm1 , 1, 'html')
end
end
return {
  patterns = {
    "^[/#!]([Ll]inkpv)$",
      },
  run = run
}

end
