local ModsScreen = GLOBAL.require("screens/redux/modsscreen") 
local ModsTab = GLOBAL.require("widgets/redux/modstab")
local TEMPLATES = GLOBAL.require ("widgets/redux/templates")
--local io = GLOBAL.require("io")
local KEY = GetModConfigData("KEY")

--later used when recreating the custom modstab widget
local settings = {
	is_configuring_server = false,
	details_width = 505,
	are_servermods_readonly = false,
}

---===============
---  Key Handler
---===============
local modkey = KEY
--The key will activate the modsscreen screen in-game
GLOBAL.TheInput:AddKeyUpHandler(
	modkey:lower():byte(), 
	function()
		if not GLOBAL.IsPaused() and IsDefaultScreen() then
			local ms = ModsScreen()
			ms.mods_page:Kill() --Kill the modstab so we can customize it later
			for k,v in pairs(ms.mods_page.subscreener.menu.items) do
				v:Kill() --Kills duplicated buttons that appear when the modstab is created again later
			end
			
			ms.mods_page.tooltip:Kill()
			ms.mods_page = ms.optionspanel:InsertWidget(ModsTab(ms, settings))
			ms.mods_page.slotnum = GLOBAL.SaveGameIndex.current_slot --This satisfies a condition in ModsTab:Apply() that ensures the Sim does not reset
			ms.bg:Kill() --Kill the default background
			ms.bg = ms.root:AddChild(TEMPLATES.BackgroundTint(0.5, {0,0,0})) --Add custom background
			ms.bg:MoveToBack()
			
			GLOBAL.TheFrontEnd:PushScreen(ms) --Finally make the screen appear
			
			--Extra code used for testing
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

--What happens when the Apply button is clicked
local function ApplyToGame(modsscreen)
	local OldApply = modsscreen.Apply
	modsscreen.Apply = function(self)
		if GLOBAL.ThePlayer ~= nil then
			GLOBAL.c_save()
			OldApply(self)
			GLOBAL.TheWorld:DoTaskInTime(2.5, function() GLOBAL.c_reset() end) --give time for c_save and OldApply to work
		end
	end
end
AddClassPostConstruct("screens/redux/modsscreen", ApplyToGame)