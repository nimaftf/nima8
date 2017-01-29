local function filter_word(msg, word)
local group = load_data('bot/group.json')
if not group[tostring(msg.chat_id_)]['filterlist'] then
    group[tostring(msg.chat_id_)]['filterlist'] = {}
    save_data(_config.group.data, group)
end
if group[tostring(msg.chat_id_)]['filterlist'][(word)] then
   text5 = '*Word [*'..word..'*] is already filtered*'
   tg.sendMessage(msg.chat_id_, 0, 1, text5 , 1, 'md')
--end
else
    group[tostring(msg.chat_id_)]['filterlist'][(word)] = true
    save_data(_config.group.data, group)
    text1 = '*Word [*'..word..'*] added to filtered words list*'
    tg.sendMessage(msg.chat_id_, 0, 1, text1 , 1, 'md')
end
end

local function unfilter_word(msg, word)
local group = load_data('bot/group.json')
if not group[tostring(msg.chat_id_)]['filterlist'] then
    group[tostring(msg.chat_id_)]['filterlist'] = {}
    save_data(_config.group.data, group)
end
if group[tostring(msg.chat_id_)]['filterlist'][word] then
    group[tostring(msg.chat_id_)]['filterlist'][(word)] = nil
    save_data(_config.group.data, group)
    text2 = '*Word [*'..word..'*] removed from filtered words list*'
    tg.sendMessage(msg.chat_id_, 0, 1, text2 , 1, 'md')
else
    text3 = '*Word *'..word..'* is not filtered*'
    tg.sendMessage(msg.chat_id_, 0, 1, text3 , 1, 'md')
end
end

function filter_list(msg)
local group = load_data('bot/group.json')
if not group[tostring(msg.chat_id_)]['filterlist'] then
    group[tostring(msg.chat_id_)]['filterlist'] = {}
    save_data(_config.group.data, group)
end
if next(group[tostring(msg.chat_id_)]['filterlist']) == nil then 
    text = '<b>Filtered words list is empty</b>'
    tg.sendMessage(msg.chat_id_, 0, 1, text, 1, 'html')
end
if not group[tostring(msg.chat_id_)]['filterlist'] then
    group[tostring(msg.chat_id_)]['filterlist'] = {}
    save_data(_config.group.data, group)
end
filterlist1 = '<b>List of filtered words :</b>\n'
tg.sendMessage(msg.chat_id_, 0, 1, filterlist , 1, 'html')
local i = 1
for k,v in pairs(group[tostring(msg.chat_id_)]['filterlist']) do
    filterlist = filterlist1..'*'..i..' -* '..k..'\n'
    i = i + 1
end
tg.sendMessage(msg.chat_id_, 0, 1, filterlist , 1, 'md')
end

local function run(msg, matches)
local addgroup = group[tostring(msg.chat_id_)]
if addgroup then
if matches[1] == 'filter' and is_momod(msg) or is_owner(msg) then
   return filter_word(msg, matches[2]) 
end 
if matches[1] == 'unfilter' and is_momod(msg) or is_owner(msg) then 
   return unfilter_word(msg, matches[2]) 
end 
if matches[1] == 'filterlist' and is_momod(msg) or is_owner(msg) then 
   return filter_list(msg) 
end
end
end
return {
patterns ={
"^[#!/](filter) (.*)$",
"^[#!/](unfilter) (.*)$",
"^[#!/](filterlist)$",
},
run=run,

}
