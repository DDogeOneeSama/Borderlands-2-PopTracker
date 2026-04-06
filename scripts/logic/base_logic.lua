require("lldebugger").start()
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
  WindshearWaste = CreateRegion{regName = "WindshearWaste", level_req = 1, connecting_regions = {"SouthernShelf"}, dlc_group = "scarlett"},
  SouthernShelf = CreateRegion{regName = "SouthernShelf", level_req = 3, travel_item_name = "Travel: Southern Shelf", connecting_regions = {"SouthernShelfBay", "ThreeHornsDivide"}},
  SouthernShelfBay = CreateRegion{regName = "SouthernShelfBay", level_req = 4, travel_item_name = "Travel: Southern Shelf Bay"},
  ThreeHornsDivide = CreateRegion{regName = "ThreeHornsDivide", level_req = 7, travel_item_name = "Travel: Three Horns Divide", connecting_regions = {"ThreeHornsValley", "Sanctuary", "FrostburnCanyon", "SanctuaryHole", "TundraExpress"}},
  ThreeHornsValley = CreateRegion{regName = "ThreeHornsValley", level_req = 8, travel_item_name = "Travel: Three Horns Valley", connecting_regions = {"SouthpawSteam&Power", "Dust", "Fridge", "BloodshotStronghold"}},
  Sanctuary = CreateRegion{regName = "Sanctuary", level_req = 7, travel_item_name = "Travel: Sanctuary"},
  FrostburnCanyon = CreateRegion{regName = "FrostburnCanyon", level_req = 9, travel_item_name = "Travel: Frostburn Canyon", story_req_regions = {"Sanctuary"}},
  ["SouthpawSteam&Power"] = CreateRegion{regName = "SouthpawSteam&Power", level_req = 8, travel_item_name = "Travel: Southpaw Steam & Power"},
  Dust = CreateRegion{regName = "Dust", level_req = 9, travel_item_name = "Travel: The Dust", connecting_regions = {"Lynchwood", "FriendshipGulag", "EridiumBlight", "Highlands"}},
  Lynchwood = CreateRegion{regName = "Lynchwood", level_req = 24, travel_item_name = "Travel: Lynchwood"},
  FriendshipGulag = CreateRegion{regName = "FriendshipGulag", level_req = 12, travel_item_name = "Travel: Friendship Gulag", story_req_regions = {"BloodshotStronghold"}},
  BloodshotStronghold = CreateRegion{regName = "BloodshotStronghold", level_req = 12, travel_item_name = "Travel: Bloodshot Stronghold", connecting_regions = {"BloodshotRamparts"}, story_req_regions = {"Dust", "FrostburnCanyon"}},
  BloodshotRamparts = CreateRegion{regName = "BloodshotRamparts", level_req = 12, travel_item_name = "Travel: Bloodshot Ramparts", story_req_regions = {"FriendshipGulag"}},
  TundraExpress = CreateRegion{regName = "TundraExpress", level_req = 13, travel_item_name = "Travel: Tundra Express", connecting_regions = {"EndOfTheLine"}, story_req_regions = {"BloodshotRamparts"}},
  EndOfTheLine = CreateRegion{regName = "EndOfTheLine", level_req = 13, travel_item_name = "Travel: End of the Line"},
  SanctuaryHole = CreateRegion{regName = "SanctuaryHole", level_req = 13, travel_item_name = "Travel: Sanctuary Hole", connecting_regions = {"CausticCaverns"}, story_req_regions = {"EndOfTheLine"}},
  CausticCaverns = CreateRegion{regName = "CausticCaverns", level_req = 16, travel_item_name = "Travel: Caustic Caverns"},
  Fridge = CreateRegion{regName = "Fridge", level_req = 15, travel_item_name = "Travel: The Fridge", connecting_regions = {"FinksSlaughterhouse", "HighlandsOutwash"}, story_req_regions = {"EndOfTheLine"}},
  FinksSlaughterhouse = CreateRegion{regName = "FinksSlaughterhouse", level_req = 15, travel_item_name = "Travel: Fink's Slaughterhouse"},
  HighlandsOutwash = CreateRegion{regName = "HighlandsOutwash", level_req = 15, travel_item_name = "Travel: Highlands Outwash", connecting_regions = {"Highlands"}},
  Highlands = CreateRegion{regName = "Highlands", level_req = 16, travel_item_name = "Travel: Highlands", connecting_regions = {"HolySpirits", "WildlifeExploitationPreserve", "ThousandCuts", "Opportunity"}, story_req_regions = {"HighlandsOutwash"}},
  HolySpirits = CreateRegion{regName = "HolySpirits", level_req = 18, travel_item_name = "Travel: The Holy Spirits"},
  WildlifeExploitationPreserve = CreateRegion{regName = "WildlifeExploitationPreserve", level_req = 19, travel_item_name = "Travel: Wildlife Exploitation Preserve", connecting_regions = {"NaturalSelectionAnnex"}},
  NaturalSelectionAnnex = CreateRegion{regName = "NaturalSelectionAnnex", level_req = 20, travel_item_name = "Travel: Natural Selection Annex"},
  ThousandCuts = CreateRegion{regName = "ThousandCuts", level_req = 20, travel_item_name = "Travel: Thousand Cuts", connecting_regions = {"Bunker", "TerramorphousPeak"}},
  Opportunity = CreateRegion{regName = "Opportunity", level_req = 20, travel_item_name = "Travel: Opportunity"},
  Bunker = CreateRegion{regName = "Bunker", level_req = 24, travel_item_name = "Travel: The Bunker", connecting_regions = {"ControlCoreAngel"}, story_req_regions = {"WildlifeExploitationPreserve", "Opportunity"}},
  ControlCoreAngel = CreateRegion{regName = "ControlCoreAngel", level_req = 25, travel_item_name = "Travel: Control Core Angel"},
  EridiumBlight = CreateRegion{regName = "EridiumBlight", level_req = 25, travel_item_name = "Travel: Eridium Blight", connecting_regions = {"OreChasm", "SawtoothCauldron", "AridNexusBoneyard", "HerosPass"}, story_req_regions = {"ControlCoreAngel"}},
  OreChasm = CreateRegion{regName = "OreChasm", level_req = 25, travel_item_name = "Travel: Ore Chasm"},
  SawtoothCauldron = CreateRegion{regName = "SawtoothCauldron", level_req = 25, travel_item_name = "Travel: Sawtooth Cauldron"},
  AridNexusBoneyard = CreateRegion{regName = "AridNexusBoneyard", level_req = 26, travel_item_name = "Travel: Arid Nexus Boneyard", connecting_regions = {"AridNexusBadlands"}, story_req_regions = {"SawtoothCauldron"}},
  AridNexusBadlands = CreateRegion{regName = "AridNexusBadlands", level_req = 26, travel_item_name = "Travel: Arid Nexus Badlands"},
  HerosPass = CreateRegion{regName = "HerosPass", level_req = 29, travel_item_name = "Travel: Hero's Pass", connecting_regions = {"VaultOfTheWarrior"}, story_req_regions = {"AridNexusBadlands"}},
  VaultOfTheWarrior = CreateRegion{regName = "VaultOfTheWarrior", level_req = 30, travel_item_name = "Travel: Vault of the Warrior"},
  TerramorphousPeak = CreateRegion{regName = "TerramorphousPeak", level_req = 30, travel_item_name = "Travel: Terramorphous Peak", story_req_regions = {"VaultOfTheWarrior"}},

  FFSIntroSanctuary = CreateRegion{regName = "FFSIntroSanctuary", level_req = 30, travel_item_name = "Travel: FFS Intro Sanctuary", connecting_regions = {"Backburner"}, dlc_group = "ffs"},
  Backburner = CreateRegion{regName = "Backburner", level_req = 30, travel_item_name = "Travel: The Backburner", connecting_regions = {"DahlAbandon"}, dlc_group = "ffs"},
  DahlAbandon = CreateRegion{regName = "DahlAbandon", level_req = 30, travel_item_name = "Travel: Dahl Abandon", connecting_regions = {"Burrows", "HeliosFallen", "Mt.ScarabResearchCenter"}, dlc_group = "ffs"},
  Burrows = CreateRegion{regName = "Burrows", level_req = 30, travel_item_name = "Travel: The Burrows", connecting_regions = {"HeliosFallen"}, dlc_group = "ffs"},
  HeliosFallen = CreateRegion{regName = "HeliosFallen", level_req = 30, travel_item_name = "Travel: Helios Fallen", story_req_regions = {"Burrows"}, dlc_group = "ffs"},
  MtScarabResearchCenter = CreateRegion{regName = "MtScarabResearchCenter", level_req = 30, travel_item_name = "Travel: Mt. Scarab Research Center", connecting_regions = {"FFSBossFight"}, story_req_regions = {"HeliosFallen"}, dlc_group = "ffs"},
  FFSBossFight = CreateRegion{regName = "FFSBossFight", level_req = 30, travel_item_name = "Travel: FFS Boss Fight", connecting_regions = {"WrithingDeep"}, dlc_group = "ffs"},
  WrithingDeep = CreateRegion{regName = "WrithingDeep", level_req = 30, travel_item_name = "Travel: Writhing Deep", dlc_group = "ffs"},

  UnassumingDocks = CreateRegion{regName = "UnassumingDocks", level_req = 30, travel_item_name = "Travel: Unassuming Docks", connecting_regions = {"FlamerockRefuge"}, dlc_group = "tina"},
  FlamerockRefuge = CreateRegion{regName = "FlamerockRefuge", level_req = 30, travel_item_name = "Travel: Flamerock Refuge", connecting_regions = {"Forest", "MurderlinsTemple"}, dlc_group = "tina"},
  Forest = CreateRegion{regName = "Forest", level_req = 30, travel_item_name = "Travel: The Forest", connecting_regions = {"ImmortalWoods"}, dlc_group = "tina"},
  ImmortalWoods = CreateRegion{regName = "ImmortalWoods", level_req = 30, travel_item_name = "Travel: Immortal Woods", connecting_regions = {"MinesOfAvarice"}, dlc_group = "tina"},
  MinesOfAvarice = CreateRegion{regName = "MinesOfAvarice", level_req = 30, travel_item_name = "Travel: Mines of Avarice", connecting_regions = {"HatredsShadow"}, dlc_group = "tina"},
  HatredsShadow = CreateRegion{regName = "HatredsShadow", level_req = 30, travel_item_name = "Travel: Hatred's Shadow", connecting_regions = {"LairOfInfiniteAgony"}, dlc_group = "tina"},
  LairOfInfiniteAgony = CreateRegion{regName = "LairOfInfiniteAgony", level_req = 30, travel_item_name = "Travel: Lair of Infinite Agony", connecting_regions = {"DragonKeep", "WingedStorm"}, dlc_group = "tina"},
  DragonKeep = CreateRegion{regName = "DragonKeep", level_req = 30, travel_item_name = "Travel: Dragon Keep", dlc_group = "tina"},
  MurderlinsTemple = CreateRegion{regName = "MurderlinsTemple", level_req = 30, travel_item_name = "Travel: Murderlin's Temple", story_req_regions = {"DragonKeep"}, dlc_group = "tina"},
  WingedStorm = CreateRegion{regName = "WingedStorm", level_req = 30, travel_item_name = "Travel: The Winged Storm", story_req_regions = {"DragonKeep"}, dlc_group = "tina"},

  BadassCrater = CreateRegion{regName = "BadassCrater", level_req = 15, travel_item_name = "Travel: Badass Crater", connecting_regions = {"Beatdown", "TorgueArena", "BadassCraterBar", "SouthernRaceway", "Forge"}, dlc_group = "torgue"},
  TorgueArena = CreateRegion{regName = "TorgueArena", level_req = 15, travel_item_name = "Travel: Torgue Arena", dlc_group = "torgue"},
  Beatdown = CreateRegion{regName = "Beatdown", level_req = 15, travel_item_name = "Travel: The Beatdown", connecting_regions = {"PyroPetesBar"}, story_req_regions = {"TorgueArena"}, dlc_group = "torgue"},
  PyroPetesBar = CreateRegion{regName = "PyroPetesBar", level_req = 15, travel_item_name = "Travel: Pyro Pete's Bar", dlc_group = "torgue"},
  BadassCraterBar = CreateRegion{regName = "BadassCraterBar", level_req = 15, travel_item_name = "Travel: Badass Crater Bar", story_req_regions = {"PyroPetesBar"}, dlc_group = "torgue"},
  SouthernRaceway = CreateRegion{regName = "SouthernRaceway", level_req = 15, travel_item_name = "Travel: Southern Raceway", story_req_regions = {"BadassCraterBar"}, dlc_group = "torgue"},
  Forge = CreateRegion{regName = "Forge", level_req = 15, travel_item_name = "Travel: The Forge", story_req_regions = {"SouthernRaceway"}, dlc_group = "torgue"},

  Oasis = CreateRegion{regName = "Oasis", level_req = 15, travel_item_name = "Travel: Oasis", connecting_regions = {"Wurmwater", "HaytersFolly", "LeviathansLair"}, dlc_group = "scarlett"},
  Wurmwater = CreateRegion{regName = "Wurmwater", level_req = 15, travel_item_name = "Travel: Wurmwater", connecting_regions = {"WashburneRefinery", "Rustyards", "MagnysLighthouse"}, dlc_group = "scarlett"},
  HaytersFolly = CreateRegion{regName = "HaytersFolly", level_req = 15, travel_item_name = "Travel: Hayter's Folly", story_req_regions = {"Wurmwater"}, dlc_group = "scarlett"},
  Rustyards = CreateRegion{regName = "Rustyards", level_req = 15, travel_item_name = "Travel: The Rustyards", story_req_regions = {"HaytersFolly"}, dlc_group = "scarlett"},
  WashburneRefinery = CreateRegion{regName = "WashburneRefinery", level_req = 15, travel_item_name = "Travel: Washburne Refinery", story_req_regions = {"Rustyards"}, dlc_group = "scarlett"},
  MagnysLighthouse = CreateRegion{regName = "MagnysLighthouse", level_req = 15, travel_item_name = "Travel: Magnys Lighthouse", story_req_regions = {"WashburneRefinery"}, dlc_group = "scarlett"},
  LeviathansLair = CreateRegion{regName = "LeviathansLair", level_req = 15, travel_item_name = "Travel: The Leviathan's Lair", story_req_regions = {"MagnysLighthouse"}, dlc_group = "scarlett"},

  HuntersGrotto = CreateRegion{regName = "HuntersGrotto", level_req = 30, travel_item_name = "Travel: Hunter's Grotto", connecting_regions = {"ScyllasGrove", "CandlerakksCrag", "ArdortonStation"}, dlc_group = "hammerlock"},
  ScyllasGrove = CreateRegion{regName = "ScyllasGrove", level_req = 30, travel_item_name = "Travel: Scylla's Grove", connecting_regions = {"ArdortonStation"}, dlc_group = "hammerlock"},
  ArdortonStation = CreateRegion{regName = "ArdortonStation", level_req = 30, travel_item_name = "Travel: Ardorton Station", story_req_regions = {"ScyllasGrove"}, dlc_group = "hammerlock"},
  CandlerakksCrag = CreateRegion{regName = "CandlerakksCrag", level_req = 30, travel_item_name = "Travel: Candlerakk's Cragg", connecting_regions = {"Terminus"}, story_req_regions = {"ArdortonStation"}, dlc_group = "hammerlock"},
  Terminus = CreateRegion{regName = "Terminus", level_req = 30, travel_item_name = "Travel: Terminus", dlc_group = "hammerlock"},

  DigistructPeak = CreateRegion{regName = "DigistructPeak", level_req = 0, travel_item_name = "Travel: Digistruct Peak", connecting_regions = {"DigistructPeakInner"}, dlc_group = "digi"},
  DigistructPeakInner = CreateRegion{regName = "DigistructPeakInner", level_req = 30, travel_item_name = "Travel: Digistruct Peak", dlc_group = "digi"},
  -- DigistructPeakOP5 = CreateRegion{regName = "DigistructPeakOP5", ""},

  MarcusMercenaryShop = CreateRegion{regName = "MarcusMercenaryShop", level_req = 15, travel_item_name = "Travel: Marcus's Mercenary Shop", dlc_group = "headhunter"},
  GluttonyGulch = CreateRegion{regName = "GluttonyGulch", level_req = 15, travel_item_name = "Travel: Gluttony Gulch", dlc_group = "headhunter"},
  RotgutDistillery = CreateRegion{regName = "RotgutDistillery", level_req = 15, travel_item_name = "Travel: Rotgut Distillery", dlc_group = "headhunter"},
  WamBamIsland = CreateRegion{regName = "WamBamIsland", level_req = 15, travel_item_name = "Travel: Wam Bam Island", dlc_group = "headhunter"},
  HallowedHollow = CreateRegion{regName = "HallowedHollow", level_req = 15, travel_item_name = "Travel: Hallowed Hollow", dlc_group = "headhunter"}
}

local entrances = {}
for _, value in pairs(regions) do
  if value.connecting_regions ~= {} then
    for _, connect in ipairs(value.connecting_regions) do
      if value.story_req_regions ~= {} then
        for _, story in ipairs(value.story_req_regions) do
          table.insert(entrances, {enter = value.regName, exit = connect, item_needed = regions[connect].travel_item_name, story_needed = story})
        end
      else
        table.insert(entrances, {enter = value.regName, exit = connect, item_needed = regions[connect].travel_item_name})
      end
    end
  end
end

function CanReachRegion(region)
  local regionAccessable = false
  if(regions[region].dlcgroup == "menu") then
    regionAccessable = true
  elseif(regions[region].dlc_group == "digi") then
    if(Tracker:FindObjectForCode('travel:digistructpeak').Active) then
      regionAccessable = true
    end
  elseif (regions[region].dlc_group == "headhunter") then
    if(Tracker:FindObjectForCode(regions[region].travel_item_name).Active) then
      regionAccessable = true
    end
  elseif(regions[region].dlc_group == "basegame" or regions[region].dlc_group == "scarlett" or regions[region].dlc_group == "torgue" or regions[region].dlc_group == "hammerlock" or regions[region].dlc_group == "tina" or regions[region].dlc_group == "ffs") then
    regionAccessable = RegionSearch(region, regions[region].dlc_group)
  else
    print(regions[region].regName, " has no associated dlc_group.")
    return false
  end
  return regionAccessable
end

function EntranceOpen(region)
  if region == "Menu" then return true end
  for _, entranceToCheck in ipairs(entrances) do
    if(entranceToCheck.exit == region) then
      if((regions[region].travel_item_name) ~= "Travel: Sanctuary Hole") then
        return EntranceOpen(entranceToCheck.entry)
      else
        return false
      end
    end
  end
end

function OnLevel(level)
  if level == nil or 0 then
    return true
  else
    print("Error placeholder")
    return false
  end
end
local I = 0
for _ in ipairs(entrances) do I = I + 1 end
print(I)
local count = 0
for key, value in pairs(regions) do
  if(value.travel_item_name ~= "")then count = count + 1 end
end
print(count)