-- VARS
local currentXP = UnitXP("player")
local maxXP = UnitXPMax("player")
local xpChange = 0
local lastXP = UnitXP("player")

-- Helpers 

local function CheckXPChange()
    currentXP = UnitXP("player")
    if currentXP > lastXP then
        print("XP gained: " .. (currentXP - lastXP))
		xpChange = currentXP - lastXP
		print("Only " ..(maxXP - currentXP) / xpChange .. " Kills remaining")
    end
    lastXP = currentXP
end


-- Event handler

local DataFrame=CreateFrame("Frame","DataFrame",UIParent);--    Our frame
DataFrame:RegisterEvent("PLAYER_ENTERING_WORLD")
DataFrame:SetScript("OnEvent", 
	function(self, event, ...)
		currentXP = UnitXP("player")
		maxXP = UnitXPMax("player")
		print('|cffc41e3a ZXP |cffa050ff :: Configured')
	end)
	
local ZXP_CalmFrame = CreateFrame("Frame")
ZXP_CalmFrame:RegisterEvent("PLAYER_REGEN_ENABLED")
ZXP_CalmFrame:SetScript("OnEvent",
	function(self, event, arg1, arg2, arg3, arg4, arg5)
		-- XP Calculation
		CheckXPChange()
		
		
	end)
	
local ZXP_CombatFrame = CreateFrame("Frame")
ZXP_CombatFrame:RegisterEvent("PLAYER_REGEN_DISABLED")
ZXP_CombatFrame:SetScript("OnEvent",
	function(self, event, arg1, arg2, arg3, arg4, arg5)
		-- Save XP
		currentXP = UnitXP("player")
		lastXP = UnitXP("player")
		
		
	end)
	
-- EXPERIMENTAL TODO:
	-- Make more accurate by capturing xp by kill instead of combat
local eventFrame = CreateFrame("Frame")
eventFrame:RegisterEvent("CHAT_MSG_COMBAT_XP_GAIN")
eventFrame:SetScript("OnEvent", function(self, event, msg)
    if event == "CHAT_MSG_COMBAT_XP_GAIN" then
        local xpGained = string.match(msg, "gain (%d+) experience")
        if xpGained then
            xpText:SetText("XP Gained: " .. xpGained)
        end
    end
end)
