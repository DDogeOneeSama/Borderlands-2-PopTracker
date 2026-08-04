local next, ipairs = next, ipairs

local staleRegions = true --Do regions need to be checked
local staleLevels = true --Do reachable levels need to be checked
local staleProgressive = true --Do progressive travels need to be checked
local currentJumpHeight = 630
local staleJump = true --Does jump height need to be recalculated
local highestLevel = 0 --Highest reachable level
local maxLevel = 0 --Max level checks available
local staleLevelLimit = true --Does max level need to be set

local accessibleRegions =
{
  Menu = AccessibilityLevel.Normal,
  WindshearWaste = AccessibilityLevel.Normal
}

function InvalidateAccessibleRegions()
  staleRegions = true
  staleLevels = true
  staleProgressive = true
  staleJump = true
  staleLevelLimit = true
  ResetProgressiveOrders()
  accessibleRegions =
  {
    Menu = AccessibilityLevel.Normal,
    WindshearWaste = AccessibilityLevel.Normal
  }
end

function CanReachRegion(regionToCheck)
  if staleRegions then
    OpenRegions()
  end
  return accessibleRegions[regionToCheck] or AccessibilityLevel.None
end

function ProgressiveCheck(regionToCheck, dlc)
  if staleProgressive then
    ModifyProgressiveTables()
  end
  for progAmount, region in ipairs(ProgressiveOrdersWorking[dlc]) do
    if region == regionToCheck then
      if Tracker:FindObjectForCode("progressivetravel:" .. dlc).AcquiredCount >= progAmount then
        return true
      else
        return false
      end
    end
  end
  return false
end

function OpenRegions()
  staleRegions = false
  local regionToCheck = ""
  local queue = {"Menu"}
  local regionChanges = false
  ::tryAgain::
  while next(queue) do
    regionToCheck = table.remove(queue, 1)
    for _, connectedRegion in ipairs(Regions[regionToCheck].connecting_regions) do
      if accessibleRegions[connectedRegion] then
        table.insert(queue, connectedRegion)
      elseif not(Tracker:FindObjectForCode("enable_region_" .. connectedRegion).Active) then
        table.insert(queue, connectedRegion)
      else
        if not(HasTravelItem(connectedRegion)) then
          goto continue
        end
        if not(MiscCasesEntrances(connectedRegion)) then
          goto continue
        end
        if next(Regions[connectedRegion].story_req_regions) then
          for _, storyReq in ipairs(Regions[connectedRegion].story_req_regions) do
            if not(accessibleRegions[storyReq]) then
              goto continue
            end
          end
        end
        --print(connectedRegion)
        accessibleRegions[connectedRegion] = AccessibilityLevel.Normal
        table.insert(queue, connectedRegion)
        regionChanges = true
      end
      ::continue::
    end
  end
  if regionChanges then
    regionChanges = false
    table.insert(queue, "Menu")
    goto tryAgain
  end
end

function ModifyProgressiveTables()
  for _, dlc in pairs(DLCProgOrderList) do
    if (Tracker:FindObjectForCode("progressive_travel_" .. dlc).CurrentStage) == 1 then
      for _, regionToAdd in ipairs(ProgressiveOrdersDefinition[dlc]) do
        if (Tracker:FindObjectForCode("enable_region_" .. regionToAdd).Active) then
          table.insert(ProgressiveOrdersWorking[dlc], regionToAdd)
        end
      end
    end
  end
end

function HasTravelItem(regionToCheck)
  if (Regions[regionToCheck].travel_item_name == "") or (Tracker:FindObjectForCode("entrance_locks").CurrentStage) == 0 then
    return true -- return true if region does not require travel item or entrance_locks_disabled
  elseif Regions[regionToCheck].dlc_group ~= "digi" and (Tracker:FindObjectForCode("progressive_travel_" .. Regions[regionToCheck].dlc_group).CurrentStage) == 1 then
    return ProgressiveCheck(regionToCheck, Regions[regionToCheck].dlc_group)
  elseif(Tracker:FindObjectForCode(Regions[regionToCheck].travel_item_name).Active) then
    return true -- return true if you have the travel item
  else
    return false
  end
end

function MiscCasesEntrances(regionToCheck)
  if(regionToCheck == "SouthernShelf") then
    return BasicCombat()
  elseif(regionToCheck == "FFSIntroSanctuary") then
    return (Tracker:FindObjectForCode("travel:thebackburner").Active or (Tracker:FindObjectForCode("progressivetravel:ffs").AcquiredCount >= 2))
  elseif(regionToCheck == "MtScarabResearchCenter") then
    return Tracker:FindObjectForCode("melee").Active
  elseif(regionToCheck == "CandlerakksCrag") then
    return Tracker:FindObjectForCode("license:commonpistol").Active
  elseif(regionToCheck == "Terminus") then
    return Tracker:FindObjectForCode("crouch").Active
  elseif(regionToCheck == "LairOfInfiniteAgony") then
    return Tracker:FindObjectForCode("crouch").Active
  elseif(regionToCheck == "TorgueArena") then
    return JumpHeight(490)
  elseif(regionToCheck == "VaultOfTheWarrior") then
    return JumpHeight(575)
  elseif(regionToCheck == "FFSBossFight") then
    return JumpHeight(588)
  elseif(regionToCheck == "WingedStorm") then
    return JumpHeight(425)
  elseif(regionToCheck == "MagnysLighthouse") then
    return JumpHeight(310)
  elseif(regionToCheck == "SouthernRaceway") then
    return JumpHeight(450)
  elseif(regionToCheck == "BadassCraterBar") then
    return JumpHeight(395)
  else
    return true
  end
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
  if staleJump then
    local heightBonus = Tracker:FindObjectForCode("max_jump_height").CurrentStage * 300
    local maxHeight = 630 + heightBonus
    local frac = Tracker:ProviderCountForCode("progressivejump") / Tracker:FindObjectForCode("jump_checks").CurrentStage
    frac = math.sqrt(frac)
    currentJumpHeight = math.max(220, math.min(maxHeight, maxHeight * frac))
    staleJump = false
  end
  return (currentJumpHeight >= height)
end

function CanMakeJump(height)
  height = tonumber(height)
  if JumpHeight(height) then
    return AccessibilityLevel.Normal
  else
    return AccessibilityLevel.None
  end
end

function OnLevel(level, aolKeep)
  aolKeep = aolKeep or false
  local levelToCheck = tonumber(level)
  if levelToCheck == 0 then
    return AccessibilityLevel.Normal
  end
  if staleRegions then
    OpenRegions()
  end
  if staleLevels then
    if aolKeep then
        goto skipAOL
    end
    if ((Tracker:FindObjectForCode("always_on_level").CurrentStage == 1) or (Tracker:FindObjectForCode("always_on_level").CurrentStage == 2)) then
      staleLevels = false
      if not(BasicCombat()) then
        return AccessibilityLevel.SequenceBreak
      end
      return AccessibilityLevel.Normal
    end
    ::skipAOL::
    highestLevel = OpenLevels()
    staleLevels = false
  end
  if not(LevelLimit(levelToCheck)) then
    return AccessibilityLevel.None
  end
  if (levelToCheck <= highestLevel) then
    return AccessibilityLevel.Normal
  else
    return AccessibilityLevel.SequenceBreak
  end
end

function OpenLevels()
  local reachableLevel = 0
  local recheckRegions = true
  if Tracker:FindObjectForCode("overridelevel15").Active then
    reachableLevel = 16
  end
  if Tracker:FindObjectForCode("overridelevel30").Active then
    reachableLevel = 31
    goto skipLoop
  end
  while recheckRegions do
    recheckRegions = false
    for region, accessibility in pairs(accessibleRegions) do
      if accessibility == AccessibilityLevel.None then
        goto continue
      end
      if Regions[region].minLevel > reachableLevel then
        goto continue
      end
      if Regions[region].maxLevel <= reachableLevel then
        goto continue
      end
      if (Regions[region].maxLevel > 0) and (reachableLevel <= 0) then
        if not(BasicCombat()) then
          reachableLevel = 0
          goto skipLoop
        end
      end
      if (Regions[region].maxLevel > 10) and (reachableLevel <= 10) then
        if not(OverLevel10()) then
          reachableLevel = 10
          goto skipLoop
        end
      end
      reachableLevel = Regions[region].maxLevel
      recheckRegions = true
      ::continue::
    end
  end
  ::skipLoop::
  print ("Reachable Level:" .. reachableLevel)
  return reachableLevel
end

function LevelLimit(level)
  local levelToCheck = tonumber(level)
  if staleLevelLimit == true then
    maxLevel = Tracker:FindObjectForCode("max_level_checks").AcquiredCount
    staleLevelLimit = false
  end
  if((levelToCheck > maxLevel) and (maxLevel ~= 0)) then -- false if over max check level
    return false
  else
    return true
  end
end

function BasicCombat()
  if (Tracker:FindObjectForCode("gear_licenses").CurrentStage > 0) then
    return (Tracker:FindObjectForCode("melee").Active) or (Tracker:FindObjectForCode("license:commonpistol").Active)
  else
    return true
  end
end

function OverLevel10()
  if (Tracker:FindObjectForCode("gear_licenses").CurrentStage > 0) then
    return (Tracker:FindObjectForCode("melee").Active) and (Tracker:FindObjectForCode("license:commonpistol").Active)
  else
    return true
  end
end

function DisableForLvl15Override()
  if Tracker:FindObjectForCode("overridelevel15").Active then
    return false
  else
    return true
  end
end

function DisableForLvl30Override()
  if Tracker:FindObjectForCode("overridelevel30").Active then
    return false
  else
    return true
  end
end