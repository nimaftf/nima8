local function pre_process(msg)
chat = msg.chat_id_
user = msg.sender_user_id_
	local function check_newmember(arg, data)
if data.username_ then
user_name = '@'..check_markdown(data.username_)
else
user_name = check_markdown(data.first_name_)
end
end
if is_silent_user(user, chat) then
tg.deleteMessages(msg.chat_id_, {[0] = msg.id_ })
--tg.deleteMessages(msg.chat_id_, {[0] = message_ids}, dl_cb, nil)
end
end

function silent_users_list(chat_id)
    local group = load_data('bot/group.json')
    local i = 1
  -- determine if table is empty
  if next(group[tostring(chat_id)]['is_silent_users']) == nil then --fix way
      text1 = "*No mute users in this group*"
	  tg.sendMessage(msg.chat_id_, 0, 1, text1, 1, 'md')
  end
   message = '*List of mute users :*\n'
  for k,v in pairs(group[tostring(chat_id)]['is_silent_users']) do
      message = message ..i.. '- '..v..' [' ..k.. '] \n'
      i = i + 1
  end
  tg.sendMessage(msg.chat_id_, 0, 1, message, 1, 'md')
end

local function action_by_reply(arg, data)
  local cmd = arg.cmd
if not tonumber(data.sender_user_id_) then return false end
if data.sender_user_id_ then

  if cmd == "silent" then
local function silent_cb(arg, data)
    local group = load_data('bot/group.json')
if data.username_ then
user_name = '@'..check_markdown(data.username_)
else
user_name = check_markdown(data.first_name_)
end
   --[[if is_momod(msg) then
        tg.sendMessage(arg.chat_id, "", 0, "*You can't mute mods,owners and bot admins*", 0, "md")
--		tg.sendMessage(msg.chat_id_, 0, 1, "*You can't mute mods,owners and bot admins*", 1, 'md')
   end]]
if group[tostring(arg.chat_id)]['is_silent_users'][tostring(data.id_)] then
      tg.sendMessage(arg.chat_id, "", 0, "*User* [`"..data.id_.."`] *is already mute*", 0, "md")
--	  tg.sendMessage(msg.chat_id_, 0, 1, "*User* [`"..data.id_.."`] *is already mute*", 1, 'md')
   end
group[tostring(arg.chat_id)]['is_silent_users'][tostring(data.id_)] = user_name
    save_data(_config.group.data, group)
      tg.sendMessage(arg.chat_id, "", 0, "*User* [`"..data.id_.."`] *added to mute users list*", 0, "md")
--	  tg.sendMessage(msg.chat_id_, 0, 1, "*User* [`"..data.id_.."`] *added to mute users list*", 1, 'md')
end
tdcli_function ({
    ID = "GetUser",
    user_id_ = data.sender_user_id_
  }, silent_cb, {chat_id=data.chat_id_,user_id=data.sender_user_id_})
  end
  if cmd == "unsilent" then
local function unsilent_cb(arg, data)
    local group = load_data(_config.moderation.data)
if data.username_ then
user_name = '@'..check_markdown(data.username_)
else
user_name = check_markdown(data.first_name_)
end
if not group[tostring(arg.chat_id)]['is_silent_users'][tostring(data.id_)] then
     tg.sendMessage(arg.chat_id, "", 0, "*User* [`"..data.id_.."`] *is not mute*", 0, "md")
--	 tg.sendMessage(msg.chat_id_, 0, 1, "*User* [`"..data.id_.."`] *is not mute*", 1, 'md')
   end
group[tostring(arg.chat_id)]['is_silent_users'][tostring(data.id_)] = nil
    save_data(_config.group.data, group)
      tg.sendMessage(arg.chat_id, "", 0, "*User* [`"..data.id_.."`] *removed from mute users list*", 0, "md")
--      tg.sendMessage(msg.chat_id_, 0, 1, "*User* [`"..data.id_.."`] *removed from mute users list*", 1, 'md')
end
tdcli_function ({
    ID = "GetUser",
    user_id_ = data.sender_user_id_
  }, unsilent_cb, {chat_id=data.chat_id_,user_id=data.sender_user_id_})
  end
else
   tg.sendMessage(data.chat_id_, "", 0, "*User Not Found*", 0, "md")
--   tg.sendMessage(msg.chat_id_, 0, 1, "*User Not Found*", 1, 'md')
end
end
local function action_by_username(arg, data)
  local cmd = arg.cmd
    local group = load_data('bot/group.json')
if not arg.username then return false end
    if data.id_ then
if data.type_.user_.username_ then
user_name = '@'..check_markdown(data.type_.user_.username_)
else
user_name = check_markdown(data.title_)
end
  if cmd == "silent" then
   if is_momod(msg) then
      tg.sendMessage(arg.chat_id, "", 0, "*You can't mute mods,owners and bot admins*", 0, "md")
--	  tg.sendMessage(msg.chat_id_, 0, 1, "*You can't mute mods,owners and bot admins*", 1, 'md')
   end
if group[tostring(arg.chat_id)]['is_silent_users'][tostring(data.id_)] then
      tg.sendMessage(arg.chat_id, "", 0, "*User* [`"..data.id_.."`] *is already mute*", 0, "md")
--      tg.sendMessage(msg.chat_id_, 0, 1, "*User* [`"..data.id_.."`] *is already mute*", 1, 'md')
end
group[tostring(arg.chat_id)]['is_silent_users'][tostring(data.id_)] = user_name
    save_data(_config.group.data, group)
      tg.sendMessage(arg.chat_id, "", 0, "*User* [`"..data.id_.."`] *added to mute users list*", 0, "md")
--      tg.sendMessage(msg.chat_id_, 0, 1, "*User* [`"..data.id_.."`] *added to mute users list*", 1, 'md')
end
  if cmd == "unsilent" then
if not group[tostring(arg.chat_id)]['is_silent_users'][tostring(data.id_)] then
     tg.sendMessage(arg.chat_id, "", 0, "*User* [`"..data.id_.."`] *is not mute*", 0, "md")
--	 tg.sendMessage(msg.chat_id_, 0, 1, "*User* [`"..data.id_.."`] *is not mute*", 1, 'md')
end
group[tostring(arg.chat_id)]['is_silent_users'][tostring(data.id_)] = nil
    save_data(_config.group.data, group)
      tg.sendMessage(arg.chat_id, "", 0, "*User* [`"..data.id_.."`] *removed from mute users list*", 0, "md")
--      tg.sendMessage(msg.chat_id_, 0, 1, "*User* [`"..data.id_.."`] *removed from mute users list*", 1, 'md')
	  end
else
   tg.sendMessage(arg.chat_id, "", 0, "*User Not Found*", 0, "md")
--   tg.sendMessage(msg.chat_id_, 0, 1, "*User Not Found*", 1, 'md')
end
end


local function run(msg, matches)
local group = load_data('bot/group.json')
chat = msg.chat_id_
user = msg.sender_user_id_
if matches[1] == "muteuser" and is_momod(msg) or is_owner(msg) then
if not matches[2] and tonumber(msg.reply_to_message_id_) ~= 0 then
    tdcli_function ({
      ID = "GetMessage",
      chat_id_ = msg.chat_id_,
      message_id_ = msg.reply_to_message_id_
    }, action_by_reply, {chat_id=msg.chat_id_,cmd="silent"})
end
  if matches[2] and string.match(matches[2], '^%d+$') then
--[[   if is_momod(msg.chat_id_, matches[2]) then
           tg.sendMessage(msg.chat_id_, "", 0, "*You can't mute mods,leaders or bot admins*", 0, "md")
       end]]
   if is_silent_user(matches[2], chat) then

    tg.sendMessage(msg.chat_id_, "", 0, "*User* [`"..matches[2].."`] *is already mute*", 0, "md")
--	tg.sendMessage(msg.chat_id_, 0, 1, "*User* [`"..matches[2].."`] *is already mute*", 1, 'md')

     end
group[tostring(chat)]['is_silent_users'][tostring(matches[2])] = ""
    save_data(_config.group.data, group)

  tg.sendMessage(msg.chat_id_, msg.id_, 0, "*User* [`"..matches[2].."`] *added to mute users list*", 0, "md")
--  tg.sendMessage(msg.chat_id_, 0, 1, "*User* [`"..matches[2].."`] *added to mute users list*", 1, 'md')

   end
  if matches[2] and not string.match(matches[2], '^%d+$') then
    tdcli_function ({
      ID = "SearchPublicChat",
      username_ = matches[2]
    }, action_by_username, {chat_id=msg.chat_id_,username=matches[2],cmd="silent"})
      end
   end
 if matches[1] == "unmuteuser" and is_momod(msg) or is_owner(msg) then
if not matches[2] and tonumber(msg.reply_to_message_id_) ~= 0 then
    tdcli_function ({
      ID = "GetMessage",
      chat_id_ = msg.chat_id_,
      message_id_ = msg.reply_to_message_id_
    }, action_by_reply, {chat_id=msg.chat_id_,cmd="unsilent"})
end
  if matches[2] and string.match(matches[2], '^%d+$') then
   if not is_silent_user(matches[2], chat) then
      tg.sendMessage(msg.chat_id_, "", 0, "*User* [`"..matches[2].."`] *is not mute*", 0, "md")
--      tg.sendMessage(msg.chat_id_, 0, 1, "*User* [`"..matches[2].."`] *is not mute*", 1, 'md')
     end
group[tostring(chat)]['is_silent_users'][tostring(matches[2])] = nil
    save_data(_config.group.data, group)
  tg.sendMessage(msg.chat_id_, msg.id_, 0, "*User* [`"..matches[2].."`] *removed from mute users list*", 0, "md")
--  tg.sendMessage(msg.chat_id_, 0, 1, "*User* [`"..matches[2].."`] *removed from mute users list*", 1, 'md')
   end
  if matches[2] and not string.match(matches[2], '^%d+$') then
   tdcli_function ({
      ID = "SearchPublicChat",
      username_ = matches[2]
    }, action_by_username, {chat_id=msg.chat_id_,username=matches[2],cmd="unsilent"})
      end
   end
if matches[1] == "mutelist" and is_momod(msg) or is_owner(msg) then
  return silent_users_list(chat)
end
end
return {
	patterns = {
        "^[!/#]([Mm]uteuser)$",
		"^[!/#]([Mm]uteuser) (.*)$",
		"^[!/#]([Uu]nmuteuser)$",
		"^[!/#]([Uu]nmuteuser) (.*)$",
		"^[!/#]([Mm]utelist)$",
	},
	run = run,
pre_process = pre_process
}

