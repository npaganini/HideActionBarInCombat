-- Grab the new main action bar frame (Midnight UI)
local MainActionBar = _G["MainActionBar"] or _G["MainMenuBar"] -- fallback

-- Create a frame to listen for events
local f = CreateFrame("Frame")

-- Register combat and vehicle events
f:RegisterEvent("PLAYER_REGEN_DISABLED")  -- Event for entering combat
f:RegisterEvent("PLAYER_REGEN_ENABLED")   -- Event for leaving combat
f:RegisterEvent("UNIT_ENTERED_VEHICLE")   -- Event for entering a vehicle
f:RegisterEvent("UNIT_EXITED_VEHICLE")    -- Event for exiting a vehicle

-- Function to handle hiding and showing the action bar
local function UpdateActionBarVisibility()
    if InCombatLockdown() then
        -- If the player is in combat and not in a vehicle, hide the action bar
        if not UnitHasVehicleUI("player") then
            MainActionBar:Hide()
        end
    else
        -- If the player is not in combat, show the action bar
        MainActionBar:Show()
    end
end

-- Function to handle the events
f:SetScript("OnEvent", function(self, event, unit)
    if not MainActionBar then
        return
    end

    if event == "PLAYER_REGEN_DISABLED" then
        -- Entering combat: hide the action bar unless the player is in a vehicle
        if not UnitHasVehicleUI("player") then
            MainActionBar:Hide()
        end
    elseif event == "PLAYER_REGEN_ENABLED" then
        -- Leaving combat: show the action bar
        MainActionBar:Show()
    elseif event == "UNIT_ENTERED_VEHICLE" and unit == "player" then
        -- Entering a vehicle: always show the action bar
        MainActionBar:Show()
    elseif event == "UNIT_EXITED_VEHICLE" and unit == "player" then
        -- Exiting a vehicle: update the action bar visibility based on combat status
        UpdateActionBarVisibility()
    end
end)
