local io = GLOBAL.require("io")

local modkey = "\'"
local command = ""
GLOBAL.TheInput:AddKeyUpHandler(
	modkey:lower():byte(), 
	function()
		if not GLOBAL.IsPaused() and IsDefaultScreen() then
			for line in io.lines("../mods/IngameModManager/command.txt") do
				command = command.." "..line
			end
			GLOBAL.ExecuteConsoleCommand(command)
		end
	end
)

function IsDefaultScreen()
	if GLOBAL.TheFrontEnd:GetActiveScreen() and GLOBAL.TheFrontEnd:GetActiveScreen().name and type(GLOBAL.TheFrontEnd:GetActiveScreen().name) == "string" and GLOBAL.TheFrontEnd:GetActiveScreen().name == "HUD" then
		return true
	else
		return false
	end
end