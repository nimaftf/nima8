local function run(msg, matches)
local group = load_data('bot/group.json')
local addgroup = group[tostring(msg.chat_id)]

	if matches[1] == 'leave' and is_sudo(msg) and addgroup or not addgroup then
	     chat_leave(msg.chat_id_, 288058778)
    end
end	
return {
  patterns = {
   
	"^[/#!](leave)$",
  },
  run = run
}
