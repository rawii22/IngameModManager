local ModsScreen = GLOBAL.require("screens/redux/modsscreen") 
local ModsTab = GLOBAL.require("widgets/redux/modstab")
local TEMPLATES = GLOBAL.require ("widgets/redux/templates")
--local io = GLOBAL.require("io")
local KEY = GetModConfigData("KEY")

local settings = {
	is_configuring_server = false,
	details_width = 505,
	are_servermods_readonly = false,
}

---===============
---  Key Handler
---===============
local modkey = KEY
GLOBAL.TheInput:AddKeyUpHandler(
	modkey:lower():byte(), 
	function()
		if not GLOBAL.IsPaused() and IsDefaultScreen() then
			local ms = ModsScreen()
			ms.mods_page:Kill()
			for k,v in pairs(ms.mods_page.subscreener.menu.items) do
				v:Kill()
			end
			ms.mods_page.tooltip:Kill()
			ms.mods_page = ms.optionspanel:InsertWidget(ModsTab(ms, settings))
			ms.mods_page.slotnum = GLOBAL.SaveGameIndex.current_slot
			ms.bg:Kill()
			ms.bg = ms.root:AddChild(TEMPLATES.BackgroundTint(0.5, {0,0,0}))
			ms.bg:MoveToBack()
			
			GLOBAL.TheFrontEnd:PushScreen(ms)
		--[[

			local command = ""
			for line in io.lines("../mods/IngameModManager/command.txt") do
				command = command.." "..line
			end
			GLOBAL.ExecuteConsoleCommand(command)]]
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

local function ApplyToGame(modsscreen)
	local OldApply = modsscreen.Apply
	modsscreen.Apply = function(self)
		if GLOBAL.ThePlayer ~= nil then
			GLOBAL.c_save()
			OldApply(self)
			GLOBAL.TheWorld:DoTaskInTime(2.5, function() GLOBAL.c_reset() end)
		end
	end
end
AddClassPostConstruct("screens/redux/modsscreen", ApplyToGame)