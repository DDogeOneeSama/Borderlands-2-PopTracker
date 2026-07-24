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
    WindshearWaste = AccessibilityLevel.Normal,
    Level0 = AccessibilityLevel.Normal
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
  if(regionToCheck == "FFSIntroSanctuary") then
    return (Tracker:FindObjectForCode("travel:thebackburner").Active or (Tracker:FindObjectForCode("progressivetravel:ffs").AcquiredCount >= 2))
  elseif(regionToCheck == "CandlerakksCrag") then
    return Tracker:FindObjectForCode("license:commonpistol").Active and JumpHeight(629)
  elseif(regionToCheck == "Terminus") then
    return Tracker:FindObjectForCode("crouch").Active
  elseif(regionToCheck == "FFSBossFight") then
    return Tracker:FindObjectForCode("melee").Active
  elseif(regionToCheck == "LairOfInfiniteAgony") then
    return Tracker:FindObjectForCode("crouch").Active
  elseif(regionToCheck == "TorgueArena") then
      return JumpHeight(490)
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

function OnLevel(level)
  local levelToCheck = tonumber(level)
  if levelToCheck == 0 then
    return AccessibilityLevel.Normal
  end
  if staleRegions then
    OpenRegions()
  end
  if staleLevels then
    if ((Tracker:FindObjectForCode("gear_licenses").CurrentStage == 1) or (Tracker:FindObjectForCode("gear_licenses").CurrentStage == 2)) then
      return AccessibilityLevel.Normal
    end
    highestLevel = OpenLevels()
    staleLevels = false
  end
  if not(LevelLimit(levelToCheck)) then
    return AccessibilityLevel.None
  end
  if ((1 <= levelToCheck and levelToCheck <= 5) and (accessibleRegions["Level1to5"])) then
    return AccessibilityLevel.Normal
  else
    return AccessibilityLevel.SequenceBreak
  end
end

function OpenLevels()
  local
  
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

function Level1to5Gear()
  if (Tracker:FindObjectForCode("gear_licenses").CurrentStage > 0) then
    return (Tracker:FindObjectForCode("melee").Active) or (Tracker:FindObjectForCode("license:commonpistol").Active)
  else
    return true
  end
end

function Level6to10Gear()
  if (Tracker:FindObjectForCode("gear_licenses").CurrentStage > 0) then
    return (Tracker:FindObjectForCode("melee").Active) and (Tracker:FindObjectForCode("license:commonpistol").Active)
  else
    return true
  end
end