-- Create a frame to listen for events
local f = CreateFrame("Frame")

-- Register events for entering and leaving combat and vehicle
f:RegisterEvent("PLAYER_REGEN_DISABLED")  -- Event for entering combat
f:RegisterEvent("PLAYER_REGEN_ENABLED")   -- Event for leaving combat
f:RegisterEvent("UNIT_ENTERED_VEHICLE")   -- Event for entering a vehicle
f:RegisterEvent("UNIT_EXITED_VEHICLE")    -- Event for exiting a vehicle

-- Function to handle hiding and showing the action bar
local function UpdateActionBarVisibility()
    if InCombatLockdown() then
        -- If the player is in combat and not in a vehicle, hide the action bar
        if not UnitHasVehicleUI("player") then
            MainMenuBar:Hide()
        end
    else
        -- If the player is not in combat, show the action bar
        MainMenuBar:Show()
    end
end

-- Function to handle the events
f:SetScript("OnEvent", function(self, event, arg1)
    if event == "PLAYER_REGEN_DISABLED" then
        -- Entering combat: hide the action bar unless the player is in a vehicle
        if not UnitHasVehicleUI("player") then
            MainMenuBar:Hide()
        end
    elseif event == "PLAYER_REGEN_ENABLED" then
        -- Leaving combat: show the action bar
        MainMenuBar:Show()
    elseif event == "UNIT_ENTERED_VEHICLE" and arg1 == "player" then
        -- Entering a vehicle: always show the action bar
        MainMenuBar:Show()
    elseif event == "UNIT_EXITED_VEHICLE" and arg1 == "player" then
        -- Exiting a vehicle: update the action bar visibility based on combat status
        UpdateActionBarVisibility()
    end
end)
