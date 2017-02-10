local function pre_process(msg)
chat = msg.chat_id_
user = msg.sender_user_id_
	local function check_newmember(arg, data)
		local group = load_data('bot/group.json')
		lock_bots = group[arg.chat_id]['settings']['lock_bot']
        if data.type_.ID == "UserTypeBot" then
            if not is_owner(arg.msg) or is_momod(arg.msg) and lock_bots == 'yes' then
                kick_user(data.id_, arg.chat_id)
            end
        end
        if data.username_ then
            user_name = '@'..check_markdown(data.username_)
        else
            user_name = check_markdown(data.first_name_)
        end
	end
	--[[if msg.adduser then
    	tdcli_function ({
        ID = "GetUser",
      	user_id_ = msg.adduser
    	}, check_newmember, {chat_id=chat,msg_id=msg.id_,user_id=user,msg=msg})
	end
	if msg.joinuser then
		tdcli_function ({
		ID = "GetUser",
      	user_id_ = msg.joinuser
    	}, check_newmember, {chat_id=chat,msg_id=msg.id_,user_id=user,msg=msg})
	end]]
end

local function action_by_reply(arg, data)
local cmd = arg.cmd
    if not tonumber(data.sender_user_id_) then return false end
    if data.sender_user_id_ then
        if cmd == "kick" then
            --[[if is_momod(data.chat_id_, data.sender_user_id_) then
                tg.sendMessage(data.chat_id_, "", 0, "_You can't kick_ *mods,owners and bot admins*", 0, "md")
            else]]
                kick_user(data.sender_user_id_, data.chat_id_)
            --end
        end
    else
        tg.sendMessage(data.chat_id_, "", 0, "*User Not Found*", 0, "md")
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
            if cmd == "kick" then
                --[[if is_momod(arg.chat_id, data.id_) then
                    tg.sendMessage(arg.chat_id, "", 0, "*You can't kick mods,owners and bot admins*", 0, "md")
                else]]
                    kick_user(data.id_, arg.chat_id)
                --end
            end
        else
            tg.sendMessage(arg.chat_id, "", 0, "*User Not Found*", 0, "md")
        end	
end

local function run(msg, matches)
local group = load_data('bot/group.json')
chat = msg.chat_id_
user = msg.sender_user_id_
    if matches[1] == "kick" and is_momod(msg) or is_owner(msg) then
        if not matches[2] and tonumber(msg.reply_to_message_id_) ~= 0 then
            tdcli_function ({
            ID = "GetMessage",
            chat_id_ = msg.chat_id_,
            message_id_ = msg.reply_to_message_id_
            }, action_by_reply, {chat_id=msg.chat_id_,cmd="kick"})
        end
        if matches[2] and string.match(matches[2], '^%d+$') then
            if is_momod(msg.chat_id_, matches[2]) then
                tg.sendMessage(msg.chat_id_, "", 0, "You can't kick mods,owners or bot admins", 0, "md")
            else
                kick_user(matches[2], msg.chat_id_)
            end
        end
        if matches[2] and not string.match(matches[2], '^%d+$') then
            tdcli_function ({
            ID = "SearchPublicChat",
            username_ = matches[2]
            }, action_by_username, {chat_id=msg.chat_id_,username=matches[2],cmd="kick"})
        end
    end
end
return {
	patterns = {
		"^[!/#](kick)$",
		"^[!/#](kick) (.*)$",
	},
	run = run,
pre_process = pre_process
}
