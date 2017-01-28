local function filter_word(msg, word)
--local hash = "gp_lang:"..msg.chat_id_
--local lang = redis:get(hash)
local group = load_data('bot/group.json')
  if not group[tostring(msg.chat_id_)]['filterlist'] then
    group[tostring(msg.chat_id_)]['filterlist'] = {}
    save_data(_config.group.data, group)
    end
if group[tostring(msg.chat_id_)]['filterlist'][(word)] then
   --[[if not lang then
         return "_Word_ *"..word.."* _is already filtered_"
            else
         return "_کلمه_ *"..word.."* _از قبل فیلتر بود_"
    end]]
text5 = '*Word [*'..word..'*] is already filtered*'
tg.sendMessage(msg.chat_id_, 0, 1, text5 , 1, 'md')
end
   group[tostring(msg.chat_id_)]['filterlist'][(word)] = true
     save_data(_config.group.data, group)
   --[[if not lang then
         return "_Word_ *"..word.."* _added to filtered words list_"
            else
         return "_کلمه_ *"..word.."* _به لیست کلمات فیلتر شده اضافه شد_"
    end]]
text1 = '*Word [*'..word..'*] added to filtered words list*'
tg.sendMessage(msg.chat_id_, 0, 1, text1 , 1, 'md')
end
end

local function unfilter_word(msg, word)
--local hash = "gp_lang:"..msg.chat_id_
--local lang = redis:get(hash)
 local group = load_data('bot/group.json')
  if not group[tostring(msg.chat_id_)]['filterlist'] then
    group[tostring(msg.chat_id_)]['filterlist'] = {}
    save_data(_config.group.data, group)
    end
      if group[tostring(msg.chat_id_)]['filterlist'][word] then
      group[tostring(msg.chat_id_)]['filterlist'][(word)] = nil
       save_data(_config.group.data, group)
--[[       if not lang then
         return "_Word_ *"..word.."* _removed from filtered words list_"
       elseif lang then
         return "_کلمه_ *"..word.."* _از لیست کلمات فیلتر شده حذف شد_"
     end]]
text2 = '*Word [*'..word..'*] removed from filtered words list*'
tg.sendMessage(msg.chat_id_, 0, 1, text2 , 1, 'md')
      else
 --[[      if not lang then
         return "_Word_ *"..word.."* _is not filtered_"
       elseif lang then
         return "_کلمه_ *"..word.."* _از قبل فیلتر نبود_"
      end]]
text3 = '*Word *'..word..'* is not filtered*'
tg.sendMessage(msg.chat_id_, 0, 1, text3 , 1, 'md')
   end
end
local function run(msg, matches)
local addgroup = group[tostring(msg.chat_id_)]
if addgroup then
if matches[1] == 'filter' and is_mod(msg) then
 return filter_word(msg, matches[2]) 
end 
if matches[1] == 'unfilter' and is_mod(msg) then 
return unfilter_word(msg, matches[2]) 
end 
if matches[1] == 'filterlist' and is_mod(msg) then 
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
--pre_process = pre_process
}
