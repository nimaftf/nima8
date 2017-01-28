local function run(msg, matches) 
if matches[1] == "get" and matches[2] and is_sudo(msg) then
local plugin = "./plugins/"..matches[2]..".lua"
tg.sendDocument(msg.chat_id_, msg.id_,0, 1, nil, plugin, 'html')
end
end
return { 
patterns = {
"^[!/#]([Gg]et) (.*)$"
}, 
run = run
}
