local function filter_word(msg, word)
	local group = load_data('bot/group.json')
	if not group[tostring(msg.chat_id_)]['filterlist'] then
		group[tostring(msg.chat_id_)]['filterlist'] = {}
		save_data(_config.group.data, group)
    end
	if group[tostring(msg.chat_id_)]['filterlist'][(word)] then
		tg.sendMessage(msg.chat_id_, 0, 1, '*Word [* '..word..' *] is already filtered*\n*Channel:* @LeaderCh', 1, 'md')
	--end
	else
	group[tostring(msg.chat_id_)]['filterlist'][(word)] = true
	save_data(_config.group.data, group)
	tg.sendMessage(msg.chat_id_, 0, 1, '*Word [* '..word..' *] added to filtered words list*\n*Channel:* @LeaderCh', 1, 'md')
	end
end

local function unfilter_word(msg, word)
	local group = load_data('bot/group.json')
	if not data[tostring(msg.chat_id_)]['filterlist'] then
		group[tostring(msg.chat_id_)]['filterlist'] = {}
		save_data(_config.group.data, group)
    end
    if group[tostring(msg.chat_id_)]['filterlist'][word] then
		group[tostring(msg.chat_id_)]['filterlist'][(word)] = nil
		save_data(_config.group.data, group)
		tg.sendMessage(msg.chat_id_, 0, 1, '*Word [* '..word..' *] removed from filtered words list*\n*Channel:* @LeaderCh', 1, 'md')
	else
		tg.sendMessage(msg.chat_id_, 0, 1, '*Word [* '..word..' *] is not filtered*\n*Channel:* @LeaderCh', 1, 'md')
	end
end

local function filter_list(msg)
    local group = load_data('bot/group.json')
	if not group[tostring(msg.chat_id_)]['filterlist'] then
		group[tostring(msg.chat_id_)]['filterlist'] = {}
		save_data(_config.group.data, group)
    end
	--[[if next(group[tostring(msg.chat_id_)]['filterlist']) == nil then 
		tg.sendMessage(msg.chat_id_, 0, 1, '*Filtered words list is empty', 1, 'md')
	end]]
	if not group[tostring(msg.chat_id_)]['filterlist'] then
		group[tostring(msg.chat_id_)]['filterlist'] = {}
		save_data(_config.group.data, group)
    end
	filterlist1 = '*List of filtered words:*\n'
	local i = 1
	for k,v in pairs(group[tostring(msg.chat_id_)]['filterlist']) do
		filterlist = filterlist1..'*'..i..'-* '..k..'\n'
        i = i + 1
    end
	tg.sendMessage(msg.chat_id_, 0, 1, filterlist..'\n*Channel:* @LeaderCh', 1, 'md')
end

local function run(msg, matches)
    local group = load_data('bot/group.json')
	local addgroup = group[tostring(msg.chat_id)]
	if addgroup and is_momod(msg) or is_owner(msg) then
		if matches[1] == 'filter' then
			return filter_word(msg, matches[2])
		end
		if matches[1] == 'unfilter' then
			return unfilter_word(msg, matches[2])
		end
		if matches[1] == 'filterlist' then
			return filter_list(msg)
		end
	end
end

return {
patterns ={
	"^[#!/]([Ff]ilter) (.*)$",
	"^[#!/]([Uu]nfilter) (.*)$",
	"^[#!/]([Ff]ilterlist)$",
},
run=run,
}

--bot.lua
function is_filter(msg, text)
local var = false
local group = load_data('bot/group.json')
  if group[tostring(msg.chat_id_)]['filterlist'] then
for k,v in pairs(group[tostring(msg.chat_id_)]['filterlist']) do 
    if string.find(string.lower(text), string.lower(k)) then
       var = true
        end
     end
  end
 return var
end
--bot.lua

--msg_checks.lua
if is_filter(msg, msg.text) then
	tg.deleteMessages(msg.chat_id_, {[0] = msg.id_ })
end
--msg_checks.lua
