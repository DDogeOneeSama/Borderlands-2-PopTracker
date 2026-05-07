local variant = Tracker.ActiveVariantUID

-- Items
require("scripts/items_import")

-- Maps
Tracker:AddMaps("maps/maps.json")

-- Layout
require("scripts/layouts")

-- Locations
require("scripts/locations_import")

-- Logic
ScriptHost:LoadScript("scripts/logic/base_logic.lua")
ScriptHost:LoadScript("scripts/logic/logic_tables.lua")

-- AutoTracking for Poptracker
require("scripts/autotracking")

function OnFrameHandler()
    ScriptHost:RemoveOnFrameHandler("load handler")
    ScriptHost:AddOnLocationSectionChangedHandler("location_section_change_handler", LocationHandler)
    CreateLuaManualStorageItem("manual_location_storage")
    ForceUpdate()
end
require("scripts/luaitems")
require("scripts/watches")
ScriptHost:AddOnFrameHandler("load handler", OnFrameHandler)
