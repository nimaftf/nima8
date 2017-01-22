local function run(msg, matches)
local addgroup = group[tostring(msg.chat_id)]
if addgroup and not is_owner(msg) or not is_momod(msg) then
if is_momod(msg) or is_robot(msg) then
return false
else
local group = load_data('bot/group.json')
local group_mute_all = group[tostring(msg.chat_id)]['settings']['mute_all']
if group_mute_all == 'yes' then
tg.deleteMessages(msg.chat_id_, {[0] = msg.id_ })
end
local group_mute_photo = group[tostring(msg.chat_id)]['settings']['mute_photo']
local is_photo_msg = msg.text:match("!!!photo:")
if group_mute_photo == 'yes' and is_photo_msg then
tg.deleteMessages(msg.chat_id_, {[0] = msg.id_ })
end
local group_lock_english = group[tostring(msg.chat_id)]['settings']['lock_english']
local is_english_msg = msg.text:match("[a-z]") or msg.text:match("[A-Z]")
local is_not_english_msg = msg.text:match("!!!photo:") or msg.text:match("!!!tgservice:") or msg.text:match("!!!edit:") or msg.text:match("!!!video:") or msg.text:match("!!!audio:") or msg.text:match("!!!voice:") or msg.text:match("!!!document:")
if group_lock_english == 'yes' and is_english_msg and not is_not_english_msg then
tg.deleteMessages(msg.chat_id_, {[0] = msg.id_ })
end
local group_lock_persian = group[tostring(msg.chat_id)]['settings']['lock_persian']
local is_persian_msg = msg.text:match("[\216-\219][\128-\191]")
if group_lock_persian == 'yes' and is_persian_msg then
tg.deleteMessages(msg.chat_id_, {[0] = msg.id_ })
end
               
local group_lock_inline = group[tostring(msg.chat_id)]['settings']['lock_inline']
--local is_inline_msg =  msg.text == "[unsupported]"
if group_lock_inline == 'yes'  and  msg.via_bot_user_id_ ~= 0 then
tg.deleteMessages(msg.chat_id_, {[0] = msg.id_ })
end
local group_lock_tgservice = group[tostring(msg.chat_id)]['settings']['lock_tgservice']
local is_tgservice_msg = msg.text:match("!!!tgservice:joinbylink")
if group_lock_tgservice == 'yes' and is_tgservice_msg then
tg.deleteMessages(msg.chat_id_, {[0] = msg.id_ })
end
--[[local group_lock_contact = group[tostring(msg.chat_id)]['settings']['lock_contact']
local is_contact_msg = msg.text:match("!!!contact:")
if group_lock_contact == 'yes' and is_contact_msg then
tg.deleteMessages(msg.chat_id_, {[0] = msg.id_ })
end   
local group_lock_location = group[tostring(msg.chat_id)]['settings']['lock_location']
local is_location_msg = msg.text:match("!!!location:")
if group_lock_location == 'yes' and is_location_msg then
tg.deleteMessages(msg.chat_id_, {[0] = msg.id_ })
end       
local group_lock_sticker = group[tostring(msg.chat_id)]['settings']['lock_sticker']
local is_sticker_msg = msg.text:match("!!!sticker:")
if group_lock_sticker == 'yes' and is_sticker_msg then
tg.deleteMessages(msg.chat_id_, {[0] = msg.id_ })
end            
local group_lock_game = group[tostring(msg.chat_id)]['settings']['lock_game']
local is_game_msg = msg.text:match("!!!game:")
if group_lock_game == 'yes' and is_game_msg then
tg.deleteMessages(msg.chat_id_, {[0] = msg.id_ })
end]]
local group_lock_spam = group[tostring(msg.chat_id)]['settings']['lock_spam']
local _nl, ctrl_chars = string.gsub(msg.text, '%c', '')
local _nl, real_digits = string.gsub(msg.text, '%d', '')
if group_lock_spam == "yes" and string.len(msg.text) > 2049 or ctrl_chars > 40 or real_digits > 2000 then
tg.deleteMessages(msg.chat_id_, {[0] = msg.id_ })
--tg.chat_del_user(msg.chat_id_, msg.sender_user_id_)             
end
local group_mute_video = group[tostring(msg.chat_id)]['settings']['mute_video']
local is_video_msg = msg.text:match("!!!video:")
if group_mute_video == 'yes' and is_video_msg then
tg.deleteMessages(msg.chat_id_, {[0] = msg.id_ })
end
local group_mute_voice = group[tostring(msg.chat_id)]['settings']['mute_voice']
local is_voice_msg = msg.text:match("!!!voice:")
if group_mute_voice == 'yes' and is_voice_msg then
tg.deleteMessages(msg.chat_id_, {[0] = msg.id_ })
end
local group_mute_document = group[tostring(msg.chat_id)]['settings']['mute_document']
local is_document_msg = msg.text:match("!!!document:")
if group_mute_document == 'yes' and is_document_msg then
tg.deleteMessages(msg.chat_id_, {[0] = msg.id_ })
end
local group_mute_gif = group[tostring(msg.chat_id)]['settings']['mute_gif']
local is_gif_msg = msg.text:match("!!!gif:")
if group_mute_gif == 'yes' and is_gif_msg then
tg.deleteMessages(msg.chat_id_, {[0] = msg.id_ })
end
local group_mute_audio = group[tostring(msg.chat_id)]['settings']['mute_audio']
local is_audio_msg = msg.text:match("!!!audio:")
if group_mute_audio == 'yes' and is_audio_msg then
tg.deleteMessages(msg.chat_id_, {[0] = msg.id_ })
end
local group_link_lock = group[tostring(msg.chat_id)]['settings']['lock_link']
local is_link_msg = msg.text:match("[Tt][Ee][Ll][Ee][Gg][Rr][Aa][Mm].[Mm][Ee]/") or msg.text:match("[Tt][Ll][Gg][Rr][Mm].[Mm][Ee]/") or msg.text:match("[Tt][Ee][Ll][Ee][Gg][Rr][Aa][Mm].[Dd][Oo][Gg]/") or msg.text:match("[Hh][Tt][Tt][Pp][Ss]:") or msg.text:match("[Hh][Tt][Tt][Pp]:") or msg.text:match("[Tt].[Mm][Ee]/")
if is_link_msg and group_link_lock == 'yes'then
tg.deleteMessages(msg.chat_id_, {[0] = msg.id_ })
end
local group_edit_lock = group[tostring(msg.chat_id)]['settings']['lock_edit']
local is_edit_msg = msg.text:match("!!!edit:")
if group_edit_lock == 'yes' and is_edit_msg then
tg.deleteMessages(msg.chat_id_, {[0] = msg.id_ })
end
local group_fwd_lock = group[tostring(msg.chat_id)]['settings']['lock_fwd']
if group_fwd_lock == 'yes' and msg.forward_info_ ~= false then
tg.deleteMessages(msg.chat_id_, {[0] = msg.id_ })
end
local group_username_lock = group[tostring(msg.chat_id)]['settings']['lock_username']
local is_username_msg = msg.text:match("@")
if group_username_lock == 'yes' and is_username_msg then
tg.deleteMessages(msg.chat_id_, {[0] = msg.id_ })
end
local group_tag_lock = group[tostring(msg.chat_id)]['settings']['lock_tag']
local is_tag_msg = msg.text:match("#")
if group_tag_lock == 'yes' and is_tag_msg then
tg.deleteMessages(msg.chat_id_, {[0] = msg.id_ })
end
local group_fosh_lock = group[tostring(msg.chat_id)]['settings']['lock_fosh']
local is_fosh_msg = msg.text:match("مار") or msg.text:match("کونی") or msg.text:match("کیونی") or msg.text:match("کصده") or msg.text:match("تخمه") or msg.text:match("سگ") or msg.text:match("حروم زاده") or msg.text:match("حرومزاده") or msg.text:match("تمار") or msg.text:match("خار") or msg.text:match("کص") or msg.text:match("کس") or msg.text:match("کیر") or msg.text:match("کاندوم") or msg.text:match("شورت") or msg.text:match("ننه") or msg.text:match("شارژ") or msg.text:match("کد") or msg.text:match("همراه اول") or msg.text:match("ایرانسل") or msg.text:match("رایتل")  or msg.text:match("کون") or msg.text:match("بیشرف") or msg.text:match("زن") or msg.text:match("ناموس") or msg.text:match("بیناموس") or msg.text:match("بی ناموس") or msg.text:match("کثافت") or msg.text:match("کصافت") or msg.text:match("کسافت") or msg.text:match("اشغال") or msg.text:match("عمه") or msg.text:match("فاک") or msg.text:match("fuck") or msg.text:match("سیک") or msg.text:match("سیکتیر") or msg.text:match("خفه") or msg.text:match("چونی") or msg.text:match("گشاد") or msg.text:match("سولاخی") or msg.text:match("سکسی") or msg.text:match("سکس") or msg.text:match("صکص") or msg.text:match("سکص") or msg.text:match("صکس") or msg.text:match("صکصی") or msg.text:match("گو") or msg.text:match("عن") or msg.text:match("شاش") or msg.text:match("عنتر") or msg.text:match("گوریل") or msg.text:match("نفهم") or msg.text:match("عقب افتاده") or msg.text:match("عوضی") or msg.text:match("عوزی") or msg.text:match("پاره") or msg.text:match("ژنده") or msg.text:match("دزد") or msg.text:match("مادر") or msg.text:match("پدر") or msg.text:match("بی شرف") or msg.text:match("جاکش") or msg.text:match("پوفیوز") or msg.text:match("خایه") or msg.text:match("تخمک") or msg.text:match("پشم") or msg.text:match("ادرار") or msg.text:match("تاپاله") or msg.text:match("گوز") or msg.text:match("چوس")
local is_foshh_msg = msg.text:match("madar") or msg.text:match("mather") or msg.text:match("father") or msg.text:match("pedar") or msg.text:match("khahar") or msg.text:match("khar") or msg.text:match("mar") or msg.text:match("tamar") or msg.text:match("cos") or msg.text:match("koc") or msg.text:match("coc") or msg.text:match("kos") or msg.text:match("kir") or msg.text:match("cir") or msg.text:match("short") or msg.text:match("kandom") or msg.text:match("kandoom") or msg.text:match("nane") or msg.text:match("maman") or msg.text:match("sharg") or msg.text:match("kod") or msg.text:match("cod") or msg.text:match("hamrah aval") or msg.text:match("irancell") or msg.text:match("raitel") or msg.text:match("nnh") or msg.text:match("nne")
if group_fosh_lock == 'yes' and is_fosh_msg or is_foshh_msg then
tg.deleteMessages(msg.chat_id_, {[0] = msg.id_ })
end
--[[local group_reply_lock = group[tostring(msg.chat_id)]['settings']['lock_fosh']
if group_reply_lock == 'yes' and msg.reply_to_message_id_~=0 then
tg.deleteMessages(msg.chat_id_, {[0] = msg.id_ })
end]]
local TIME_CHECK = 2
local user = msg.sender_user_id_
--local chat_id = msg.chat_id_
--local user_id = msg.sender_user_id_
local group_flood_lock = group[tostring(msg.chat_id)]['settings']['lock_flood']      
if group_flood_lock == 'yes' then
local hash = 'user:'..user..':msgs'
local msgs = tonumber(redis:get(hash) or 0)
local NUM_MSG_MAX = 5
--if data[tostring(chat)] then
if group[tostring(target)]['settings']['num_msg_max'] then
NUM_MSG_MAX = tonumber(group[tostring(target)]['settings']['num_msg_max'])
--else
-- NUM_MSG_MAX = 5
end
--end
if msgs > NUM_MSG_MAX then
if not redis:get('sender:'..user..':lock_flood') then
--return
--else
tg.deleteMessages(msg.chat_id_, {[0] = msg.id_})
--kick_user(user, chat)
--tg.changeChatMemberStatus(chat_id, user_id, 'Kicked')
pm2 = '*User* [ `'..user..'` ] *has been deleted messages because of flooding*'
tg.sendMessage(msg.chat_id_, 0, 1, pm2 , 1, 'md') 
redis:setex('sender:'..user..':lock_flood', 60, true)
--redis:set('sender:'..user..':lock_flood', 30, true)
end
end
redis:setex(hash, TIME_CHECK, msgs+1)
--redis:set(hash, TIME_CHECK, msgs+1)
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
