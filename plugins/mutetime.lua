local function pre_process(msg)
  local group = load_data('bot/group.json')
  local addgroup = group[tostring(msg.chat_id)]
  local hash = 'mute_time:'..msg.chat_id_
  if redis:get(hash) and addgroup and not is_owner(msg) or not is_momod(msg) then
    tg.deleteMessages(msg.chat_id_, {[0] = tonumber(msg.id_)})
  end
 end
 
local function run(msg, matches)
  local group = load_data('bot/group.json')
  local addgroup = group[tostring(msg.chat_id)]
  if addgroup then
  if matches[1]:lower() == 'mute' and is_owner(msg) or is_momod(msg) then
     local hash = 'mute_time:'..msg.chat_id_
     if matches[2] then
     local hour = string.gsub(matches[2], 'h', '')
     local num1 = tonumber(hour) * 3600
     local minutes = string.gsub(matches[3], 'm', '')
     local num2 = tonumber(minutes) * 60
     local num4 = tonumber(num1 + num2)
	 redis:setex(hash, num4, true)
     pm = '<b>Group to time: \nHorse: [</b><code>'..matches[2]..'</code><b>]\nMinute: [</b><code>'..matches[3]..'</code><b>]\nclosed</b>'
    tg.sendMessage(msg.chat_id_, 0, 1, pm, 1, 'html')
	end
  end
  if matches[1]:lower() == 'unmute' and is_owner(msg) or is_momod(msg) then
     local hash = 'mute_time:'..msg.chat_id_
     redis:del(hash)
     pm1 '<b>Group has been successfully from mute exited</b>'
	 tg.sendMessage(msg.chat_id_, 0, 1, pm1, 1, 'html')
  end
  end
end
return {
   patterns = {
      '^[/!#]([Uu]nmute)$',
	  '^[/!#]([Mm]ute) (%d+) (%d+)$',
 },
  run = run,
  pre_process = pre_process
}
