-- VARS
local currentXP = UnitXP("player")
local maxXP = UnitXPMax("player")
local xpChange = 0
local lastXP = UnitXP("player")


-- Create the main frame
local xpFrame = CreateFrame("Frame", "ZXPLoggerFrame", UIParent)
--xpFrame:SetPoint("CENTER", UIParent, "CENTER", 0, 200)
xpFrame:ClearAllPoints()
-- xpFrame:SetPoint('TOP', 0, -50)
xpFrame:SetPoint("TOPLEFT", CharacterFrame, "BOTTOMLEFT", 0, -10)
xpFrame:SetFrameStrata('LOW')
xpFrame:SetWidth(1)
xpFrame:SetHeight(1)


-- Create the text label
local xpText = xpFrame:CreateFontString(nil, "OVERLAY", "GameFontNormalLarge")
xpText:SetPoint("CENTER", xpFrame, "CENTER", 0, 0)
xpText:SetText("XP Gained: 0")

-- Helpers 

local function CheckXPChange()
    currentXP = UnitXP("player")
    if currentXP > lastXP then
        print("XP gained: " .. (currentXP - lastXP))
		xpChange = currentXP - lastXP
		local numKillsRemaining = math.floor((maxXP - currentXP) / xpChange) 
		print("Only " .. numKillsRemaining.. " Kills remaining")
		xpText:SetText("Only " .. numKillsRemaining.. " Kills remaining")
    end
    lastXP = currentXP
end


-- Event handler


	
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
	

--eventFrame:RegisterEvent("PLAYER_XP_UPDATE")



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

local DataFrame=CreateFrame("Frame","DataFrame",UIParent);--    Our frame
DataFrame:RegisterEvent("PLAYER_ENTERING_WORLD")
DataFrame:SetScript("OnEvent", 
	function(self, event, ...)
		currentXP = UnitXP("player")
		maxXP = UnitXPMax("player")
		print('|cffc41e3a ZXP |cffa050ff :: Configured')
		xpFrame:Show()
	end)