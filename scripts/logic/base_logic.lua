function CreateRegion(options) --Base region creation, call to initialize regions with their data
  return {
    regName = options.regName or "No Region Name",
    level_req = options.level_req or 0,
    travel_item_name = options.travel_item_name or "",
    connecting_regions = options.connecting_regions or {},
    story_req_regions = options.story_req_regions or {},
    dlc_group = options.dlc_group or "basegame"
    }
end
local Menu = CreateRegion{regName = "Menu", connecting_regions = {
        "WindshearWaste",
        "DigistructPeak",
        "FFSIntroSanctuary",
        "UnassumingDocks",
        "BadassCrater",
        "Oasis",
        "HuntersGrotto",
        "MarcusMercenaryShop",
        "GluttonyGulch",
        "RotgutDistillery",
        "WamBamIsland",
        "HallowedHollow",
        }, dlc_group = "menu"
      }
local WindshearWaste = CreateRegion{regName = "WindshearWaste", level_req = 1, connecting_regions = {"SouthernShelf"}, dlc_group = "scarlett"}
local MarcusMercenaryShop = CreateRegion{regName = "MarcusMercenaryShop", level_req = 15, travel_item_name = "travel:marcussmercenaryshop", dlc_group="headhunter"}
local regions = {
  Menu = Menu,
  WindshearWaste = WindshearWaste,
  MarcusMercenaryShop = MarcusMercenaryShop
}

function CanReach(region, level)
  local regionAccessable = false
  if(regions[region].dlc_group == "basegame" or regions[region].dlc_group == "scarlett" or regions[region].dlc_group == "torgue" or regions[region].dlc_group == "hammerlock" or regions[region].dlc_group == "tina" or regions[region].dlc_group == "ffs") then
    
  elseif (regions[region].dlc_group == "digi") then
    if(Tracker:ProviderCountForCode('travel:digistructpeak') == 1) then
      regionAccessable = true
    end
  elseif (regions[region].dlc_group == "headhunter") then
    if(Tracker:ProviderCountForCode(regions[region].travel_item_name) == 1) then
      regionAccessable = true
    end
  else
    print(regions[region].regName, " has no associated dlc_group.")
    return false
  end
  print(regionAccessable == OnLevel(level))
  return regionAccessable == OnLevel(level)
end

function OnLevel(level)
  if level == nil then
    return true
  else
    print("Error placeholder")
    return false
  end
end

function RegionSearch(region, dlc)

end