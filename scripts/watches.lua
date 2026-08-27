
Archipelago:AddClearHandler("clear handler", onClear)
Archipelago:AddItemHandler("item handler", onItem)
Archipelago:AddLocationHandler("location handler", onLocation)

Archipelago:AddSetReplyHandler("notify handler", OnNotify)
Archipelago:AddRetrievedHandler("notify launch handler", OnNotifyLaunch)
ScriptHost:AddWatchForCode("state changed", "*", InvalidateAccessibleRegions)

function BackpackOverlayUpdate(code)
    local backpack = Tracker:FindObjectForCode("backpackupgrade") or ""
    local upgrades = backpack.CurrentStage or 0
    local amount = 12 + (upgrades*3)

    backpack:SetOverlayFontSize(16)
    backpack:SetOverlayColor("#ffffff")

    if (upgrades == 10) or (code == "infiniteupgrade") then
        backpack:SetOverlay("∞")
    elseif code == "backpackupgrade" then
        backpack:SetOverlay(tostring(amount))
    end
end

ScriptHost:AddWatchForCode("backpack update", "backpackupgrade", BackpackOverlayUpdate)
ScriptHost:AddWatchForCode("backpack update infinite", "infiniteupgrade", BackpackOverlayUpdate)