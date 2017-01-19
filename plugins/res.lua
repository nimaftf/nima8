local function action_by_username(arg, data)
local cmd = arg.cmd
if cmd == "id" then
    return tdcli.sendMessage(arg.chat_id, "", 0, "*"..data.id_.."*", 0, "md")
end
    if cmd == "res" then
    local text = "Result for [ ".. data.type_.user_.username_ .." ] :\n"
    .. "".. data.title_ .."\n"
    .. " [".. data.id_ .."]"
       return tdcli.sendMessage(arg.chat_id, 0, 1, text, 1)
   end
end   
