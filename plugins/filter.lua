local function addword(msg, name)
    local hash = 'chat:'..msg.chat_id_..':badword'
    redis:hset(hash, name, 'newword')
    
	tg.sendMessage(msg.chat_id_, 0, 1, '<b>New word has been added to list:</b> \n>'..name, 1, 'html')
end

local function get_badword_hash(msg)
    return 'chat:'..msg.chat_id_..':badword'
end 

local function list_badwords(msg)
	local hash = get_badword_hash(msg)
	local result=''
	if hash then
		local names = redis:hkeys(hash)
		for i=1, #names do
			result = result..'>'..names[i]..'\n'
		end
		if #result>0 then
			tg.sendMessage(msg.chat_id_, 0, 1, '<b>List of words filter :</b>\n\n'..result, 1, 'html')
		else
			pm = '<b>Filter list is empty</b>'
			tg.sendMessage(msg.chat_id_, 0, 1, pm, 1, 'html')
		end
	end
end

local function clear_badwords(msg, var_name) 
	local hash = get_badword_hash(msg)
	redis:del(hash, var_name)
	pm = '<b>Filter list cleaned!</b>'
	tg.sendMessage(msg.chat_id_, 0, 1, pm, 1, 'html')
end

local function list_badword2(msg, arg)
local group = load_data('bot/group.json')
local addgroup = group[tostring(msg.chat_id)]
	local hash = get_badword_hash(msg)
	if hash then
		local names = redis:hkeys(hash)
		local text = ''
		for i=1, #names do
			if string.match(arg, names[i]) and not is_momod(msg) or not is_owner(msg) then
				if addgroup then
				tg.deleteMessages(msg.chat_id_, {[0] = msg.id_}, dl_cb, nil)
			end
				return 
			end
		end
	end
end

local function clear_badword(msg, cmd_name)  
	local hash = get_badword_hash(msg)
	redis:hdel(hash, cmd_name)
	tg.sendMessage(msg.chat_id_, 0, 1, cmd_name..' cleaned!', 1, 'html')
end

local function pre_process(msg)
local group = load_data('bot/group.json')
local addgroup = group[tostring(msg.chat_id)]
	msg.text = msg.content_.text_
	local hash = get_badword_hash(msg)
	if hash then
		local names = redis:hkeys(hash)
		local text = ''
		for i=1, #names do
			if string.match(msg.text, names[i]) and not is_momod(msg) or not is_owner(msg) then
				if addgroup then
					tg.deleteMessages(msg.chat_id_, {[0] = msg.id_}, dl_cb, nil)
				end
				return 
			end
		end
	end
end

local function run(msg, matches
local group = load_data('bot/group.json')
local addgroup = group[tostring(msg.chat_id)]
	if addgroup and is_momod(msg) or is_owner(msg) then
		if matches[2]:lower() == 'filter' then
			local name = string.sub(matches[3], 1, 50)
			local text = addword(msg, name)
			return text
		end
		if matches[2]:lower() == 'filterlist' then
			return list_badwords(msg)
		elseif matches[2]:lower() == 'clean' then
			local number = '1'
			return clear_badwords(msg, number)
		elseif matches[2]:lower() == 'unfilter' then
			return clear_badword(msg, matches[3])
		end
	end
end

return {
  patterns = {
	"^[!/#]([Ff]ilter) (.*)$",
	"^[!/#]([Uu]nfilter) (.*)$",
    "^[!/#]([Ff]ilterlist)$",
    "^[!/#]([Cc]lean) ([Ff]ilterlist)$",
  },
  run = run, 
  pre_process = pre_process
}
