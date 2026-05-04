--[[
if arg[2] == "debug" then
    require("lldebugger").start()
end
--]]

local next, pairs, ipairs = next, pairs, ipairs

function CreateRegion(options) --Base region creation, call to initialize regions with their data
  return {
    regName = options.regName or "No Region Name",
    level_req = options.level_req or 0,
    travel_item_name = options.travel_item_name or "", -- item required to get to this region
    connecting_regions = options.connecting_regions or {}, -- regions this region goes to
    story_req_regions = options.story_req_regions or {}, -- unconnected regions also required to get to this region
    dlc_group = options.dlc_group or "basegame",
    any_entrance = options.any_entrance or {}, -- Regions where you need to be able to access one of them to be able to access this region
    multi_entrance = options.multi_entrance or {}, -- For regions with multiple entrances
    progressive_required = options.progressive_required or 0 -- Num of prog items needed for 
    }
end

local regions = { --List of all regions, created with CreateRegion command passed their relevant fields
  Menu = CreateRegion{regName = "Menu", connecting_regions = {
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
      },
  WindshearWaste = CreateRegion{regName = "WindshearWaste", level_req = 1, connecting_regions = {"SouthernShelf"}},
  SouthernShelf = CreateRegion{regName = "SouthernShelf", level_req = 3, travel_item_name = "travel:southernshelf", connecting_regions = {"SouthernShelfBay", "ThreeHornsDivide"}, progressive_required = 1},
  SouthernShelfBay = CreateRegion{regName = "SouthernShelfBay", level_req = 4, travel_item_name = "travel:southernshelfbay", dlc_group = "basegame_side", progressive_required = 1},
  ThreeHornsDivide = CreateRegion{regName = "ThreeHornsDivide", level_req = 7, travel_item_name = "travel:threehornsdivide", connecting_regions = {"ThreeHornsValley", "Sanctuary", "FrostburnCanyon", "SanctuaryHole", "TundraExpress"}, progressive_required = 2},
  Sanctuary = CreateRegion{regName = "Sanctuary", level_req = 7, travel_item_name = "travel:sanctuary", progressive_required = 3},
  FrostburnCanyon = CreateRegion{regName = "FrostburnCanyon", level_req = 9, travel_item_name = "travel:frostburncanyon", progressive_required = 4},
  ThreeHornsValley = CreateRegion{regName = "ThreeHornsValley", level_req = 8, travel_item_name = "travel:threehornsvalley", connecting_regions = {"SouthpawSteam&Power", "Dust", "Fridge", "BloodshotStronghold"}, progressive_required = 5},
  ["SouthpawSteam&Power"] = CreateRegion{regName = "SouthpawSteam&Power", level_req = 8, travel_item_name = "travel:southpawsteam&power", dlc_group = "basegame_side", progressive_required = 2},
  Dust = CreateRegion{regName = "Dust", level_req = 9, travel_item_name = "travel:thedust", connecting_regions = {"Lynchwood", "FriendshipGulag", "EridiumBlight", "Highlands"}, progressive_required = 6},
  BloodshotStronghold = CreateRegion{regName = "BloodshotStronghold", level_req = 12, travel_item_name = "travel:bloodshotstronghold", connecting_regions = {"BloodshotRamparts"}, story_req_regions = {"Dust", "FrostburnCanyon", "Sanctuary"}, progressive_required = 7},
  BloodshotRamparts = CreateRegion{regName = "BloodshotRamparts", level_req = 12, travel_item_name = "travel:bloodshotramparts", story_req_regions = {"FriendshipGulag"}, progressive_required = 8},
  FriendshipGulag = CreateRegion{regName = "FriendshipGulag", level_req = 12, travel_item_name = "travel:friendshipgulag", story_req_regions = {"BloodshotStronghold"}, progressive_required = 9},
  TundraExpress = CreateRegion{regName = "TundraExpress", level_req = 13, travel_item_name = "travel:tundraexpress", connecting_regions = {"EndOfTheLine"}, story_req_regions = {"BloodshotRamparts"}, progressive_required = 10},
  EndOfTheLine = CreateRegion{regName = "EndOfTheLine", level_req = 13, travel_item_name = "travel:endoftheline", progressive_required = 11},
  Fridge = CreateRegion{regName = "Fridge", level_req = 15, travel_item_name = "travel:thefridge", connecting_regions = {"FinksSlaughterhouse", "HighlandsOutwash"}, story_req_regions = {"EndOfTheLine"}, progressive_required = 12},
  FinksSlaughterhouse = CreateRegion{regName = "FinksSlaughterhouse", level_req = 15, travel_item_name = "travel:finksslaughterhouse", dlc_group = "basegame_side", progressive_required = 3},
  HighlandsOutwash = CreateRegion{regName = "HighlandsOutwash", level_req = 15, travel_item_name = "travel:highlandsoutwash", connecting_regions = {"Highlands"}, progressive_required = 13},
  Highlands = CreateRegion{regName = "Highlands", level_req = 16, travel_item_name = "travel:highlands", connecting_regions = {"HolySpirits", "WildlifeExploitationPreserve", "ThousandCuts", "Opportunity"}, story_req_regions = {"HighlandsOutwash"}, progressive_required = 14},
  HolySpirits = CreateRegion{regName = "HolySpirits", level_req = 18, travel_item_name = "travel:theholyspirits", dlc_group = "basegame_side", progressive_required = 4},
  SanctuaryHole = CreateRegion{regName = "SanctuaryHole", level_req = 13, travel_item_name = "travel:sanctuaryhole", connecting_regions = {"CausticCaverns"}, story_req_regions = {"EndOfTheLine"}, dlc_group = "basegame_side", progressive_required = 5},
  CausticCaverns = CreateRegion{regName = "CausticCaverns", level_req = 16, travel_item_name = "travel:causticcaverns", dlc_group = "basegame_side", progressive_required = 6},
  WildlifeExploitationPreserve = CreateRegion{regName = "WildlifeExploitationPreserve", level_req = 19, travel_item_name = "travel:wildlifeexploitationpreserve", connecting_regions = {"NaturalSelectionAnnex"}, progressive_required = 15},
  NaturalSelectionAnnex = CreateRegion{regName = "NaturalSelectionAnnex", level_req = 20, travel_item_name = "travel:naturalselectionannex", dlc_group = "basegame_side", progressive_required = 7},
  ThousandCuts = CreateRegion{regName = "ThousandCuts", level_req = 20, travel_item_name = "travel:thousandcuts", connecting_regions = {"Bunker", "TerramorphousPeak"}, progressive_required = 16},
  Lynchwood = CreateRegion{regName = "Lynchwood", level_req = 24, travel_item_name = "travel:lynchwood", dlc_group = "basegame_side", progressive_required = 8},
  Opportunity = CreateRegion{regName = "Opportunity", level_req = 20, travel_item_name = "travel:opportunity", progressive_required = 17},
  Bunker = CreateRegion{regName = "Bunker", level_req = 24, travel_item_name = "travel:thebunker", connecting_regions = {"ControlCoreAngel"}, story_req_regions = {"WildlifeExploitationPreserve", "Opportunity"}, progressive_required = 18},
  ControlCoreAngel = CreateRegion{regName = "ControlCoreAngel", level_req = 25, travel_item_name = "travel:controlcoreangel", progressive_required = 19},
  EridiumBlight = CreateRegion{regName = "EridiumBlight", level_req = 25, travel_item_name = "travel:eridiumblight", connecting_regions = {"OreChasm", "SawtoothCauldron", "AridNexusBoneyard", "HerosPass"}, story_req_regions = {"ControlCoreAngel"}, progressive_required = 20},
  OreChasm = CreateRegion{regName = "OreChasm", level_req = 25, travel_item_name = "travel:orechasm", dlc_group = "basegame_side", progressive_required = 9},
  SawtoothCauldron = CreateRegion{regName = "SawtoothCauldron", level_req = 25, travel_item_name = "travel:sawtoothcauldron", progressive_required = 21},
  AridNexusBoneyard = CreateRegion{regName = "AridNexusBoneyard", level_req = 26, travel_item_name = "travel:aridnexusboneyard", connecting_regions = {"AridNexusBadlands"}, story_req_regions = {"SawtoothCauldron"}, progressive_required = 22},
  AridNexusBadlands = CreateRegion{regName = "AridNexusBadlands", level_req = 26, travel_item_name = "travel:aridnexusbadlands", progressive_required = 23},
  HerosPass = CreateRegion{regName = "HerosPass", level_req = 29, travel_item_name = "travel:herospass", connecting_regions = {"VaultOfTheWarrior"}, story_req_regions = {"AridNexusBadlands"}, progressive_required = 24},
  VaultOfTheWarrior = CreateRegion{regName = "VaultOfTheWarrior", level_req = 30, travel_item_name = "travel:vaultofthewarrior", progressive_required = 25},
  TerramorphousPeak = CreateRegion{regName = "TerramorphousPeak", level_req = 30, travel_item_name = "travel:terramorphouspeak", story_req_regions = {"VaultOfTheWarrior"}, dlc_group = "basegame_side", progressive_required = 10},

  FFSIntroSanctuary = CreateRegion{regName = "FFSIntroSanctuary", level_req = 30, travel_item_name = "travel:ffsintrosanctuary", connecting_regions = {"Backburner"}, dlc_group = "ffs", progressive_required = 1},
  Backburner = CreateRegion{regName = "Backburner", level_req = 30, travel_item_name = "travel:thebackburner", connecting_regions = {"DahlAbandon"}, dlc_group = "ffs", progressive_required = 2},
  DahlAbandon = CreateRegion{regName = "DahlAbandon", level_req = 30, travel_item_name = "travel:dahlabandon", connecting_regions = {"Burrows", "HeliosFallen", "MtScarabResearchCenter"}, dlc_group = "ffs", progressive_required = 3},
  Burrows = CreateRegion{regName = "Burrows", level_req = 30, travel_item_name = "travel:theburrows", connecting_regions = {"HeliosFallen"}, dlc_group = "ffs", progressive_required = 4},
  HeliosFallen = CreateRegion{regName = "HeliosFallen", level_req = 30, travel_item_name = "travel:heliosfallen", story_req_regions = {"Burrows"}, dlc_group = "ffs", progressive_required = 5},
  MtScarabResearchCenter = CreateRegion{regName = "MtScarabResearchCenter", level_req = 30, travel_item_name = "travel:mtscarabresearchcenter", connecting_regions = {"FFSBossFight"}, story_req_regions = {"HeliosFallen"}, dlc_group = "ffs", progressive_required = 6},
  FFSBossFight = CreateRegion{regName = "FFSBossFight", level_req = 30, travel_item_name = "travel:ffsbossfight", connecting_regions = {"WrithingDeep"}, dlc_group = "ffs", progressive_required = 7},
  WrithingDeep = CreateRegion{regName = "WrithingDeep", level_req = 30, travel_item_name = "travel:writhingdeep", dlc_group = "ffs", progressive_required = 8},

  UnassumingDocks = CreateRegion{regName = "UnassumingDocks", level_req = 30, travel_item_name = "travel:unassumingdocks", connecting_regions = {"FlamerockRefuge"}, dlc_group = "tina", progressive_required = 1},
  FlamerockRefuge = CreateRegion{regName = "FlamerockRefuge", level_req = 30, travel_item_name = "travel:flamerockrefuge", connecting_regions = {"Forest", "MurderlinsTemple"}, dlc_group = "tina", progressive_required = 2},
  Forest = CreateRegion{regName = "Forest", level_req = 30, travel_item_name = "travel:theforest", connecting_regions = {"ImmortalWoods"}, dlc_group = "tina", progressive_required = 3},
  ImmortalWoods = CreateRegion{regName = "ImmortalWoods", level_req = 30, travel_item_name = "travel:immortalwoods", connecting_regions = {"MinesOfAvarice"}, dlc_group = "tina", progressive_required = 4},
  MinesOfAvarice = CreateRegion{regName = "MinesOfAvarice", level_req = 30, travel_item_name = "travel:minesofavarice", connecting_regions = {"HatredsShadow"}, dlc_group = "tina", progressive_required = 5},
  HatredsShadow = CreateRegion{regName = "HatredsShadow", level_req = 30, travel_item_name = "travel:hatredsshadow", connecting_regions = {"LairOfInfiniteAgony"}, dlc_group = "tina", progressive_required = 6},
  LairOfInfiniteAgony = CreateRegion{regName = "LairOfInfiniteAgony", level_req = 30, travel_item_name = "travel:lairofinfiniteagony", connecting_regions = {"DragonKeep", "WingedStorm"}, dlc_group = "tina", progressive_required = 7},
  DragonKeep = CreateRegion{regName = "DragonKeep", level_req = 30, travel_item_name = "travel:dragonkeep", dlc_group = "tina", progressive_required = 8},
  MurderlinsTemple = CreateRegion{regName = "MurderlinsTemple", level_req = 30, travel_item_name = "travel:murderlinstemple", story_req_regions = {"DragonKeep"}, dlc_group = "tina", progressive_required = 9},
  WingedStorm = CreateRegion{regName = "WingedStorm", level_req = 30, travel_item_name = "travel:thewingedstorm", story_req_regions = {"DragonKeep"}, dlc_group = "tina", progressive_required = 10},

  BadassCrater = CreateRegion{regName = "BadassCrater", level_req = 15, travel_item_name = "travel:badasscrater", connecting_regions = {"Beatdown", "TorgueArena", "BadassCraterBar", "SouthernRaceway", "Forge"}, dlc_group = "torgue", progressive_required = 1},
  TorgueArena = CreateRegion{regName = "TorgueArena", level_req = 15, travel_item_name = "travel:torguearena", dlc_group = "torgue", progressive_required = 2},
  Beatdown = CreateRegion{regName = "Beatdown", level_req = 15, travel_item_name = "travel:thebeatdown", connecting_regions = {"PyroPetesBar"}, story_req_regions = {"TorgueArena"}, dlc_group = "torgue", progressive_required = 3},
  PyroPetesBar = CreateRegion{regName = "PyroPetesBar", level_req = 15, travel_item_name = "travel:pyropetesbar", dlc_group = "torgue", progressive_required = 4},
  BadassCraterBar = CreateRegion{regName = "BadassCraterBar", level_req = 15, travel_item_name = "travel:badasscraterbar", story_req_regions = {"PyroPetesBar"}, dlc_group = "torgue", progressive_required = 5},
  SouthernRaceway = CreateRegion{regName = "SouthernRaceway", level_req = 15, travel_item_name = "travel:southernraceway", story_req_regions = {"BadassCraterBar"}, dlc_group = "torgue", progressive_required = 6},
  Forge = CreateRegion{regName = "Forge", level_req = 15, travel_item_name = "travel:theforge", story_req_regions = {"SouthernRaceway"}, dlc_group = "torgue", progressive_required = 7},

  Oasis = CreateRegion{regName = "Oasis", level_req = 15, travel_item_name = "travel:oasis", connecting_regions = {"Wurmwater", "HaytersFolly", "LeviathansLair"}, dlc_group = "scarlett", progressive_required = 1},
  Wurmwater = CreateRegion{regName = "Wurmwater", level_req = 15, travel_item_name = "travel:wurmwater", connecting_regions = {"WashburneRefinery", "Rustyards", "MagnysLighthouse"}, dlc_group = "scarlett", progressive_required = 2},
  HaytersFolly = CreateRegion{regName = "HaytersFolly", level_req = 15, travel_item_name = "travel:haytersfolly", story_req_regions = {"Wurmwater"}, dlc_group = "scarlett", progressive_required = 3},
  Rustyards = CreateRegion{regName = "Rustyards", level_req = 15, travel_item_name = "travel:therustyards", story_req_regions = {"HaytersFolly"}, dlc_group = "scarlett", progressive_required = 4},
  WashburneRefinery = CreateRegion{regName = "WashburneRefinery", level_req = 15, travel_item_name = "travel:washburnerefinery", story_req_regions = {"Rustyards"}, dlc_group = "scarlett", progressive_required = 5},
  MagnysLighthouse = CreateRegion{regName = "MagnysLighthouse", level_req = 15, travel_item_name = "travel:magnyslighthouse", story_req_regions = {"WashburneRefinery"}, dlc_group = "scarlett", progressive_required = 6},
  LeviathansLair = CreateRegion{regName = "LeviathansLair", level_req = 15, travel_item_name = "travel:theleviathanslair", story_req_regions = {"MagnysLighthouse"}, dlc_group = "scarlett", progressive_required = 7},

  HuntersGrotto = CreateRegion{regName = "HuntersGrotto", level_req = 30, travel_item_name = "travel:huntersgrotto", connecting_regions = {"ScyllasGrove", "CandlerakksCrag", "ArdortonStation"}, dlc_group = "hammerlock", progressive_required = 1},
  ScyllasGrove = CreateRegion{regName = "ScyllasGrove", level_req = 30, travel_item_name = "travel:scyllasgrove", connecting_regions = {"ArdortonStation"}, dlc_group = "hammerlock", progressive_required = 2},
  ArdortonStation = CreateRegion{regName = "ArdortonStation", level_req = 30, travel_item_name = "travel:ardortonstation", story_req_regions = {"ScyllasGrove"}, dlc_group = "hammerlock", multi_entrance = {"ScyllasGrove", "HuntersGrotto"}, progressive_required = 3},
  CandlerakksCrag = CreateRegion{regName = "CandlerakksCrag", level_req = 30, travel_item_name = "travel:candlerakkscragg", connecting_regions = {"Terminus"}, story_req_regions = {"ArdortonStation"}, dlc_group = "hammerlock", progressive_required = 4},
  Terminus = CreateRegion{regName = "Terminus", level_req = 30, travel_item_name = "travel:terminus", dlc_group = "hammerlock", progressive_required = 5},

  DigistructPeak = CreateRegion{regName = "DigistructPeak", level_req = 0, travel_item_name = "travel:digistructpeak", connecting_regions = {"DigistructPeakInner"}, dlc_group = "digi"},
  DigistructPeakInner = CreateRegion{regName = "DigistructPeakInner", level_req = 30, travel_item_name = "travel:digistructpeak", dlc_group = "digi"},
  -- DigistructPeakOP5 = CreateRegion{regName = "DigistructPeakOP5", ""},

  HallowedHollow = CreateRegion{regName = "HallowedHollow", level_req = 15, travel_item_name = "travel:hallowedhollow", dlc_group = "headhunter", progressive_required = 1},
  GluttonyGulch = CreateRegion{regName = "GluttonyGulch", level_req = 15, travel_item_name = "travel:gluttonygulch", dlc_group = "headhunter", progressive_required = 2},
  MarcusMercenaryShop = CreateRegion{regName = "MarcusMercenaryShop", level_req = 15, travel_item_name = "travel:marcussmercenaryshop", dlc_group = "headhunter", progressive_required = 3},
  RotgutDistillery = CreateRegion{regName = "RotgutDistillery", level_req = 15, travel_item_name = "travel:rotgutdistillery", dlc_group = "headhunter", progressive_required = 4},
  WamBamIsland = CreateRegion{regName = "WamBamIsland", level_req = 15, travel_item_name = "travel:wambamisland", dlc_group = "headhunter", progressive_required = 5},

  Level0 = CreateRegion{regName = "Level0", level_req = 0, connecting_regions = {"Level1to5"}, dlc_group = "level",},
  Level1to5 = CreateRegion{regName = "Level1to5", level_req = 1, connecting_regions = {"Level6to10"}, dlc_group = "level",},
  Level6to10 = CreateRegion{regName = "Level6to10", level_req = 6, connecting_regions = {"Level11to15"}, dlc_group = "level",
    any_entrance = {"SouthernShelf", "SouthernShelfBay"}},
  Level11to15 = CreateRegion{regName = "Level11to15", level_req = 11, connecting_regions = {"Level16to20"}, dlc_group = "level",
    any_entrance = {"ThreeHornsDivide", "ThreeHornsValley", "FrostburnCanyon", "SouthpawSteam&Power", "FriendshipGulag"}},
  Level16to20 = CreateRegion{regName = "Level16to20", level_req = 16, connecting_regions = {"Level21to25"}, dlc_group = "level",
    any_entrance = {"Dust", "BloodshotStronghold", "BloodshotRamparts", "Fridge", "HighlandsOutwash",
    "FinksSlaughterhouse", "SanctuaryHole", "TundraExpress", "EndOfTheLine", "MarcusMercenaryShop",
    "GluttonyGulch", "RotgutDistillery", "WamBamIsland", "HallowedHollow", "BadassCrater", "Oasis"}},
  Level21to25 = CreateRegion{regName = "Level21to25", level_req = 21, connecting_regions = {"Level26to30"}, dlc_group = "level",
    any_entrance = {"Highlands", "CausticCaverns", "WildlifeExploitationPreserve", "NaturalSelectionAnnex", "Opportunity", "ThousandCuts",
    "PyroPetesBar", "Forge", "MagnysLighthouse", "LeviathansLair"}},
  Level26to30 = CreateRegion{regName = "Level26to30", level_req = 26, connecting_regions = {"Level31+"}, dlc_group = "level",
    any_entrance = {"Lynchwood", "Bunker", "EridiumBlight", "SawtoothCauldron"}},
  ["Level31+"] = CreateRegion{regName = "Level31+", level_req = 31, dlc_group = "level",
    any_entrance = {"VaultOfTheWarrior"}},
}

local entrances = {}
for _, region in pairs(regions) do -- check every region
  if (next(regions[region.regName].connecting_regions) ~= nil) then -- if region has connecting_regions
    for _, connectingRegion in ipairs(region.connecting_regions) do -- then for every connecting region
      table.insert(entrances, {entryRegion = region.regName, exitRegion = connectingRegion, storyRegions = regions[connectingRegion].story_req_regions, anyEntrance = region.any_entrance}) -- create an entrance
    end
  end
end

function CanReachRegion(region)
  local regionAccessable = AccessibilityLevel.None
  if(RegionOpen(region)) then
    regionAccessable = AccessibilityLevel.Normal
  end
  print(regionAccessable.." "..region)
  return regionAccessable
end

function CanAccessAllRegions(regionArray)
  if(next(regionArray) == nil) then return true end
  for _, regionToCheck in ipairs(regionArray) do
    if(not(RegionOpen(regionToCheck))) then
      return false
    end
  end
  return true
end

function CanAccessAnyRegions(regionArray)
  if(next(regionArray) == nil) then return true end
  for _, regionToCheck in ipairs(regionArray) do
    if((RegionOpen(regionToCheck))) then
      return true
    end
  end
  return false
end

function RegionOpen(region)
  if (Tracker:FindObjectForCode("entrance_locks_disabled").Active) then
    return true
  end
  if ((regions[region].dlc_group ~= "digi" and regions[region].dlc_group ~= "level") and Tracker:FindObjectForCode("progressive_travel_" .. regions[region].dlc_group .. "_enabled").Active) then
    return ProgressiveCheck(region)
  end
  if (regions[region].dlc_group == "digi") then return HasTravelItem(region) end
  if region == "Menu" then return true end
  if region == "WindshearWaste" then return true end
  if region == "Level0" then return true end
  if((regions[region].travel_item_name ~= "") and (not(HasTravelItem(region)))) then -- If you dont have the travel item for the region, return false
    return false
  end
  if(next(regions[region].multi_entrance) ~= nil) then  -- If has multiple entrances, check if can access any of the entrances
    return (CanAccessAnyRegions(regions[region].multi_entrance)) -- Needs to be updated in the case of entrance randomizer
  end
  for _, entranceToCheck in ipairs(entrances) do
    if(entranceToCheck.exitRegion == region) then
      if(next(entranceToCheck.storyRegions) ~= nil) then
        if(not(CanAccessAllRegions(entranceToCheck.storyRegions))) then
          return false
        end
        if (not(RegionOpen(entranceToCheck.entryRegion))) then
          return false
        end
        if (not(MiscCasesEntrances(entranceToCheck))) then
          return false
        end
        if(next(entranceToCheck.any_entrance) ~= nil) then
          if (not(CanAccessAnyRegions(entranceToCheck.any_entrance))) then
            return false
          end
        end
        return true
      else
        if (not(RegionOpen(entranceToCheck.entryRegion))) then
          return false
        end
        if (not(MiscCasesEntrances(entranceToCheck))) then
          return false
        end
        if(regions[region].dlc_group == "level") then
          if (not(CanAccessAnyRegions(entranceToCheck.any_entrance))) then
            return false
          end
        end
        return true
      end
    end
  end
end

function HasTravelItem(regionToCheck)
  if(regionToCheck == "WindshearWaste") then
    return true -- return true if checking windshear
  elseif(regionToCheck == "Menu") then
    return true -- return true if checking menu
  elseif(regionToCheck == "Level0") then
    return true -- return true if level 0
  elseif(Tracker:FindObjectForCode(regions[regionToCheck].travel_item_name).Active) then
    return true -- return true if you have the travel item
  else
    return false
  end
end

function MiscCasesEntrances(entranceToCheck)
  if((Tracker:FindObjectForCode("gear_licenses").CurrentStage > 0) and (entranceToCheck.entryRegion == "WindshearWaste") and (entranceToCheck.exitRegion == "SouthernShelf"))then
    return (Tracker:FindObjectForCode("melee").Active) or (Tracker:FindObjectForCode("license:commonpistol").Active)
  elseif((entranceToCheck.entryRegion == "Menu") and (entranceToCheck.exitRegion == "FFSIntroSanctuary")) then
    return (Tracker:FindObjectForCode("travel:thebackburner").Active or (Tracker:FindObjectForCode("progressivetravel:fightforsanctuary").AcquiredCount >= 2))
  elseif((entranceToCheck.entryRegion == "HuntersGrotto") and (entranceToCheck.exitRegion == "CandlerakksCrag")) then
    return Tracker:FindObjectForCode("commonpistol").Active
  elseif((entranceToCheck.entryRegion == "CandlerakksCrag") and (entranceToCheck.exitRegion == "Terminus")) then
    return Tracker:FindObjectForCode("crouch").Active
  elseif((entranceToCheck.entryRegion == "MtScarabResearchCenter") and (entranceToCheck.exitRegion == "FFSBossFight")) then
    return Tracker:FindObjectForCode("melee").Active
  elseif((entranceToCheck.entryRegion == "HatredsShadow") and (entranceToCheck.exitRegion == "LairOfInfiniteAgony")) then
    return Tracker:FindObjectForCode("crouch").Active
  elseif((entranceToCheck.entryRegion == "TundraExpress") and (entranceToCheck.exitRegion == "EndOfTheLine")) then
    if Tracker:FindObjectForCode("progressive_travel_toggle_basegame").Active then
      if Tracker:ProviderCountForCode("progressivetravel:basegame") >= regions["Highlands"].progressive_required then
        return true
      else
        return false
      end
    end
    if (Tracker:FindObjectForCode(regions["Fridge"].travel_item_name).Active) and (Tracker:FindObjectForCode(regions["HighlandsOutwash"].travel_item_name).Active) and (Tracker:FindObjectForCode(regions["Highlands"].travel_item_name).Active) then
      return true
    else
      return false
    end
  elseif(Tracker:FindObjectForCode("jump_checks").CurrentStage > 0) then
    if((entranceToCheck.entryRegion == "BadassCrater") and (entranceToCheck.exitRegion == "TorgueArena")) then
      return JumpHeight(490)
    elseif((entranceToCheck.entryRegion == "CandlerakksCrag") and (entranceToCheck.exitRegion == "Terminus")) then
      return JumpHeight(629)
    end
  elseif (entranceToCheck.entryRegion == "Level0") and (entranceToCheck.exitRegion == "Level1to5") then
    return Level1to5()
  elseif (entranceToCheck.entryRegion == "Level1to5") and (entranceToCheck.exitRegion == "Level6to1") then
    return Level6to10()
  else
    return true
  end
end

function ProgressiveCheck(regionToCheck)
  if (Tracker:FindObjectForCode("entrance_locks_disabled").Active) then
    return true
  end
  if regionToCheck == "Menu" then return true end
  if regionToCheck == "WindshearWaste" then return true end
  if regionToCheck == "Level0" then return true end
  if (Tracker:ProviderCountForCode("progressivetravel:" .. regions[regionToCheck].dlc_group)) < regions[regionToCheck].progressive_required then
    return false
  end
  if (regions[regionToCheck].dlc_group == "basegame_side") then
    for _, entranceToCheck in pairs(entrances) do
      if (entranceToCheck.exitRegion == regionToCheck) then
        if (not(RegionOpen(entranceToCheck.entryRegion))) then
          return false
        end
      end
    end
  end
  if (Tracker:ProviderCountForCode("progressivetravel:" .. regions[regionToCheck].dlc_group)) >= regions[regionToCheck].progressive_required then
    for _, entranceToCheck in ipairs(entrances) do
      if(entranceToCheck.exitRegion == regionToCheck) then
        if(next(entranceToCheck.storyRegions) ~= nil) then
          if (not(MiscCasesEntrances(entranceToCheck))) then
            return false
          end
          if(next(entranceToCheck.any_entrance) ~= nil) then
            if (not(CanAccessAnyRegions(entranceToCheck.any_entrance))) then
              return false
            end
          end
          return true
        else
          if(not(CanAccessAllRegions(entranceToCheck.storyRegions))) then
            return false
          end
          if (not(MiscCasesEntrances(entranceToCheck))) then
            return false
          end
          if(next(entranceToCheck.any_entrance) ~= nil) then
            if (not(CanAccessAnyRegions(entranceToCheck.any_entrance))) then
              return false
            end
          end
          return true
        end
      end
    end
  end
  print("An error has occured in ProgressiveCheck")
  return false
end

function JumpHeight(height)
  height = tonumber(height)
  if(Tracker:FindObjectForCode("jump_checks").CurrentStage == 0) then
    return true
  elseif(height < 220) then  -- Height with no jump items
    return true
  elseif(height > 630) then  -- Normal jump height, should never be needed
    return false
  end
  local heightBonus = Tracker:FindObjectForCode("max_jump_height").CurrentStage * 300
  local maxHeight = 630 + heightBonus
  local frac = Tracker:ProviderCountForCode("progressivejump") / Tracker:FindObjectForCode("jump_checks").CurrentStage
  frac = math.sqrt(frac)
  local currentJump = math.max(220, math.min(maxHeight, maxHeight * frac))
  return (currentJump >= height)
end

function OnLevel(level)
  level = tonumber(level)
  if level == 0 then
    return AccessibilityLevel.Normal
  elseif ((1 <= level and level <= 5) and (RegionOpen("Level1to5"))) then
    return AccessibilityLevel.Normal
  elseif ((6 <= level and level <= 10) and (RegionOpen("Level6to10"))) then
    return AccessibilityLevel.Normal
  elseif ((11 <= level and level <= 15) and (RegionOpen("Level11to15"))) then
    return AccessibilityLevel.Normal
  elseif ((16 <= level and level <= 20) and (RegionOpen("Level16to20"))) then
    return AccessibilityLevel.Normal
  elseif ((21 <= level and level <= 25) and (RegionOpen("Level21to25"))) then
    return AccessibilityLevel.Normal
  elseif ((26 <= level and level <= 30) and (RegionOpen("Level26to30"))) then
    return AccessibilityLevel.Normal
  elseif ((level > 30) and (RegionOpen("Level31+"))) then
    return AccessibilityLevel.Normal
  else
    return AccessibilityLevel.SequenceBreak
  end
end

function LevelLimit(level)
  level = tonumber(level)
  if((level > Tracker:FindObjectForCode("max_level_checks").AcquiredCount) and (Tracker:ProviderCountForCode("max_level_checks") ~= 0)) then -- false if over max check level
    return false
  end
  return true
end

function Level1to5()
  return (Tracker:FindObjectForCode("melee").Active) or (Tracker:FindObjectForCode("license:commonpistol").Active)
end

function Level6to10()
  return (Tracker:FindObjectForCode("melee").Active) and (Tracker:FindObjectForCode("license:commonpistol").Active) and (Tracker:FindObjectForCode("license:commonshield").Active) and (Tracker:FindObjectForCode("license:commonshotgun").Active) and (Tracker:FindObjectForCode("license:uncommonpistol").Active)
end