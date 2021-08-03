---@diagnostic disable: undefined-global, lowercase-global
--*Bear
--TODO:Add 2800AP Change to use Swipe for ST.
--TODO:Change to OM casts for Bear based on Threat Table sorted a-->b

--*Cat
--TODO:Rake for Bosses, not worth on default hc bosses.

--*PvP
--TODO:Faerie Fire on Rogues/Druid
--TODO:Bear->Charge->Kick important casts
--TODO:Roots on HasBuff(object,Spell) -- Melee List needed
--TODO:TotemStomp(Spell,Range) * List needed
--TODO:Break Stuns with Changeform
--TODO:Cyclone on Healer if target <= xx


--*Tree stuff
--TODO:If im bored?
--!Prolly not lol fuck healing.

local Tinkr = ...
local wowex = {}
local Routine = Tinkr.Routine
local Util = Tinkr.Util
local Draw = Tinkr.Util.Draw:New()
local OM = Tinkr.Util.ObjectManager
local lastdebugmsg = ""
local lastdebugtime = 0
Tinkr:require('scripts.cromulon.libs.Libdraw.Libs.LibStub.LibStub', wowex) --! If you are loading from disk your rotaiton. 
Tinkr:require('scripts.cromulon.libs.Libdraw.LibDraw', wowex) 
Tinkr:require('scripts.cromulon.libs.AceGUI30.AceGUI30', wowex)
Tinkr:require('scripts.cromulon.libs.AceGUI30.widgets.AceGUIContainer-BlizOptionsGroup' , wowex)
Tinkr:require('scripts.cromulon.libs.AceGUI30.widgets.AceGUIContainer-DropDownGroup' , wowex)
Tinkr:require('scripts.cromulon.libs.AceGUI30.widgets.AceGUIContainer-Frame' , wowex)
Tinkr:require('scripts.cromulon.libs.AceGUI30.widgets.AceGUIContainer-InlineGroup' , wowex)
Tinkr:require('scripts.cromulon.libs.AceGUI30.widgets.AceGUIContainer-ScrollFrame' , wowex)
Tinkr:require('scripts.cromulon.libs.AceGUI30.widgets.AceGUIContainer-SimpleGroup' , wowex)
Tinkr:require('scripts.cromulon.libs.AceGUI30.widgets.AceGUIContainer-TabGroup' , wowex)
Tinkr:require('scripts.cromulon.libs.AceGUI30.widgets.AceGUIContainer-TreeGroup' , wowex)
Tinkr:require('scripts.cromulon.libs.AceGUI30.widgets.AceGUIContainer-Window' , wowex)
Tinkr:require('scripts.cromulon.libs.AceGUI30.widgets.AceGUIWidget-Button' , wowex)
Tinkr:require('scripts.cromulon.libs.AceGUI30.widgets.AceGUIWidget-CheckBox' , wowex)
Tinkr:require('scripts.cromulon.libs.AceGUI30.widgets.AceGUIWidget-ColorPicker' , wowex)
Tinkr:require('scripts.cromulon.libs.AceGUI30.widgets.AceGUIWidget-DropDown' , wowex)
Tinkr:require('scripts.cromulon.libs.AceGUI30.widgets.AceGUIWidget-DropDown-Items' , wowex)
Tinkr:require('scripts.cromulon.libs.AceGUI30.widgets.AceGUIWidget-EditBox' , wowex)
Tinkr:require('scripts.cromulon.libs.AceGUI30.widgets.AceGUIWidget-Heading' , wowex)
Tinkr:require('scripts.cromulon.libs.AceGUI30.widgets.AceGUIWidget-Icon' , wowex)
Tinkr:require('scripts.cromulon.libs.AceGUI30.widgets.AceGUIWidget-InteractiveLabel' , wowex)
Tinkr:require('scripts.cromulon.libs.AceGUI30.widgets.AceGUIWidget-Keybinding' , wowex)
Tinkr:require('scripts.cromulon.libs.AceGUI30.widgets.AceGUIWidget-Label' , wowex)
Tinkr:require('scripts.cromulon.libs.AceGUI30.widgets.AceGUIWidget-MultiLineEditBox' , wowex)
Tinkr:require('scripts.cromulon.libs.AceGUI30.widgets.AceGUIWidget-Slider' , wowex)
Tinkr:require('scripts.wowex.libs.AceAddon30.AceAddon30' , wowex)
Tinkr:require('scripts.wowex.libs.AceConsole30.AceConsole30' , wowex)
Tinkr:require('scripts.wowex.libs.AceDB30.AceDB30' , wowex)
Tinkr:require('scripts.cromulon.system.configs' , wowex)
Tinkr:require('scripts.cromulon.system.storage' , wowex)
Tinkr:require('scripts.cromulon.libs.libCh0tFqRg.libCh0tFqRg' , wowex)
Tinkr:require('scripts.cromulon.libs.libNekSv2Ip.libNekSv2Ip' , wowex)
Tinkr:require('scripts.cromulon.libs.CallbackHandler10.CallbackHandler10' , wowex)
Tinkr:require('scripts.cromulon.libs.HereBeDragons.HereBeDragons-20' , wowex)
Tinkr:require('scripts.cromulon.libs.HereBeDragons.HereBeDragons-pins-20' , wowex)
Tinkr:require('scripts.cromulon.interface.uibuilder' , wowex)
Tinkr:require('scripts.cromulon.interface.buttons' , wowex)
Tinkr:require('scripts.cromulon.interface.panels' , wowex)
Tinkr:require('scripts.cromulon.interface.minimap' , wowex)



function distancetwo(object)
  local X1, Y1, Z1 = ObjectPosition('player')
  local X2, Y2, Z2 = ObjectPosition(object)
  if X1 and Y1 and X2 and Y2 and Z1 and Z2 then
    return math.sqrt(((X2 - X1) ^ 2) + ((Y2 - Y1) ^ 2) + ((Z2 - Z1) ^ 2))
  end
end

function round(num, numDecimalPlaces)
  return tonumber(string.format("%." .. (numDecimalPlaces or 0) .. "f", num))
end
Draw:Sync(function(draw)
  local px, py, pz = ObjectPosition('player')
  local rotation = ObjectRotation("player")
  if wowex.wowexStorage.read('targetingusdraw') then
    for i, object in ipairs(Objects()) do
      if ObjectType(object) == 4 and UnitCanAttack("player",object) then
        if not ObjectTarget(object) == ObjectId("player") then
          local px, py, pz = ObjectPosition("player")
          local tx, ty, tz = ObjectPosition(object)
          if distancetwo(object) <= 8 then
            draw:SetColor(0,255,0)
          end
          if distancetwo(object) >= 8 and distancetwo(object) <= 30 then
            draw:SetColor(199,206,0)            
          end
          if distancetwo(object) >= 30 then
            draw:SetColor(255,0,0)
          end  
          draw:SetWidth(4)
          draw:SetAlpha(150)
          draw:Line(px,py,pz,tx,ty,tz,4,55)
        end
      end
    end 
  end
  if wowex.wowexStorage.read('pvpdraw') then
    for object in OM:Objects(OM.Types.Player) do
      if UnitCanAttack("player",object) then
        local tx, ty, tz = ObjectPosition(object)
        local dist = distancetwo(object) 
        local health = UnitHealth(object)
        local class = UnitClass(object)
        Draw:SetColor(0,255,0)
        Draw:Text(round(dist).."y".." "..health.."%","GameFontNormalSmall", tx, ty, tz+2)
        if UnitClass(object) == "Warrior" then
          Draw:SetColor(198,155,109)
          Draw:Text(class,"GameFontNormalSmall", tx, ty, tz+1)
        elseif UnitClass(object) == "Warlock" then
          Draw:SetColor(135,136,238)
          Draw:Text(class,"GameFontNormalSmall", tx, ty, tz+1)
        elseif UnitClass(object) == "Shaman" then
          Draw:SetColor(0,112,221	)
          Draw:Text(class,"GameFontNormalSmall", tx, ty, tz+1)
        elseif UnitClass(object) == "Priest" then
          Draw:SetColor(255,255,255)
          Draw:Text(class,"GameFontNormalSmall", tx, ty, tz+1)
        elseif UnitClass(object) == "Mage" then
          Draw:SetColor(63,199,235)
          Draw:Text(class,"GameFontNormalSmall", tx, ty, tz+1)
        elseif UnitClass(object) == "Hunter" then
          Draw:SetColor(170,211,114)
          Draw:Text(class,"GameFontNormalSmall", tx, ty, tz+1)
        elseif UnitClass(object) == "Paladin" then
          Draw:SetColor(244,140,186	)
          Draw:Text(class,"GameFontNormalSmall", tx, ty, tz+1)
        elseif UnitClass(object) == "Rogue" then
          Draw:SetColor(255,244,104)
          Draw:Text(class,"GameFontNormalSmall", tx, ty, tz+1)
        elseif UnitClass(object) == "Druid" then
          Draw:SetColor(255,124,10)
          Draw:Text(class,"GameFontNormalSmall", tx, ty, tz+1)
        end
      end
    end
  end
end)

local function Debug(spellid,text)
  if (lastdebugmsg ~= message or lastdebugtime < GetTime()) then
    local _, _, icon = GetSpellInfo(spellid)
    lastdebugmsg = message
    lastdebugtime = GetTime() + 2
    RaidNotice_AddMessage(RaidWarningFrame, "|T"..icon..":0|t"..text, ChatTypeInfo["RAID_WARNING"],1)
    return true
  end
  return false
end

Routine:RegisterRoutine(function()
  if UnitCastingInfo("player") or UnitChannelInfo("player") or IsEatingOrDrinking() then return end
  local GetComboPoints = GetComboPoints("player","target")
  local mana = power(PowerType.Mana, "player")
  local rage = power(PowerType.Rage, "player")
  
  local function GetAggroRange(unit)
    local range = 0
    local playerlvl = UnitLevel("player")
    local targetlvl = UnitLevel(unit)
    range = 20 - (playerlvl - targetlvl) * 1
    if range <= 5 then
      range = 10
    elseif range >= 45 then
      range = 45
    elseif UnitReaction("player", unit) >= 4 then
      range = 10
    end
    return range +2
  end
  function AoeHasDebuff(spell,range)
    local count = 0
    for object in OM:Objects(OM.Types.Units) do
      if UnitAffectingCombat(object) and UnitCanAttack("player",object) and not UnitIsDeadOrGhost(object) and ObjectDistance("player",object) <= range then
        local isTanking, status, threatpct, rawthreatpct, threatvalue = UnitDetailedThreatSituation("player", object)
        if threatvalue and threatvalue > 0 then
          if debuff(spell,object) then
            count = count + 1
          end
        end
      end
    end
    return count
  end
  local function GetFinisherMaxDamage(ID)
    local function GetStringSpace(x, y)
      for i = 1, 7 do
        if string.sub(x, y + i, y + i) then
          if string.sub(x, y + i, y + i) == " " then
            return i
          end
        end
      end
    end
    local f = GetSpellDescription(ID)
    local _, a, b, c, d, e = strsplit("\n", f)
    local aa, bb, cc, dd, ee = string.find(a, "%-"), string.find(b, "%-"), string.find(c, "%-"), string.find(d, "%-"), string.find(e, "%-")
    return tonumber(string.sub(a, aa + 1, aa + GetStringSpace(a, aa))), tonumber(string.sub(b, bb + 1, bb + GetStringSpace(b, bb))), tonumber(string.sub(c, cc + 1, cc + GetStringSpace(c, cc))), tonumber(string.sub(d, dd + 1, dd + GetStringSpace(d, dd))), tonumber(string.sub(e, ee + 1, ee + GetStringSpace(e, ee)))
  end
  local function manacost(spellname)
    if not spellname then
      return 0
    else
      local costTable = GetSpellPowerCost(spellname)
      if costTable == nil then
        return 0
      end
      for _, costInfo in pairs(costTable) do
        if costInfo.type == 0 then
          return costInfo.cost
        end
      end
    end
  end
  local function GetSpellEffect(spellID)
    local spell_effect_cache = {}
    if not spellID then return end
    if spell_effect_cache[spellID] then return spell_effect_cache[spellID] end
    local desc = GetSpellDescription(spellID);
    local blocks = {};
    for n in desc:gmatch("%S+") do
      table.insert(blocks,n);
    end
    local good = {}
    for i=1,#blocks do
      local s = string.gsub(blocks[i],",","");
      table.insert(good,s);
    end
    local reallygood={};
    for i=1,#good do if tonumber(good[i]) then table.insert(reallygood,tonumber(good[i])); end end
    table.sort(reallygood, function(x,y) return x > y end)
    spell_effect_cache[spellID] = reallygood[1]
    return reallygood[1]
  end
  local function Shapeform()
    if not IsSpellKnown(9634) then
      return manacost("Bear Form")
    end
    if IsSpellKnown(9634) then
      return manacost("Dire Bear Form")
    end
    return false
  end
  local function IsFacing(Unit, Other)
    local SelfX, SelfY, SelfZ = ObjectPosition(Unit)
    local SelfFacing = ObjectRotation(Unit)
    local OtherX, OtherY, OtherZ = ObjectPosition(Other)
    local Angle = SelfX and SelfY and OtherX and OtherY and SelfFacing and ((SelfX - OtherX) * math.cos(-SelfFacing)) - ((SelfY - OtherY) * math.sin(-SelfFacing)) or 0
    return Angle < 0
  end
  local function IsBehind(Unit, Other)
    if not IsFacing(Unit, Other) then
      return true
    else return false
    end
  end
  function IsPoisoned(unit)
    unit = unit or "player"
    for i=1,30 do
      local debuff,_,_,debufftype = UnitDebuff(unit,i)
      if not debuff then break end
      if debufftype == "Poison" then
        return debuff
      end
    end
  end
  local function Loot()
    if wowex.wowexStorage.read('autoloot') and not buff(Prowl,"player") then
      for i, object in ipairs(Objects()) do
        if ObjectLootable(object) and ObjectDistance("player",object) < 5 and ObjectType(object) == 3 then
          ObjectInteract(object)
        end
      end
      for i = GetNumLootItems(), 1, -1 do
        LootSlot(i)
      end
    end
    return false
  end
  local function Opener()
    if buff(Prowl,"player") then
      if IsBehind("target","player") then
        if wowex.wowexStorage.read("openerbehind") == "Ravage" and castable(Ravage,"target") then
          return cast(Ravage,"target")
        end
        if wowex.wowexStorage.read("openerbehind") == "Pounce"  and castable(Pounce,"target") then
          return cast(Pounce,"target")
        end
      end
      if not IsBehind("target","player") then
        if wowex.wowexStorage.read("openerfrontal") == "Pounce" and castable(Pounce,"target") then
          return cast(Pounce,"target")
        end
      end
    end
  end
  local function IsDungeonBoss(unit)
    unit = unit or "target"
    if IsInInstance() or IsInRaid() then
      local _, _, encountersTotal = GetInstanceLockTimeRemaining()
      for i = 1, encountersTotal do
        local boss = GetInstanceLockTimeRemainingEncounter(i)
        local name = UnitName(unit)
        if name == boss then            
          return true
        end
      end
      return false
    end
  end
  local function Healing()
    if wowex.wowexStorage.read("useDispel") and IsPoisoned("player") and castable(AbolishPoison,"player") then
      cast(AbolishPoison,"player")
      Debug(2893," Cured "..IsPoisoned("player"))
    end
    if wowex.wowexStorage.read("useHeals") then
      --*ic
      if UnitAffectingCombat("player") then
        if health() <=wowex.wowexStorage.read('rejuvichp',45) and castable(Rejuvenation,"player") and (not buff(Rejuvenation,"player") or buffduration(Rejuvenation,"player") <= 0.3) and mana >= manacost("Rejuvenation") + manacost("Cat Form") then 
          return cast(Rejuvenation,"player")
        end
        if health() <= wowex.wowexStorage.read('regrowthichp',45) and not moving("player") and castable(Regrowth,"player") and (not buff(Regrowth,"player") or buffduration(Regrowth,"player") <= 0.3) and mana >= manacost("Regrowth") + manacost("Cat Form") then 
          return cast(Regrowth,"player")
        end
        if health() <= wowex.wowexStorage.read('healingtouchichp',20) and not moving("player") and castable(Regrowth,"player") and mana >= manacost("Healing Touch") + manacost("Cat Form") then 
          return cast(HealingTouch,"player")
        end
      end
      --*ooc
      if not UnitAffectingCombat("player") then
        if health() <=wowex.wowexStorage.read('rejuvoochp',45) and castable(Rejuvenation,"player") and (not buff(Rejuvenation,"player") or buffduration(Rejuvenation,"player") <= 0.3) and mana >= manacost("Rejuvenation") + manacost("Cat Form") then 
          return cast(Rejuvenation,"player")
        end
        if health() <= wowex.wowexStorage.read('regrowthoochp',45) and not moving("player") and castable(Regrowth,"player") and (not buff(Regrowth,"player") or buffduration(Regrowth,"player") <= 0.3) and mana >= manacost("Regrowth") + manacost("Cat Form") then 
          return cast(Regrowth,"player")
        end
        if health() <= wowex.wowexStorage.read('healingtouchoochp',20) and not moving("player") and castable(Regrowth,"player") and mana >= manacost("Healing Touch") + manacost("Cat Form") then 
          return cast(HealingTouch,"player")
        end
      end
    end
    
    return false
  end
  local function Dps()
    if UnitCanAttack("player","target") and not UnitIsDeadOrGhost("target") then
      if not IsPlayerAttacking('target') then
        Eval('StartAttack()', 't')
      end
      if buff(CatForm,"player") then
        if castable(Rip,"target") then
          if GetComboPoints == 5 and ttd() >= 10 then
            return cast(Rip,"target")
          end
        end
        if castable(FerociousBite,"target") then
          local ap = UnitAttackPower("player")
          local multiplier = 1.4
          local f1, f2, f3, f4, f5 = GetFinisherMaxDamage("Ferocious Bite")
          local fb1calculated = ap * (1 * 0.03) + f1 * multiplier
          local fb2calculated = ap * (2 * 0.03) + f2 * multiplier
          local fb3calculated = ap * (3 * 0.03) + f3 * multiplier
          local fb4calculated = ap * (4 * 0.03) + f4 * multiplier
          if UnitHealth("target") <= fb1calculated and GetComboPoints == 1 then
            return cast(FerociousBite,"target")
          end
          if UnitHealth("target") <= fb2calculated and GetComboPoints == 2 then
            return cast(FerociousBite,"target")
            
          end
          if UnitHealth("target") <= fb3calculated and GetComboPoints == 3 then
            return cast(FerociousBite,"target")
            
          end
          if UnitHealth("target") <= fb4calculated and GetComboPoints == 4 then
            return cast(FerociousBite,"target")
            
          end
          if GetComboPoints == 5 and not UnitIsPlayer("target") or (UnitIsPlayer("target") and UnitHealth("target") <= 15) then
            return cast(FerociousBite,"target")
          end
        end
        if castable(FaerieFireFeral,"target") and ttd() > 6 and (not debuff(FaerieFireFeral,"target") or debuffduration(FaerieFireFeral,"target") <= 0.4) then
          return cast(FaerieFireFeral,"target")
        end
        if melee() then
          if castable(MangleCat) and GetComboPoints < 5 and (not debuff(MangleCat,"target") or debuffduration(MangleCat,"target") <= 0.4) then
            return cast(MangleCat,"target")
          end
          if IsBehind("target","player") and castable(Shred,"target") and GetComboPoints < 5 then
            return cast(Shred,"target")
          end
          
          if not IsBehind("target","player") and GetComboPoints < 5 then
            return cast(MangleCat,"target")
          end   
        end
      end
      --*Bear
      if buff(BearForm,"player") or buff(DireBearForm,"player") then
        local rage = power(PowerType.Rage, "player")
        local base, posBuff, negBuff = UnitAttackPower("player")
        local effective = base + posBuff + negBuff
        local MaulID = resolveSpellID(Maul)
        if castable(Growl) then
          for object in OM:Objects(OM.Types.Units) do
            if UnitCanAttack("player",object) and UnitCreatureType(object) ~= "Critter" and not UnitIsPlayer(object) and not UnitIsDeadOrGhost(object)  then
              local isTanking, status, threatpct, rawthreatpct, threatvalue = UnitDetailedThreatSituation("player", object)
              if threatpct and threatpct <= 60 and distance("player",object) <= 8 then
                cast(Growl,object)
              end
            end
          end
        end
        if AoeHasDebuff(DemoralizingRoar,8) < enemies("player", 8) and castable(DemoralizingRoar) then
          return cast(DemoralizingRoar)
        end
        if enemies("player",8) >= 3 then
          if castable(Swipe,"target") then
            return cast(Swipe,"target")
          end
          if rage > 45 and not IsCurrentSpell(MaulID) then
            return cast(Maul,"target")
          end
        end
        if enemies("player", 8) < 3 then
          if castable(Lacerate) and (debuffCount(Lacerate, "target") < 5 or debuffduration(Lacerate,"target") <= 2) then --(debuffCount('target', Lacerate) < 5 or debuffduration(Lacerate,"target") <= 2) then
            return cast(Lacerate,"target")
          end
          if rage > 45 and not IsCurrentSpell(MaulID) then
            return cast(Maul,"target")
          end
        end        
      end
    end
    return false
  end
  local function Buff()
    local isArena, isRegistered = IsActiveBattlefieldArena();
    if castable(MarkOfTheWild,"player") and (not buff(MarkOfTheWild,"player") and not buff(GiftOfTheWild,"player"))  then
      return cast(MarkOfTheWild,"player")
    end
    if castable(Thorns,"player") and (not buff(Thorns,"player") or buffduration(Thorns,"player") <= 60) then
      return cast(Thorns,"player")
    end
    if castable(OmenOfClarity) and (not buff(OmenOfClarity,"player") or buffduration(OmenOfClarity,"player") <= 120) then
      return cast(OmenOfClarity,"player")
    end
    if not UnitAffectingCombat("player") and (buff(BearForm,"player") or buff(DireBearForm,"player")) then 
      if rage <= 20 and rage >= 5 then
        if distance("player","target") <= 25 and distance("player","target") > 15 then
          cast(Enrage,"player")
          Debug(5229,"Enrage on Pull")
        end
      end
      if rage == 0 and UnitExists("target") and not UnitIsDeadOrGhost("target") and distance("player","target") <= 25 then
        Eval('RunMacroText("/cast !Dire Bear Form")', 'r')
        Debug(9634,"Power Shift 0 Rage on Pull")
      end
    end
    if isArena then
      for i = 1 , GetNumGroupMembers() do
        if not buff(MarkOfTheWild,"PARTY"..i) and castable(MarkOfTheWild,"PARTY"..i) then
          return cast(MarkOfTheWild,"PARTY"..i)
        end
      end
      for i = 1 , GetNumGroupMembers() do
        if not buff(Thorns,"PARTY"..i) and castable(Thorns,"PARTY"..i) then
          return cast(Thorns,"PARTY"..i)
        end
      end
    end
  end
  local function Hide()
    if wowex.wowexStorage.read("useStealth") and not buff(Prowl,"player") and castable(Prowl) then
      if wowex.wowexStorage.read("stealthmode") == "DynOM" then
        for i, object in ipairs(Objects()) do
          if ObjectType(object) == 3 and UnitCanAttack("player",object) and UnitCreatureType(object) ~= "Critter" and distance("player",object) <= GetAggroRange(object) and not UnitIsDeadOrGhost(object) and not UnitAffectingCombat(object) then
            return cast(Prowl)
          end
        end
      end
      if UnitIsPlayer("target") and distance("player","target") <= 30 and UnitCanAttack("player","target") then
        return cast(Prowl)
      end
    end    
    return false
  end
  local function PowerShift()
    if buff(CatForm,"player") and power() <= 8 and mana >= manacost("Cat Form") then
      Eval('RunMacroText("/return cast !Cat Form")', 'r')
    end 
  end
  local function OutOfCombat()
    if not UnitAffectingCombat("player") then
      if Opener() then return true end
      if Loot() then return true end
      if Healing() then return true end
      if Buff() then return true end
      if Hide() then return true end
    end
    return false
  end
  local function Incombat()
    if UnitAffectingCombat("player") then
      if PowerShift() then return true end
      if Dps() then return true end
      if Healing() then return true end
    end
    return false
  end  
  if OutOfCombat() then return true end
  if Incombat() then return true end
  
end, Routine.Classes.Druid, Routine.Specs.Druid)
Routine:LoadRoutine(Routine.Specs.Druid)

local button_example = {
  {
    key = "useStealth",
    buttonname = "useStealth",
    texture = "ability_druid_supriseattack",
    tooltip = "Stealth",
    text = "Stealth",
    setx = "TOP",
    parent = "settings",
    sety = "TOPRIGHT"
  },
  {
    key = "useHeals",
    buttonname = "useHeals",
    texture = "spell_nature_healingtouch",
    tooltip = "Use Heals",
    text = "Use Heals",
    setx = "TOP",
    parent = "useStealth",
    sety = "TOPRIGHT"
  },
  {
    key = "useDispel",
    buttonname = "useDispel",
    texture = "Spell_nature_nullifypoison",
    tooltip = "Dispel Poison",
    text = "Dispel Poison",
    setx = "TOP",
    parent = "useHeals",
    sety = "TOPRIGHT"
  },
}
wowex.button_factory(button_example)

local mytable = {
  key = "cromulon_config",
  name = "Rebecca Feral Tbc",
  height = 650,
  width = 400,
  panels = 
  {
    { 
      name = "Offensive",
      items = 
      {
        { key = "heading", type = "text", color = 'FF7C0A', text = "Multiplier = Eviscerate=Attack Power * (Number of Combo Points used * 0.03) * abitrary multiplier to account for Auto Attacks while pooling Recommendation : <= 60 == 1.6 >= 60 == 1.4" },
        
        { key = "heading", type = "heading", color = 'FF7C0A', text = "Execute" },
        { key = "personalmultiplier", type = "slider", text = "Execute Multiplier", label = "Execute Multiplier", min = 1, max = 3, step = 0.1 },
        { key = "heading", type = "heading", color = 'FF7C0A', text = "Opener" },
        { key = "openerfrontal", width = 175, label = "Frontal", text = wowex.wowexStorage.read("openerfrontal"), type = "dropdown",
        options = {"Pounce", "None",} },
        { key = "openerbehind", width = 175, label = "Behind", text = wowex.wowexStorage.read("openerbehind"), type = "dropdown",
        options = {"Ravage", "Pounce","None"} },
        --{ key = "pershealwavepercent", type = "slider", text = "Healing Wave", label = "Healing Wave at", min = 1, max = 100, step = 1 },
        
      },
    },
    { 
      name = "Defensives",
      items = 
      {
        { key = "heading", type = "heading", color = 'FF7C0A', text = "In Combat Healing" },
        { key = "heading", type = "heading", color = 'FF7C0A', text = "Rejuvenation" },
        { key = "rejuvichp", type = "slider", text = "", label = "Rejuvenation at", min = 1, max = 100, step = 1 },
        { key = "heading", type = "heading", color = 'FF7C0A', text = "Healing Touch" },
        { key = "healingtouchichp", type = "slider", text = "", label = "Healing Touch at", min = 0, max = 100, step = 1 },
        { key = "heading", type = "heading", color = 'FF7C0A', text = "Regrowth" },
        { key = "regrowthichp", type = "slider", text = "", label = "Regrowth at", min = 0, max = 100, step = 1 },
        { key = "heading", type = "heading", color = 'FF7C0A', text = "Out of Combat Healing" },
        { key = "heading", type = "heading", color = 'FF7C0A', text = "Rejuvenation" },
        { key = "rejuvoochp", type = "slider", text = "", label = "Rejuvenation at", min = 1, max = 100, step = 1 },
        { key = "heading", type = "heading", color = 'FF7C0A', text = "Healing Touch" },
        { key = "healingtouchoochp", type = "slider", text = "", label = "Healing Touch at", min = 0, max = 100, step = 1 },
        { key = "heading", type = "heading", color = 'FF7C0A', text = "Regrowth" },
        { key = "regrowthoochp", type = "slider", text = "", label = "Regrowth at", min = 0, max = 100, step = 1 },
        
      }
    },
    { 
      name = "General",
      items = 
      {
        { key = "heading", type = "heading", color = 'FF7C0A', text = "Stealth" },
        {type = "text", text = "DynOM = Scans the area around you for NPC aggro ranges and puts you into stealth when you get close to them.", color = 'FF7C0A'},
        {type = "text", text = "DynTarget = Stealthes you when you're near your TARGET's aggro range.", color = 'FF7C0A'},       
        { key = "stealthmode", width = 175, label = "Stealth Mode", text = wowex.wowexStorage.read("stealthmode"), type = "dropdown",
        options = {"DynOM", "DynTarget",} },
        
        { key = "heading", type = "heading", color = 'FF7C0A', text = "Other" },
        { key = "autoloot",  type = "checkbox", text = "Auto Loot", desc = "" },
        
      }
    },
    { 
      name = "Draw",
      items = 
      {
        --  { key = "bladeflurrydraw",  type = "checkbox", text = "BladeFlurry Range", desc = "" },
        --  { key = "targetingusdraw",  type = "checkbox", text = "Players targeting us", desc = "" },
        --  {type = "text", text = "Red: >= 30y yellow: <= 30y green: <= 8y", color = 'FFF468'},
        { key = "pvpdraw",  type = "checkbox", text = "PvP Radar", desc = "" },
        
      }
    },
  },
  
  tabgroup = 
  {
    {text = "Offensive", value = "one"},
    {text = "Defensives", value = "two"},
    {text = "General", value = "three"},
    {text = "Draw", value = "four"}
    
  }
}
Draw:Enable()
wowex.createpanels(mytable)
wowex.panel:Hide()     
