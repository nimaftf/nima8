local function action_by_username(arg, data)
local cmd = arg.cmd
if cmd == "id" then
    return tg.sendMessage(arg.chat_id, "", 0, "*"..data.id_.."*", 0, "md")
    --return tg.sendMessage(msg.chat_id_, 0, 0, "*"..data.id_.."*", 0, "md")    
end
    if cmd == "res" then
    local text = "Result for [ ".. data.type_.user_.username_ .." ] :\n"
    .. "".. data.title_ .."\n"
    .. " [".. data.id_ .."]"
       return tg.sendMessage(arg.chat_id, 0, 1, text, 1)
       --return tg.sendMessage(msg.chat_id_, 0, 0, text, 1) 
   end
end  
local function action_by_reply(arg, data)
local cmd = arg.cmd
if cmd == "id" then
local function id_cb(arg, data)
    return tg.sendMessage(arg.chat_id, "", 0, "*"..data.id_.."*", 0, "md")
end
tg_function ({
    ID = "GetUser",
    user_id_ = data.sender_user_id_
  }, id_cb, {chat_id=data.chat_id_,user_id=data.sender_user_id_})
  end
end
local function run(msg, matches)
   local chat = msg.chat_id_
   local user = msg.sender_user_id_
if matches[1] == "id" then
if not matches[2] and tonumber(msg.reply_to_message_id_) == 0 then
return "*Chat ID :* _"..chat.."_\n*User ID :* _"..user.."_"
end
if not matches[2] and tonumber(msg.reply_to_message_id_) ~= 0 then
    tg_function ({
      ID = "GetMessage",
      chat_id_ = msg.chat_id_,
      message_id_ = msg.reply_to_message_id_
    }, action_by_reply, {chat_id=msg.chat_id_,cmd="id"})
  end
if matches[2] and tonumber(msg.reply_to_message_id_) == 0 then
   tg_function ({
      ID = "SearchPublicChat",
      username_ = matches[2]
    }, action_by_username, {chat_id=msg.chat_id_,username=matches[2],cmd="id"})
      end
   end    
if matches[1] == "res" and matches[2] then
    tg_function ({
      ID = "SearchPublicChat",
      username_ = matches[2]
    }, action_by_username, {chat_id=msg.chat_id_,username=matches[2],cmd="res"})
  end
end
return {
patterns ={
        "^[!/#](id)$",
        "^[!/#](id) (.*)$",
        "^[!/#](res) (.*)$",
},
run=run
}        
