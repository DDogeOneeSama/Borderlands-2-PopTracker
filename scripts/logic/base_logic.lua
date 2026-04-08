--[[
if arg[2] == "debug" then
    require("lldebugger").start()
end
--]]
function CreateRegion(options) --Base region creation, call to initialize regions with their data
  return {
    regName = options.regName or "No Region Name",
    level_req = options.level_req or 0,
    travel_item_name = options.travel_item_name or "", -- item required to get to this region
    connecting_regions = options.connecting_regions or {}, -- regions this region goes to
    story_req_regions = options.story_req_regions or {}, -- unconnected regions also required to get to this region
    dlc_group = options.dlc_group or "basegame",
    any_entrance = options.any_entrance or {}, -- Regions where you need to be able to access one of them to be able to access this region
    multi_entrance = options.multi_entrance or {} -- For regions with multiple entrances
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
  SouthernShelf = CreateRegion{regName = "SouthernShelf", level_req = 3, travel_item_name = "travel:southernshelf", connecting_regions = {"SouthernShelfBay", "ThreeHornsDivide"}},
  SouthernShelfBay = CreateRegion{regName = "SouthernShelfBay", level_req = 4, travel_item_name = "travel:southernshelfbay"},
  ThreeHornsDivide = CreateRegion{regName = "ThreeHornsDivide", level_req = 7, travel_item_name = "travel:threehornsdivide", connecting_regions = {"ThreeHornsValley", "Sanctuary", "FrostburnCanyon", "SanctuaryHole", "TundraExpress"}},
  ThreeHornsValley = CreateRegion{regName = "ThreeHornsValley", level_req = 8, travel_item_name = "travel:threehornsvalley", connecting_regions = {"SouthpawSteam&Power", "Dust", "Fridge", "BloodshotStronghold"}},
  Sanctuary = CreateRegion{regName = "Sanctuary", level_req = 7, travel_item_name = "travel:sanctuary"},
  FrostburnCanyon = CreateRegion{regName = "FrostburnCanyon", level_req = 9, travel_item_name = "travel:frostburncanyon", story_req_regions = {"Sanctuary"}},
  ["SouthpawSteam&Power"] = CreateRegion{regName = "SouthpawSteam&Power", level_req = 8, travel_item_name = "travel:southpawsteam&power"},
  Dust = CreateRegion{regName = "Dust", level_req = 9, travel_item_name = "travel:thedust", connecting_regions = {"Lynchwood", "FriendshipGulag", "EridiumBlight", "Highlands"}},
  Lynchwood = CreateRegion{regName = "Lynchwood", level_req = 24, travel_item_name = "travel:lynchwood"},
  FriendshipGulag = CreateRegion{regName = "FriendshipGulag", level_req = 12, travel_item_name = "travel:friendshipgulag", story_req_regions = {"BloodshotStronghold"}},
  BloodshotStronghold = CreateRegion{regName = "BloodshotStronghold", level_req = 12, travel_item_name = "travel:bloodshotstronghold", connecting_regions = {"BloodshotRamparts"}, story_req_regions = {"Dust", "FrostburnCanyon"}},
  BloodshotRamparts = CreateRegion{regName = "BloodshotRamparts", level_req = 12, travel_item_name = "travel:bloodshotramparts", story_req_regions = {"FriendshipGulag"}},
  TundraExpress = CreateRegion{regName = "TundraExpress", level_req = 13, travel_item_name = "travel:tundraexpress", connecting_regions = {"EndOfTheLine"}, story_req_regions = {"BloodshotRamparts"}},
  EndOfTheLine = CreateRegion{regName = "EndOfTheLine", level_req = 13, travel_item_name = "travel:endoftheline", story_req_regions = {"Fridge, HighlandsOutwash, Highlands"}},
  SanctuaryHole = CreateRegion{regName = "SanctuaryHole", level_req = 13, travel_item_name = "travel:sanctuaryhole", connecting_regions = {"CausticCaverns"}, story_req_regions = {"EndOfTheLine"}},
  CausticCaverns = CreateRegion{regName = "CausticCaverns", level_req = 16, travel_item_name = "travel:causticcaverns"},
  Fridge = CreateRegion{regName = "Fridge", level_req = 15, travel_item_name = "travel:thefridge", connecting_regions = {"FinksSlaughterhouse", "HighlandsOutwash"}, story_req_regions = {"EndOfTheLine"}},
  FinksSlaughterhouse = CreateRegion{regName = "FinksSlaughterhouse", level_req = 15, travel_item_name = "travel:finksslaughterhouse"},
  HighlandsOutwash = CreateRegion{regName = "HighlandsOutwash", level_req = 15, travel_item_name = "travel:highlandsoutwash", connecting_regions = {"Highlands"}},
  Highlands = CreateRegion{regName = "Highlands", level_req = 16, travel_item_name = "travel:highlands", connecting_regions = {"HolySpirits", "WildlifeExploitationPreserve", "ThousandCuts", "Opportunity"}, story_req_regions = {"HighlandsOutwash"}},
  HolySpirits = CreateRegion{regName = "HolySpirits", level_req = 18, travel_item_name = "travel:theholyspirits"},
  WildlifeExploitationPreserve = CreateRegion{regName = "WildlifeExploitationPreserve", level_req = 19, travel_item_name = "travel:wildlifeexploitationpreserve", connecting_regions = {"NaturalSelectionAnnex"}},
  NaturalSelectionAnnex = CreateRegion{regName = "NaturalSelectionAnnex", level_req = 20, travel_item_name = "travel:naturalselectionannex"},
  ThousandCuts = CreateRegion{regName = "ThousandCuts", level_req = 20, travel_item_name = "travel:thousandcuts", connecting_regions = {"Bunker", "TerramorphousPeak"}},
  Opportunity = CreateRegion{regName = "Opportunity", level_req = 20, travel_item_name = "travel:opportunity"},
  Bunker = CreateRegion{regName = "Bunker", level_req = 24, travel_item_name = "travel:thebunker", connecting_regions = {"ControlCoreAngel"}, story_req_regions = {"WildlifeExploitationPreserve", "Opportunity"}},
  ControlCoreAngel = CreateRegion{regName = "ControlCoreAngel", level_req = 25, travel_item_name = "travel:controlcoreangel"},
  EridiumBlight = CreateRegion{regName = "EridiumBlight", level_req = 25, travel_item_name = "travel:eridiumblight", connecting_regions = {"OreChasm", "SawtoothCauldron", "AridNexusBoneyard", "HerosPass"}, story_req_regions = {"ControlCoreAngel"}},
  OreChasm = CreateRegion{regName = "OreChasm", level_req = 25, travel_item_name = "travel:orechasm"},
  SawtoothCauldron = CreateRegion{regName = "SawtoothCauldron", level_req = 25, travel_item_name = "travel:sawtoothcauldron"},
  AridNexusBoneyard = CreateRegion{regName = "AridNexusBoneyard", level_req = 26, travel_item_name = "travel:aridnexusboneyard", connecting_regions = {"AridNexusBadlands"}, story_req_regions = {"SawtoothCauldron"}},
  AridNexusBadlands = CreateRegion{regName = "AridNexusBadlands", level_req = 26, travel_item_name = "travel:aridnexusbadlands"},
  HerosPass = CreateRegion{regName = "HerosPass", level_req = 29, travel_item_name = "travel:herospass", connecting_regions = {"VaultOfTheWarrior"}, story_req_regions = {"AridNexusBadlands"}},
  VaultOfTheWarrior = CreateRegion{regName = "VaultOfTheWarrior", level_req = 30, travel_item_name = "travel:vaultofthewarrior"},
  TerramorphousPeak = CreateRegion{regName = "TerramorphousPeak", level_req = 30, travel_item_name = "travel:terramorphouspeak", story_req_regions = {"VaultOfTheWarrior"}},

  FFSIntroSanctuary = CreateRegion{regName = "FFSIntroSanctuary", level_req = 30, travel_item_name = "travel:ffsintrosanctuary", connecting_regions = {"Backburner"}, dlc_group = "ffs"},
  Backburner = CreateRegion{regName = "Backburner", level_req = 30, travel_item_name = "travel:thebackburner", connecting_regions = {"DahlAbandon"}, dlc_group = "ffs"},
  DahlAbandon = CreateRegion{regName = "DahlAbandon", level_req = 30, travel_item_name = "travel:dahlabandon", connecting_regions = {"Burrows", "HeliosFallen", "MtScarabResearchCenter"}, dlc_group = "ffs"},
  Burrows = CreateRegion{regName = "Burrows", level_req = 30, travel_item_name = "travel:theburrows", connecting_regions = {"HeliosFallen"}, dlc_group = "ffs"},
  HeliosFallen = CreateRegion{regName = "HeliosFallen", level_req = 30, travel_item_name = "travel:heliosfallen", story_req_regions = {"Burrows"}, dlc_group = "ffs"},
  MtScarabResearchCenter = CreateRegion{regName = "MtScarabResearchCenter", level_req = 30, travel_item_name = "travel:mtscarabresearchcenter", connecting_regions = {"FFSBossFight"}, story_req_regions = {"HeliosFallen"}, dlc_group = "ffs"},
  FFSBossFight = CreateRegion{regName = "FFSBossFight", level_req = 30, travel_item_name = "travel:ffsbossfight", connecting_regions = {"WrithingDeep"}, dlc_group = "ffs"},
  WrithingDeep = CreateRegion{regName = "WrithingDeep", level_req = 30, travel_item_name = "travel:writhingdeep", dlc_group = "ffs"},

  UnassumingDocks = CreateRegion{regName = "UnassumingDocks", level_req = 30, travel_item_name = "travel:unassumingdocks", connecting_regions = {"FlamerockRefuge"}, dlc_group = "tina"},
  FlamerockRefuge = CreateRegion{regName = "FlamerockRefuge", level_req = 30, travel_item_name = "travel:flamerockrefuge", connecting_regions = {"Forest", "MurderlinsTemple"}, dlc_group = "tina"},
  Forest = CreateRegion{regName = "Forest", level_req = 30, travel_item_name = "travel:theforest", connecting_regions = {"ImmortalWoods"}, dlc_group = "tina"},
  ImmortalWoods = CreateRegion{regName = "ImmortalWoods", level_req = 30, travel_item_name = "travel:immortalwoods", connecting_regions = {"MinesOfAvarice"}, dlc_group = "tina"},
  MinesOfAvarice = CreateRegion{regName = "MinesOfAvarice", level_req = 30, travel_item_name = "travel:minesofavarice", connecting_regions = {"HatredsShadow"}, dlc_group = "tina"},
  HatredsShadow = CreateRegion{regName = "HatredsShadow", level_req = 30, travel_item_name = "travel:hatredsshadow", connecting_regions = {"LairOfInfiniteAgony"}, dlc_group = "tina"},
  LairOfInfiniteAgony = CreateRegion{regName = "LairOfInfiniteAgony", level_req = 30, travel_item_name = "travel:lairofinfiniteagony", connecting_regions = {"DragonKeep", "WingedStorm"}, dlc_group = "tina"},
  DragonKeep = CreateRegion{regName = "DragonKeep", level_req = 30, travel_item_name = "travel:dragonkeep", dlc_group = "tina"},
  MurderlinsTemple = CreateRegion{regName = "MurderlinsTemple", level_req = 30, travel_item_name = "travel:murderlinstemple", story_req_regions = {"DragonKeep"}, dlc_group = "tina"},
  WingedStorm = CreateRegion{regName = "WingedStorm", level_req = 30, travel_item_name = "travel:thewingedstorm", story_req_regions = {"DragonKeep"}, dlc_group = "tina"},

  BadassCrater = CreateRegion{regName = "BadassCrater", level_req = 15, travel_item_name = "travel:badasscrater", connecting_regions = {"Beatdown", "TorgueArena", "BadassCraterBar", "SouthernRaceway", "Forge"}, dlc_group = "torgue"},
  TorgueArena = CreateRegion{regName = "TorgueArena", level_req = 15, travel_item_name = "travel:torguearena", dlc_group = "torgue"},
  Beatdown = CreateRegion{regName = "Beatdown", level_req = 15, travel_item_name = "travel:thebeatdown", connecting_regions = {"PyroPetesBar"}, story_req_regions = {"TorgueArena"}, dlc_group = "torgue"},
  PyroPetesBar = CreateRegion{regName = "PyroPetesBar", level_req = 15, travel_item_name = "travel:pyropetesbar", dlc_group = "torgue"},
  BadassCraterBar = CreateRegion{regName = "BadassCraterBar", level_req = 15, travel_item_name = "travel:badasscraterbar", story_req_regions = {"PyroPetesBar"}, dlc_group = "torgue"},
  SouthernRaceway = CreateRegion{regName = "SouthernRaceway", level_req = 15, travel_item_name = "travel:southernraceway", story_req_regions = {"BadassCraterBar"}, dlc_group = "torgue"},
  Forge = CreateRegion{regName = "Forge", level_req = 15, travel_item_name = "travel:theforge", story_req_regions = {"SouthernRaceway"}, dlc_group = "torgue"},

  Oasis = CreateRegion{regName = "Oasis", level_req = 15, travel_item_name = "travel:oasis", connecting_regions = {"Wurmwater", "HaytersFolly", "LeviathansLair"}, dlc_group = "scarlett"},
  Wurmwater = CreateRegion{regName = "Wurmwater", level_req = 15, travel_item_name = "travel:wurmwater", connecting_regions = {"WashburneRefinery", "Rustyards", "MagnysLighthouse"}, dlc_group = "scarlett"},
  HaytersFolly = CreateRegion{regName = "HaytersFolly", level_req = 15, travel_item_name = "travel:haytersfolly", story_req_regions = {"Wurmwater"}, dlc_group = "scarlett"},
  Rustyards = CreateRegion{regName = "Rustyards", level_req = 15, travel_item_name = "travel:therustyards", story_req_regions = {"HaytersFolly"}, dlc_group = "scarlett"},
  WashburneRefinery = CreateRegion{regName = "WashburneRefinery", level_req = 15, travel_item_name = "travel:washburnerefinery", story_req_regions = {"Rustyards"}, dlc_group = "scarlett"},
  MagnysLighthouse = CreateRegion{regName = "MagnysLighthouse", level_req = 15, travel_item_name = "travel:magnyslighthouse", story_req_regions = {"WashburneRefinery"}, dlc_group = "scarlett"},
  LeviathansLair = CreateRegion{regName = "LeviathansLair", level_req = 15, travel_item_name = "travel:theleviathanslair", story_req_regions = {"MagnysLighthouse"}, dlc_group = "scarlett"},

  HuntersGrotto = CreateRegion{regName = "HuntersGrotto", level_req = 30, travel_item_name = "travel:huntersgrotto", connecting_regions = {"ScyllasGrove", "CandlerakksCrag", "ArdortonStation"}, dlc_group = "hammerlock"},
  ScyllasGrove = CreateRegion{regName = "ScyllasGrove", level_req = 30, travel_item_name = "travel:scyllasgrove", connecting_regions = {"ArdortonStation"}, dlc_group = "hammerlock"},
  ArdortonStation = CreateRegion{regName = "ArdortonStation", level_req = 30, travel_item_name = "travel:ardortonstation", story_req_regions = {"ScyllasGrove"}, dlc_group = "hammerlock", multi_entrance = {"ScyllasGrove", "HuntersGrotto"}},
  CandlerakksCrag = CreateRegion{regName = "CandlerakksCrag", level_req = 30, travel_item_name = "travel:candlerakkscragg", connecting_regions = {"Terminus"}, story_req_regions = {"ArdortonStation"}, dlc_group = "hammerlock"},
  Terminus = CreateRegion{regName = "Terminus", level_req = 30, travel_item_name = "travel:terminus", dlc_group = "hammerlock"},

  DigistructPeak = CreateRegion{regName = "DigistructPeak", level_req = 0, travel_item_name = "travel:digistructpeak", connecting_regions = {"DigistructPeakInner"}, dlc_group = "digi"},
  DigistructPeakInner = CreateRegion{regName = "DigistructPeakInner", level_req = 30, travel_item_name = "travel:digistructpeak", dlc_group = "digi"},
  -- DigistructPeakOP5 = CreateRegion{regName = "DigistructPeakOP5", ""},

  MarcusMercenaryShop = CreateRegion{regName = "MarcusMercenaryShop", level_req = 15, travel_item_name = "travel:marcussmercenaryshop", dlc_group = "headhunter"},
  GluttonyGulch = CreateRegion{regName = "GluttonyGulch", level_req = 15, travel_item_name = "travel:gluttonygulch", dlc_group = "headhunter"},
  RotgutDistillery = CreateRegion{regName = "RotgutDistillery", level_req = 15, travel_item_name = "travel:rotgutdistillery", dlc_group = "headhunter"},
  WamBamIsland = CreateRegion{regName = "WamBamIsland", level_req = 15, travel_item_name = "travel:wambamisland", dlc_group = "headhunter"},
  HallowedHollow = CreateRegion{regName = "HallowedHollow", level_req = 15, travel_item_name = "travel:hallowedhollow", dlc_group = "headhunter"},

  Level0 = CreateRegion{regName = "Level0", level_req = 0, connecting_regions = {"Level1to5"}},
  Level1to5 = CreateRegion{regName = "Level1to5", level_req = 1, connecting_regions = {"Level6to10"}},
  Level6to10 = CreateRegion{regName = "Level6to10", level_req = 6, connecting_regions = {"Level11to15"},
    any_entrance = {"SouthernShelf", "SouthernShelfBay"}},
  Level11to15 = CreateRegion{regName = "Level11to15", level_req = 11, connecting_regions = {"Level16to20"},
    any_entrance = {"ThreeHornsDivide", "ThreeHornsValley", "FrostburnCanyon", "SouthpawSteam&Power", "FriendshipGulag"}},
  Level16to20 = CreateRegion{regName = "Level16to20", level_req = 16, connecting_regions = {"Level21to25"},
    any_entrance = {"Dust", "BloodshotStronghold", "BloodshotRamparts", "Fridge", "HighlandsOutwash",
    "FinksSlaughterhouse", "SanctuaryHole", "TundraExpress", "EndOfTheLine", "MarcusMercenaryShop",
    "GluttonyGulch", "RotgutDistillery", "WamBamIsland", "HallowedHollow", "BadassCrater", "Oasis"}},
  Level21to25 = CreateRegion{regName = "Level21to25", level_req = 21, connecting_regions = {"Level26to30"}, 
    any_entrance = {"Highlands", "CausticCaverns", "WildlifeExploitationPreserve", "NaturalSelectionAnnex", "Opportunity", "ThousandCuts",
    "PyroPetesBar", "Forge", "MagnysLighthouse", "LeviathansLair"}},
  Level26to30 = CreateRegion{regName = "Level26to30", level_req = 26, connecting_regions = {"Level31+"},
    any_entrance = {"Lynchwood", "Bunker", "EridiumBlight", "SawtoothCauldron"}},
  ["Level31+"] = CreateRegion{regName = "Level31+", level_req = 31,
    any_entrance = {"VaultOfTheWarrior"}},
}

local entrances = {}
for _, region in pairs(regions) do -- check every region
  if (regions[region.regName].connecting_regions ~= {}) then -- if region has connecting_regions
    for _, connectingRegion in ipairs(region.connecting_regions) do -- then for every connecting region
      table.insert(entrances, {entryRegion = region.regName, exitRegion = connectingRegion, travelItem = regions[connectingRegion].travel_item_name, storyRegions = regions[connectingRegion].story_req_regions, anyEntrance = region.any_entrance}) -- create an entrance
    end
  end
end

function CanReachRegion(region)
  local regionAccessable = false
  regionAccessable = RegionOpen(region)
  return regionAccessable
end

function CanAccessAllRegions(regionArray)
  for _, regionToCheck in ipairs(regionArray) do
    if(~(RegionOpen(regionToCheck))) then
      return false
    end
  end
  return true
end

function CanAccessAnyRegions(regionArray)
  if(regionArray == {}) then return true end
  for _, regionToCheck in ipairs(regionArray) do
    if((RegionOpen(regionToCheck))) then
      return true
    end
  end
  return false
end

function RegionOpen(region)
  if region == "Menu" then return true end
  if region == "WindshearWaste" then return true end
  if region == "Level0" then return true end
  if(~(HasTravelItem(region))) then -- If you dont have the travel item for the region, return false
    return false
  end
  if(regions[region].multi_entrance ~= {}) then  -- If has multiple entrances, check if can access any of the entrances
    return (CanAccessAnyRegions(regions[region].multi_entrance)) -- Needs to be updated in the case of entrance randomizer
  end
  for _, entranceToCheck in ipairs(entrances) do
    if(entranceToCheck.exitRegion == region) then
      if(entranceToCheck.storyRegions ~= {}) then
        if(~(CanAccessAllRegions(entranceToCheck.storyRegions))) then
          return false
        end
        if (~(RegionOpen(entranceToCheck.entryRegion))) then
          return false
        end
        if (~(MiscCasesEntrances(entranceToCheck))) then
          return false
        end
        if((~(entranceToCheck.any_entrance == {})) and (~(CanAccessAnyRegions(entranceToCheck.any_entrance)))) then
          return false
        end
        return true
      else
        if (~(RegionOpen(entranceToCheck.entryRegion))) then
          return false
        end
        if (~(MiscCasesEntrances(entranceToCheck))) then
          return false
        end
        if((~(entranceToCheck.any_entrance == {})) and (~(CanAccessAnyRegions(entranceToCheck.any_entrance)))) then
          return false
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
    return true -- return true if checking menu
  elseif(Tracker:FindObjectForCode(regions[regionToCheck].travel_item_name).Active) then
    return true -- return true if you have the travel item
  else
    return false
  end
end

function MiscCasesEntrances(entranceToCheck)
  if((SLOT_DATA[gear_rarity_item_pool] > 0) and (entranceToCheck.entryRegion == "WindshearWaste") and (entranceToCheck.exitRegion == "SouthernShelf"))then
    return (Tracker:FindObjectForCode("melee").Active or Tracker:FindObjectForCode("commonpistol").Active)
  elseif((entranceToCheck.entryRegion == "Menu") and (entranceToCheck.exitRegion == "FFSIntroSanctuary")) then
    return Tracker:FindObjectForCode("travel:thebackburner").Active
  elseif((entranceToCheck.entryRegion == "HuntersGrotto") and (entranceToCheck.exitRegion == "CandlerakksCrag")) then
    return Tracker:FindObjectForCode("commonpistol").Active
  elseif((entranceToCheck.entryRegion == "CandlerakksCrag") and (entranceToCheck.exitRegion == "Terminus")) then
    return Tracker:FindObjectForCode("crouch").Active
  elseif((entranceToCheck.entryRegion == "MtScarabResearchCenter") and (entranceToCheck.exitRegion == "FFSBossFight")) then
    return Tracker:FindObjectForCode("melee").Active
  elseif((entranceToCheck.entryRegion == "HatredsShadow") and (entranceToCheck.exitRegion == "LairOfInfiniteAgony")) then
    return Tracker:FindObjectForCode("crouch").Active
  elseif(SLOT_DATA[jump_checks] > 0) then
    if((entranceToCheck.entryRegion == "BadassCrater") and (entranceToCheck.exitRegion == "TorgueArena")) then
      return JumpHeight(490)
    elseif((entranceToCheck.entryRegion == "CandlerakksCrag") and (entranceToCheck.exitRegion == "Terminus")) then
      return JumpHeight(629)
    end
  else
    return true
  end
end

function JumpHeight(height)
  if(SLOT_DATA[jump_checks] == 0) then
    return true
  elseif(height < 220) then  -- Height with no jump items
    return true
  elseif(height > 630) then  -- Normal jump height, should never be needed
    return false
  end
  local heightBonus = SLOT_DATA[max_jump_height] * 300
  local maxHeight = 630 + heightBonus
  local frac = Tracker:ProviderCountForCode("progressivejump") / SLOT_DATA[jump_checks]
  frac = math.sqrt(frac)
  local currentJump = math.max(220, math.min(maxHeight, maxHeight * frac))
  return (currentJump >= height)
end

function OnLevel(level)
  if((level > SLOT_DATA[max_level_checks]) and (SLOT_DATA[max_level_checks] ~= 0)) then -- false if over max check level
    return false
  end
  if level == 0 then
    return true
  elseif (1 <= level <= 5) then
    return RegionOpen("Level1to5")
  elseif (6 <= level <= 10) then
    return RegionOpen("Level6to10")
  elseif (11 <= level <= 15) then
    return RegionOpen("Level11to15")
  elseif (16 <= level <= 20) then
    return RegionOpen("Level16to20")
  elseif (21 <= level <= 25) then
    return RegionOpen("Level21to25")
  elseif (26 <= level <= 30) then
    return RegionOpen("Level26to30")
  elseif (level > 30) then
    return RegionOpen("Level31+")
  else
    print("Error placeholder")
    return false
  end
end

function LevelLimit(level)
  if((level > SLOT_DATA[max_level_checks]) and (SLOT_DATA[max_level_checks] ~= 0)) then -- false if over max check level
    return false
  end
  return true
end
