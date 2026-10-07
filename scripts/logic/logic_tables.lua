function CreateRegion(options) --Base region creation, call to initialize regions with their data
  return {
    regName = options.regName or "",
    minLevel = options.minLevel or 0,
    maxLevel = options.maxLevel or 0,
    travel_item_name = options.travel_item_name or "", -- item required to get to this region
    connecting_regions = options.connecting_regions or {}, -- regions this region goes to
    story_req_regions = options.story_req_regions or {}, -- unconnected regions also required to get to this region
    dlc_group = options.dlc_group or "basegame",
    any_entrance = options.any_entrance or {}, -- Regions where you need to be able to access one of them to be able to access this region
    progressive_required = options.progressive_required or 0 -- Num of prog items needed for 
    }
end

Regions = { --List of all regions, created with CreateRegion command passed their relevant fields
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
  WindshearWaste = CreateRegion{regName = "WindshearWaste", minLevel = 0, maxLevel = 3, connecting_regions = {"SouthernShelf"}},
  SouthernShelf = CreateRegion{regName = "SouthernShelf", minLevel = 1, maxLevel = 5, travel_item_name = "travel:southernshelf", connecting_regions = {"SouthernShelfBay", "ThreeHornsDivide"}, progressive_required = 1},
  SouthernShelfBay = CreateRegion{regName = "SouthernShelfBay", minLevel = 4, maxLevel = 6, travel_item_name = "travel:southernshelfbay", dlc_group = "basegame_side", progressive_required = 1},
  ThreeHornsDivide = CreateRegion{regName = "ThreeHornsDivide", minLevel = 6, maxLevel = 10, travel_item_name = "travel:threehornsdivide", connecting_regions = {"ThreeHornsValley", "Sanctuary", "FrostburnCanyon", "SanctuaryHole", "TundraExpress"}, progressive_required = 2},
  Sanctuary = CreateRegion{regName = "Sanctuary", minLevel = 7, maxLevel = 7, travel_item_name = "travel:sanctuary", progressive_required = 3},
  FrostburnCanyon = CreateRegion{regName = "FrostburnCanyon", minLevel = 9, maxLevel = 11, travel_item_name = "travel:frostburncanyon", progressive_required = 4},
  ThreeHornsValley = CreateRegion{regName = "ThreeHornsValley", minLevel = 8, maxLevel = 10, travel_item_name = "travel:threehornsvalley", connecting_regions = {"SouthpawSteam&Power", "Dust", "Fridge", "BloodshotStronghold"}, progressive_required = 5},
  ["SouthpawSteam&Power"] = CreateRegion{regName = "SouthpawSteam&Power", minLevel = 8, maxLevel = 9, travel_item_name = "travel:southpawsteam&power", dlc_group = "basegame_side", progressive_required = 2},
  Dust = CreateRegion{regName = "Dust", minLevel = 9, maxLevel = 12, travel_item_name = "travel:thedust", connecting_regions = {"Lynchwood", "FriendshipGulag", "EridiumBlight", "Highlands"}, progressive_required = 6},
  BloodshotStronghold = CreateRegion{regName = "BloodshotStronghold", minLevel = 12, maxLevel = 14, travel_item_name = "travel:bloodshotstronghold", connecting_regions = {"BloodshotRamparts"}, story_req_regions = {"Dust", "FrostburnCanyon", "Sanctuary"}, progressive_required = 7},
  BloodshotRamparts = CreateRegion{regName = "BloodshotRamparts", minLevel = 12, maxLevel = 14, travel_item_name = "travel:bloodshotramparts", story_req_regions = {"FriendshipGulag"}, progressive_required = 8},
  FriendshipGulag = CreateRegion{regName = "FriendshipGulag", minLevel = 12, maxLevel = 14, travel_item_name = "travel:friendshipgulag", story_req_regions = {"BloodshotStronghold"}, progressive_required = 9},
  TundraExpress = CreateRegion{regName = "TundraExpress", minLevel = 13, maxLevel = 16, travel_item_name = "travel:tundraexpress", connecting_regions = {"EndOfTheLine"}, story_req_regions = {"BloodshotRamparts"}, progressive_required = 10},
  EndOfTheLine = CreateRegion{regName = "EndOfTheLine", minLevel = 13, maxLevel = 16, travel_item_name = "travel:endoftheline", progressive_required = 11},
  Fridge = CreateRegion{regName = "Fridge", minLevel = 15, maxLevel = 17, travel_item_name = "travel:thefridge", connecting_regions = {"FinksSlaughterhouse", "HighlandsOutwash"}, story_req_regions = {"EndOfTheLine"}, progressive_required = 12},
  FinksSlaughterhouse = CreateRegion{regName = "FinksSlaughterhouse", minLevel = 15, maxLevel = 17, travel_item_name = "travel:finksslaughterhouse", dlc_group = "basegame_side", progressive_required = 3},
  HighlandsOutwash = CreateRegion{regName = "HighlandsOutwash", minLevel = 15, maxLevel = 17, travel_item_name = "travel:highlandsoutwash", connecting_regions = {"Highlands"}, progressive_required = 13},
  Highlands = CreateRegion{regName = "Highlands", minLevel = 16, maxLevel = 19, travel_item_name = "travel:highlands", connecting_regions = {"HolySpirits", "WildlifeExploitationPreserve", "ThousandCuts", "Opportunity"}, story_req_regions = {"HighlandsOutwash"}, progressive_required = 14},
  HolySpirits = CreateRegion{regName = "HolySpirits", minLevel = 18, maxLevel = 18, travel_item_name = "travel:theholyspirits", dlc_group = "basegame_side", progressive_required = 4},
  SanctuaryHole = CreateRegion{regName = "SanctuaryHole", minLevel = 13, maxLevel = 15, travel_item_name = "travel:sanctuaryhole", connecting_regions = {"CausticCaverns"}, story_req_regions = {"EndOfTheLine"}, dlc_group = "basegame_side", progressive_required = 5},
  CausticCaverns = CreateRegion{regName = "CausticCaverns", minLevel = 16, maxLevel = 18, travel_item_name = "travel:causticcaverns", dlc_group = "basegame_side", progressive_required = 6},
  WildlifeExploitationPreserve = CreateRegion{regName = "WildlifeExploitationPreserve", minLevel = 18, maxLevel = 21, travel_item_name = "travel:wildlifeexploitationpreserve", connecting_regions = {"NaturalSelectionAnnex"}, progressive_required = 15},
  NaturalSelectionAnnex = CreateRegion{regName = "NaturalSelectionAnnex", minLevel = 20, maxLevel = 21, travel_item_name = "travel:naturalselectionannex", dlc_group = "basegame_side", progressive_required = 7},
  ThousandCuts = CreateRegion{regName = "ThousandCuts", minLevel = 20, maxLevel = 23, travel_item_name = "travel:thousandcuts", connecting_regions = {"Bunker", "TerramorphousPeak"}, progressive_required = 16},
  Lynchwood = CreateRegion{regName = "Lynchwood", minLevel = 24, maxLevel = 26, travel_item_name = "travel:lynchwood", dlc_group = "basegame_side", progressive_required = 8},
  Opportunity = CreateRegion{regName = "Opportunity", minLevel = 20, maxLevel = 24, travel_item_name = "travel:opportunity", progressive_required = 17},
  Bunker = CreateRegion{regName = "Bunker", minLevel = 24, maxLevel = 26, travel_item_name = "travel:thebunker", connecting_regions = {"ControlCoreAngel"}, story_req_regions = {"WildlifeExploitationPreserve", "Opportunity"}, progressive_required = 18},
  ControlCoreAngel = CreateRegion{regName = "ControlCoreAngel", minLevel = 25, maxLevel = 25, travel_item_name = "travel:controlcoreangel", progressive_required = 19},
  EridiumBlight = CreateRegion{regName = "EridiumBlight", minLevel = 25, maxLevel = 27, travel_item_name = "travel:eridiumblight", connecting_regions = {"OreChasm", "SawtoothCauldron", "AridNexusBoneyard", "HerosPass"}, story_req_regions = {"ControlCoreAngel"}, progressive_required = 20},
  OreChasm = CreateRegion{regName = "OreChasm", minLevel = 25, maxLevel = 27, travel_item_name = "travel:orechasm", dlc_group = "basegame_side", progressive_required = 9},
  SawtoothCauldron = CreateRegion{regName = "SawtoothCauldron", minLevel = 25, maxLevel = 28, travel_item_name = "travel:sawtoothcauldron", progressive_required = 21},
  AridNexusBoneyard = CreateRegion{regName = "AridNexusBoneyard", minLevel = 26, maxLevel = 29, travel_item_name = "travel:aridnexusboneyard", connecting_regions = {"AridNexusBadlands"}, story_req_regions = {"SawtoothCauldron"}, progressive_required = 22},
  AridNexusBadlands = CreateRegion{regName = "AridNexusBadlands", minLevel = 26, maxLevel = 30, travel_item_name = "travel:aridnexusbadlands", progressive_required = 23},
  HerosPass = CreateRegion{regName = "HerosPass", minLevel = 29, maxLevel = 30, travel_item_name = "travel:herospass", connecting_regions = {"VaultOfTheWarrior"}, story_req_regions = {"AridNexusBadlands"}, progressive_required = 24},
  VaultOfTheWarrior = CreateRegion{regName = "VaultOfTheWarrior", minLevel = 30, maxLevel = 31, travel_item_name = "travel:vaultofthewarrior", progressive_required = 25},
  TerramorphousPeak = CreateRegion{regName = "TerramorphousPeak", minLevel = 30, maxLevel = 30, travel_item_name = "travel:terramorphouspeak", story_req_regions = {"VaultOfTheWarrior"}, dlc_group = "basegame_side", progressive_required = 10},

  FFSIntroSanctuary = CreateRegion{regName = "FFSIntroSanctuary", minLevel = 30, maxLevel = 30, travel_item_name = "travel:ffsintrosanctuary", connecting_regions = {"Backburner"}, dlc_group = "ffs", progressive_required = 1},
  Backburner = CreateRegion{regName = "Backburner", minLevel = 30, maxLevel = 30, travel_item_name = "travel:thebackburner", connecting_regions = {"DahlAbandon"}, dlc_group = "ffs", progressive_required = 2},
  DahlAbandon = CreateRegion{regName = "DahlAbandon", minLevel = 30, maxLevel = 30, travel_item_name = "travel:dahlabandon", connecting_regions = {"Burrows", "HeliosFallen", "MtScarabResearchCenter"}, dlc_group = "ffs", progressive_required = 3},
  Burrows = CreateRegion{regName = "Burrows", minLevel = 30, maxLevel = 30, travel_item_name = "travel:theburrows", connecting_regions = {"HeliosFallen"}, dlc_group = "ffs", progressive_required = 4},
  HeliosFallen = CreateRegion{regName = "HeliosFallen", minLevel = 30, maxLevel = 30, travel_item_name = "travel:heliosfallen", story_req_regions = {"Burrows"}, dlc_group = "ffs", progressive_required = 5},
  MtScarabResearchCenter = CreateRegion{regName = "MtScarabResearchCenter", minLevel = 30, maxLevel = 30, travel_item_name = "travel:mtscarabresearchcenter", connecting_regions = {"FFSBossFight"}, story_req_regions = {"HeliosFallen"}, dlc_group = "ffs", progressive_required = 6},
  FFSBossFight = CreateRegion{regName = "FFSBossFight", minLevel = 30, maxLevel = 30, travel_item_name = "travel:ffsbossfight", connecting_regions = {"WrithingDeep"}, dlc_group = "ffs", progressive_required = 7},
  WrithingDeep = CreateRegion{regName = "WrithingDeep", minLevel = 30, maxLevel = 30, travel_item_name = "travel:writhingdeep", dlc_group = "ffs", progressive_required = 8},

  UnassumingDocks = CreateRegion{regName = "UnassumingDocks", minLevel = 30, maxLevel = 30, travel_item_name = "travel:unassumingdocks", connecting_regions = {"FlamerockRefuge"}, dlc_group = "tina", progressive_required = 1},
  FlamerockRefuge = CreateRegion{regName = "FlamerockRefuge", minLevel = 30, maxLevel = 30, travel_item_name = "travel:flamerockrefuge", connecting_regions = {"Forest", "MurderlinsTemple"}, dlc_group = "tina", progressive_required = 2},
  Forest = CreateRegion{regName = "Forest", minLevel = 30, maxLevel = 30, travel_item_name = "travel:theforest", connecting_regions = {"ImmortalWoods"}, dlc_group = "tina", progressive_required = 3},
  ImmortalWoods = CreateRegion{regName = "ImmortalWoods", minLevel = 30, maxLevel = 30, travel_item_name = "travel:immortalwoods", connecting_regions = {"MinesOfAvarice"}, dlc_group = "tina", progressive_required = 4},
  MinesOfAvarice = CreateRegion{regName = "MinesOfAvarice", minLevel = 30, maxLevel = 30, travel_item_name = "travel:minesofavarice", connecting_regions = {"HatredsShadow"}, dlc_group = "tina", progressive_required = 5},
  HatredsShadow = CreateRegion{regName = "HatredsShadow", minLevel = 30, maxLevel = 30, travel_item_name = "travel:hatredsshadow", connecting_regions = {"LairOfInfiniteAgony"}, dlc_group = "tina", progressive_required = 6},
  LairOfInfiniteAgony = CreateRegion{regName = "LairOfInfiniteAgony", minLevel = 30, maxLevel = 30, travel_item_name = "travel:lairofinfiniteagony", connecting_regions = {"DragonKeep", "WingedStorm"}, dlc_group = "tina", progressive_required = 7},
  DragonKeep = CreateRegion{regName = "DragonKeep", minLevel = 30, maxLevel = 30, travel_item_name = "travel:dragonkeep", dlc_group = "tina", progressive_required = 8},
  MurderlinsTemple = CreateRegion{regName = "MurderlinsTemple", minLevel = 30, maxLevel = 30, travel_item_name = "travel:murderlinstemple", story_req_regions = {"DragonKeep"}, dlc_group = "tina", progressive_required = 9},
  WingedStorm = CreateRegion{regName = "WingedStorm", minLevel = 30, maxLevel = 30, travel_item_name = "travel:thewingedstorm", story_req_regions = {"DragonKeep"}, dlc_group = "tina", progressive_required = 10},

  BadassCrater = CreateRegion{regName = "BadassCrater", minLevel = 15, maxLevel = 16, travel_item_name = "travel:badasscrater", connecting_regions = {"Beatdown", "TorgueArena", "BadassCraterBar", "SouthernRaceway", "Forge"}, dlc_group = "torgue", progressive_required = 1},
  TorgueArena = CreateRegion{regName = "TorgueArena", minLevel = 15, maxLevel = 17, travel_item_name = "travel:torguearena", dlc_group = "torgue", progressive_required = 2},
  Beatdown = CreateRegion{regName = "Beatdown", minLevel = 15, maxLevel = 18, travel_item_name = "travel:thebeatdown", connecting_regions = {"PyroPetesBar"}, story_req_regions = {"TorgueArena"}, dlc_group = "torgue", progressive_required = 3},
  PyroPetesBar = CreateRegion{regName = "PyroPetesBar", minLevel = 15, maxLevel = 18, travel_item_name = "travel:pyropetesbar", dlc_group = "torgue", progressive_required = 4},
  BadassCraterBar = CreateRegion{regName = "BadassCraterBar", minLevel = 15, maxLevel = 15, travel_item_name = "travel:badasscraterbar", story_req_regions = {"PyroPetesBar"}, dlc_group = "torgue", progressive_required = 5},
  SouthernRaceway = CreateRegion{regName = "SouthernRaceway", minLevel = 15, maxLevel = 19, travel_item_name = "travel:southernraceway", story_req_regions = {"BadassCraterBar"}, dlc_group = "torgue", progressive_required = 6},
  Forge = CreateRegion{regName = "Forge", minLevel = 15, maxLevel = 20, travel_item_name = "travel:theforge", story_req_regions = {"SouthernRaceway"}, dlc_group = "torgue", progressive_required = 7},

  Oasis = CreateRegion{regName = "Oasis", minLevel = 15, maxLevel = 16, travel_item_name = "travel:oasis", connecting_regions = {"Wurmwater", "HaytersFolly", "LeviathansLair"}, dlc_group = "scarlett", progressive_required = 1},
  Wurmwater = CreateRegion{regName = "Wurmwater", minLevel = 15, maxLevel = 17, travel_item_name = "travel:wurmwater", connecting_regions = {"WashburneRefinery", "Rustyards", "MagnysLighthouse"}, dlc_group = "scarlett", progressive_required = 2},
  HaytersFolly = CreateRegion{regName = "HaytersFolly", minLevel = 15, maxLevel = 18, travel_item_name = "travel:haytersfolly", story_req_regions = {"Wurmwater"}, dlc_group = "scarlett", progressive_required = 3},
  Rustyards = CreateRegion{regName = "Rustyards", minLevel = 15, maxLevel = 18, travel_item_name = "travel:therustyards", story_req_regions = {"HaytersFolly"}, dlc_group = "scarlett", progressive_required = 4},
  WashburneRefinery = CreateRegion{regName = "WashburneRefinery", minLevel = 15, maxLevel = 18, travel_item_name = "travel:washburnerefinery", story_req_regions = {"Rustyards"}, dlc_group = "scarlett", progressive_required = 5},
  MagnysLighthouse = CreateRegion{regName = "MagnysLighthouse", minLevel = 15, maxLevel = 19, travel_item_name = "travel:magnyslighthouse", story_req_regions = {"WashburneRefinery"}, dlc_group = "scarlett", progressive_required = 6},
  LeviathansLair = CreateRegion{regName = "LeviathansLair", minLevel = 15, maxLevel = 19, travel_item_name = "travel:theleviathanslair", story_req_regions = {"MagnysLighthouse"}, dlc_group = "scarlett", progressive_required = 7},

  HuntersGrotto = CreateRegion{regName = "HuntersGrotto", minLevel = 30, maxLevel = 30, travel_item_name = "travel:huntersgrotto", connecting_regions = {"ScyllasGrove", "CandlerakksCrag", "ArdortonStation"}, dlc_group = "hammerlock", progressive_required = 1},
  ScyllasGrove = CreateRegion{regName = "ScyllasGrove", minLevel = 30, maxLevel = 30, travel_item_name = "travel:scyllasgrove", connecting_regions = {"ArdortonStation"}, dlc_group = "hammerlock", progressive_required = 2},
  ArdortonStation = CreateRegion{regName = "ArdortonStation", minLevel = 30, maxLevel = 30, travel_item_name = "travel:ardortonstation", story_req_regions = {"ScyllasGrove"}, dlc_group = "hammerlock", progressive_required = 3},
  CandlerakksCrag = CreateRegion{regName = "CandlerakksCrag", minLevel = 30, maxLevel = 30, travel_item_name = "travel:candlerakkscrag", connecting_regions = {"Terminus"}, story_req_regions = {"ArdortonStation"}, dlc_group = "hammerlock", progressive_required = 4},
  Terminus = CreateRegion{regName = "Terminus", minLevel = 30, maxLevel = 30, travel_item_name = "travel:terminus", dlc_group = "hammerlock", progressive_required = 5},

  DigistructPeak = CreateRegion{regName = "DigistructPeak", minLevel = 0, maxLevel = 3, travel_item_name = "travel:digistructpeak", connecting_regions = {"DigistructPeakInner"}, dlc_group = "digi"},
  DigistructPeakInner = CreateRegion{regName = "DigistructPeakInner", minLevel = 30, maxLevel = 30, travel_item_name = "travel:digistructpeak", dlc_group = "digi"},
  -- DigistructPeakOP5 = CreateRegion{regName = "DigistructPeakOP5", ""},

  HallowedHollow = CreateRegion{regName = "HallowedHollow", minLevel = 15, maxLevel = 17, travel_item_name = "travel:hallowedhollow", dlc_group = "headhunter", progressive_required = 1},
  GluttonyGulch = CreateRegion{regName = "GluttonyGulch", minLevel = 15, maxLevel = 17, travel_item_name = "travel:gluttonygulch", dlc_group = "headhunter", progressive_required = 2},
  MarcusMercenaryShop = CreateRegion{regName = "MarcusMercenaryShop", minLevel = 15, maxLevel = 17, travel_item_name = "travel:marcussmercenaryshop", dlc_group = "headhunter", progressive_required = 3},
  RotgutDistillery = CreateRegion{regName = "RotgutDistillery", minLevel = 15, maxLevel = 17, travel_item_name = "travel:rotgutdistillery", dlc_group = "headhunter", progressive_required = 4},
  WamBamIsland = CreateRegion{regName = "WamBamIsland", minLevel = 15, maxLevel = 17, travel_item_name = "travel:wambamisland", dlc_group = "headhunter", progressive_required = 5},
}

DLCProgOrderList = {
    "basegame",
    "basegame_side",
    "ffs",
    "tina",
    "torgue",
    "scarlett",
    "hammerlock",
    "headhunter"
}

function ResetProgressiveOrders()
    ProgressiveOrdersWorking = {
        basegame = {
        },

        basegame_side = {
        },

        ffs = {
        },

        tina = {
        },

        torgue = {
        },

        scarlett = {
        },

        hammerlock = {
        },

        headhunter = {
        }
    }
end

ProgressiveOrdersDefinition = {
    basegame = {
        "SouthernShelf",
        "ThreeHornsDivide",
        "Sanctuary",
        "FrostburnCanyon",
        "ThreeHornsValley",
        "Dust",
        "BloodshotStronghold",
        "BloodshotRamparts",
        "FriendshipGulag",
        "TundraExpress",
        "EndOfTheLine",
        "Fridge",
        "HighlandsOutwash",
        "Highlands",
        "WildlifeExploitationPreserve",
        "ThousandCuts",
        "Opportunity",
        "Bunker",
        "ControlCoreAngel",
        "EridiumBlight",
        "SawtoothCauldron",
        "AridNexusBoneyard",
        "AridNexusBadlands",
        "HerosPass",
        "VaultOfTheWarrior"
    },

    basegame_side = {
        "SouthernShelfBay",
        "SouthpawSteam&Power",
        "FinksSlaughterhouse",
        "HolySpirits",
        "SanctuaryHole",
        "CausticCaverns",
        "NaturalSelectionAnnex",
        "Lynchwood",
        "OreChasm",
        "TerramorphousPeak"
    },

    ffs = {
        "FFSIntroSanctuary",
        "Backburner",
        "DahlAbandon",
        "Burrows",
        "HeliosFallen",
        "MtScarabResearchCenter",
        "FFSBossFight",
        "WrithingDeep"
    },

    tina = {
        "UnassumingDocks",
        "FlamerockRefuge",
        "Forest",
        "ImmortalWoods",
        "MinesOfAvarice",
        "HatredsShadow",
        "LairOfInfiniteAgony",
        "DragonKeep",
        "MurderlinsTemple",
        "WingedStorm"
    },

    torgue = {
            "BadassCrater",
            "TorgueArena",
            "Beatdown",
            "PyroPetesBar",
            "BadassCraterBar",
            "SouthernRaceway",
            "Forge"
    },

    scarlett = {
        "Oasis",
        "Wurmwater",
        "HaytersFolly",
        "Rustyards",
        "WashburneRefinery",
        "MagnysLighthouse",
        "LeviathansLair"
    },

    hammerlock = {
        "HuntersGrotto",
        "ScyllasGrove",
        "ArdortonStation",
        "CandlerakksCrag",
        "Terminus"
    },

    headhunter = {
        "HallowedHollow",
        "GluttonyGulch",
        "MarcusMercenaryShop",
        "RotgutDistillery",
        "WamBamIsland"
    }
}
