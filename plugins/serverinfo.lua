local function run(msg, matches)
local text = io.popen("sh ./data/cmd.sh"):read('*all')
if is_sudo(msg) then
  return text
end
  end
return {
  patterns = {
	"^[/#!](server)$",
  },
  run = run,
  moderated = true
}
