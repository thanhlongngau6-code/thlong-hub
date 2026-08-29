--[[
  ╔══════════════════════════════════════════════════════╗
  ║  BANANA HUB MASTER v5.0                            ║
  ║  Core: bloxfruit.lua (verbatim functions+loops)    ║
  ║  GUI : UiBanana.txt Linoria pattern                ║
  ╠══════════════════════════════════════════════════════╣
  ║  Method/Function: bê nguyên từ bloxfruit.lua       ║
  ║  GUI toggles: set _G.* flags → loops chạy tự động ║
  ╚══════════════════════════════════════════════════════╝
]]
do
  ply = game:GetService("Players")
  plr = ply.LocalPlayer or ply.PlayerAdded:Wait()
  replicated = game:GetService("ReplicatedStorage")
  TeleportService = game:GetService("TeleportService")
  TW = game:GetService("TweenService")
  Lighting = game:GetService("Lighting")
  Enemies = workspace:FindFirstChild("Enemies") or workspace
  vim1 = game:GetService("VirtualInputManager")
  vim2 = game:GetService("VirtualUser")
  TeamSelf = plr.Team
  RunSer = game:GetService("RunService")
  Stats = game:GetService("Stats")
  BringConnections = {}
  BossList = {}
  MaterialList = {}
  NPCList = {}
  shouldTween = false
  SoulGuitar = false
  KenTest = true
  debug = false
  Brazier1 = false
  Brazier2 = false
  Brazier3 = false
  Sec = 0.1
  ClickState = 0
  Num_self = 25

  pcall(function()
    if plr.Character then
      Root = plr.Character:FindFirstChild("HumanoidRootPart")
      Energy = plr.Character:FindFirstChild("Energy") and plr.Character.Energy.Value or 100
    end
    if plr:FindFirstChild("Data") and plr.Data:FindFirstChild("Level") then
      Lv = plr.Data.Level.Value
    else
      Lv = 1
    end
  end)

  plr.CharacterAdded:Connect(function(char)
    task.spawn(function()
      Root = char:WaitForChild("HumanoidRootPart", 5)
      local e = char:WaitForChild("Energy", 5)
      if e then Energy = e.Value end
    end)
  end)
end

pcall(function()
  if not game:IsLoaded() then game.Loaded:Wait() end
  if plr and plr:FindFirstChild("PlayerGui") and plr.PlayerGui:FindFirstChild("Main") and plr.PlayerGui.Main:FindFirstChild("Loading") then
    local t = tick()
    while plr.PlayerGui.Main:FindFirstChild("Loading") and plr.PlayerGui.Main.Loading.Visible and (tick() - t < 5) do
      task.wait(0.5)
    end
  end
end)
World1 = game.PlaceId == 2753915549 or game.PlaceId == 85211729168715
World2 = game.PlaceId == 4442272183 or game.PlaceId == 79091703265657
World3 = game.PlaceId == 7449423635 or game.PlaceId == 100117331123089
Marines = function() replicated.Remotes.CommF_:InvokeServer("SetTeam","Marines") end
Pirates = function() replicated.Remotes.CommF_:InvokeServer("SetTeam","Pirates") end
if World1 then BossList = {"The Gorilla King","Bobby","The Saw","Yeti","Mob Leader","Vice Admiral","Saber Expert","Warden","Chief Warden","Swan","Magma Admiral","Fishman Lord","Wysper","Thunder God","Cyborg","Ice Admiral","Greybeard"}
elseif World2 then BossList = {"Diamond","Jeremy","Orbitus","Don Swan","Smoke Admiral","Awakened Ice Admiral","Tide Keeper","Darkbeard","Cursed Captain","Order"}
elseif World3 then BossList = {"Stone","Hydra Leader","Kilo Admiral","Captain Elephant","Beautiful Pirate","Cake Queen","Dough King","Longma","Soul Reaper","rip_indra True Form","Tyrant of the Skies"}
end
if World1 then MaterialList = {"Leather + Scrap Metal", "Angel Wings", "Magma Ore", "Fish Tail"}
elseif World2 then MaterialList = {"Leather + Scrap Metal", "Radioactive Material", "Ectoplasm", "Mystic Droplet", "Magma Ore", "Vampire Fang"}
elseif World3 then MaterialList = {"Scrap Metal", "Demonic Wisp", "Conjured Cocoa", "Dragon Scale", "Gunpowder", "Fish Tail", "Mini Tusk"}
end
local DungeonTables = {"Flame","Ice","Quake","Light","Dark","String","Rumble","Magma","Human: Buddha","Sand","Bird: Phoenix","Dough"}
local RenMon = {"Snow Lurker","Arctic Warrior","Hidden Key","Awakened Ice Admiral"}
local CursedTables = {["Mob"] = "Mythological Pirate",["Mob2"] = "Cursed Skeleton","Hell's Messenger",["Mob3"] = "Cursed Skeleton","Heaven's Guardian"}
local Past = {"Part","SpawnLocation","Terrain","WedgePart","MeshPart"}
local BartMon = {"Swan Pirate","Jeremy"}
local CitizenTable = {"Forest Pirate","Captain Elephant"}
local Human_v3_Mob = {"Fajita","Jeremy","Diamond"}
local AllBoats = {"Beast Hunter","Lantern","Guardian","Grand Brigade","Dinghy","Sloop","The Sentinel"}
local mastery1 = {"Cookie Crafter"}
local mastery2 = {"Reborn Skeleton"}
local PosMsList = {["Pirate Millionaire"] = CFrame.new(-712.8272705078125, 98.5770492553711, 5711.9541015625),["Pistol Billionaire"] = CFrame.new(-723.4331665039062, 147.42906188964844, 5931.9931640625),["Dragon Crew Warrior"] = CFrame.new(7021.50439453125, 55.76270294189453, -730.1290893554688),["Dragon Crew Archer"] = CFrame.new(6625, 378, 244),["Female Islander"] = CFrame.new(4692.7939453125, 797.9766845703125, 858.8480224609375),["Venomous Assailant"] = CFrame.new(4902, 670, 39), ["Marine Commodore"] = CFrame.new(2401, 123, -7589),["Marine Rear Admiral"] = CFrame.new(3588, 229, -7085),["Fishman Raider"] = CFrame.new(-10941, 332, -8760),["Fishman Captain"] = CFrame.new(-11035, 332, -9087),["Forest Pirate"] = CFrame.new(-13446, 413, -7760),["Mythological Pirate"] = CFrame.new(-13510, 584, -6987),["Jungle Pirate"] = CFrame.new(-11778, 426, -10592),["Musketeer Pirate"] = CFrame.new(-13282, 496, -9565),["Reborn Skeleton"] = CFrame.new(-8764, 142, 5963),["Living Zombie"] = CFrame.new(-10227, 421, 6161),["Demonic Soul"] = CFrame.new(-9579, 6, 6194),["Posessed Mummy"] = CFrame.new(-9579, 6, 6194),["Peanut Scout"] = CFrame.new(-1993, 187, -10103),["Peanut President"] = CFrame.new(-2215, 159, -10474),["Ice Cream Chef"] = CFrame.new(-877, 118, -11032),["Ice Cream Commander"] = CFrame.new(-877, 118, -11032),["Cookie Crafter"] = CFrame.new(-2021, 38, -12028),["Cake Guard"] = CFrame.new(-2024, 38, -12026),["Baking Staff"] = CFrame.new(-1932, 38, -12848),["Head Baker"] = CFrame.new(-1932, 38, -12848),["Cocoa Warrior"] = CFrame.new(95, 73, -12309),["Chocolate Bar Battler"] = CFrame.new(647, 42, -12401),["Sweet Thief"] = CFrame.new(116, 36, -12478),["Candy Rebel"] = CFrame.new(47, 61, -12889),["Ghost"] = CFrame.new(5251, 5, 1111)}
local Remotes = {
    RFJobsRemoteFunction = replicated.Modules.Net["RF/JobsRemoteFunction"], 
    RFCraft = replicated:WaitForChild("Modules"):WaitForChild("Net"):WaitForChild("RF/Craft")
}
EquipWeapon = function(text)
  if not text then return end
  if plr.Backpack:FindFirstChild(text) then
	plr.Character.Humanoid:EquipTool(plr.Backpack:FindFirstChild(text))
  end
end
weaponSc = function(weapon)
  for __in, v in pairs(plr.Backpack:GetChildren()) do
    if v:IsA("Tool") then
      if v.ToolTip == weapon then EquipWeapon(v.Name) end
    end
  end
end
local Attack = {}
Attack.__index = Attack
Attack.Alive = function(model) if not model then return end local Humanoid = model:FindFirstChild("Humanoid") return Humanoid and Humanoid.Health > 0 end
Attack.Pos = function(model,dist) return (Root.Position - mode.Position).Magnitude <= dist end
Attack.Dist = function(model,dist) return (Root.Position - model:FindFirstChild("HumanoidRootPart").Position).Magnitude <= dist end
Attack.DistH = function(model,dist) return (Root.Position - model:FindFirstChild("HumanoidRootPart").Position).Magnitude > dist end
Attack.Kill = function(model,Succes)
  if model and Succes then
  if not model:GetAttribute("Locked") then model:SetAttribute("Locked",model.HumanoidRootPart.CFrame) end
  PosMon = model:GetAttribute("Locked").Position
  BringEnemy()
  EquipWeapon(_G.SelectWeapon)
  local Equipped = game.Players.LocalPlayer.Character:FindFirstChildOfClass("Tool")
  local ToolTip = Equipped.ToolTip
  if ToolTip == "Blox Fruit" then _tp(model.HumanoidRootPart.CFrame * CFrame.new(0,10,0) * CFrame.Angles(0,math.rad(90),0)) else _tp(model.HumanoidRootPart.CFrame * CFrame.new(0,30,0) * CFrame.Angles(0,math.rad(180),0))end
  if RandomCFrame then wait(.5)_tp(model.HumanoidRootPart.CFrame * CFrame.new(0, 30, 25)) wait(.5)_tp(model.HumanoidRootPart.CFrame * CFrame.new(25, 30, 0)) wait(.5)_tp(model.HumanoidRootPart.CFrame * CFrame.new(-25, 30 ,0)) wait(.5)_tp(model.HumanoidRootPart.CFrame * CFrame.new(0, 30, 25)) wait(.5)_tp(model.HumanoidRootPart.CFrame * CFrame.new(-25, 30, 0))end
  end
end
Attack.Kill2 = function(model,Succes)
  if model and Succes then
  if not model:GetAttribute("Locked") then model:SetAttribute("Locked",model.HumanoidRootPart.CFrame) end
  PosMon = model:GetAttribute("Locked").Position
  BringEnemy()
  EquipWeapon(_G.SelectWeapon)
  local Equipped = game.Players.LocalPlayer.Character:FindFirstChildOfClass("Tool")
  local ToolTip = Equipped.ToolTip
  if ToolTip == "Blox Fruit" then _tp(model.HumanoidRootPart.CFrame * CFrame.new(0,10,0) * CFrame.Angles(0,math.rad(90),0)) else _tp(model.HumanoidRootPart.CFrame * CFrame.new(0,30,8) * CFrame.Angles(0,math.rad(180),0))end
  if RandomCFrame then wait(0.1)_tp(model.HumanoidRootPart.CFrame * CFrame.new(0, 30, 25)) wait(0.1)_tp(model.HumanoidRootPart.CFrame * CFrame.new(25, 30, 0)) wait(0.1)_tp(model.HumanoidRootPart.CFrame * CFrame.new(-25, 30 ,0)) wait(0.1)_tp(model.HumanoidRootPart.CFrame * CFrame.new(0, 30, 25)) wait(0.1)_tp(model.HumanoidRootPart.CFrame * CFrame.new(-25, 30, 0))end
  end
end
Attack.KillSea = function(model,Succes)
  if model and Succes then
  if not model:GetAttribute("Locked") then model:SetAttribute("Locked",model.HumanoidRootPart.CFrame) end
  PosMon = model:GetAttribute("Locked").Position
  BringEnemy()
  EquipWeapon(_G.SelectWeapon)
  local Equipped = game.Players.LocalPlayer.Character:FindFirstChildOfClass("Tool")
  local ToolTip = Equipped.ToolTip
  if ToolTip == "Blox Fruit" then _tp(model.HumanoidRootPart.CFrame * CFrame.new(0,10,0) * CFrame.Angles(0,math.rad(90),0)) else notween(model.HumanoidRootPart.CFrame * CFrame.new(0,50,8)) wait(.85)notween(model.HumanoidRootPart.CFrame * CFrame.new(0,400,0)) wait(1)end
  end
end
Attack.Sword = function(model,Succes)
  if model and Succes then
  if not model:GetAttribute("Locked") then model:SetAttribute("Locked",model.HumanoidRootPart.CFrame) end
  PosMon = model:GetAttribute("Locked").Position
  BringEnemy()
  weaponSc("Sword")
  _tp(model.HumanoidRootPart.CFrame * CFrame.new(0,30,0))
  if RandomCFrame then wait(0.1)_tp(model.HumanoidRootPart.CFrame * CFrame.new(0, 30, 25)) wait(0.1)_tp(model.HumanoidRootPart.CFrame * CFrame.new(25, 30, 0)) wait(0.1)_tp(model.HumanoidRootPart.CFrame * CFrame.new(-25, 30 ,0)) wait(0.1)_tp(model.HumanoidRootPart.CFrame * CFrame.new(0, 30, 25)) wait(0.1)_tp(model.HumanoidRootPart.CFrame * CFrame.new(-25, 30, 0))end
  end
end
Attack.Mas = function(model,Succes)
  if model and Succes then
  if not model:GetAttribute("Locked") then model:SetAttribute("Locked",model.HumanoidRootPart.CFrame) end
  PosMon = model:GetAttribute("Locked").Position
  BringEnemy()
    if model.Humanoid.Health <= HealthM then
      _tp(model.HumanoidRootPart.CFrame * CFrame.new(0,20,0))
      Useskills("Blox Fruit","Z")
      Useskills("Blox Fruit","X")
      Useskills("Blox Fruit","C")
    else
      weaponSc("Melee")
      _tp(model.HumanoidRootPart.CFrame * CFrame.new(0,30,0))
    end
  end
end
Attack.Masgun = function(model,Succes)
  if model and Succes then
  if not model:GetAttribute("Locked") then model:SetAttribute("Locked",model.HumanoidRootPart.CFrame) end
  PosMon = model:GetAttribute("Locked").Position
  BringEnemy()
    if model.Humanoid.Health <= HealthM then
      _tp(model.HumanoidRootPart.CFrame * CFrame.new(0,35,8))
      Useskills("Gun","Z")
      Useskills("Gun","X")
    else
      weaponSc("Melee")
      _tp(model.HumanoidRootPart.CFrame * CFrame.new(0,30,0))
    end
  end
end
statsSetings = function(Num, value)
  if Num == "Melee" then
    if plr.Data.Points.Value ~= 0 then
      replicated.Remotes.CommF_:InvokeServer("AddPoint","Melee",value)
    end
  elseif Num == "Defense" then
    if plr.Data.Points.Value ~= 0 then
      replicated.Remotes.CommF_:InvokeServer("AddPoint","Defense",value)
    end
  elseif Num == "Sword" then
    if plr.Data.Points.Value ~= 0 then
      replicated.Remotes.CommF_:InvokeServer("AddPoint","Sword",value)
    end
  elseif Num == "Gun" then
    if plr.Data.Points.Value ~= 0 then
      replicated.Remotes.CommF_:InvokeServer("AddPoint","Gun",value)
    end
  elseif Num == "Devil" then
    if plr.Data.Points.Value ~= 0 then
      replicated.Remotes.CommF_:InvokeServer("AddPoint","Demon Fruit",value)
    end
  end
end
BringEnemy = function(Mon)
    if not _B then return end
    if not Mon then 
        -- T?? ????g t??m mob n??u kh??ng c?? Mon
        local hrp = plr.Character and plr.Character:FindFirstChild("HumanoidRootPart")
        if not hrp then return end
        
        local closestDist = math.huge
        for _, enemy in ipairs(workspace.Enemies:GetChildren()) do
            local hum = enemy:FindFirstChildOfClass("Humanoid")
            local root = enemy:FindFirstChild("HumanoidRootPart")
            if hum and root and hum.Health > 0 then
                local dist = (root.Position - hrp.Position).Magnitude
                if dist < closestDist then
                    closestDist = dist
                    Mon = enemy
                end
            end
        end
        if not Mon then return end
    end
    
    local AreaMob = false
    
    local function Mobs(enemy)
        local hum = enemy:FindFirstChildOfClass("Humanoid")
        local root = enemy:FindFirstChild("HumanoidRootPart")
        return hum and root and hum.Health > 0, root, hum
    end

    local function Network(part)
        if isnetworkowner then
            return isnetworkowner(part)
        end
        return part.ReceiveAge == 0 and not part.Anchored and part.Velocity.Magnitude > 0
    end
    
    pcall(function()
        -- T??g simulation radius
        if sethiddenproperty then 
            sethiddenproperty(plr, "SimulationRadius", math.huge)
        end
        
        local targetPos = Mon.HumanoidRootPart.Position
        
        for _, v in ipairs(workspace.Enemies:GetChildren()) do
            if v ~= Mon then
                local alive, root, hum = Mobs(v)
                if alive and v.Name == Mon.Name then
                    local distance = (root.Position - targetPos).Magnitude
                    if distance <= 3000 then
                        -- T??o BodyVelocity ???? gi?? mob
                        local bv = root:FindFirstChild("BodyVelocity")
                        if not bv then
                            bv = Instance.new("BodyVelocity")
                            bv.Name = "BodyVelocity"
                            bv.MaxForce = Vector3.new(1e9, 1e9, 1e9)
                            bv.Velocity = Vector3.zero
                            bv.Parent = root
                        end
                        
                        if distance <= 10 then
                            AreaMob = true
                        end
                        
                        -- K??o mob l??i n??u l?? network owner v?? ch??a ?? g??n
                        if not AreaMob and Network(root) then
                            root.CFrame = CFrame.new(targetPos)
                        end
                        
                        -- T??t va ch??m v?? ng?? di chuy??
                        root.CanCollide = false
                        hum.WalkSpeed = 0
                        hum.JumpPower = 0
                    end
                end
            end
        end
        
        -- X?? l?? mob ch??nh
        if Mon and Mon:FindFirstChild("HumanoidRootPart") then
            Mon.HumanoidRootPart.CanCollide = false
            Mon.Humanoid.WalkSpeed = 0
            Mon.Humanoid.JumpPower = 0
        end
    end)
end
Useskills = function(weapon, skill)
  if weapon == "Melee" then
    weaponSc("Melee")
    if skill == "Z" then
      vim1:SendKeyEvent(true, "Z", false, game);
      vim1:SendKeyEvent(false, "Z", false, game);
    elseif skill == "X" then
      vim1:SendKeyEvent(true, "X", false, game);
      vim1:SendKeyEvent(false, "X", false, game);
    elseif skill == "C" then
      vim1:SendKeyEvent(true, "C", false, game);
      vim1:SendKeyEvent(false, "C", false, game);
    end
  elseif weapon == "Sword" then
    weaponSc("Sword")
    if skill == "Z" then
      vim1:SendKeyEvent(true, "Z", false, game);
      vim1:SendKeyEvent(false, "Z", false, game);
    elseif skill == "X" then
      vim1:SendKeyEvent(true, "X", false, game);
      vim1:SendKeyEvent(false, "X", false, game);
    end
  elseif weapon == "Blox Fruit" then
    weaponSc("Blox Fruit")
    if skill == "Z" then
      vim1:SendKeyEvent(true, "Z", false, game);
      vim1:SendKeyEvent(false, "Z", false, game);
    elseif skill == "X" then
      vim1:SendKeyEvent(true, "X", false, game);
      vim1:SendKeyEvent(false, "X", false, game);
    elseif skill == "C" then
      vim1:SendKeyEvent(true, "C", false, game);
      vim1:SendKeyEvent(false, "C", false, game);        
    elseif skill == "V" then
      vim1:SendKeyEvent(true, "V", false, game);
      vim1:SendKeyEvent(false, "V", false, game);
    end
  elseif weapon == "Gun" then
    weaponSc("Gun")
    if skill == "Z" then
      vim1:SendKeyEvent(true, "Z", false, game);
      vim1:SendKeyEvent(false, "Z", false, game);
    elseif skill == "X" then
      vim1:SendKeyEvent(true, "X", false, game);
      vim1:SendKeyEvent(false, "X", false, game);
    end
  end
  if weapon == "nil" and skill == "Y" then
    vim1:SendKeyEvent(true, "Y", false, game);
    vim1:SendKeyEvent(false, "Y", false, game);
  end
end
local gg = getrawmetatable(game)
local old = gg.__namecall
setreadonly(gg, false)
gg.__namecall = newcclosure(function(...)
  local method = getnamecallmethod()
  local args = {...}    
    if tostring(method) == "FireServer" then
      if tostring(args[1]) == "RemoteEvent" then
        if tostring(args[2]) ~= "true" and tostring(args[2]) ~= "false" then
          if (_G.FarmMastery_G and not SoulGuitar) or (_G.FarmMastery_Dev) or (_G.FarmBlazeEM) or (_G.Prehis_Skills) or (_G.SeaBeast1 or _G.FishBoat or _G.PGB or _G.Leviathan1 or _G.Complete_Trials) or (_G.AimMethod and ABmethod == "Aim Player") or (_G.AimMethod and ABmethod == "Nearest Aim") then
            args[2] = MousePos
            return old(unpack(args))
          end
        end
      end
    end
  return old(...)
end)
GetConnectionEnemies = function(a)
  for i,v in pairs(replicated:GetChildren()) do
    if v:IsA("Model") and  ((typeof(a) == "table" and table.find(a, v.Name)) or v.Name == a) and v:FindFirstChild("Humanoid") and v.Humanoid.Health > 0 then
      return v
    end
  end
  for i,v in next,game.Workspace.Enemies:GetChildren() do
    if v:IsA("Model") and ((typeof(a) == "table" and table.find(a, v.Name)) or v.Name == a)  and v:FindFirstChild("Humanoid") and v.Humanoid.Health > 0 then
      return v
    end
  end
end
LowCpu = function()
  local decalsyeeted = true
  local g = game
  local w = g.Workspace
  local l = g.Lighting
  local t = w.Terrain
  t.WaterWaveSize = 0
  t.WaterWaveSpeed = 0
  t.WaterReflectance = 0
  t.WaterTransparency = 0
  l.GlobalShadows = false
  l.FogEnd = 9e9
  l.Brightness = 0
  settings().Rendering.QualityLevel = "Level01"
  for i, v in pairs(g:GetDescendants()) do
    if v:IsA("Part") or v:IsA("Union") or v:IsA("CornerWedgePart") or v:IsA("TrussPart") then
      v.Material = "Plastic"
      v.Reflectance = 0
    elseif v:IsA("Decal") or v:IsA("Texture") and decalsyeeted then
      v.Transparency = 1
    elseif v:IsA("ParticleEmitter") or v:IsA("Trail") then
      v.Lifetime = NumberRange.new(0)
    elseif v:IsA("Explosion") then
      v.BlastPressure = 1
      v.BlastRadius = 1
    elseif v:IsA("Fire") or v:IsA("SpotLight") or v:IsA("Smoke") or v:IsA("Sparkles") then
      v.Enabled = false
    elseif v:IsA("MeshPart") then
      v.Material = "Plastic"
      v.Reflectance = 0
      v.TextureID = 10385902758728957
    end
  end
  for i, e in pairs(l:GetChildren()) do
    if e:IsA("BlurEffect") or e:IsA("SunRaysEffect") or e:IsA("ColorCorrectionEffect") or e:IsA("BloomEffect") or e:IsA("DepthOfFieldEffect") then
      e.Enabled = false
    end
  end
end
CheckF = function()
  if GetBP("Dragon-Dragon") or GetBP("Gas-Gas") or GetBP("Yeti-Yeti") or GetBP("Kitsune-Kitsune") or GetBP("T-Rex-T-Rex") then return true end
end
CheckBoat = function()
  for i, v in pairs(workspace.Boats:GetChildren()) do
    if tostring(v.Owner.Value) == tostring(plr.Name) then
      return v    
end;
  end;
  return false
end;
CheckEnemiesBoat = function()
  for _,v in pairs(workspace.Enemies:GetChildren()) do
    if (v.Name == "FishBoat") and v:FindFirstChild("Health").Value > 0 then
      return true    
end;
  end;
  return false
end;
CheckPirateGrandBrigade = function()
  for _,v in pairs(workspace.Enemies:GetChildren()) do
    if (v.Name == "PirateGrandBrigade" or v.Name == "PirateBrigade") and v:FindFirstChild("Health").Value > 0 then
      return true
    end
  end
  return false
end
CheckShark = function()
  for _,v in pairs(workspace.Enemies:GetChildren()) do
    if v.Name == "Shark" and Attack.Alive(v) then
      return true    
end;
  end;
  return false
end;
CheckTerrorShark = function()
  for _,v in pairs(workspace.Enemies:GetChildren()) do
    if v.Name == "Terrorshark" and Attack.Alive(v) then
      return true    
end;
  end;
  return false
end;
CheckPiranha = function()
  for _,v in pairs(workspace.Enemies:GetChildren()) do
    if v.Name == "Piranha" and Attack.Alive(v) then
      return true    
end;
  end;
  return false
end;
CheckFishCrew = function()
  for _,v in pairs(workspace.Enemies:GetChildren()) do
    if (v.Name == "Fish Crew Member" or v.Name == "Haunted Crew Member") and Attack.Alive(v) then
      return true    
end;
  end;
  return false
end;
CheckHauntedCrew = function()
  for _,v in pairs(workspace.Enemies:GetChildren()) do
    if (v.Name == "Haunted Crew Member") and Attack.Alive(v) then
      return true    
end;
  end;
  return false
end;
CheckSeaBeast = function()
  if workspace.SeaBeasts:FindFirstChild("SeaBeast1") then
    return true  
end;
  return false
end;
CheckLeviathan = function()
  if workspace.SeaBeasts:FindFirstChild("Leviathan") then
    return true  
end;
  return false
end;
UpdStFruit = function()
  for z,x in next, plr.Backpack:GetChildren() do
  StoreFruit = x:FindFirstChild("EatRemote", true)
    if StoreFruit then
      replicated.Remotes.CommF_:InvokeServer("StoreFruit",StoreFruit.Parent:GetAttribute("OriginalName"),
      plr.Backpack:FindFirstChild(x.Name))
    end
  end
end
collectFruits = function(Succes)
  if Succes then
    local Character = plr.Character
    for _,v1 in pairs(workspace:GetChildren()) do
    if string.find(v1.Name, "Fruit") then v1.Handle.CFrame = Character.HumanoidRootPart.CFrame end
    end
  end
end
Getmoon = function()
  if World1 then
    return Lighting.FantasySky.MoonTextureId
  elseif World2 then
    return Lighting.FantasySky.MoonTextureId
  elseif World3 then
    return Lighting.Sky.MoonTextureId
  end
end
DropFruits = function()
  for _,v3 in next, plr.Backpack:GetChildren() do
    if string.find(v3.Name, "Fruit") then
      EquipWeapon(v3.Name) wait(.1)
      if plr.PlayerGui.Main.Dialogue.Visible == true then plr.PlayerGui.Main.Dialogue.Visible = false end EquipWeapon(v3.Name) plr.Character:FindFirstChild(v3.Name).EatRemote:InvokeServer("Drop")
    end
  end
  for a,b2 in pairs(plr.Character:GetChildren()) do
    if string.find(b2.Name, "Fruit") then EquipWeapon(b2.Name) wait(.1)
    if plr.PlayerGui.Main.Dialogue.Visible == true then plr.PlayerGui.Main.Dialogue.Visible = false end EquipWeapon(b2.Name) plr.Character:FindFirstChild(b2.Name).EatRemote:InvokeServer("Drop")
    end
  end
end
GetBP = function(v)
  return plr.Backpack:FindFirstChild(v) or plr.Character:FindFirstChild(v)
end
GetIn = function(Name)
  for _ ,v1 in pairs(replicated.Remotes.CommF_:InvokeServer("getInventory")) do
    if type(v1) == "table" then
      if v1.Name == Name or plr.Character:FindFirstChild(Name) or plr.Backpack:FindFirstChild(Name) then
        return true
	 end
    end
  end
  return false
end
GetM = function(Name)
  for _,tab in pairs(replicated.Remotes.CommF_:InvokeServer("getInventory")) do
    if type(tab) == "table" then
	  if tab.Type == "Material" then
	    if tab.Name == Name then
		  return tab.Count
	    end
	  end
    end
  end
return 0
end
GetWP = function(nametool)
  for _,v4 in pairs(replicated.Remotes.CommF_:InvokeServer("getInventory")) do
    if type(v4) == "table" then
      if v4.Type == "Sword" then
        if v4.Name == nametool or plr.Character:FindFirstChild(nametool) or plr.Backpack:FindFirstChild(nametool) then
	     return true
	     end
	   end
      end
    end
  return false
end 
getInfinity_Ability = function(Method, Var)
  if not Root then return end
  if Method == "Soru" and Var then
    for _,gc in next, getgc() do
      if plr.Character.Soru then
        if ((typeof(gc) == "function") and (getfenv(gc).script == plr.Character.Soru)) then
          for _, v in next, getupvalues(gc) do
            if (typeof(v) == "table") then
              repeat wait(Sec) v.LastUse = 0 until not Var or (plr.Character.Humanoid.Health <= 0)
            end
          end
        end
      end
    end    
  elseif Method == "Energy" and Var then
    plr.Character.Energy.Changed:connect(function()
      if Var then plr.Character.Energy.Value = Energy end 
    end)
  elseif Method == "Observation" and Var then
    local VisionRadius = plr.VisionRadius
    VisionRadius.Value = math.huge
  end
end
Hop = function()
  pcall(function()
    for count = math.random(1, math.random(40, 75)), 100 do
      local remote = replicated.__ServerBrowser:InvokeServer(count)
	  for _, v in next, remote do
	  if tonumber(v['Count']) < 12 then TeleportService:TeleportToPlaceInstance(game.PlaceId, _) end
	  end    
    end
  end)
end
local block = Instance.new("Part", workspace)
block.Size = Vector3.new(1, 1, 1)
block.Name = "Rip_Indra"
block.Anchored = true
block.CanCollide = false
block.CanTouch = false
block.Transparency = 1
local blockfind = workspace:FindFirstChild(block.Name)
if blockfind and blockfind ~= block then blockfind:Destroy() end
task.spawn(function()while task.wait()do if block and block.Parent==workspace then if shouldTween then getgenv().OnFarm=true else getgenv().OnFarm=false end else getgenv().OnFarm=false end end end)
task.spawn(function()local a=game.Players.LocalPlayer;repeat task.wait()until a.Character and a.Character.PrimaryPart;block.CFrame=a.Character.PrimaryPart.CFrame;while task.wait()do pcall(function()if getgenv().OnFarm then if block and block.Parent==workspace then local b=a.Character and a.Character.PrimaryPart;if b and(b.Position-block.Position).Magnitude<=200 then b.CFrame=block.CFrame else block.CFrame=b.CFrame end end;local c=a.Character;if c then for d,e in pairs(c:GetChildren())do if e:IsA("BasePart")then e.CanCollide=false end end end else local c=a.Character;if c then for d,e in pairs(c:GetChildren())do if e:IsA("BasePart")then e.CanCollide=true end end end end end)end end)

ReplicatedStorage = game:GetService("ReplicatedStorage")
TweenService = game:GetService("TweenService")
RunService = game:GetService("RunService")
Players = game:GetService("Players")
LocalPlayer = Players.LocalPlayer

sea1 = (game.PlaceId == 2753915549 or game.PlaceId == 85211729168715)
sea2 = (game.PlaceId == 4442272183 or game.PlaceId == 79091703265657)
sea3 = (game.PlaceId == 7449423635 or game.PlaceId == 100117331123089)

local Settings = {
    ["Tween Speed"] = 350,
    ["Bypass Teleport"] = true,
    ["Up Y"] = false,
    ["Up Y When Low Health"] = false,
    ["Same Y"] = false
}

local newdao = CFrame.new(10641.0918, -1953.92981, 9825.07031, -0.652825892, -9.2805891e-08, -0.757508039, -2.73638356e-08, 1, -9.89323823e-08, 0.757508039, -4.38572947e-08, -0.652825892)
local cframenpc = CFrame.new(-16271.126, 25.5847301, 1371.98755, 0.999396622, -5.78875188e-08, -0.0347310975, 5.52972779e-08, 1, -8.7544322e-08, 0.034731105, 8.28877091e-08, 0.999396741)

function Convert_CFrame(x)
    if not x then return end
    if typeof(x) == "Vector3" then
        return CFrame.new(x)
    elseif typeof(x) == "CFrame" then
        return x
    elseif typeof(x) == "Model" then
        return x:GetPivot()
    elseif x.CFrame then
        return x.CFrame
    end
    return nil
end

function GetDistance(POS_1, POS_2, NO_Y)
    if POS_1 == nil then return 9e9 end
    
    local Character = LocalPlayer.Character
    if not Character then return 9e9 end
    
    local Humanoid = Character:FindFirstChild("Humanoid")
    if not Humanoid or Humanoid.Health <= 0 then
        return 9e9
    end
    
    if POS_2 == nil then
        POS_2 = Character:FindFirstChild("HumanoidRootPart")
        if not POS_2 then return 9e9 end
    end
    
    local pos1 = Convert_CFrame(POS_1)
    local pos2 = Convert_CFrame(POS_2)
    
    if NO_Y then
        return (Vector3.new(pos1.X, 0, pos1.Z) - Vector3.new(pos2.X, 0, pos2.Z)).Magnitude
    else
        return (pos1.Position - pos2.Position).Magnitude
    end
end

function InArea(POS)
    local WorldOrigin = workspace:FindFirstChild("_WorldOrigin")
    if not WorldOrigin then return {Name = ""} end
    
    local pos = Convert_CFrame(POS)
    for i,v in next, WorldOrigin.Locations:GetChildren() do
        if v:FindFirstChild("Mesh") and (pos.Position - v.Position).Magnitude <= v.Mesh.Scale.X then
            return v
        end
    end
    return {Name = ""}
end

function GetSpawnPoint(x)
    local Spawns = workspace:FindFirstChild("_WorldOrigin") 
        and workspace._WorldOrigin:FindFirstChild("PlayerSpawns") 
        and workspace._WorldOrigin.PlayerSpawns:FindFirstChild("Pirates")
    if not Spawns then return end
    
    for i,v in next, Spawns:GetChildren() do
        if v:FindFirstChild("Part") and (v.Part.Position - x.Position).Magnitude <= 2500 then
            return v
        end
    end
end

function CheckLegendaryItems()
    local function CheckItem(ITEM_NAME)
        for i,v in next, LocalPlayer.Backpack:GetChildren() do
            if v:IsA('Tool') and (v.Name == ITEM_NAME or string.find(v.Name, ITEM_NAME)) then 
                return v 
            end
        end
        for i,v in next, LocalPlayer.Character:GetChildren() do
            if v:IsA('Tool') and (v.Name == ITEM_NAME or string.find(v.Name, ITEM_NAME)) then 
                return v 
            end
        end
    end
    
    if CheckItem("God's Chalice") or CheckItem("Fist of Darkness") or CheckItem("Sweet Chalice") or CheckItem("Hallow Essence") or CheckItem("Flower1") then
        return true
    end
    return false
end

function WaitForHumanoid()
    local Character = LocalPlayer.Character
    if not Character then return nil end
    
    local Humanoid = Character:FindFirstChild("Humanoid")
    if Humanoid then return Humanoid end
    
    local timeout = tick() + 5
    while tick() < timeout do
        Humanoid = Character:FindFirstChild("Humanoid")
        if Humanoid then return Humanoid end
        task.wait(0.1)
    end
    return nil
end

function checkinventory(v)
    if v then
        for i, vl in pairs(ReplicatedStorage.Remotes.CommF_:InvokeServer("getInventory")) do
            if vl.Name == v then
                return true
            end
        end
    end
    return false
end

function getdis(a,b)
    b = b or LocalPlayer.Character.HumanoidRootPart.CFrame
    local _a = CFrame.new(a.X, b.Y, a.Z)
    local _b = CFrame.new(b.X,b.Y,b.Z)
    return (_a.Position - _b.Position).Magnitude
end

function CanBypassTeleport(x)
    local AreaName = InArea(x).Name
    if AreaName == "" then return false end
    
    if not Settings["Bypass Teleport"] 
        or AreaName:find("Dimension") 
        or AreaName:find("Submerged") 
        or AreaName == "Sealed Cavern" 
        or AreaName:lower():find("under") 
        or CheckLegendaryItems() then
        return false
    end
    
    if LocalPlayer.Data and LocalPlayer.Data.LastSpawnPoint and LocalPlayer.Data.LastSpawnPoint.Value == "SubmergedIsland" then 
        return false 
    end
    
    if GetDistance(x.Position) <= 3500 then
        return false
    end
    
    return true
end

function GetBypassCFrame(x)
    local Max = math.huge
    local Pos
    local Spawns = workspace._WorldOrigin.PlayerSpawns.Pirates:GetChildren()
    local HRP = LocalPlayer.Character and LocalPlayer.Character:FindFirstChild("HumanoidRootPart")
    if not HRP then return nil end
    
    for i,v in next, Spawns do
        if v:FindFirstChild("Part") then
            if (x.Position - HRP.Position).Magnitude >= 3000 
            and GetSpawnPoint(v.Part) ~= GetSpawnPoint(HRP) 
            and (v.Part.Position - HRP.Position).Magnitude <= 10000 
            and (v.Part.Position - x.Position).Magnitude <= Max then
                Max = (v.Part.Position - x.Position).Magnitude
                Pos = v
            end
        end
    end
    return Pos
end

function BypassTP(Target)
    local Character = LocalPlayer.Character
    if not Character then return end
    
    local Humanoid = WaitForHumanoid()
    if not Humanoid or Humanoid.Health <= 0 then return end
    
    if CanBypassTeleport(Target) and GetBypassCFrame(Target) then
        local TargetTP = GetBypassCFrame(Target)
        if TargetTP and TargetTP:FindFirstChild("Part") then
            Character.LastSpawnPoint.Disabled = true
            ReplicatedStorage.Remotes.CommF_:InvokeServer("SetLastSpawnPoint", TargetTP.Name)
            ReplicatedStorage.Remotes.CommF_:InvokeServer("SetSpawnPoint")
            Character:PivotTo(TargetTP.Part.CFrame)
            Humanoid:ChangeState(15)
            
            repeat 
                task.wait() 
            until LocalPlayer.Character and WaitForHumanoid() and WaitForHumanoid().Health > 0
        end
    end
end

function totopofgreattree()
    if getdis(CFrame.new(28310.0234, 14895.1123, 109.456741)) > 1500 then
        ReplicatedStorage.Remotes.CommF_:InvokeServer("requestEntrance", Vector3.new(28310.0234, 14895.1123, 109.456741))
        wait(0.3)
    end
    
    local targetCF = CFrame.new(28607.5352, 14896.5449, 106.011726)
    _tp(targetCF)
    
    repeat
        wait()
    until getdis(targetCF) <= 5
    
    wait(0.5)
    for i = 1, 4 do
        ReplicatedStorage.Remotes.CommF_:InvokeServer("RaceV4Progress", "TeleportBack")
    end
end

function requestentrance(pos)
    local tb = {}
    local targetPos = pos
    
    if typeof(pos) == "CFrame" then
        targetPos = pos.Position
    end
    
    if sea1 then
        tb = {
            ["Sky3"] = Vector3.new(-7894, 5547, -380),
            ["Sky3Exit"] = Vector3.new(-4607, 874, -1667),
            ["UnderWater"] = Vector3.new(61163, 11, 1819),
            ["Underwater City"] = Vector3.new(61165.19140625, 0.18704631924629211, 1897.379150390625),
            ["Pirate Village"] = Vector3.new(-1242.4625244140625, 4.787059783935547, 3901.282958984375),
            ["UnderwaterExit"] = Vector3.new(4050, -1, -1814)
        }
    elseif sea2 then
        tb = {
            ["Swan Mansion"] = Vector3.new(-390, 332, 673),
            ["Swan Room"] = Vector3.new(2285, 15, 905),
            ["Cursed Ship"] = Vector3.new(923, 126, 32852),
            ["Zombie Island"] = Vector3.new(-6509, 83, -133)
        }
    else
        tb = {
            ["Hydra Island"] = Vector3.new(5657.88623046875, 1013.0790405273438, -335.4996337890625),
            ["Mansion"] = Vector3.new(-12462, 375, -7552),
            ["Castle"] = Vector3.new(-5036, 315, -3179),
            ["Temple of Time"] = Vector3.new(28286, 14897, 103),
            ["Greate Tree"] = Vector3.new(3024.1709, 2280.69434, -7325.12793)
        }
        if not checkinventory("Valkyrie Helm") then
            return
        end
    end
    
    local x, y = nil, math.huge
    for i, v in pairs(tb) do
        local distance = (typeof(v) == "Vector3" and (v - targetPos).Magnitude) or (v.Position - targetPos).Magnitude
        if distance < y then
            y = distance
            x = v
        end
    end
    
    if x and y and y < getdis(pos) then
        pcall(function ()
            if _G.TweenCache then
                _G.TweenCache:Cancel()
            end
        end)
        
        if typeof(x) == "Vector3" 
            and x.X == 3024.1709 and x.Y == 2280.69434 and x.Z == -7325.12793
            and ReplicatedStorage.Remotes.CommF_:InvokeServer("RaceV4Progress", "Check") >= 2 then
            totopofgreattree()
            wait(1)
        elseif y < getdis(pos) then
            local requestPos = typeof(x) == "Vector3" and x or x.Position
            ReplicatedStorage.Remotes.CommF_:InvokeServer("requestEntrance", requestPos)
            wait(1)
        end
    end
end

_tp = function(target)
    local gg
    if typeof(target) == "Vector3" then
        gg = CFrame.new(target)
    elseif typeof(target) == "CFrame" then
        gg = target
    else
        gg = target and target.CFrame
    end
    
    if not gg then return end
    
    local character = plr.Character
    if not character or not character:FindFirstChild("HumanoidRootPart") then return end
    local rootPart = character.HumanoidRootPart
    
    pcall(function()
        if CanBypassTeleport(gg) then
            BypassTP(gg)
            task.wait(0.5)
        end
    end)
    
    pcall(function()
        requestentrance(target)
    end)
    
    if sea3 and getdis(gg.Position, newdao.Position) < 2000 then
        local hrp = plr.Character.HumanoidRootPart
        if math.abs(newdao.Position.Y - hrp.CFrame.Y) > 1000 then
            repeat
                task.wait()
                old_tp(cframenpc)
                if getdis(cframenpc) < 10 then
                    local net = ReplicatedStorage.Modules.Net
                    net["RF/SubmarineWorkerSpeak"]:InvokeServer("AskKilledTikiBoss")
                    task.wait(0.5)
                    net["RF/SubmarineWorkerSpeak"]:InvokeServer("TravelToSubmergedIsland")
                end
            until getdis(gg.Position) < 2000
            task.wait(0.6)
            pcall(function()
                if hrp:FindFirstChild("BodyClip") then
                    hrp.BodyClip:Destroy()
                end
            end)
        end
    end
    
    local distance = (gg.Position - rootPart.Position).Magnitude
    local tweenInfo = TweenInfo.new(distance / 300, Enum.EasingStyle.Linear)
    local tween = game:GetService("TweenService"):Create(block, tweenInfo, {CFrame = gg})    
    
    if plr.Character.Humanoid.Sit == true then
        block.CFrame = CFrame.new(block.Position.X, gg.Y, block.Position.Z)
    end  
    
    tween:Play()    
    
    task.spawn(function() 
        while tween.PlaybackState == Enum.PlaybackState.Playing do 
            if not shouldTween then 
                tween:Cancel() 
                break 
            end 
            task.wait(0.1) 
        end 
    end)
    
    return tween
end

old_tp = function(p) 
    local char = plr.Character
    if char and char:FindFirstChild("HumanoidRootPart") then
        char.HumanoidRootPart.CFrame = p 
    end
end

TeleportToTarget = function(targetCFrame) if (targetCFrame.Position - plr.Character.HumanoidRootPart.Position).Magnitude > 1000 then _tp(targetCFrame)else _tp(targetCFrame)end end
notween = function(p) plr.Character.HumanoidRootPart.CFrame = p end
function BTP(p)
    local player = game.Players.LocalPlayer
    local humanoidRootPart = player.Character.HumanoidRootPart
    local humanoid = player.Character.Humanoid
    local playerGui = player.PlayerGui.Main
    local targetPosition = p.Position
    local lastPosition = humanoidRootPart.Position
    repeat
        humanoid.Health = 0
        humanoidRootPart.CFrame = p
        playerGui.Quest.Visible = false
        if (humanoidRootPart.Position - lastPosition).Magnitude > 1 then
            lastPosition = humanoidRootPart.Position
            humanoidRootPart.CFrame = p
        end
        task.wait(0.5)
    until (p.Position - humanoidRootPart.Position).Magnitude <= 2000
end

spawn(function()
  while task.wait() do
    pcall(function()
      if _G.SailBoat_Hydra or _G.WardenBoss or _G.AutoFactory or _G.HighestMirage or _G.HCM or _G.PGB or _G.Leviathan1 or _G.UPGDrago or _G.Complete_Trials or _G.TpDrago_Prehis or _G.BuyDrago or _G.AutoFireFlowers or _G.DT_Uzoth or _G.AutoBerry or _G.Prefully or _G.Prehis_Find or _G.Prehis_Skills or _G.Prehis_DB or _G.Prehis_DE or _G.FarmBlazeEM or _G.Dojoo or _G.CollectPresent or _G.AutoLawKak or _G.TpLab or _G.AutoPhoenixF or _G.AutoFarmChest or _G.AutoHytHallow or _G.LongsWord or _G.BlackSpikey or _G.AutoHolyTorch or _G.TrainDrago  or _G.AutoSaber or _G.FarmMastery_Dev or _G.CitizenQuest or _G.AutoEctoplasm or _G.KeysRen or _G.Auto_Rainbow_Haki or _G.obsFarm or _G.AutoBigmom or _G.Doughv2 or _G.AuraBoss or _G.Raiding or _G.Auto_Cavender or _G.TpPly or _G.Bartilo_Quest or _G.Level or _G.FarmEliteHunt or _G.AutoZou or _G.AutoFarm_Bone or getgenv().AutoMaterial or _G.CraftVM or _G.FrozenTP or _G.TPDoor or _G.AcientOne or _G.AutoFarmNear or _G.AutoRaidCastle or _G.DarkBladev3 or _G.AutoFarmRaid or _G.Auto_Cake_Prince or _G.Addealer or _G.TPNpc or _G.TwinHook or _G.FindMirage or _G.FarmChestM or _G.Shark or _G.TerrorShark or _G.Piranha or _G.MobCrew or _G.SeaBeast1 or _G.FishBoat or _G.AutoPole or _G.AutoPoleV2 or _G.Auto_SuperHuman or _G.AutoDeathStep or _G.Auto_SharkMan_Karate or _G.Auto_Electric_Claw or _G.AutoDragonTalon or _G.Auto_Def_DarkCoat or _G.Auto_God_Human or _G.Auto_Tushita or _G.AutoMatSoul or _G.AutoKenVTWO or _G.AutoSerpentBow or _G.AutoFMon or _G.Auto_Soul_Guitar or _G.TPGEAR or _G.AutoSaw or _G.AutoTridentW2 or _G.AutoEvoRace or _G.AutoGetQuestBounty or _G.MarinesCoat or _G.TravelDres or _G.Defeating or _G.DummyMan or _G.Auto_Yama or _G.Auto_SwanGG or _G.SwanCoat or _G.AutoEcBoss or _G.Auto_Mink or _G.Auto_Human or _G.Auto_Skypiea or _G.Auto_Fish or _G.CDK_TS or _G.CDK_YM or _G.CDK or _G.AutoFarmGodChalice or _G.AutoFistDarkness or _G.AutoMiror or _G.Teleport or _G.AutoKilo or _G.AutoGetUsoap or _G.Praying or _G.TryLucky or _G.AutoColShad or _G.AutoUnHaki or _G.Auto_DonAcces or _G.AutoRipIngay or _G.DragoV3 or _G.DragoV1 or _G.SailBoats or NextIs or _G.FarmGodChalice or _G.IceBossRen or senth or senth2 or _G.Lvthan or _G.beasthunter or _G.DangerLV or _G.Relic123 or _G.tweenKitsune or _G.Collect_Ember or _G.AutofindKitIs or _G.snaguine or _G.TwFruits or _G.tweenKitShrine or _G.Tp_LgS or _G.Tp_MasterA or _G.tweenShrine or _G.FarmMastery_G or _G.FarmMastery_S or _G.FarmBoss or _G.AutoFarmAllBoss or _G.AutoFishSlap or _G.FarmTyrant or _G.FarmPhaBinh or _G.AutoSpawnCP or _G.AutoBerryH or _G.AutoChestBP or _G.FarmEliteHop or _G.AutoHop_Dough or _G.AutoDoughKing or _G.AutoAttackDoughKing or _G.AutoChipFruit or _G.AutoChipBeli or _G.StartEvent or _G.AutoMysticIsland or _G.AutoPlayerHunter or _G.SafeMode or _G.AutoKillMob or _G.AutoStartPrehistoric or _G.AutoUnHaki or _G.AutoAttackRipIndra or _G.AutoFarmIsland or _G.AutoFarmDungeon or _G.AutoFarmCandy or _G.AutoTP_Gift or _G.AutoTPGift or _G.AutoTPAndCollect or _G.MasterAutoLevel or _G.MasterAutoCandy or _G.TPFloor1 or _G.TPFloor2 or _G.TPFloor3 or _G.TPFloor4 then
        shouldTween = true
        if not plr.Character.HumanoidRootPart:FindFirstChild("BodyClip") then
          local Noclip = Instance.new("BodyVelocity")
          Noclip.Name = "BodyClip"
          Noclip.Parent = plr.Character.HumanoidRootPart
          Noclip.MaxForce = Vector3.new(100000,100000,100000)
          Noclip.Velocity = Vector3.new(0,0,0)
        end        
              for _, child in pairs(plr.Character:GetChildren()) do
            if child:IsA("Highlight") or child.Name == "highlight" then
                child:Destroy()
            end
        end
        for _, no in pairs(plr.Character:GetDescendants()) do if no:IsA("BasePart") then no.CanCollide = false end end
      else
        shouldTween = false
        if plr.Character.HumanoidRootPart:FindFirstChild("BodyClip") then plr.Character.HumanoidRootPart:FindFirstChild("BodyClip"):Destroy() end
        for _, child in pairs(plr.Character:GetChildren()) do
            if child:IsA("Highlight") or child.Name == "highlight" then
                child:Destroy()
            end
        end
      end
    end)
  end
end)

QuestB = function()
				if World1 then
					if _G.FindBoss == "The Gorilla King" then
						bMon = "The Gorilla King"
						Qname = "JungleQuest"
						Qdata = 3;
						PosQBoss = CFrame.new(-1601.6553955078, 36.85213470459, 153.38809204102)
						PosB = CFrame.new(-1088.75977, 8.13463783, -488.559906, -0.707134247, 0, 0.707079291, 0, 1, 0, -0.707079291, 0, -0.707134247)
					elseif _G.FindBoss == "Bobby" then
						bMon = "Bobby"
						Qname = "BuggyQuest1"
						Qdata = 3;
						PosQBoss = CFrame.new(-1140.1761474609, 4.752049446106, 3827.4057617188)
						PosB = CFrame.new(-1087.3760986328, 46.949409484863, 4040.1462402344)
					elseif _G.FindBoss == "The Saw" then
						bMon = "The Saw"
						PosB = CFrame.new(-784.89715576172, 72.427383422852, 1603.5822753906)
					elseif _G.FindBoss == "Yeti" then
						bMon = "Yeti"
						Qname = "SnowQuest"
						Qdata = 3;
						PosQBoss = CFrame.new(1386.8073730469, 87.272789001465, -1298.3576660156)
						PosB = CFrame.new(1218.7956542969, 138.01184082031, -1488.0262451172)
					elseif _G.FindBoss == "Mob Leader" then
						bMon = "Mob Leader"
						PosB = CFrame.new(-2844.7307128906, 7.4180502891541, 5356.6723632813)
					elseif _G.FindBoss == "Vice Admiral" then
						bMon = "Vice Admiral"
						Qname = "MarineQuest2"
						Qdata = 2;
						PosQBoss = CFrame.new(-5036.2465820313, 28.677835464478, 4324.56640625)
						PosB = CFrame.new(-5006.5454101563, 88.032081604004, 4353.162109375)
					elseif _G.FindBoss == "Saber Expert" then
						bMon = "Saber Expert"
						PosB = CFrame.new(-1458.89502, 29.8870335, -50.633564)
					elseif _G.FindBoss == "Warden" then
						bMon = "Warden"
						Qname = "ImpelQuest"
						Qdata = 1;
						PosB = CFrame.new(5278.04932, 2.15167475, 944.101929, 0.220546961, -4.49946401e-06, 0.975376427, -1.95412576e-05, 1, 9.03162072e-06, -0.975376427, -2.10519756e-05, 0.220546961)
						PosQBoss = CFrame.new(5191.86133, 2.84020686, 686.438721, -0.731384635, 0, 0.681965172, 0, 1, 0, -0.681965172, 0, -0.731384635)
					elseif _G.FindBoss == "Chief Warden" then
						bMon = "Chief Warden"
						Qname = "ImpelQuest"
						Qdata = 2;
						PosB = CFrame.new(5206.92578, 0.997753382, 814.976746, 0.342041343, -0.00062915677, 0.939684749, 0.00191645394, 0.999998152, -2.80422337e-05, -0.939682961, 0.00181045406, 0.342041939)
						PosQBoss = CFrame.new(5191.86133, 2.84020686, 686.438721, -0.731384635, 0, 0.681965172, 0, 1, 0, -0.681965172, 0, -0.731384635)
					elseif _G.FindBoss == "Swan" then
						bMon = "Swan"
						Qname = "ImpelQuest"
						Qdata = 3;
						PosB = CFrame.new(5325.09619, 7.03906584, 719.570679, -0.309060812, 0, 0.951042235, 0, 1, 0, -0.951042235, 0, -0.309060812)
						PosQBoss = CFrame.new(5191.86133, 2.84020686, 686.438721, -0.731384635, 0, 0.681965172, 0, 1, 0, -0.681965172, 0, -0.731384635)
					elseif _G.FindBoss == "Magma Admiral" then
						bMon = "Magma Admiral"
						Qname = "MagmaQuest"
						Qdata = 3;
						PosQBoss = CFrame.new(-5314.6220703125, 12.262420654297, 8517.279296875)
						PosB = CFrame.new(-5765.8969726563, 82.92064666748, 8718.3046875)
					elseif _G.FindBoss == "Fishman Lord" then
						bMon = "Fishman Lord"
						Qname = "FishmanQuest"
						Qdata = 3;
						PosQBoss = CFrame.new(61122.65234375, 18.497442245483, 1569.3997802734)
						PosB = CFrame.new(61260.15234375, 30.950881958008, 1193.4329833984)
					elseif _G.FindBoss == "Wysper" then
						bMon = "Wysper"
						Qname = "SkyExp1Quest"
						Qdata = 3;
						PosQBoss = CFrame.new(-7861.947265625, 5545.517578125, -379.85974121094)
						PosB = CFrame.new(-7866.1333007813, 5576.4311523438, -546.74816894531)
					elseif _G.FindBoss == "Thunder God" then
						bMon = "Thunder God"
						Qname = "SkyExp2Quest"
						Qdata = 3;
						PosQBoss = CFrame.new(-7903.3828125, 5635.9897460938, -1410.923828125)
						PosB = CFrame.new(-7994.984375, 5761.025390625, -2088.6479492188)
					elseif _G.FindBoss == "Cyborg" then
						bMon = "Cyborg"
						Qname = "FountainQuest"
						Qdata = 3;
						PosQBoss = CFrame.new(5258.2788085938, 38.526931762695, 4050.044921875)
						PosB = CFrame.new(6094.0249023438, 73.770050048828, 3825.7348632813)
					elseif _G.FindBoss == "Ice Admiral" then
						bMon = "Ice Admiral"
						Qdata = nil;
						PosQBoss = CFrame.new(1266.08948, 26.1757946, -1399.57678, -0.573599219, 0, -0.81913656, 0, 1, 0, 0.81913656, 0, -0.573599219)
						PosB = CFrame.new(1266.08948, 26.1757946, -1399.57678, -0.573599219, 0, -0.81913656, 0, 1, 0, 0.81913656, 0, -0.573599219)
					elseif _G.FindBoss == "Greybeard" then
						bMon = "Greybeard"
						Qdata = nil;
						PosQBoss = CFrame.new(-5081.3452148438, 85.221641540527, 4257.3588867188)
						PosB = CFrame.new(-5081.3452148438, 85.221641540527, 4257.3588867188)
					end
				end;
				if World2 then
					if _G.FindBoss == "Diamond" then
						bMon = "Diamond"
						Qname = "Area1Quest"
						Qdata = 3;
						PosQBoss = CFrame.new(-427.5666809082, 73.313781738281, 1835.4208984375)
						PosB = CFrame.new(-1576.7166748047, 198.59265136719, 13.724286079407)
					elseif _G.FindBoss == "Jeremy" then
						bMon = "Jeremy"
						Qname = "Area2Quest"
						Qdata = 3;
						PosQBoss = CFrame.new(636.79943847656, 73.413787841797, 918.00415039063)
						PosB = CFrame.new(2006.9261474609, 448.95666503906, 853.98284912109)
					elseif _G.FindBoss == "Orbitus" then
						bMon = "Orbitus"
						Qname = "MarineQuest3"
						Qdata = 3;
						PosQBoss = CFrame.new(-2441.986328125, 73.359344482422, -3217.5324707031)
						PosB = CFrame.new(-2172.7399902344, 103.32216644287, -4015.025390625)
					elseif _G.FindBoss == "Don Swan" then
						bMon = "Don Swan"
						PosB = CFrame.new(2286.2004394531, 15.177839279175, 863.8388671875)
					elseif _G.FindBoss == "Smoke Admiral" then
						bMon = "Smoke Admiral"
						Qname = "IceSideQuest"
						Qdata = 3;
						PosQBoss = CFrame.new(-5429.0473632813, 15.977565765381, -5297.9614257813)
						PosB = CFrame.new(-5275.1987304688, 20.757257461548, -5260.6669921875)
					elseif _G.FindBoss == "Awakened Ice Admiral" then
						bMon = "Awakened Ice Admiral"
						Qname = "FrostQuest"
						Qdata = 3;
						PosQBoss = CFrame.new(5668.9780273438, 28.519989013672, -6483.3520507813)
						PosB = CFrame.new(6403.5439453125, 340.29766845703, -6894.5595703125)
					elseif _G.FindBoss == "Tide Keeper" then
						bMon = "Tide Keeper"
						Qname = "ForgottenQuest"
						Qdata = 3;
						PosQBoss = CFrame.new(-3053.9814453125, 237.18954467773, -10145.0390625)
						PosB = CFrame.new(-3795.6423339844, 105.88877105713, -11421.307617188)
					elseif _G.FindBoss == "Darkbeard" then
						bMon = "Darkbeard"
						Qdata = nil;
						PosQBoss = CFrame.new(3677.08203125, 62.751937866211, -3144.8332519531)
						PosB = CFrame.new(3677.08203125, 62.751937866211, -3144.8332519531)
					elseif _G.FindBoss == "Cursed Captaim" then
						bMon = "Cursed Captain"
						Qdata = nil;
						PosQBoss = CFrame.new(916.928589, 181.092773, 33422)
						PosB = CFrame.new(916.928589, 181.092773, 33422)
					elseif _G.FindBoss == "Order" then
						bMon = "Order"
						Qdata = nil;
						PosQBoss = CFrame.new(-6217.2021484375, 28.047645568848, -5053.1357421875)
						PosB = CFrame.new(-6217.2021484375, 28.047645568848, -5053.1357421875)
					end
				end;
				if World3 then
					if _G.FindBoss == "Stone" then
						bMon = "Stone"
						Qname = "PiratePortQuest"
						Qdata = 3;
						PosQBoss = CFrame.new(-289.76705932617, 43.819011688232, 5579.9384765625)
						PosB = CFrame.new(-1027.6512451172, 92.404174804688, 6578.8530273438)
					elseif _G.FindBoss == "Hydra Leader" then
						bMon = "Hydra Leader"
						Qname = "VenomCrewQuest"
						Qdata = 3;
						PosQBoss = CFrame.new(5211.021484375, 1004.35778859375, 758.1847534179688)
						PosB = CFrame.new(5821.89794921875, 1019.0950927734375, -73.71923065185547)
					elseif _G.FindBoss == "Kilo Admiral" then
						bMon = "Kilo Admiral"
						Qname = "MarineTreeIsland"
						Qdata = 3;
						PosQBoss = CFrame.new(2179.3010253906, 28.731239318848, -6739.9741210938)
						PosB = CFrame.new(2764.2233886719, 432.46154785156, -7144.4580078125)
					elseif _G.FindBoss == "Captain Elephant" then
						bMon = "Captain Elephant"
						Qname = "DeepForestIsland"
						Qdata = 3;
						PosQBoss = CFrame.new(-13232.682617188, 332.40396118164, -7626.01171875)
						PosB = CFrame.new(-13376.7578125, 433.28689575195, -8071.392578125)
					elseif _G.FindBoss == "Beautiful Pirate" then
						bMon = "Beautiful Pirate"
						Qname = "DeepForestIsland2"
						Qdata = 3;
						PosQBoss = CFrame.new(-12682.096679688, 390.88653564453, -9902.1240234375)
						PosB = CFrame.new(5283.609375, 22.56223487854, -110.78285217285)
					elseif _G.FindBoss == "Cake Queen" then
						bMon = "Cake Queen"
						Qname = "IceCreamIslandQuest"
						Qdata = 3;
						PosQBoss = CFrame.new(-819.376709, 64.9259796, -10967.2832, -0.766061664, 0, 0.642767608, 0, 1, 0, -0.642767608, 0, -0.766061664)
						PosB = CFrame.new(-678.648804, 381.353943, -11114.2012, -0.908641815, 0.00149294338, 0.41757378, 0.00837114919, 0.999857843, 0.0146408929, -0.417492568, 0.0167988986, -0.90852499)
					elseif _G.FindBoss == "Longma" then
						bMon = "Longma"
						Qdata = nil;
						PosQBoss = CFrame.new(-10238.875976563, 389.7912902832, -9549.7939453125)
						PosB = CFrame.new(-10238.875976563, 389.7912902832, -9549.7939453125)
					elseif _G.FindBoss == "Soul Reaper" then
						bMon = "Soul Reaper"
						Qdata = nil;
						PosQBoss = CFrame.new(-9524.7890625, 315.80429077148, 6655.7192382813)
						PosB = CFrame.new(-9524.7890625, 315.80429077148, 6655.7192382813)
					end
				end
			end
			QuestBeta = function()
				local Neta = QuestB()
				return {
					[0] = _G.FindBoss,
					[1] = bMon,
					[2] = Qdata,
					[3] = Qname,
					[4] = PosB,
					[5] = PosQBoss,
				}  
			end

local Quests = require(game:GetService("ReplicatedStorage"):WaitForChild("Quests"))
local GuideModule = require(game:GetService("ReplicatedStorage"):WaitForChild("GuideModule"))

local blacklistquest = {
    "MarineQuest",
    "BartiloQuest",
    "CitizenQuest",
    "Trainees"
}

CheckSea = function(b)
    if (game.PlaceId == 2753915549 or game.PlaceId == 85211729168715) and b == 1 then
        return true
    elseif (game.PlaceId == 4442272183 or game.PlaceId == 79091703265657) and b == 2 then
        return true
    elseif (game.PlaceId == 7449423635 or game.PlaceId == 100117331123089) and b == 3 then
        return true
    end
    return false
end

GetQuestPointFromNPC = function(npcName)
    for _, npc in pairs(workspace.NPCs:GetChildren()) do
        if npc.Name == npcName and npc:FindFirstChild("HumanoidRootPart") then
            return npc.HumanoidRootPart.CFrame
        end
    end
    for _, npc in pairs(replicated.NPCs:GetChildren()) do
        if npc.Name == npcName and npc:FindFirstChild("HumanoidRootPart") then
            return npc.HumanoidRootPart.CFrame
        end
    end
    return nil
end

GetQuests = function()
    local lvl = plr.Data.Level.Value
    local LevelReq = 0
    local mmb = {}
    
    if lvl >= 700 and CheckSea(1) then
        mmb["Mob"] = "Galley Captain"
        mmb["NameQuest"] = "FountainQuest"
        mmb["ID"] = 2
        mmb["LevelReq"] = 700
    elseif lvl >= 1500 and CheckSea(2) then
        mmb["Mob"] = "Water Fighter"
        mmb["NameQuest"] = "ForgottenQuest"
        mmb["ID"] = 2
        mmb["LevelReq"] = 1450
    else
        for r, v in pairs(Quests) do
            for id, v1 in pairs(v) do
                local LvReq = v1.LevelReq
                for nguoi, tinh in pairs(v1.Task) do
                    if lvl >= LvReq and LevelReq <= LvReq and v1.Task[nguoi] > 1 and not table.find(blacklistquest, r) then
                        LevelReq = LvReq
                        mmb["Mob"] = nguoi
                        mmb["NameQuest"] = r
                        mmb["ID"] = id
                        mmb["LevelReq"] = LvReq
                    end
                end
            end
        end
    end
    
    return mmb
end

GetQuestPoint = function()
    if GuideModule and GuideModule.Data and GuideModule.Data.LastClosestNPC then
        return GetQuestPointFromNPC(GuideModule.Data.LastClosestNPC)
    end
    return nil
end

MaterialMon=function()local a=game.Players.LocalPlayer;local b=a.Character and a.Character:FindFirstChild("HumanoidRootPart")if not b then return end;shouldRequestEntrance=function(c,d)local e=(b.Position-c).Magnitude;if e>=d then replicated.Remotes.CommF_:InvokeServer("requestEntrance",c)end end;if World1 then if SelectMaterial=="Angel Wings"then MMon={"Shanda","Royal Squad","Royal Soldier","Wysper","Thunder God"}MPos=CFrame.new(-4698,845,-1912)SP="Default"local c=Vector3.new(-4607.82275,872.54248,-1667.55688)shouldRequestEntrance(c,10000)elseif SelectMaterial=="Leather + Scrap Metal"then MMon={"Brute","Pirate"}MPos=CFrame.new(-1145,15,4350)SP="Default"elseif SelectMaterial=="Magma Ore"then MMon={"Military Soldier","Military Spy","Magma Admiral"}MPos=CFrame.new(-5815,84,8820)SP="Default"elseif SelectMaterial=="Fish Tail"then MMon={"Fishman Warrior","Fishman Commando","Fishman Lord"}MPos=CFrame.new(61123,19,1569)SP="Default"local c=Vector3.new(61163.8515625,5.342342376708984,1819.7841796875)shouldRequestEntrance(c,17000)end elseif World2 then if SelectMaterial=="Leather + Scrap Metal"then MMon={"Marine Captain"}MPos=CFrame.new(-2010.5059814453125,73.00115966796875,-3326.620849609375)SP="Default"elseif SelectMaterial=="Magma Ore"then MMon={"Magma Ninja","Lava Pirate"}MPos=CFrame.new(-5428,78,-5959)SP="Default"elseif SelectMaterial=="Ectoplasm"then MMon={"Ship Deckhand","Ship Engineer","Ship Steward","Ship Officer"}MPos=CFrame.new(911.35827636719,125.95812988281,33159.5390625)SP="Default"local c=Vector3.new(61163.8515625,5.342342376708984,1819.7841796875)shouldRequestEntrance(c,18000)elseif SelectMaterial=="Mystic Droplet"then MMon={"Water Fighter"}MPos=CFrame.new(-3385,239,-10542)SP="Default"elseif SelectMaterial=="Radioactive Material"then MMon={"Factory Staff"}MPos=CFrame.new(295,73,-56)SP="Default"elseif SelectMaterial=="Vampire Fang"then MMon={"Vampire"}MPos=CFrame.new(-6033,7,-1317)SP="Default"end elseif World3 then if SelectMaterial=="Scrap Metal"then MMon={"Jungle Pirate","Forest Pirate"}MPos=CFrame.new(-11975.78515625,331.7734069824219,-10620.0302734375)SP="Default"elseif SelectMaterial=="Fish Tail"then MMon={"Fishman Raider","Fishman Captain"}MPos=CFrame.new(-10993,332,-8940)SP="Default"elseif SelectMaterial=="Conjured Cocoa"then MMon={"Chocolate Bar Battler","Cocoa Warrior"}MPos=CFrame.new(620.6344604492188,78.93644714355469,-12581.369140625)SP="Default"elseif SelectMaterial=="Dragon Scale"then MMon={"Dragon Crew Archer","Dragon Crew Warrior"}MPos=CFrame.new(6594,383,139)SP="Default"elseif SelectMaterial=="Gunpowder"then MMon={"Pistol Billionaire"}MPos=CFrame.new(-84.8556900024414, 85.62061309814453, 6132.0087890625)SP="Default"elseif SelectMaterial=="Mini Tusk"then MMon={"Mythological Pirate"}MPos=CFrame.new(-13545,470,-6917)SP="Default"elseif SelectMaterial=="Demonic Wisp"then MMon={"Demonic Soul"}MPos=CFrame.new(-9495.6806640625,453.58624267578125,5977.3486328125)SP="Default"end end end
QuestNeta = function()
    local questData = GetQuests()
    return {
        [1] = questData.Mob,           
        [2] = questData.ID,             
        [3] = questData.NameQuest,      
        [4] = questData.LevelReq,       
        [5] = questData.Mob,             
        [6] = GetQuestPoint()            
    }
end

-- ==========================================
-- STAR HUB AUTO-SAVE SYSTEM
-- ==========================================
local ConfigFile = "StarHub/Settings/StarHub_AutoSave_" .. (LocalPlayer and LocalPlayer.UserId or "Guest") .. ".json"
getgenv().StarHubConfig = getgenv().StarHubConfig or {}

function LoadStarHubConfig()
    pcall(function()
        if isfile and isfile(ConfigFile) then
            local raw = readfile(ConfigFile)
            if raw then
                local data = HttpService:JSONDecode(raw)
                if type(data) == "table" then
                    getgenv().StarHubConfig = data

        if _G.Level then
            pcall(function()
                local char = plr.Character or plr.CharacterAdded:Wait()
                local Root = char:WaitForChild("HumanoidRootPart")
                if not Root then return end

                local level = plr.Data.Level.Value
                local inSub = IsInSubmergedIsland()
                local questUI = plr.PlayerGui.Main.Quest
                local QuestTitle = questUI.Visible and questUI.Container.QuestTitle.Title.Text or ""

                if level >= 2600 and not inSub and not teleporting and not alreadyTeleported then
                    teleporting = true
                    
                    local npcPos = CFrame.new(-16269.7041, 25.2288494, 1373.65955)
                    local teleportAttempts = 0
                    
                    repeat 
                        task.wait(Sec)
                        _tp(npcPos)
                        teleportAttempts = teleportAttempts + 1
                    until not _G.Level or (Root.Position - npcPos.Position).Magnitude <= 8 or teleportAttempts > 20

                    if not _G.Level then 
                        teleporting = false
                        return 
                    end

                    task.wait(1)
                    
                    pcall(function()
                        local args = {"TravelToSubmergedIsland"} 
                        game:GetService("ReplicatedStorage").Modules.Net:FindFirstChild("RF/SubmarineWorkerSpeak"):InvokeServer(unpack(args))
                    end)

                    local timeout = tick()
                    repeat 
                        task.wait(0.5)
                        local currentInSub = IsInSubmergedIsland()
                        local farFromNPC = (Root.Position - npcPos.Position).Magnitude > 50
                        
                        if currentInSub or farFromNPC then
                            break
                        end
                    until not _G.Level or tick() - timeout > 15

                    task.wait(2)
                    alreadyTeleported = true
                    teleporting = false
                    
                elseif inSub or level < 2600 then
                    alreadyTeleported = true
                    teleporting = false

                    local questData = QuestNeta()
                    
                    if not questData or not questData[1] then
                        task.wait(1)
                        return
                    end
                    
                    if questUI.Visible and not string.find(QuestTitle, questData[1]) then
                        replicated.Remotes.CommF_:InvokeServer("AbandonQuest")
                        task.wait(0.2)
                        return
                    end

                    if not questUI.Visible then
                        local questPos = questData[6]
                        if questPos then
                            _tp(questPos)
                            task.wait(2)
                            
                            if (Root.Position - questPos.Position).Magnitude <= 10 then
                                pcall(function()
                                    replicated.Remotes.CommF_:InvokeServer("StartQuest", questData[3], questData[2])
                                end)
                                task.wait(1)
                            end
                        else
                            pcall(function()
                                replicated.Remotes.CommF_:InvokeServer("StartQuest", questData[3], questData[2])
                            end)
                            task.wait(1)
                        end
                        return
                    end

                    local enemyName = questData[1]
                    
                    local foundMob = false
                    for _, v in pairs(workspace.Enemies:GetChildren()) do
                        if v.Name == enemyName and Attack.Alive(v) then
                            foundMob = true
                            repeat
                                task.wait(Sec)
                                _tp(v.HumanoidRootPart.CFrame * CFrame.new(0,20,0))
                                Attack.Kill(v, _G.Level)
                                
                                if not questUI.Visible then
                                    break
                                end
                            until not _G.Level or not v.Parent or v.Humanoid.Health <= 0
                            break
                        end
                    end
                    
                    if not foundMob then
                        for _, v in pairs(replicated:GetChildren()) do
                            if v.Name == enemyName and Attack.Alive(v) then
                                foundMob = true
                                _tp(v.HumanoidRootPart.CFrame * CFrame.new(0,20,0))
                                break
                            end
                        end
                    end
                    
                    if not foundMob then
                        for _, spawnPoint in pairs(workspace["_WorldOrigin"].EnemySpawns:GetChildren()) do
                            if string.find(spawnPoint.Name, enemyName) then
                                _tp(spawnPoint.CFrame * CFrame.new(0, 20, 0))
                                break
                            end
                        end
                    end
                end
            end)
        else
            teleporting = false
            alreadyTeleported = false
        end
    end
end)

Name = "Auto Farm Nearest", 
Description = "ฟามมอนรอบๆตัวละคร", 
Default = false, 
Callback = function(Value)
  _G.AutoFarmNear = Value
end})

  while wait() do
    pcall(function()
      if _G.AutoFarmNear then
        for i,v in pairs(workspace.Enemies:GetChildren()) do
          if v:FindFirstChild("Humanoid") or v:FindFirstChild("HumanoidRootPart") then
            if v.Humanoid.Health > 0 then
              repeat wait() Attack.Kill(v,_G.AutoFarmNear) until not _G.AutoFarmNear or not v.Parent or v.Humanoid.Health <= 0
            end
          end
        end
      end
    end)
  end
end)
Name = "Auto Factory Raid", 
Description = "ฟามโรงงาน", 
Default = false,
Callback = function(Value)
  _G.AutoFactory = Value
end})
spawn(function()
  while wait(Sec) do

Default = false,
Callback = function(Value)
  _G.AutoRaidCastle = Value
end})
spawn(function()
  while wait(Sec) do
    if _G.AutoRaidCastle then
      pcall(function()
      local CFrameCastleRaid = CFrame.new(-5496.17432, 313.768921, -2841.53027, 0.924894512, 7.37058015e-09, 0.380223751, 3.5881019e-08, 1, -1.06665446e-07, -0.380223751, 1.12297109e-07, 0.924894512)
        if (CFrame.new(-5539.3115234375, 313.800537109375, -2972.372314453125).Position - Root.Position).Magnitude <= 500 then
          for i,v in pairs(workspace.Enemies:GetChildren()) do
            if v:FindFirstChild("HumanoidRootPart") and v:FindFirstChild("Humanoid") and v.Humanoid.Health > 0 then
              if v.Name then
                if (v.HumanoidRootPart.Position - Root.Position).Magnitude <= 2000 then
                  repeat wait() Attack.Kill(v,_G.AutoRaidCastle) until not _G.AutoRaidCastle or not v.Parent or v.Humanoid.Health <= 0 or not workspace.Enemies:FindFirstChild(v.Name)
                end
              end
            end
          end
        else
          local Castle_Mob = {"Galley Pirate","Galley Captain","Raider","Mercenary","Vampire","Zombie","Snow Trooper","Winter Warrior","Lab Subordinate","Horned Warrior","Magma Ninja","Lava Pirate","Ship Deckhand","Ship Engineer","Ship Steward","Ship Officer","Arctic Warrior","Snow Lurker","Sea Soldier","Water Fighter"}
          for i = 1,#Castle_Mob do
            if replicated:FindFirstChild(Castle_Mob[i]) then
              for _,v in pairs(replicated:GetChildren()) do
                if table.find(Castle_Mob, v.Name) then _tp(CFrameCastleRaid) end
              end
            end
          end
        end
      end)
    end
  end
end)




Name = "Auto Farm Ectoplasm", 
Description = "ฟามก้อนเขียวๆเรือผี", 
Default = false,
Callback = function(Value)
  _G.AutoEctoplasm = Value
end})
spawn(function()
  while wait(Sec) do
    pcall(function()
      if _G.AutoEctoplasm then
        local EctoTable = {"Ship Deckhand","Ship Engineer","Ship Steward","Ship Officer","Arctic Warrior"}    
        local v = GetConnectionEnemies(EctoTable)
		if Attack.Alive(v) then
		  repeat wait() Attack.Kill(v, _G.AutoEctoplasm)until not _G.AutoEctoplasm or not v.Parent or v.Humanoid.Health <= 0		        
	    else
	      replicated.Remotes.CommF_:InvokeServer("requestEntrance",Vector3.new(923.21252441406, 126.9760055542, 32852.83203125))
	    end
      end
    end)
  end
end)


ChestTW = Tabs.Main:AddToggle({
Name = "Auto Farm Chest", 
Description = "ฟามกล่อง", 
Default = false,

  _G.AutoFarmChest = Value
end})
spawn(function()
  while wait(Sec) do
    if _G.AutoFarmChest then
      pcall(function()
        local CollectionService = game:GetService("CollectionService")
        local Players = game:GetService("Players")
        local Player = Players.LocalPlayer
        local Character = Player.Character or Player.CharacterAdded:Wait()                
        if not Character then return end                
        local Position = Character:GetPivot().Position
        local Chests = CollectionService:GetTagged("_ChestTagged")      
        local Distance, Nearest = math.huge, nil  
        for i = 1, #Chests do
          local Chest = Chests[i]
          local Magnitude = (Chest:GetPivot().Position - Position).Magnitude        
          if not SelectedIsland or Chest:IsDescendantOf(SelectedIsland) then
            if not Chest:GetAttribute("IsDisabled") and Magnitude < Distance then
              Distance = Magnitude
              Nearest = Chest
            end
          end
        end
      if Nearest then _tp(Nearest:GetPivot()) end
      end)
    end
  end
end)

ChestBP = Tabs.Main:AddToggle({
    Name = "Auto Chest Bypass", 
    Description = "",
    Default = false,
    Callback = function(Value)
        _G.AutoChestBP = Value

        if Value then
            local LocalPlayer = game:GetService("Players").LocalPlayer
            local IsFarming = false
            local UncheckedChests = {}
            local FirstRun = true

            local function getCharacter()
                if not LocalPlayer.Character then
                    LocalPlayer.CharacterAdded:Wait()
                end
                LocalPlayer.Character:WaitForChild("HumanoidRootPart")
                return LocalPlayer.Character
            end

            local function getChestsSorted()
                if FirstRun then
                    FirstRun = false
                    for _, Object in pairs(game:GetDescendants()) do
                        if Object.Name:find("Chest") and Object.ClassName == "Part" then
                            table.insert(UncheckedChests, Object)
                        end
                    end
                end

                local Chests = {}
                for _, Chest in pairs(UncheckedChests) do
                    if Chest:FindFirstChild("TouchInterest") then
                        table.insert(Chests, Chest)
                    end
                end

                local RootPart = getCharacter().LowerTorso
                table.sort(Chests, function(a, b)
                    return (RootPart.Position - a.Position).Magnitude < (RootPart.Position - b.Position).Magnitude
                end)
                return Chests
            end

            local function runChestLoop()
                if IsFarming then return end
                IsFarming = true

                task.spawn(function()
                    while _G.AutoChestBP and LocalPlayer.Character and LocalPlayer.Character.Parent do
                        local Chests = getChestsSorted()
                        if #Chests > 0 then
                            local RootPart = getCharacter().HumanoidRootPart
                            RootPart.CFrame = Chests[1].CFrame
                        end
                        task.wait(0.1)
                    end
                    IsFarming = false
                end)
            end

            LocalPlayer.CharacterAdded:Connect(function()
                getCharacter()
                task.wait(0.5)
                if _G.AutoChestBP then
                    runChestLoop()
                end
            end)

            runChestLoop()
        end
    end
})

StopI = Tabs.Main:AddToggle({
Name = "Stop Items", 
Description = "", 
Default = true,
Callback = function(Value)
    _G.StopWhenChalice = Value
end})

spawn(function()
    while wait(0.2) do
        if _G.StopWhenChalice and (_G.AutoFarmChest or _G.AutoChestBP) then
            pcall(function()
                if GetBP("God's Chalice") or GetBP("Sweet Chalice") or GetBP("Fist of Darkness") then
                    _G.AutoFarmChest = false
                    _G.AutoChestBP = false
                end
            end)
        end
    end
end)


Berry = Tabs.Main:AddToggle({
Name = "Auto Farm Berry", 
Description = "", 
Default = false,
Callback = function(Value)
  _G.AutoBerry = Value
end})
spawn(function()
  while wait(Sec) do
    if _G.AutoBerry then
      local CollectionService= game:GetService("CollectionService")
      local Players= game:GetService("Players")
      local Player = Players.LocalPlayer
      local BerryBush = CollectionService:GetTagged("BerryBush")      
      local Distance, Nearest = math.huge      
      for i = 1, #BerryBush do
        local Bush = BerryBush[i]        
        for AttributeName, BerryName in pairs(Bush:GetAttributes()) do
          if not BerryArray or table.find(BerryArray, BerryName) then           
            _tp(Bush.Parent:GetPivot())
            for i = 1, #BerryBush do
            local Bush = BerryBush[i]        
              for AttributeName, BerryName in pairs(Bush:GetChildren()) do
                if not BerryArray or table.find(BerryArray, BerryName) then
                  _tp(BerryName.WorldPivot)
                  fireproximityprompt(BerryName.ProximityPrompt,math.huge)
                end
              end
            end      
          end
        end
      end      
    end
  end
end)



BerryH = Tabs.Main:AddToggle({
Name = "Auto Farm Berry + Hop", 
Description = "", 
Default = false,
Callback = function(Value)
  _G.AutoBerryH = Value
end})

spawn(function()
    while wait(Sec) do
        if _G.AutoBerryH then
            local CollectionService = game:GetService("CollectionService")
            local Players = game:GetService("Players")
            local Player = Players.LocalPlayer
            local BerryBush = CollectionService:GetTagged("BerryBush")

            if #BerryBush == 0 then
                local TeleportService = game:GetService("TeleportService")
                local ServerList = {}
                
                local Success, Error = pcall(function()
                    ServerList = game:GetService("HttpService"):JSONDecode(game:HttpGet("https://games.roblox.com/v1/games/" .. game.PlaceId .. "/servers/Public?sortOrder=Asc&limit=100"))
                end)
                
                if Success and ServerList.data then
                    for _, Server in pairs(ServerList.data) do
                        if Server.playing < Server.maxPlayers and Server.id ~= game.JobId then
                            TeleportService:TeleportToPlaceInstance(game.PlaceId, Server.id, Player)
                            break
                        end
                    end
                end
            else
                for i = 1, #BerryBush do
                    local Bush = BerryBush[i]
                    
                    for AttributeName, BerryName in pairs(Bush:GetAttributes()) do
                        if not BerryArray or table.find(BerryArray, BerryName) then
                            _tp(Bush.Parent:GetPivot())
                            
                            for j = 1, #BerryBush do
                                local Bush2 = BerryBush[j]
                                
                                for _, BerryChild in pairs(Bush2:GetChildren()) do
                                    if not BerryArray or table.find(BerryArray, BerryChild.Name) then
                                        _tp(BerryChild.WorldPivot)
                                        fireproximityprompt(BerryChild.ProximityPrompt, math.huge)
                                    end

    _G.FarmEliteHunt = Value
end})

spawn(function()
    while wait(1) do
        pcall(function()
            if _G.FarmEliteHunt then
                local questGui = plr.PlayerGui.Main.Quest
                local questTitle = questGui.Container.QuestTitle.Title.Text

                if not questGui.Visible then
                    
                    local result = replicated.Remotes.CommF_:InvokeServer("EliteHunter")
                    if result == nil or string.find(result, "Cooldown") then
                      
                        wait(10)
                        return
                    end
                    task.wait(1)
                else
                    
                    local eliteName = nil
                    for _, name in pairs({"Diablo", "Urban", "Deandre"}) do
                        if string.find(questTitle, name) then
                            eliteName = name
                            break
                        end
                    end

                    if eliteName then
                        local boss = nil
                        
                        for _, v in pairs(replicated:GetChildren()) do
                            if v.Name == eliteName and v:FindFirstChild("HumanoidRootPart") then
                                boss = v
                                break
                            end
                        end
                        for _, v in pairs(Enemies:GetChildren()) do
                            if v.Name == eliteName and Attack.Alive(v) then
                                boss = v
                                break
                            end
                        end

                        if boss and boss:FindFirstChild("HumanoidRootPart") then
                            _tp(boss.HumanoidRootPart.CFrame * CFrame.new(0, 30, 0))
                            repeat
                                wait()
                                Attack.Kill(boss, _G.FarmEliteHunt)
                            until not _G.FarmEliteHunt or not boss.Parent or boss.Humanoid.Health <= 0 or not questGui.Visible
                        else
                           
                            wait(5)
                        end
                    else
                       
                        replicated.Remotes.CommF_:InvokeServer("AbandonQuest")
                    end
                end
            end
        end)
    end
end)

EliteH = Tabs.Main:AddToggle({
	Name = "Auto Farm Elite + Hop",
	Description = "",
	Default = false,
	Callback = function(Value)
	_G.FarmEliteH = Value
end})


function HopServer()
	local Http = game:GetService("HttpService")
	local TPS = game:GetService("TeleportService")
	local Api = "https://games.roblox.com/v1/games/"
	local PlaceID = game.PlaceId
	local Servers = {}
	local Cursor = ""
	local foundServer = false

	repeat
		local success, result = pcall(function()
			return game:HttpGet(Api .. PlaceID .. "/servers/Public?sortOrder=Asc&limit=100&cursor=" .. Cursor)
		end)
		if success and result then
			local data = Http:JSONDecode(result)
			if data.data then
				for _, v in pairs(data.data) do
					if v.playing < v.maxPlayers and v.id ~= game.JobId then
						foundServer = true
						TPS:TeleportToPlaceInstance(PlaceID, v.id)
						break
					end
				end
				Cursor = data.nextPageCursor or ""
			end
		end
	until not Cursor or foundServer
end


spawn(function()
	while task.wait(1) do
		pcall(function()
			if _G.FarmEliteH then
				local questGui = plr.PlayerGui.Main.Quest
				local questTitle = questGui.Container.QuestTitle.Title.Text

				
				if not questGui.Visible then
					local result = replicated.Remotes.CommF_:InvokeServer("EliteHunter")
					if result == nil or string.find(result, "Cooldown") then
					
						HopServer()
						return
					end
					task.wait(1)

				else
				
					local eliteName = nil
					for _, name in pairs({"Diablo", "Urban", "Deandre"}) do
						if string.find(questTitle, name) then
							eliteName = name
							break
						end
					end

					if eliteName then
						local boss = nil
						for _, v in pairs(replicated:GetChildren()) do
							if v.Name == eliteName and v:FindFirstChild("HumanoidRootPart") then
								boss = v
								break
							end
						end
						for _, v in pairs(workspace.Enemies:GetChildren()) do
							if v.Name == eliteName and Attack.Alive(v) then
								boss = v
								break
							end
						end

						if boss and boss:FindFirstChild("HumanoidRootPart") then
							_tp(boss.HumanoidRootPart.CFrame * CFrame.new(0, 30, 0))
							repeat
								wait()
								Attack.Kill(boss, _G.FarmEliteH)
							until not _G.FarmEliteH or not boss.Parent or boss.Humanoid.Health <= 0 or not questGui.Visible
						else
						
							task.wait(5)
							HopServer()
						end
					else
					
						replicated.Remotes.CommF_:InvokeServer("AbandonQuest")
						task.wait(1)
						HopServer()
					end
				end
			end
		end)
	end
end)


Name = "Auto Attack Rip Indra", 
Description = "ตีบอสแอดมิน", 
Default = false,
Callback = function(Value)
  _G.AutoRipIngay = Value
end})
spawn(function()

  _G.AutoRipIngay = Value
end})
spawn(function()
  while wait(Sec) do
    pcall(function()
      if _G.AutoRipIngay then
        local v = GetConnectionEnemies("rip_indra")
	    if not GetWP("Dark Dagger") or not GetIn("Valkyrie") and v then
	      repeat wait() Attack.Kill(v,_G.AutoRipIngay)until not _G.AutoRipIngay or not v.Parent or v.Humanoid.Health <= 0
        else
          replicated.Remotes.CommF_:InvokeServer("requestEntrance",Vector3.new(-5097.93164, 316.447021, -3142.66602, -0.405007899, -4.31682743e-08, 0.914313197, -1.90943332e-08, 1, 3.8755779e-08, -0.914313197, -1.76180437e-09, -0.405007899))
		  wait(.1)_tp(CFrame.new(-5344.822265625, 423.98541259766, -2725.0930175781))
	    end
      end
    end)
  end
end)

Name = "Auto Unlocked Haki", 
Description = "ปลดล๊อคฮาคิเอง", 
Default = false,
Callback = function(Value)
  _G.AutoUnHaki = Value
end})
AuraSkin = function(HakiID)
  local args = {[1] = {["StorageName"] = HakiID,["Type"] = "AuraSkin",["Context"] = "Equip"}};
  replicated:WaitForChild("Modules"):WaitForChild("Net"):WaitForChild("RF/FruitCustomizerRF"):InvokeServer(unpack(args));
end;
VaildColor = function(Part)
  if Part and Part.BrickColor then return (tostring(Part.BrickColor) == "Lime green") end;
end;
HakiCalculate = function(Part)
  local ID = {["Really red"] = "Pure Red";["Oyster"] = "Snow White";["Hot pink"] = "Winter Sky";};
  if Part and Part.BrickColor then return (ID[tostring(Part.BrickColor)])end;
end;
spawn(function()
  while wait(Sec) do
    if _G.AutoUnHaki then
      pcall(function()
        local Summoner = workspace.Map["Boat Castle"]:FindFirstChild("Summoner");
        if Summoner and Summoner:FindFirstChild("Circle") then 
          for i,v in pairs(Summoner:FindFirstChild("Circle"):GetChildren()) do 
            if v.Name == "Part" then 
            local TogglesPart = v:FindFirstChild("Part");
              if VaildColor(TogglesPart) == false then 
                AuraSkin(HakiCalculate(v));
                repeat wait() _tp(v.CFrame) until VaildColor(TogglesPart) == true or not _G.AutoUnHaki;
              end
            end            
          end
        end        
      end)
    end
  end
end)

MobKilled = Tabs.Main:AddParagraph("Cake Princes", "")
spawn(function()
    while wait(0.2) do
        pcall(function()
            local Killed = string.match(replicated.Remotes.CommF_:InvokeServer("CakePrinceSpawner"), "%d+")
            if Killed then
                MobKilled:SetDesc("Killed : " .. (500 - tonumber(Killed) or 0))
            end
        end)
    end
end)

Cake = Tabs.Main:AddToggle({
    Name = "Auto Farm Cake Prince",
    Description = "ตีคาตาคุริ",
    Default = false,
    Callback = function(Value)
    _G.Auto_Cake_Prince = Value
end
})

spawn(function()
    while task.wait() do
        if _G.Auto_Cake_Prince and not _G.AutoRaidCastle then
            pcall(function()
                local player = game.Players.LocalPlayer
                local root = player.Character and player.Character:FindFirstChild("HumanoidRootPart")
                local questUI = player.PlayerGui.Main.Quest
                local enemies = workspace.Enemies
                local cakeMap = workspace.Map:FindFirstChild("CakeLoaf")
                local bigMirror = cakeMap and cakeMap:FindFirstChild("BigMirror")
                if not root then return end

                if _G.AcceptQuestC and questUI and not questUI.Visible then
                    local questPos = CFrame.new(-1927.92, 37.8, -12842.54)
                    _tp(questPos)
                    while (questPos.Position - root.Position).Magnitude > 50 do
                        task.wait(0.2)
                    end
                    local randomQuest = math.random(1, 4)
                    local questData = {
                        [1] = {"StartQuest", "CakeQuest2", 2},
                        [2] = {"StartQuest", "CakeQuest2", 1},
                        [3] = {"StartQuest", "CakeQuest1", 1},
                        [4] = {"StartQuest", "CakeQuest1", 2}
                    }
                    pcall(function()
                        game.ReplicatedStorage.Remotes.CommF_:InvokeServer(unpack(questData[randomQuest]))
                    end)
                end

                if not cakeMap then
                    _tp(CFrame.new(-2077, 252, -12373))
                    task.wait(2)
                    return
                end

                if bigMirror and (bigMirror.Other.Transparency == 0 or enemies:FindFirstChild("Cake Prince")) then
                    local boss = GetConnectionEnemies("Cake Prince")
                    if boss then
                        repeat task.wait()
                            Attack.Kill2(boss, _G.Auto_Cake_Prince)
                        until not _G.Auto_Cake_Prince or not boss.Parent or boss.Humanoid.Health <= 0
                    else
                        _tp(CFrame.new(-2151.82, 149.32, -12404.91))
                    end
                else

                    local CakeMobs = {"Cookie Crafter","Cake Guard","Baking Staff","Head Baker"}
                    local mob = GetConnectionEnemies(CakeMobs)
                    if mob then
                        repeat task.wait()
                            Attack.Kill(mob, _G.Auto_Cake_Prince)
                        until not _G.Auto_Cake_Prince or not mob.Parent or mob.Humanoid.Health <= 0 or (bigMirror and bigMirror.Other.Transparency == 0)
                    else
                        _tp(CFrame.new(-2077, 252, -12373))
                    end
                end
            end)
        end
    end
end)

CakeQ = Tabs.Main:AddToggle({
Name = "Accept Quests", 
Description = "รับเควสตอนตีคาตาคุริ", 
Default = false,
Callback = function(Value)
  _G.AcceptQuestC = Value
end
})


CakeSM = Tabs.Main:AddToggle({
    Name = "Auto Summon Cake Prince",
    Description = "เสกคาตาคุริเอง",
    Default = false,
    Callback = function(Value)
    _G.AutoSpawnCP = Value
end})

spawn(function()
    while task.wait(2) do
        if _G.AutoSpawnCP then
            pcall(function()
                local CommF = game.ReplicatedStorage.Remotes.CommF_
                local enemies = workspace.Enemies
                local bigMirror = workspace.Map.CakeLoaf:FindFirstChild("BigMirror")
                if not bigMirror then return end
                if enemies:FindFirstChild("Cake Prince") then return end
                if bigMirror.Other.Transparency == 0 then return end

                CommF:InvokeServer("CakePrinceSpawner", true)
            end)
        end
    end
end)


    Name = "Auto Dough King [Fully]",
    Default = false,
    Callback = function(Value)
        _G.AutoDoughKing = Value
    end
})

spawn(function()
    while wait() do
        if _G.AutoDoughKing then
            pcall(function()
                if not workspace.Map.CakeLoaf:FindFirstChild("RedDoor") then
                    if GetBP("Red Key") then
                        replicated.Remotes.CommF_:InvokeServer("CakeScientist", "Check")
                        replicated.Remotes.CommF_:InvokeServer("RaidsNpc", "Check")
                    end
                elseif workspace.Map.CakeLoaf:FindFirstChild("RedDoor") then
                    if GetBP("Red Key") then
                        repeat
                            task.wait()
                            _tp(CFrame.new(-2681.97998, 64.3921585, -12853.7363,0.149007782, -1.87902192e-08, 0.98883605,3.60619588e-08, 1, 1.35681812e-08,-0.98883605, 3.36376011e-08, 0.149007782))
                        until not getgenv().AutoDoughKing or (plr.Character.HumanoidRootPart.CFrame - CFrame.new(-2681.97998, 64.3921585, -12853.7363,0.149007782, -1.87902192e-08, 0.98883605,3.60619588e-08, 1, 1.35681812e-08,-0.98883605, 3.36376011e-08, 0.149007782)).Magnitude <= 5
                        EquipWeapon("Red Key")
                    end
                elseif GetConnectionEnemies("Dough King") then
                    local v = GetConnectionEnemies("Dough King")
                    if v then
                        repeat
                            task.wait()
                            Attack.Kill(v, _G.AutoDoughKing)
                        until not _G.AutoDoughKing or not v.Parent or v.Humanoid.Health <= 0
                    else
                        _tp(CFrame.new(-1943.676513671875, 251.5095672607422, -12337.880859375))
                    end
                end
                if GetBP("Sweet Chalice") then
                    replicated.Remotes.CommF_:InvokeServer("CakePrinceSpawner", true)
                    _G.AutoAttackDoughKing = true
                else
                    _G.AutoAttackDoughKing = false
                end
                if GetBP("God's Chalice") and GetM("Conjured Cocoa") >= 10 then
                    replicated.Remotes.CommF_:InvokeServer("SweetChaliceNpc")
                end
                if not plr.Backpack:FindFirstChild("God's Chalice")
                    or plr.Character:FindFirstChild("God's Chalice")
                then
                    _G.FarmEliteHunt = true
                else
                    _G.FarmEliteHunt = false
                end
                if GetM("Conjured Cocoa") <= 10 then
                    local v = GetConnectionEnemies{"Cocoa Warrior", "Chocolate Bar Battler"}
                    if v then
                        repeat
                            task.wait()
                            Attack.Kill(v, _G.AutoDoughKing)
                        until _G.AutoDoughKing == false or not v.Parent or v.Humanoid.Health <= 0
                    else
                        _tp(CFrame.new(402.7189025878906, 81.06050109863281, -12259.54296875))
                    end
                end
            end)
        end
    end
end)
    Name = "Auto Farm Dough King",
    Default = false,
    Callback = function(Value)
        _G.AutoAttackDoughKing = Value
    end
})
spawn(function()
    while wait() do
        if _G.AutoAttackDoughKing then
            pcall(function()
                local v = GetConnectionEnemies("Dough King")
                if v then
                    repeat 
                        task.wait()
                        Attack.Kill(v,_G.AutoAttackDoughKing)
                    until not _G.AutoAttackDoughKing or not v.Parent or v.Humanoid.Health <= 0
                else
                    _tp(CFrame.new(-1943.6765, 251.5095, -12337.8809))
                end
            end)
        end
    end
end)

    Name = "Auto Farm Dough King + Hop",
    Default = false,
    Callback = function(Value)
        _G.AutoHop_Dough = Value
    end
})


function HopServer()
    pcall(function()
        local Http = game:GetService("HttpService")
        local Servers = {}
        local req = game:HttpGet("https://games.roblox.com/v1/games/"..game.PlaceId.."/servers/Public?sortOrder=Asc&limit=100")
        local data = Http:JSONDecode(req)

        for i,v in pairs(data.data) do
            if v.playing < v.maxPlayers then
                table.insert(Servers, v.id)
            end
        end
        if #Servers > 0 then
            game:GetService("TeleportService"):TeleportToPlaceInstance(game.PlaceId, Servers[math.random(1,#Servers)], game.Players.LocalPlayer)
        end
    end)
end


spawn(function()
    while task.wait() do
        if _G.AutoHop_Dough then
            pcall(function()
                local v = GetConnectionEnemies("Dough King")

                if v then
                 
                    repeat 
                        task.wait()
                        Attack.Kill(v, _G.AutoHop_Dough)
                    until not _G.AutoHop_Dough or not v.Parent or v.Humanoid.Health <= 0

                else
                  
                    _tp(CFrame.new(-1943.6765, 251.5095, -12337.8809))

                    task.wait(2)

                    
                    local checkAgain = GetConnectionEnemies("Dough King")

                    if not checkAgain and _G.AutoHop_Dough then
                        HopServer()
                    end
                end
            end)
        end
    end
end)


CheckingBone = Tabs.Main:AddParagraph("Bones", "")
spawn(function()
    while wait(0.2) do
        pcall(function()
            CheckingBone:SetDesc("Bones : " .. GetM("Bones"))
        end)
    end
end)

    local player = game.Players.LocalPlayer
    local BonesTable = {
        "Reborn Skeleton",
        "Living Zombie",
        "Demonic Soul",
        "Possessed Mummy"
    }

    while wait(0.5) do
        if not _G.AutoFarm_Bone then continue end

        pcall(function()
            local char = player.Character
            local root = char and char:FindFirstChild("HumanoidRootPart")
            if not root then return end

           
            local questUI =
                player.PlayerGui:FindFirstChild("Main")
                and player.PlayerGui.Main:FindFirstChild("Quest")

            local bone = GetConnectionEnemies(BonesTable)

            
            if _G.AcceptQuestB and questUI and not questUI.Visible then
                local questPos = CFrame.new(-9516.99316,172.01718,6078.46533)
                _tp(questPos)

                repeat wait(2)
                until not _G.AutoFarm_Bone
                   or (questPos.Position - root.Position).Magnitude <= 50

                if not _G.AutoFarm_Bone then return end

                local questData = {
                    {"StartQuest","HauntedQuest2",2},
                    {"StartQuest","HauntedQuest2",1},
                    {"StartQuest","HauntedQuest1",1},
                    {"StartQuest","HauntedQuest1",2}
                }

                game.ReplicatedStorage.Remotes.CommF_:InvokeServer(
                    unpack(questData[math.random(1,#questData)])
                )
            end

           
            if bone then
                repeat
                    wait()
                    Attack.Kill(bone, true)
                until not _G.AutoFarm_Bone
                   or not bone.Parent
                   or bone.Humanoid.Health <= 0
            else
            
                _tp(CFrame.new(-9495.6806640625, 453.58624267578125, 5977.3486328125))
            end
        end)
    end
end)

Name = "Accept Quests", 
Description = "รับเควสตอนฟามกระดูก", 
Default = false,
Callback = function(Value)
  _G.AcceptQuestB = Value
end
})        



Name = "Auto Soul Reaper", 
Description = "เสกบอสที่ได้จากการสุ่มกระดูกเอง", 
Default = false,
Callback = function(Value)
  _G.AutoHytHallow = Value
end})
spawn(function()
  while wait(Sec) do
    if _G.AutoHytHallow then
      pcall(function()
        local v = GetConnectionEnemies("Soul Reaper")
	    if v then
          repeat task.wait() Attack.Kill(v,_G.AutoHytHallow) until v.Humanoid.Health <= 0 or _G.AutoHytHallow == false
        else
          if not GetBP("Hallow Essence") then

            pcall(function()
                if not plr.Character then return end
                local hrp = plr.Character:FindFirstChild("HumanoidRootPart")
                if not hrp then return end

                local bossPos = Vector3.new(-16268.287, 152.616, 1390.773)
                
                if (hrp.Position - bossPos).Magnitude > 5 then
                    _tp(CFrame.new(bossPos))
                    repeat wait() until not _G.FarmTyrant or (plr.Character and plr.Character:FindFirstChild("HumanoidRootPart") and (plr.Character.HumanoidRootPart.Position - bossPos).Magnitude <= 5)
                end

                local boss = workspace.Enemies:FindFirstChild("Tyrant of the Skies")
                if boss and boss:FindFirstChild("Humanoid") and boss.Humanoid.Health > 0 then
                    repeat
                        if not _G.FarmTyrant then break end
                        if Attack and Attack.Kill then
                            Attack.Kill(boss, _G.FarmTyrant)
                        end
                        wait()
                    until not _G.FarmTyrant or not boss.Parent or boss.Humanoid.Health <= 0
                    return
                end

                local mobList = {"Serpent Hunter","Skull Slayer","Isle Champion","Sun-kissed Warrior"}
                for _, mobName in ipairs(mobList) do
                    if not _G.FarmTyrant then break end
                    for _, mob in pairs(workspace.Enemies:GetChildren()) do
                        if not _G.FarmTyrant then break end
                        if mob and mob.Name == mobName and mob:FindFirstChild("HumanoidRootPart") and mob:FindFirstChild("Humanoid") and mob.Humanoid.Health > 0 then
                            if (hrp.Position - mob.HumanoidRootPart.Position).Magnitude > 5000 then
                                _tp(mob.HumanoidRootPart.CFrame * CFrame.new(0,30,0))
                                local t0 = tick()
                                repeat wait() hrp = plr.Character and plr.Character:FindFirstChild("HumanoidRootPart") until not _G.FarmTyrant or not hrp or (hrp.Position - mob.HumanoidRootPart.Position).Magnitude <= 6 or tick() - t0 > 8
                            end
                            repeat
                                if not _G.FarmTyrant then break end
                                if Attack and Attack.Kill then
                                    Attack.Kill(mob, _G.FarmTyrant)
                                end
                                wait()
                            until not _G.FarmTyrant or not mob.Parent or mob.Humanoid.Health <= 0
                        end
                    end
                end
            end)
        end
    end
end)

Name = "Auto Summon Boss", 
Description = "เสกบอสนกเอง", 
Default = false,
Callback = function(Value)
    _G.FarmPhaBinh = Value
end})

function sendSkillKey(skillKey)
    local virtualInputManager = game:GetService("VirtualInputManager")
    virtualInputManager:SendKeyEvent(true, skillKey, false, game)
    wait(0.05)
    virtualInputManager:SendKeyEvent(false, skillKey, false, game)
end

function equipAndUseSkill(toolType)
    local character = plr.Character
    local backpack = plr.Backpack
    if not (character and character:FindFirstChild("Humanoid") and character.Humanoid.Health > 0) then return end

    for _, item in pairs(backpack:GetChildren()) do
        if item:IsA("Tool") and item.ToolTip == toolType then
            item.Parent = character
            wait(0.12)
            for _, skill in ipairs({"Z", "X", "C", "V", "F"}) do
                if not _G.FarmPhaBinh then break end
                pcall(function() sendSkillKey(skill) end)
                wait(0.12)
            end
            item.Parent = backpack
            break
        end
    end
end

local PhaBinhPoints = {
    CFrame.new(-16332.5263671875, 158.07200622558594, 1440.324951171875),
    CFrame.new(-16288.609375, 158.16700744628906, 1470.3680419921875),
    CFrame.new(-16245.412109375, 158.43699645996094, 1463.365966796875),
    CFrame.new(-16212.46875, 158.16700744628906, 1466.343994140625),
    CFrame.new(-16211.9462890625, 158.07200622558594, 1322.39794921875),
    CFrame.new(-16260.921875, 154.92100524902344, 1323.615966796875),
    CFrame.new(-16297.0595703125, 159.322998046875, 1317.2239990234375),
    CFrame.new(-16335.0966796875, 159.33399963378906, 1324.885986328125),

    end
})


BossQ = Tabs.Main:AddToggle({
    Name = "Accept Quests",
    Description = "รับเควสตอนฟาร์มบอส",
    Default = true,
    Callback = function(Value)
        _G.AcceptQuestBoss = Value
    end
})

FarmAllBoss = Tabs.Main:AddToggle({
   Name = "Auto Farm All Boss",
    Default = false,
Callback = function(Value)
    _G.AutoFarmAllBoss = Value
end})

task.spawn(function()
    while task.wait(0.3) do
        if _G.AutoFarmAllBoss then
            pcall(function()
                local player = game.Players.LocalPlayer
                if not player.Character or not player.Character:FindFirstChild("HumanoidRootPart") then return end
                local hrp = player.Character.HumanoidRootPart

                local nearestBoss, nearestDist = nil, math.huge

                for _, boss in pairs(workspace.Enemies:GetChildren()) do
                    if boss:FindFirstChild("HumanoidRootPart") and boss:FindFirstChild("Humanoid") and boss.Humanoid.Health > 0 then
                        if table.find(BossList, boss.Name) then
                            local dist = (hrp.Position - boss.HumanoidRootPart.Position).Magnitude
                            if dist < nearestDist then
                                nearestBoss = boss
                                nearestDist = dist
                            end
                        end
                    end
                end

                if nearestBoss and nearestBoss:FindFirstChild("HumanoidRootPart") then
                    local bossHRP = nearestBoss.HumanoidRootPart
                    local humanoid = nearestBoss.Humanoid

                    repeat
                        task.wait(0.1)
                        if not _G.AutoFarmAllBoss then break end

                        local targetCFrame = bossHRP.CFrame * CFrame.new(0, 5, 0)
                        if (hrp.Position - targetCFrame.Position).Magnitude > 100 then
                            player.Character:PivotTo(targetCFrame)
                        else
                            _tp(targetCFrame)
                        end

                        if Attack and typeof(Attack.Kill) == "function" then
                            Attack.Kill(nearestBoss, true)
                        end
                    until not nearestBoss.Parent or humanoid.Health <= 0 or not _G.AutoFarmAllBoss
                end
            end)
        end
    end
end)

local posMastery = {"Cake","Bone"}
Mastery_Config = Tabs.Main:AddDropdown({
Name = "Choose Island",
		Description = "เลือกเกาะที่จะฟาร์ม",
		Options = posMastery,
		Default = Bone,
		Callback = function(Value)
  SelectIsland = Value
end})
MasteryFruits = Tabs.Main:AddToggle({
Name = "Auto Mastery Fruits", 
Description = "ฟามผล", 
Default = false,
Callback = function(Value)
  _G.FarmMastery_Dev = Value
end})
spawn(function()RunSer.RenderStepped:Connect(function() pcall(function()if _G.FarmMastery_Dev or _G.FarmMastery_G or _G.FarmMastery_S then for a,b in pairs(plr.PlayerGui.Notifications:GetChildren())do if b.Name=="NotificationTemplate"then if string.find(b.Text,"Skill locked!")then b:Destroy()end end end end end)end) end)
spawn(function()
  while wait(Sec) do
    if _G.FarmMastery_Dev then
      pcall(function()
        if SelectIsland == "Cake" then         
          local v = GetConnectionEnemies(mastery1)
		  if v then		   
		    HealthM = v.Humanoid.MaxHealth * 70 / 100
		    repeat wait()
		      MousePos = v.HumanoidRootPart.Position
		      Attack.Mas(v,_G.FarmMastery_Dev)
		    until _G.FarmMastery_Dev == false or v.Humanoid.Health <= 0 or not v.Parent         		         		        
		  else
		    _tp(CFrame.new(-1943.676513671875, 251.5095672607422, -12337.880859375)) 
		  end
		elseif SelectIsland == "Bone" then
          local v = GetConnectionEnemies(mastery2)
		  if v then		
		    HealthM = v.Humanoid.MaxHealth * 70 / 100
		    repeat wait()
		      MousePos = v.HumanoidRootPart.Position
		      Attack.Mas(v,_G.FarmMastery_Dev)
		    until _G.FarmMastery_Dev == false or v.Humanoid.Health <= 0 or not v.Parent		        
		  else
		    _tp(CFrame.new(-9495.6806640625, 453.58624267578125, 5977.3486328125)) 		    
		  end
        end
      end)
    end
  end
end)
MasteryGun = Tabs.Main:AddToggle({
Name = "Auto Mastery Gun", 
Description = "ฟามปืน", 
Default = false,
Callback = function(Value)
  _G.FarmMastery_G = Value
end})
spawn(function()
  while wait(Sec) do
    if _G.FarmMastery_G then
      pcall(function()
        if SelectIsland == "Cake" then
          local v = GetConnectionEnemies(mastery1)
		  if v then		      
		    HealthM = v.Humanoid.MaxHealth * 70 / 100
		    repeat wait()
		      MousePos = v.HumanoidRootPart.Position
		      Attack.Masgun(v,_G.FarmMastery_G)
		      local Modules = replicated:FindFirstChild("Modules")
              local Net = Modules:FindFirstChild("Net")
              local RE_ShootGunEvent = Net:FindFirstChild("RE/ShootGunEvent")    
              if plr.Character:FindFirstChildOfClass("Tool").ToolTip ~= "Gun" then return end
              if plr.Character:FindFirstChildOfClass("Tool") and plr.Character:FindFirstChildOfClass("Tool").Name == 'Skull Guitar' then
                SoulGuitar = true
		        plr.Character:FindFirstChildOfClass("Tool").RemoteEvent:FireServer("TAP", MousePos)
		        if _G.FarmMastery_G then
		          vim1:SendMouseButtonEvent(0, 0, 0, true, game, 1);wait(0.05)
                  vim1:SendMouseButtonEvent(0, 0, 0, false, game, 1);wait(0.05)
                end
		      elseif plr.Character:FindFirstChildOfClass("Tool") and plr.Character:FindFirstChildOfClass("Tool").Name ~= 'Skull Guitar' then
		        SoulGuitar = false
		        RE_ShootGunEvent:FireServer(MousePos, { v.HumanoidRootPart })
		        if _G.FarmMastery_G then
		          vim1:SendMouseButtonEvent(0, 0, 0, true, game, 1);wait(0.05)
                  vim1:SendMouseButtonEvent(0, 0, 0, false, game, 1);wait(0.05)
                end
		      end		            		
		    until _G.FarmMastery_G == false or v.Humanoid.Health <= 0 or not v.Parent    
		    SoulGuitar = false     		         		        
		  else
		    _tp(CFrame.new(-1943.676513671875, 251.5095672607422, -12337.880859375)) 		    
	  	  end
		elseif SelectIsland == "Bone" then
          local v = GetConnectionEnemies(mastery2)
		  if v then		      
		    HealthM = v.Humanoid.MaxHealth * 70 / 100
		    repeat wait()
		      MousePos = v.HumanoidRootPart.Position
		      Attack.Masgun(v,_G.FarmMastery_G)
		      local Modules = replicated:FindFirstChild("Modules")
              local Net = Modules:FindFirstChild("Net")
              local RE_ShootGunEvent = Net:FindFirstChild("RE/ShootGunEvent")    
              if plr.Character:FindFirstChildOfClass("Tool").ToolTip ~= "Gun" then return end
              if plr.Character:FindFirstChildOfClass("Tool") and plr.Character:FindFirstChildOfClass("Tool").Name == 'Skull Guitar' then
                SoulGuitar = true
		        plr.Character:FindFirstChildOfClass("Tool").RemoteEvent:FireServer("TAP", MousePos)
		        if _G.FarmMastery_G then
		          vim1:SendMouseButtonEvent(0, 0, 0, true, game, 1);wait(0.05)
                  vim1:SendMouseButtonEvent(0, 0, 0, false, game, 1);wait(0.05)
                end
		      elseif plr.Character:FindFirstChildOfClass("Tool") and plr.Character:FindFirstChildOfClass("Tool").Name ~= 'Skull Guitar' then
		        SoulGuitar = false
		        RE_ShootGunEvent:FireServer(MousePos, { v.HumanoidRootPart })
		        if _G.FarmMastery_G then
		          vim1:SendMouseButtonEvent(0, 0, 0, true, game, 1);wait(0.05)
                  vim1:SendMouseButtonEvent(0, 0, 0, false, game, 1);wait(0.05)
                end
		      end		            		
		    until _G.FarmMastery_G == false or v.Humanoid.Health <= 0 or not v.Parent    
		    SoulGuitar = false     		         		        
		  else
		    _tp(CFrame.new(-9495.6806640625, 453.58624267578125, 5977.3486328125)) 
	  	  end
        end
      end)
    end
  end
end)
MasterySword = Tabs.Main:AddToggle({
Name = "Auto Mastery All Sword", 
Description = "ฟามดาบทั้งหมด", 
Default = false,
Callback = function(Value)
  _G.FarmMastery_S = Value
end})
spawn(function()
  while wait(Sec) do
    pcall(function()
      if _G.FarmMastery_S then
        if SelectIsland == "Cake" then
          for _, v in next, replicated.Remotes.CommF_:InvokeServer("getInventory") do          
            if type(v) == "table" then
              if v.Type == "Sword" then
                SwordName = v.Name
                if tonumber(v.Mastery) >= 1 or tonumber(v.Mastery) <= 599 then
                  local v = GetConnectionEnemies(mastery1)
                  if GetBP(SwordName) then                    
		            if v then
                      repeat wait() Attack.Sword(v,_G.FarmMastery_S) until _G.FarmMastery_S == false or not v.Parent or v.Humanoid.Health <= 0		                  
		            else
		              _tp(CFrame.new(-1943.676513671875, 251.5095672607422, -12337.880859375)) 
		            end                    
                  else
                    replicated.Remotes.CommF_:InvokeServer("LoadItem",SwordName)   
                  end   
              elseif tonumber(v.Mastery) >= 600 then
                if GetBP(SwordName) then return nil else replicated.Remotes.CommF_:InvokeServer("LoadItem",SwordName) end       
              end
                break
              end
            end         
          end
        elseif SelectIsland == "Bone" then
          for _, v in next, replicated.Remotes.CommF_:InvokeServer("getInventory") do          
            if type(v) == "table" then
              if v.Type == "Sword" then
                SwordName = v.Name
                if tonumber(v.Mastery) >= 1 or tonumber(v.Mastery) <= 599 then
                  local v = GetConnectionEnemies(mastery2)
                  if GetBP(SwordName) then                    
		            if v then
                      repeat wait() Attack.Sword(v,_G.FarmMastery_S) until _G.FarmMastery_S == false or not v.Parent or v.Humanoid.Health <= 0		                  
		            else
		              _tp(CFrame.new(-9495.6806640625, 453.58624267578125, 5977.3486328125)) 
		            end                    
                  else
                    replicated.Remotes.CommF_:InvokeServer("LoadItem",SwordName)   
                  end   
                elseif tonumber(v.Mastery) >= 600 then
                  if GetBP(SwordName) then return nil else replicated.Remotes.CommF_:InvokeServer("LoadItem",SwordName) end       
                end
                break
              end
            end         
          end
        end
      end
    end)
  end
end)







Initialize = Tabs.Settings:AddToggle({
Name = "Fast Attack", 
Description = "ตีเร็ว", 
Default = true,
Callback = function(Value)
  _G.Seriality = Value
end})

    if v:FindFirstChild("Humanoid") and v:FindFirstChild("HumanoidRootPart") and v.Humanoid.Health > 0 then
      if v.Name == EnemyName then repeat wait() Attack.Kill(v,getgenv().AutoMaterial) until not getgenv().AutoMaterial or not v.Parent or v.Humanoid.Health <= 0 end
    end
  end
  local function handleEnemySpawns()
    for _, v in pairs(game:GetService("Workspace")["_WorldOrigin"].EnemySpawns:GetChildren()) do
      for _, EnemyName in ipairs(MMon) do
        if string.find(v.Name, EnemyName) then
          if (game.Players.LocalPlayer.Character.HumanoidRootPart.Position - v.Position).Magnitude >= 10 then
            _tp(v.CFrame * Pos)
          end
        end
      end
    end
  end
  while wait() do
    if getgenv().AutoMaterial then
      pcall(function()
        if getgenv().SelectMaterial then MaterialMon(getgenv().SelectMaterial) _tp(MPos) end
        for _, EnemyName in ipairs(MMon) do
          for _, v in pairs(workspace.Enemies:GetChildren()) do processEnemy(v, EnemyName) end
        end
        handleEnemySpawns()
      end)
    end
  end
end)



		BossDropdown = Tabs.Main:AddDropdown({
		Name = "Select Boss",
		Description = "เลือกบอส",
		Options = BossList,
		Callback = function(value)
			_G.FindBoss = value
		end
		})

    Name = "Auto Farm Boss",
    Description = "ฟาร์มบอสเอง",
    Default = false,
    Callback = function(value)
        _G.FarmBoss = value
        spawn(function()
            while wait(Sec) do
                if _G.FarmBoss then
                    pcall(function()
                        local HasQuest = QuestBeta()[2] ~= nil and QuestBeta()[3] ~= nil
                        local QuestTitle = plr.PlayerGui.Main.Quest.Container.QuestTitle.Title.Text

                       
                        if _G.AcceptQuestBoss and HasQuest then
                            if not string.find(QuestTitle, QuestBeta()[0]) then
                                replicated.Remotes.CommF_:InvokeServer("AbandonQuest")
                            end

                            if plr.PlayerGui.Main.Quest.Visible == false then
                                _tp(QuestBeta()[5])
                                if (Root.Position - QuestBeta()[5].Position).Magnitude <= 5 then
                                    replicated.Remotes.CommF_:InvokeServer("StartQuest", QuestBeta()[3], QuestBeta()[2])
                                end
                            elseif plr.PlayerGui.Main.Quest.Visible == true then
                                if workspace.Enemies:FindFirstChild(QuestBeta()[1]) then
                                    for i, v in pairs(workspace.Enemies:GetChildren()) do
                                        if Attack.Alive(v) and v.Name == QuestBeta()[1] then
                                            if string.find(QuestTitle, QuestBeta()[0]) then
                                                repeat
                                                    wait()
                                                    Attack.Kill(v, _G.FarmBoss)
                                                until not _G.FarmBoss or v.Humanoid.Health <= 0 or not v.Parent or plr.PlayerGui.Main.Quest.Visible == false
                                            else
                                                replicated.Remotes.CommF_:InvokeServer("AbandonQuest")
                                            end
                                        end
                                    end
                                else
                                    _tp(QuestBeta()[4])
                                    if replicated:FindFirstChild(QuestBeta()[1]) then
                                        _tp(replicated:FindFirstChild(QuestBeta()[1]).HumanoidRootPart.CFrame * CFrame.new(0, 30, 0))
                                    end
                                end
                            end
                        else
                           
                            if workspace.Enemies:FindFirstChild(QuestBeta()[1]) then
                                for i, v in pairs(workspace.Enemies:GetChildren()) do
                                    if Attack.Alive(v) and v.Name == QuestBeta()[1] then
                                        repeat
                                            wait()
                                            Attack.Kill(v, _G.FarmBoss)
                                        until not _G.FarmBoss or v.Humanoid.Health <= 0 or not v.Parent
                                    end
                                end
                            else
                                _tp(QuestBeta()[4])
                                if replicated:FindFirstChild(QuestBeta()[1]) then
                                    _tp(replicated:FindFirstChild(QuestBeta()[1]).HumanoidRootPart.CFrame * CFrame.new(0, 30, 0))
                                end
                            end
                        end
                    end)
                end
            end
        end)
    end

Description = "ทำฮาคิรุ้ง", 
Default = false,
Callback = function(Value)
  _G.Auto_Rainbow_Haki = Value
end})
spawn(function()
  pcall(function()
    while wait(Sec) do
      if _G.Auto_Rainbow_Haki then
        if plr.PlayerGui.Main.Quest.Visible == false then
          if _G.GetQFast then
            if plr.PlayerGui.Main.Quest.Visible == false then replicated.Remotes.CommF_:InvokeServer("HornedMan","Bet") end     
          else
            Rainbow1 = CFrame.new(-11892.0703125, 930.57672119141, -8760.1591796875)
            if (plr.Character.HumanoidRootPart.CFrame ~= Rainbow1) then
              _tp(Rainbow1)
            elseif (plr.Character.HumanoidRootPart.CFrame == Rainbow1) then
              wait(1)
              replicated.Remotes.CommF_:InvokeServer("HornedMan","Bet")
            end
          end
          elseif plr.PlayerGui.Main.Quest.Visible == true and string.find(plr.PlayerGui.Main.Quest.Container.QuestTitle.Title.Text, "Stone") then
            local v = GetConnectionEnemies("Stone")
            if v then
              repeat wait() Attack.Kill(v,_G.Auto_Rainbow_Haki) until _G.Auto_Rainbow_Haki == false or v.Humanoid.Health <= 0 or not v.Parent or plr.PlayerGui.Main.Quest.Visible == false
            else
              _tp(CFrame.new(-1086.11621, 38.8425903, 6768.71436, 0.0231462717, -0.592676699, 0.805107772, 2.03251839e-05, 0.805323839, 0.592835128, -0.999732077, -0.0137055516, 0.0186523199))
            end
          elseif plr.PlayerGui.Main.Quest.Visible == true and string.find(plr.PlayerGui.Main.Quest.Container.QuestTitle.Title.Text, "Hydra Leader") then
            local v = GetConnectionEnemies("Hydra Leader")
            if v then
              repeat task.wait()Attack.Kill(v,_G.Auto_Rainbow_Haki) until _G.Auto_Rainbow_Haki == false or v.Humanoid.Health <= 0 or not v.Parent or plr.PlayerGui.Main.Quest.Visible == false
            else
              replicated.Remotes.CommF_:InvokeServer("requestEntrance",Vector3.new(5643.45263671875, 1013.0858154296875, -340.51025390625))
              local framelong1 = Vector3.new(5643.45263671875, 1013.0858154296875, -340.51025390625)
              local framelong2 = CFrame.new(5821.89794921875, 1019.0950927734375, -73.71923065185547)
              if (plr.Character.HumanoidRootPart.CFrame.Position == framelong1) then _tp(framelong2)end
            end
          elseif plr.PlayerGui.Main.Quest.Visible == true and string.find(plr.PlayerGui.Main.Quest.Container.QuestTitle.Title.Text, "Kilo Admiral") then
            local v = GetConnectionEnemies("Kilo Admiral")
            if v then
              repeat task.wait()Attack.Kill(v,_G.Auto_Rainbow_Haki) until _G.Auto_Rainbow_Haki == false or v.Humanoid.Health <= 0 or not v.Parent or plr.PlayerGui.Main.Quest.Visible == false
            else
              _tp(CFrame.new(2877.61743, 423.558685, -7207.31006, -0.989591599, -0, -0.143904909, -0, 1.00000012, -0, 0.143904924, 0, -0.989591479))
            end
            elseif plr.PlayerGui.Main.Quest.Visible == true and string.find(plr.PlayerGui.Main.Quest.Container.QuestTitle.Title.Text, "Captain Elephant") then
              local v = GetConnectionEnemies("Captain Elephant")
              if v then
                repeat task.wait() Attack.Kill(v,_G.Auto_Rainbow_Haki)until _G.Auto_Rainbow_Haki == false or v.Humanoid.Health <= 0 or not v.Parent or plr.PlayerGui.Main.Quest.Visible == false
              else
              local gamergayror1 = Vector3.new(-12471.169921875, 374.94024658203, -7551.677734375)
              local gamergayror2 = CFrame.new(-13376.7578125, 433.28689575195, -8071.392578125)
              if (plr.Character.HumanoidRootPart.CFrame.Position ~= gamergayror1) then
                replicated.Remotes.CommF_:InvokeServer("requestEntrance",Vector3.new(-12471.169921875, 374.94024658203, -7551.677734375))
              elseif (plr.Character.HumanoidRootPart.CFrame.Position == gamergayror1) then
                _tp(gamergayror2)
              end
            end
        elseif plr.PlayerGui.Main.Quest.Visible == true and string.find(plr.PlayerGui.Main.Quest.Container.QuestTitle.Title.Text, "Beautiful Pirate") then
          local v = GetConnectionEnemies("Captain Elephant")
          if v then
            repeat task.wait() Attack.Kill(v,_G.Auto_Rainbow_Haki) until _G.Auto_Rainbow_Haki == false or v.Humanoid.Health <= 0 or not v.Parent or plr.PlayerGui.Main.Quest.Visible == false
          else
            replicated.Remotes.CommF_:InvokeServer("requestEntrance",Vector3.new(5314.54638671875, 22.562219619750977, -127.06755065917969))
          end
        end                  
      end
    end    
  end)
end)
Q = Tabs.Quests:AddToggle({
Name = "Accept Rainbow Quest Faster", 
Description = "กดทีเดียวไปทำเควสเลย", 
Default = false,
Callback = function(Value)
  _G.GetQFast = Value
end})

Q = Tabs.Quests:AddToggle({
Name = "Auto Farm Observation", 
Description = "ฟามฮาคิสังเกต", 
Default = false,
Callback = function(Value)
  _G.obsFarm = Value
end})
spawn(function()
  while wait(.2) do
    pcall(function()
      if _G.obsFarm then        
        replicated.Remotes.CommE:FireServer("Ken",true)
        if plr:GetAttribute("KenDodgesLeft") == 0 then
          KenTest = false
        elseif plr:GetAttribute("KenDodgesLeft") > 0 then
          replicated.Remotes.CommE:FireServer("Ken",true)
          KenTest = true
        end        
      end
    end)
  end
end)    
spawn(function()      
  while wait(.2) do
    pcall(function()
      if _G.obsFarm then
        if World1 then
          if workspace.Enemies:FindFirstChild("Galley Captain") then
            if KenTest then
              repeat wait()
                plr.Character.HumanoidRootPart.CFrame = workspace.Enemies:FindFirstChild("Galley Captain").HumanoidRootPart.CFrame * CFrame.new(3,0,0)
              until _G.obsFarm == false or KenTest == false
            else
              repeat wait()
                plr.Character.HumanoidRootPart.CFrame = workspace.Enemies:FindFirstChild("Galley Captain").HumanoidRootPart.CFrame * CFrame.new(0,50,0)
              until _G.obsFarm == false or KenTest
            end
          else
            _tp(CFrame.new(5533.29785, 88.1079102, 4852.3916))
          end
        elseif World2 then
          if workspace.Enemies:FindFirstChild("Lava Pirate") then
            if KenTest then
              repeat wait()
                plr.Character.HumanoidRootPart.CFrame = workspace.Enemies:FindFirstChild("Lava Pirate").HumanoidRootPart.CFrame * CFrame.new(3,0,0)
              until _G.obsFarm == false or KenTest == false
            else
              repeat wait()
                plr.Character.HumanoidRootPart.CFrame = workspace.Enemies:FindFirstChild("Lava Pirate").HumanoidRootPart.CFrame * CFrame.new(0,50,0)
              until _G.obsFarm == false or KenTest
            end
          else
            _tp(CFrame.new(-5478.39209, 15.9775667, -5246.9126))
          end
        elseif World3 then
          if workspace.Enemies:FindFirstChild("Venomous Assailant") then
            if KenTest then
              repeat wait()
                _tp(workspace.Enemies:FindFirstChild("Venomous Assailant").HumanoidRootPart.CFrame * CFrame.new(3,0,0))
              until _G.obsFarm == false or KenTest == false
            else
              repeat wait()
                _tp(workspace.Enemies:FindFirstChild("Venomous Assailant").HumanoidRootPart.CFrame * CFrame.new(0,50,0))
              until _G.obsFarm == false or KenTest
            end
          else
            _tp(CFrame.new(4530.3540039063, 656.75695800781, -131.60952758789))
          end
        end        
      end
    end)
  end
end)
Q = Tabs.Quests:AddToggle({
Name = "Auto Observation V2", 
Description = "ฟามฮาคิสังเกตวี2", 
Default = false,
Callback = function(Value)
  _G.AutoKenVTWO = Value
end})
spawn(function()
  while wait(Sec) do
    if _G.AutoKenVTWO then
      pcall(function()
      local Kv2Pos1 = CFrame.new(-12444.78515625, 332.40396118164, -7673.1806640625)
      local Kv2Pos2 = "Kuy"
      local Kv2Pos3 = CFrame.new(-10920.125, 624.20275878906, -10266.995117188)
      local Kv2Pos4 = CFrame.new(-13277.568359375, 370.34185791016, -7821.1572265625)
      local Kv2Pos5 = CFrame.new(-13493.12890625, 318.89553833008, -8373.7919921875)
	  if plr.PlayerGui.Main.Quest.Visible == true and string.find(plr.PlayerGui.Main.Quest.Container.QuestTitle.Title.Text,"Defeat 50 Forest Pirates") then
	    local v = GetConnectionEnemies("Forest Pirate")
        if v then
	      repeat wait() Attack.Kill(v,_G.AutoKenVTWO) until not _G.AutoKenVTWO or v.Humanoid.Health <= 0 or plr.PlayerGui.Main.Quest.Visible == false
	    else
	      _tp(Kv2Pos4)
	    end
	  elseif plr.PlayerGui.Main.Quest.Visible == true then 
	    local v = GetConnectionEnemies("Captain Elephant")
	    if v then
          repeat wait() Attack.Kill(v,_G.AutoKenVTWO) until not _G.AutoKenVTWO or v.Humanoid.Health <= 0 or plr.PlayerGui.Main.Quest.Visible == false
	    else
	      _tp(Kv2Pos5)
	    end
	  elseif plr.PlayerGui.Main.Quest.Visible == false then
	    replicated.Remotes.CommF_:InvokeServer("CitizenQuestProgress","Citizen") wait(.1)
	    replicated.Remotes.CommF_:InvokeServer("StartQuest","CitizenQuest",1)
	  end
	  if replicated.Remotes.CommF_:InvokeServer("CitizenQuestProgress","Citizen") == 2 then
	    _tp(CFrame.new(-12513.51953125, 340.1137390136719, -9873.048828125))
	  end
	  if not plr.Backpack:FindFirstChild("Fruit Bowl") or not plr.Character:FindFirstChild("Fruit Bowl") then
	  if not GetBP("Fruit Bowl") then   	    
	    if not GetBP("Apple") then
	      replicated.Remotes.CommF_:InvokeServer("requestEntrance",Vector3.new(-12471.169921875, 374.94024658203, -7551.677734375))
	      for i,v in pairs(workspace:GetDescendants()) do
	        if v.Name == "Apple" then
	          v.Handle.CFrame = plr.Character.HumanoidRootPart.CFrame * CFrame.new(0,1,10) wait()
		      firetouchinterest(plr.Character.HumanoidRootPart,v.Handle,0) wait()		    
	        end
	      end
	    elseif not GetBP("Banana") then
	      _tp(CFrame.new(2286.0078125,73.13391876220703,-7159.80908203125))
	      for i,v in pairs(workspace:GetDescendants()) do
	        if v.Name == "Banana" then
	          v.Handle.CFrame = plr.Character.HumanoidRootPart.CFrame * CFrame.new(0,1,10) wait()
		      firetouchinterest(plr.Character.HumanoidRootPart,v.Handle,0) wait()		    
	        end
	      end	    
	    elseif not GetBP("Pineapple") then
	      _tp(CFrame.new(-712.8272705078125,98.5770492553711,5711.9541015625))
	      for i,v in pairs(workspace:GetDescendants()) do
	        if v.Name == "Pineapple" then
	          v.Handle.CFrame = plr.Character.HumanoidRootPart.CFrame * CFrame.new(0,1,10) wait()
		      firetouchinterest(plr.Character.HumanoidRootPart,v.Handle,0) wait()		    
	        end
	      end	    
	    end	  
	  end  	    	    
	    if plr.Backpack:FindFirstChild("Banana") and plr.Backpack:FindFirstChild("Apple") and plr.Backpack:FindFirstChild("Pineapple") or plr:FindFirstChild("Banana") and plr:FindFirstChild("Apple") and plr:FindFirstChild("Pineapple") then
	      repeat wait() _tp(Kv2Pos1) until _G.AutoKenVTWO or plr.Character.HumanoidRootPart.CFrame == Kv2Pos1
		  replicated.Remotes.CommF_:InvokeServer("CitizenQuestProgress","Citizen")	    			 
	    end
	      if plr.Backpack:FindFirstChild("Fruit Bowl") or plr.Character:FindFirstChild("Fruit Bowl") then
	        if plr.Character.HumanoidRootPart.CFrame ~= Kv2Pos3 then _tp(Kv2Pos3)
		    elseif plr.Character.HumanoidRootPart.CFrame == Kv2Pos3 then
		      replicated.Remotes.CommF_:InvokeServer("KenTalk2","Start") wait(.1)
		      replicated.Remotes.CommF_:InvokeServer("KenTalk2","Buy")
	        end			 		    
	      end
	    end
      end)
    end
  end
end)



Bartilo = Tabs.Quests:AddToggle({
Name = "Auto Done Bartilo Quest", 
Description = "ทำเควาบาโทโรมิโอ750", 
Default = false,
Callback = function(Value)
  _G.Bartilo_Quest = Value
end})
spawn(function()
  while wait(.1) do    
    pcall(function()
      if _G.Bartilo_Quest and Lv >= 850 then
      local Qbart = plr.PlayerGui.Main.Quest
        if replicated.Remotes.CommF_:InvokeServer("BartiloQuestProgress","Bartilo") == 0 then
          _G.Level = false
          if Qbart.Visible == true then
            local v = GetConnectionEnemies("Swan Pirate")
            if v then
              local x = GetConnectionEnemies(BartMon)
              if x then
                repeat task.wait()
                  if not string.find(plr.PlayerGui.Main.Quest.Container.QuestTitle.Title.Text, "Swan Pirate")then replicated.Remotes.CommF_:InvokeServer("AbandonQuest")
                  else Attack.Kill(x,_G.Bartilo_Quest)end
                until _G.Bartilo_Quest == false or not x.Parent or x.Humanoid.Health <= 0 or Qbart.Visible == false or not x:FindFirstChild("HumanoidRootPart")                  
              end
            else
              _tp(CFrame.nee(970.369446, 142.653198, 1217.3667, 0.162079468, -4.85452638e-08, -0.986777723, 1.03357589e-08, 1, -4.74980872e-08, 0.986777723, -2.50063148e-09, 0.162079468))
            end
          else
            repeat wait() 
              _tp(CFrame.new(-461.533203, 72.3478546, 300.311096, 0.050853312, -0, -0.998706102, 0, 1, -0, 0.998706102, 0, 0.050853312))
            until (CFrame.new(-461.533203, 72.3478546, 300.311096, 0.050853312, -0, -0.998706102, 0, 1, -0, 0.998706102, 0, 0.050853312).Position - plr.Character.HumanoidRootPart.Position).Magnitude <= 20 or _G.Bartilo_Quest == false
            if (CFrame.new(-461.533203, 72.3478546, 300.311096, 0.050853312, -0, -0.998706102, 0, 1, -0, 0.998706102, 0, 0.050853312).Position - plr.Character.HumanoidRootPart.Position).Magnitude <= 1 then
              replicated.Remotes.CommF_:InvokeServer("StartQuest", "BartiloQuest",1)
            end
          end
          elseif replicated.Remotes.CommF_:InvokeServer("BartiloQuestProgress","Bartilo") == 1 then
            _G.Level = false
            local je = GetConnectionEnemies("Jeremy")
            if je then
              repeat task.wait() Attack.Kill(je,_G.Bartilo_Quest) until _G.Bartilo_Quest == false or not je.Parent or je.Humanoid.Health <= 0 or Qbart.Visible == false or not je:FindFirstChild("HumanoidRootPart")                  
            else
              _tp(CFrame.new(2158.97412, 449.056244, 705.411682, -0.754199564, -4.17389057e-09, -0.656645238, -4.47752875e-08, 1, 4.50709301e-08, 0.656645238, 6.3393955e-08, -0.754199564))
            end
          elseif replicated.Remotes.CommF_:InvokeServer("BartiloQuestProgress","Bartilo") == 2 then
          repeat wait() _tp(CFrame.new(-1830.83972, 10.5578213, 1680.60229, 0.979988456, -2.02152783e-08, -0.199054286, 2.20792113e-08, 1, 7.1442483e-09, 0.199054286, -1.13962431e-08, 0.979988456))until (CFrame.new(-1830.83972, 10.5578213, 1680.60229, 0.979988456, -2.02152783e-08, -0.199054286, 2.20792113e-08, 1, 7.1442483e-09, 0.199054286, -1.13962431e-08, 0.979988456).Position - plr.Character.HumanoidRootPart.Position).Magnitude <= 1 or _G.Bartilo_Quest == false
          wait(0.5)
          plr.Character.HumanoidRootPart.CFrame = workspace.Map.Dressrosa.BartiloPlates.Plate1.CFrame
          wait(0.5)
          plr.Character.HumanoidRootPart.CFrame = workspace.Map.Dressrosa.BartiloPlates.Plate2.CFrame
          wait(0.5)
          plr.Character.HumanoidRootPart.CFrame = workspace.Map.Dressrosa.BartiloPlates.Plate3.CFrame
          wait(0.5)
          plr.Character.HumanoidRootPart.CFrame = workspace.Map.Dressrosa.BartiloPlates.Plate4.CFrame
          wait(0.5)
          plr.Character.HumanoidRootPart.CFrame = workspace.Map.Dressrosa.BartiloPlates.Plate5.CFrame
          wait(0.5)
          plr.Character.HumanoidRootPart.CFrame = workspace.Map.Dressrosa.BartiloPlates.Plate6.CFrame
          wait(0.5)
          plr.Character.HumanoidRootPart.CFrame = workspace.Map.Dressrosa.BartiloPlates.Plate7.CFrame
          wait(0.5)
          plr.Character.HumanoidRootPart.CFrame = workspace.Map.Dressrosa.BartiloPlates.Plate8.CFrame
          wait(2.5)
        end
      end
    end)
  end
end)
Name = "Auto Done Citizen Quest", 
Description = "ฟามเควสชาวบ้าน", 
Default = false,
Callback = function(Value)
  _G.CitizenQuest = Value
end})
spawn(function()	
  while wait(Sec) do
    pcall(function()
      if _G.CitizenQuest then
        if Lv >= 1800 and replicated.Remotes.CommF_:InvokeServer("CitizenQuestProgress").KilledBandits == false then
          if string.find(plr.PlayerGui.Main.Quest.Container.QuestTitle.Title.Text, "Forest Pirate") and string.find(plr.PlayerGui.Main.Quest.Container.QuestTitle.Title.Text, "50") and plr.PlayerGui.Main.Quest.Visible == true then
            local v = GetConnectionEnemies("Forest Pirate")
            if v then
              repeat task.wait() Attack.Kill(v,_G.CitizenQuest)until _G.CitizenQuest == false or not v.Parent or v.Humanoid.Health <= 0 or plr.PlayerGui.Main.Quest.Visible == false
            else
              _tp(CFrame.new(-13206.452148438, 425.89199829102, -7964.5537109375))
            end
          else
            _tp(CFrame.new(-12443.8671875, 332.40396118164, -7675.4892578125))
            if (Vector3.new(-12443.8671875, 332.40396118164, -7675.4892578125) - plr.Character.HumanoidRootPart.Position).Magnitude <= 30 then
              wait(1.5) replicated.Remotes.CommF_:InvokeServer("StartQuest","CitizenQuest",1)
            end
          end
        elseif Lv >= 1800 and replicated.Remotes.CommF_:InvokeServer("CitizenQuestProgress").KilledBoss == false then
          local v = GetConnectionEnemies("Captain Elephant")
          if plr.PlayerGui.Main.Quest.Visible and string.find(plr.PlayerGui.Main.Quest.Container.QuestTitle.Title.Text, "Captain Elephant") and plr.PlayerGui.Main.Quest.Visible == true then
            if v then
              repeat task.wait() Attack.Kill(v,_G.CitizenQuest) until _G.CitizenQuest == false or v.Humanoid.Health <= 0 or not v.Parent or plr.PlayerGui.Main.Quest.Visible == false
            else
              _tp(CFrame.new(-13374.889648438, 421.27752685547, -8225.208984375))
            end
          else
            _tp(CFrame.new(-12443.8671875, 332.40396118164, -7675.4892578125))
            if (CFrame.new(-12443.8671875, 332.40396118164, -7675.4892578125).Position - plr.Character.HumanoidRootPart.Position).Magnitude <= 4 then
              wait(1.5)
              replicated.Remotes.CommF_:InvokeServer("CitizenQuestProgress","Citizen")
            end
          end
        elseif Lv >= 1800 and replicated.Remotes.CommF_:InvokeServer("CitizenQuestProgress","Citizen") == 2 then
          _tp(CFrame.new(-12512.138671875, 340.39279174805, -9872.8203125))
        end
      end
    end)
  end
end)
Q = Tabs.Quests:AddToggle({
Name = "Auto Training Dummy", 
Description = "กดทีเดียวไปหาเทรนนิ่งdummy", 
Default = false,
Callback = function(Value)
  _G.DummyMan = Value
end})
spawn(function()
  while wait(Sec) do
    if _G.DummyMan then
      pcall(function()

    end
  end
end)

Q = Tabs.Quests:AddToggle({
Name = "Auto Pole V1", 
Description = "ฟามเสาเทพ", 
Default = false,
Callback = function(Value)
  _G.AutoPole = Value
end})
spawn(function()
  while wait(Sec) do
    if _G.AutoPole then
      pcall(function()
        local v = GetConnectionEnemies("Thunder God")
	    if v then
          repeat task.wait() Attack.Kill(v, _G.AutoPole) until not _G.AutoPole or not v.Parent or v.Humanoid.Health <= 0
        else
          _tp(CFrame.new(-7994.984375, 5761.025390625, -2088.6479492188))
        end
      end)
    end
  end
end)
Q = Tabs.Quests:AddToggle({
Name = "Auto Pole V2 [Beta]", 
Description = "ออโต้เควสเสาเทพอันใหม่", 
Default = false,
Callback = function(Value)
  _G.AutoPoleV2 = Value
end})
spawn(function()
  while wait(Sec) do
    pcall(function()
      if _G.AutoPoleV2 then        
	   if not GetBP("Pole (1st Form)") then replicated.Remotes.CommF_:InvokeServer("LoadItem","Pole (1st Form)") end
	   if not GetBP("Pole (2nd Form)") then replicated.Remotes.CommF_:InvokeServer("LoadItem","Pole (2nd Form)") end      
	   if GetBP("Pole (1st Form)") and GetBP("Pole (1st Form)").Level.Value <= 179 then _G.Level = true elseif GetBP("Pole (1st Form)") and GetBP("Pole (1st Form)").Level.Value >= 180 then _G.Level = false end	   
	   if not GetBP("Rumble Fruit") then return end
	   if GetBP("Rumble Fruit").AwakenedMoves:FindFirstChild("Z") and GetBP("Rumble Fruit").AwakenedMoves:FindFirstChild("X") and GetBP("Rumble Fruit").AwakenedMoves:FindFirstChild("C") and GetBP("Rumble Fruit").AwakenedMoves:FindFirstChild("V") and GetBP("Rumble Fruit").AwakenedMoves:FindFirstChild("F") then
	     _G.SelectChip = nil
		 _G.Raiding = false
		 _G.Auto_Awakener = false
		if plr.Data.Fragments.Value >= 5000 then
          replicated.Remotes.CommF_:InvokeServer("Thunder God", "Talk") wait(Sec)
          replicated.Remotes.CommF_:InvokeServer("Thunder God", "Sure")
        end
        elseif replicated.Remotes.CommF_:InvokeServer("Awakener","Check") == nil or replicated.Remotes.CommF_:InvokeServer("Awakener","Check") == 0 then
          _G.SelectChip = "Rumble"
          local Buying = replicated.Remotes.CommF_:InvokeServer("RaidsNpc","Select",_G.SelectChip)
          if Buying then Buying:Stop() end
          _G.Raiding = true
          _G.Auto_Awakener = true
	    end	   
      end
    end)
  end
end)
Name = "Auto Saw Sword", 
Description = "ออโต้ทำดาบเลื่อย", 
Default = false,
Callback = function(Value)
  _G.AutoSaw = Value
end})
spawn(function()
  while wait(.2) do
    pcall(function()
      if _G.AutoSaw then
        local v = GetConnectionEnemies("The Saw")
        if v then repeat task.wait() Attack.Kill(v, _G.AutoSaw)until _G.AutoSaw == false or v.Humanoid.Health <= 0
        else _tp(CFrame.new(-784.89715576172, 72.427383422852, 1603.5822753906))
        end
      end
    end)
  end
end)

Q = Tabs.Quests:AddToggle({
Name = "Auto Saber Sword", 
Description = "ออโต้ดาบแชงค์", 
Default = false,
Callback = function(Value)
  _G.AutoSaber = Value
end})
spawn(function()
  while wait(.2) do
    pcall(function()
      if _G.AutoSaber and plr.Data.Level.Value >= 200 and not plr.Backpack:FindFirstChild("Saber") and not plr.Character:FindFirstChild("Saber") then
        if workspace.Map.Jungle.Final.Part.Transparency == 0 then
	      if workspace.Map.Jungle.QuestPlates.Door.Transparency == 0 then
		    if (CFrame.new(-1612.55884, 36.9774132, 148.719543, 0.37091279, 3.0717151e-09, -0.928667724, 3.97099491e-08, 1, 1.91679348e-08, 0.928667724, -4.39869794e-08, 0.37091279).Position - plr.Character.HumanoidRootPart.Position).Magnitude <= 100 then
		      _tp(plr.Character.HumanoidRootPart.CFrame)
		      wait(0.5)

Description = "ทำเควสdojo", 
Default = false,
Callback = function(Value)
  _G.Dojoo = Value
end})
function printBeltName(data) if type(data) == "table" and data.Quest["BeltName"] then return data.Quest["BeltName"] end end
spawn(function()
  while wait(Sec) do
    if _G.Dojoo then
      pcall(function()
        local args = {[1] = {["NPC"] = "Dojo Trainer",["Command"] = "RequestQuest"}}        
        local progress = replicated.Modules.Net:FindFirstChild("RF/InteractDragonQuest"):InvokeServer(unpack(args))
        local NameBelt = printBeltName(progress)
        if debug == false and not progress and not NameBelt then
          _tp(CFrame.new(5865.0234375, 1208.3154296875, 871.15185546875))
          debug = true
        elseif debug == true and (CFrame.new(5865.0234375, 1208.3154296875, 871.15185546875).Position - plr.Character.HumanoidRootPart.Position).Magnitude <= 50 then
          if NameBelt == "White" then
            local v = GetConnectionEnemies("Skull Slayer")
            if v then repeat task.wait() Attack.Kill(v, _G.Dojoo) until not progress or not _G.Dojoo or not Attack.Alive(v)
            else _tp(CFrame.new(-16759.58984375, 71.28376770019531, 1595.3399658203125))
            end
          elseif NameBelt == "Yellow" then
            repeat task.wait()
              _G.SeaBeast1 = true
              _G.TerrorShark = true
              _G.Shark = true
              _G.Piranha = true
              _G.MobCrew = true
              _G.FishBoat = true
              _G.SailBoats = true
            until not _G.Dojoo or not progress
            _G.SeaBeast1 = false
            _G.TerrorShark = false
            _G.Shark = false
            _G.Piranha = false
            _G.MobCrew = false
            _G.FishBoat = false
            _G.SailBoats = false               
          elseif NameBelt == "Green" then
            repeat task.wait()
              _G.SailBoats = true
            until not _G.Dojoo or not progress
            _G.SailBoats = false
          elseif NameBelt == "Purple" then
            repeat task.wait()
              _G.FarmEliteHunt = true
            until not _G.Dojoo or not progress
            _G.FarmEliteHunt = false
          elseif NameBelt == "Red" then
            repeat task.wait()
              _G.SailBoats = true
              _G.FishBoat = true
            until not _G.Dojoo or not progress
            _G.SailBoats = false
            _G.FishBoat = false                      
          elseif NameBelt == "Black" then
            repeat task.wait()              
              if workspace.Map:FindFirstChild("PrehistoricIsland") or workspace._WorldOrigin.Locations:FindFirstChild("Prehistoric Island") then    
                _G.Prehis_Find = true                   
                if workspace.Map.PrehistoricIsland.Core.ActivationPrompt:FindFirstChild("ProximityPrompt",true) then
                  _G.Prehis_Skills = false
                  _G.Prehis_Find = true
                else
                  _G.Prehis_Skills = true
                  _G.Prehis_Find = false
                end
              else
                _G.Prehis_Find = true
                _G.Prehis_Skills = false
              end
            until not _G.Dojoo or not progress
            _G.Prehis_Find = false
            _G.Prehis_Skills = false                        
          elseif NameBelt == "Orange" or NameBelt == "Blue" then
            return nil
          end
        end
        if not progress then
          debug = false
          local args = {[1] = {["NPC"] = "Dojo Trainer",["Command"] = "ClaimQuest"}}
          replicated.Modules.Net:FindFirstChild("RF/InteractDragonQuest"):InvokeServer(unpack(args))
        end
      end)
    end
  end
end)
BlazeEM = Tabs.Prehistoric:AddToggle({
Name = "Auto Dragon Hunter", 
Description = "ทำ Dragon Hunter", 
Default = false,
Callback = function(Value)
  _G.FarmBlazeEM = Value
end})
checkQuesta=function()local a={[1]={["Context"]="Check"}}local b=nil;pcall(function()local c={[1]={["Context"]="RequestQuest"}}game:GetService("ReplicatedStorage"):WaitForChild("Modules"):WaitForChild("Net"):WaitForChild("RF/DragonHunter"):InvokeServer(unpack(c))end)local d,e=pcall(function()b=game:GetService("ReplicatedStorage"):WaitForChild("Modules"):WaitForChild("Net"):WaitForChild("RF/DragonHunter"):InvokeServer(unpack(a))end)local f=false;local g;local h;local i;if b then if b.Text then f=true;local j=b.Text;if string.find(tostring(j),"Defeat")then i=1;g=string.sub(tostring(j),8,9)g=tonumber(g)local k={"Hydra Enforcer","Venomous Assailant"}for l,m in pairs(k)do if string.find(j,m)then h=m;break end end elseif string.find(tostring(j),"Destroy")then g=10;i=2;h=nil end end end;return f,h,g,i end
BackTODoJo=function()for a,b in pairs(game:GetService("Players").LocalPlayer.PlayerGui.Notifications:GetChildren())do if b.Name=="NotificationTemplate"then if string.find(b.Text,"Head back to the Dojo to complete more tasks")then return true end end end;return false end
DragonMobClear=function(a,b,c)if workspace.Enemies:FindFirstChild(b)then for d,e in pairs(workspace.Enemies:GetChildren())do if e.Name==b and Attack.Alive(e)then if a then Attack.Kill(e,a)end end end else _tp(c)end end
spawn(function()
  while wait() do 
    if _G.FarmBlazeEM then
      pcall(function()              
        local a,v,h,x = checkQuesta()                  
        if a == true and not BackTODoJo() then
          if x == 1 then
            if v == "Hydra Enforcer" or v == "Venomous Assailant" then            
              repeat wait()
                DragonMobClear(true, v, CFrame.new(4620.61572265625, 1002.2954711914062, 399.0868835449219))
              until not _G.FarmBlazeEM or not a or BackTODoJo()                            
            end      
          elseif x == 2 then
            if workspace.Map.Waterfall.IslandModel:FindFirstChild("Meshes/bambootree", true) then
              repeat wait()                
                spawn(function() _tp(workspace.Map.Waterfall.IslandModel:FindFirstChild("Meshes/bambootree", true).CFrame * CFrame.new(4,0,0)) end)
                if (workspace.Map.Waterfall.IslandModel:FindFirstChild("Meshes/bambootree", true).Position - Root.Position).Magnitude <= 200 then
                MousePos = workspace.Map.Waterfall.IslandModel:FindFirstChild("Meshes/bambootree", true).Position
                Useskills("Melee","Z")
	            Useskills("Melee","X")
	            Useskills("Melee","C")
                wait(.5)
                Useskills("Sword","Z")
                Useskills("Sword","X")
                wait(.5)
                Useskills("Blox Fruit","Z")
                Useskills("Blox Fruit","X")
                Useskills("Blox Fruit","C")
                wait(.5)
                Useskills("Gun","Z")
                Useskills("Gun","X")
                end
              until not _G.FarmBlazeEM or not a or BackTODoJo()
            end
          end
        else
          _tp(CFrame.new(5813, 1208, 884))
          DragonMobClear(false, nil, nil) 
        end
      end)
    end
  end
end)
spawn(function()
  while wait(.1) do 
    if _G.FarmBlazeEM then
      pcall(function()              
        if workspace.EmberTemplate:FindFirstChild("Part") then
          game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = workspace.EmberTemplate.Part.CFrame        
        end
      end)
    end
  end
end)

GetQuestDracoLevel = function()
  local v371 = {[1] = {NPC = "Dragon Wizard",Command = "Upgrade"}};
  return replicated.Modules.Net:FindFirstChild("RF/InteractDragonQuest"):InvokeServer(unpack(v371))
end
Name = "Tween To Upgrade Droco Trial", 
Description = "วาร์ปไปหา Droco Trial", 
Default = false,
Callback = function(Value)
  _G.UPGDrago = Value
end})
spawn(function()
  while wait(Sec) do
    pcall(function()
      if _G.UPGDrago then     
        if GetQuestDracoLevel() == false then
          return nil
        elseif GetQuestDracoLevel() == true then
          if (CFrame.new(5814.42724609375, 1208.3267822265625, 884.5785522460938).Position - Root.Position).Magnitude >= 300 then
            _tp(CFrame.new(5814.42724609375, 1208.3267822265625, 884.5785522460938));
          else
            _tp(CFrame.new(5814.42724609375, 1208.3267822265625, 884.5785522460938));
            local v371 = {[1] = {NPC = "Dragon Wizard",Command = "Upgrade"}};
            replicated.Modules.Net:FindFirstChild("RF/InteractDragonQuest"):InvokeServer(unpack(v371));
          end
        end
      end
    end)
  end
end)
Name = "Auto Drago (V1)", 
Description = "ทำเผ่ามังกรวี1", 
Default = false,
Callback = function(Value)
  _G.DragoV1 = Value
end})
spawn(function()
  while wait(Sec) do
    pcall(function()
      if _G.DragoV1 then     
        if GetM("Dragon Egg") <= 0 then
        repeat wait()
          _G.Prehis_Find = true
          _G.Prehis_Skills = true
          _G.Prehis_DE = true
        until not _G.DragoV1 or GetM("Dragon Egg") >= 1
          _G.Prehis_Find = false
          _G.Prehis_Skills = false
          _G.Prehis_DE = false
        end
      end
    end)
  end
end)
fireflower = Tabs.Prehistoric:AddToggle({
Name = "Auto Drago (V2)", 
Description = "ทำเผ่ามังกรวี2", 
Default = false,
Callback = function(Value)
  _G.AutoFireFlowers = Value
end})
spawn(function()
  while wait(Sec) do
    if _G.AutoFireFlowers then
      local FireFlower = workspace:FindFirstChild("FireFlowers")
      local v = GetConnectionEnemies("Forest Pirate")
      if v then repeat wait() Attack.Kill(v,_G.AutoFireFlowers) until not _G.AutoFireFlowers or not v.Parent or v.Humanoid.Health <= 0 or FireFlower
      else _tp(CFrame.new(-13206.452148438, 425.89199829102, -7964.5537109375))
      end      
      if FireFlower then
        for i, v in pairs(FireFlower:GetChildren()) do
          if (v:IsA("Model") and v.PrimaryPart) then
            local FlowerPos = v.PrimaryPart.Position;
            local playerRoot = game.Players.LocalPlayer.Character.HumanoidRootPart.Position;
            local Magnited = (FlowerPos - playerRoot).Magnitude;
            if (Magnited <= 100) then
              vim1:SendKeyEvent(true, "E", false, game) wait(1.5) vim1:SendKeyEvent(false, "E", false, game)

	    elseif replicated.Remotes.CommF_:InvokeServer("Wenlocktoad","1") == 1 then
	      for i,v in pairs(game.Players:GetChildren()) do
            if v.Name ~= plr.Name and tostring(v.Data.Race.Value) == "Skypiea" then
		      repeat task.wait() _tp(v.HumanoidRootPart.CFrame * CFrame.new(0,8,0) * CFrame.Angles(math.rad(-45),0,0))until v.Humanoid.Health <= 0 or _G.Auto_Skypiea == false
	        end
	      end
        end          
      end
    end)
  end
end)
RaceFish = Tabs.Race:AddToggle({
Name = "Auto Upgrade FishMan", 
Description = "ทำเผ่ามนุษย์ปลาวี2-3", 
Default = false,
Callback = function(Value)
  _G.Auto_Fish = Value
end})
spawn(function()
  while wait(Sec) do
    pcall(function()
      if _G.Auto_Fish then
        if replicated.Remotes.CommF_:InvokeServer("Alchemist","1") ~= -2 then
	      if replicated.Remotes.CommF_:InvokeServer("Alchemist","1") == 0 then
		    replicated.Remotes.CommF_:InvokeServer("Alchemist","2")
		  elseif replicated.Remotes.CommF_:InvokeServer("Alchemist","1") == 1 then
	        if not plr.Backpack:FindFirstChild("Flower 1") and not plr.Character:FindFirstChild("Flower 1") then
		      _tp(workspace.Flower1.CFrame)
	        elseif not plr.Backpack:FindFirstChild("Flower 2") and not plr.Character:FindFirstChild("Flower 2") then
	          _tp(workspace.Flower2.CFrame)
	        elseif not plr.Backpack:FindFirstChild("Flower 3") and not plr.Character:FindFirstChild("Flower 3") then
	          local v = GetConnectionEnemies("Swan Pirate")
		      if v then
			    repeat wait()Attack.Kill(v,_G.Auto_Fish)until plr.Backpack:FindFirstChild("Flower 3") or not v.Parent or v.Humanoid.Health <= 0 or _G.Auto_Fish == false
	          else
		       _tp(CFrame.new(980.0985107421875, 121.331298828125, 1287.2093505859375))
	          end
            end
	      elseif replicated.Remotes.CommF_:InvokeServer("Alchemist","1") == 2 then
            replicated.Remotes.CommF_:InvokeServer("Alchemist","3")
          end
        elseif replicated.Remotes.CommF_:InvokeServer("Wenlocktoad","1") == 0 then
	      replicated.Remotes.CommF_:InvokeServer("Wenlocktoad","2")
	    elseif replicated.Remotes.CommF_:InvokeServer("Wenlocktoad","1") == 1 then
          warn("Sea Beast Soon")
        end
      end
    end)
  end
end)


CheckTier = Tabs.Race:AddParagraph("Tiers V4 Status", "")
spawn(function()
    pcall(function()
        while wait(0.2) do
            CheckTier:SetDesc("Tiers - V4 : " .. " " .. plr.Data.Race.C.Value)
        end
    end)
end)

function GetHRP()
    local char = plr.Character
    return char and char:FindFirstChild("HumanoidRootPart")
end

    Name = "Auto Farm Dungeon",
    Description = "ลงดันเอง",
    Default = false,
    Callback = function(Value)
        _G.AutoFarmDungeon = Value
    end
})

local FARM_RANGE = 5000

spawn(function()
    while task.wait(0.15) do
        if not _G.AutoFarmDungeon then continue end

        pcall(function()
            local plr = game.Players.LocalPlayer
            local char = plr.Character
            local hrp = char and char:FindFirstChild("HumanoidRootPart")
            local hum = char and char:FindFirstChildOfClass("Humanoid")
            if not hrp or not hum or hum.Health <= 0 then return end

            for _, mob in pairs(workspace.Enemies:GetChildren()) do
                if not _G.AutoFarmDungeon then break end

                local mh = mob:FindFirstChild("Humanoid")
                local mhrp = mob:FindFirstChild("HumanoidRootPart")

                if mh and mhrp and mh.Health > 0 then
                    local dist = (mhrp.Position - hrp.Position).Magnitude
                    if dist <= FARM_RANGE then
                        repeat
                            task.wait()
                            Attack.Kill(mob, true)
                        until not _G.AutoFarmDungeon
                            or not mob.Parent
                            or mh.Health <= 0
                    end
                end
            end
        end)

Description = "ทำดาบ Tushita", 
Default = false,
Callback = function(Value)
  _G.Auto_Tushita = Value
end})
spawn(function()
  while wait(Sec) do
    pcall(function()
      if _G.Auto_Tushita then
        if workspace.Map.Turtle:FindFirstChild("TushitaGate") then
          if not GetBP("Holy Torch") then
            _tp(CFrame.new(5148.03613, 162.352493, 910.548218))
            wait(0.7)
          else
            EquipWeapon("Holy Torch")
            task.wait(1)
            repeat task.wait() _tp(CFrame.new(-10752, 417, -9366)) until not _G.Auto_Tushita or (CFrame.new(-10752, 417, -9366).Position - plr.Character.HumanoidRootPart.Position).Magnitude <= 10
            wait(.7)
            repeat task.wait() _tp(CFrame.new(-11672, 334, -9474)) until not _G.Auto_Tushita or (CFrame.new(-11672, 334, -9474).Position - plr.Character.HumanoidRootPart.Position).Magnitude <= 10
            wait(.7)
            repeat task.wait() _tp(CFrame.new(-12132, 521, -10655)) until not _G.Auto_Tushita or (CFrame.new(-12132, 521, -10655).Position - plr.Character.HumanoidRootPart.Position).Magnitude <= 10
            wait(.7)
            repeat task.wait() _tp(CFrame.new(-13336, 486, -6985)) until not _G.Auto_Tushita or (CFrame.new(-13336, 486, -6985).Position - plr.Character.HumanoidRootPart.Position).Magnitude <= 10
            wait(.7)
            repeat task.wait() _tp(CFrame.new(-13489, 332, -7925)) until not _G.Auto_Tushita or (CFrame.new(-13489, 332, -7925).Position - plr.Character.HumanoidRootPart.Position).Magnitude <= 10
          end
        else
          local v = GetConnectionEnemies("Longma")
          if v then repeat task.wait() Attack.Kill(v,_G.Auto_Tushita) until v.Humanoid.Health <= 0 or not _G.Auto_Tushita or not v.Parent
          else 
          if replicated:FindFirstChild("Longma") then _tp(replicated:FindFirstChild("Longma").HumanoidRootPart.CFrame * CFrame.new(0,40,0)) end
          end                     
        end
      end
    end)
  end
end)
Q = Tabs.Quests:AddToggle({
Name = "Auto Yama Sword", 
Description = "ทำดาบ Yama", 
Default = false,
Callback = function(Value)
  _G.Auto_Yama = Value
end})
spawn(function()
  while wait(Sec) do
    pcall(function()
      if _G.Auto_Yama then
	    if replicated.Remotes.CommF_:InvokeServer("EliteHunter", "Progress") < 30 then
	      _G.FarmEliteHunt = true
	    elseif replicated.Remotes.CommF_:InvokeServer("EliteHunter", "Progress") > 30 then
	      _G.FarmEliteHunt = false
	      if (workspace.Map.Waterfall.SealedKatana.Handle.Position-plr.Character.HumanoidRootPart.Position).Magnitude >= 20 then
            _tp(workspace.Map.Waterfall.SealedKatana.Handle.CFrame)
            local zx = GetConnectionEnemies("Ghost")
            if zx then
              repeat wait() Attack.Kill(zx,_G.Auto_Yama) until zx.Humanoid.Health <= 0 or not zx.Parent or not _G.Auto_Yama               
			  fireclickdetector(workspace.Map.Waterfall.SealedKatana.Handle.ClickDetector)
            end
          end
	    end
      end
    end)
  end
end)

CheckSoul = Tabs.Quests:AddParagraph("Skull Guitar Quests", "")
spawn(function()
    while wait(0.2) do
        pcall(function()
            if Quest1 == true then 
                CheckSoul:SetDesc("Quest Number : Quest1")
            elseif Quest2 == true then 
                CheckSoul:SetDesc("Quest Number : Quest2")
            elseif Quest3 == true then 
                CheckSoul:SetDesc("Quest Number : Quest3")
            elseif Quest4 == true then 
                CheckSoul:SetDesc("Quest Number : Quest4")
            elseif GetWP("Skull Guitar") then 
                CheckSoul:SetDesc("Quest Number : Collect!!")
            else 
                CheckSoul:SetDesc("Quest Number : No Quest!!")

  _G.Seriality = Value
end})
Bringmob = Tabs.Settings:AddToggle({
Name = "Bring Mobs", 
Description = "ดึงมอนมาหาเรา", 
Default = true,
Callback = function(Value)
  _B = Value
end})
    Name = "Auto Hop Server with time",
    Default = false,
    Callback = function(Value)
        _G.AutoHopServer = Value
        if not Value then
            _G.HopTimer = nil
        end
    end
})

Spawn(function()
    while Wait(1) do
        if _G.AutoHopServer then
            pcall(function()
                if not _G.HopTimer then
                    _G.HopTimer = tick()
                end

                if tick() - _G.HopTimer >= _G.HopDelay then
                    _G.HopTimer = tick()

                    if syn and syn.queue_on_teleport then
                        syn.queue_on_teleport(
                            "loadstring(game:HttpGet('https://pastefy.app/iiFOhcot/raw'))()"
                        )
                    end

                    game:GetService("TeleportService")
                        :Teleport(game.PlaceId, game.Players.LocalPlayer)
                end
            end)
        end
    end
end)
    Name = "Hop Delay (Minutes)",
    Min = 5,
    Max = 120,
    Default = 30,
    Increment = 1,
    Callback = function(Value)
        _G.HopDelay = Value * 60
    end
})
    Name = "Auto Set Spawn Point",
    Default = false,
    Callback = function(Value)
        getgenv().Set = Value
        if Value then
            pcall(function()
                game:GetService("ReplicatedStorage").Remotes.CommF_:InvokeServer("SetSpawnPoint")
            end)
        end
    end
})
BusuAura = Tabs.Settings:AddToggle({
Name = "Auto Turn on Buso", 
Description = "เปิดฮาคิเอง", 
Default = true,
Callback = function(Value)
  Boud = Value
end})
spawn(function()
  while wait(Sec) do
    pcall(function()
      if Boud then
      local _HasBuso = {"HasBuso","Buso"}
  	  if not plr.Character:FindFirstChild(_HasBuso[1]) then replicated.Remotes.CommF_:InvokeServer(_HasBuso[2]) end
      end
    end)
  end


-- ══════════════════════════════════════════════════════
--  GUI — UiBanana.txt Linoria Pattern (KEPT EXACTLY)
-- ══════════════════════════════════════════════════════
local Library = loadstring(game:HttpGet("https://pastefy.app/kyYdSx0A/raw"))()
assert(Library, "[BananaHub] UI Library load failed!")

local Window = Library:CreateWindow({
    Title    = "🍌 Banana Hub Master",
    Subtitle = "v5.0 | bloxfruit core",
    Image    = "rbxassetid://5009915795",
})

-- ── STATUS ────────────────────────────────────────────
local TabInfo = Window:AddTab("📊 Status")
local InfoL   = TabInfo:AddLeftGroupbox("Info")
local InfoR   = TabInfo:AddRightGroupbox("Player")

local lv="?"; pcall(function() lv=tostring(plr.Data.Level.Value) end)
InfoL:AddLabel("👤 "..plr.Name)
InfoL:AddLabel("⚔️ Level: "..lv)
pcall(function()
    InfoL:AddLabel("🌊 "..SeaName[SeaIndex])
end)
InfoL:AddLabel("✅ Core: bloxfruit.lua verbatim")
InfoL:AddLabel("⌨️ V = Toggle GUI")

InfoR:AddButton({Title="🔄 Refresh Level", Callback=function()
    local l="?"; pcall(function() l=tostring(plr.Data.Level.Value) end)
    Library:Notify({Title="Level",Description="⚔️ Level: "..l,Duration=3})
end})
InfoR:AddButton({Title="📋 Copy JobId", Callback=function()
    if setclipboard then setclipboard(game.JobId) end
    Library:Notify({Title="Copied",Description=game.JobId:sub(1,24).."...",Duration=2})
end})
InfoR:AddButton({Title="🌀 Hop Server", Callback=function()
    spawn(function() Hop() end)
end})
InfoR:AddButton({Title="❌ Abandon Quest", Callback=function()
    replicated.Remotes.CommF_:InvokeServer("AbandonQuest")
    Library:Notify({Title="Quest",Description="Abandoned!",Duration=2})
end})

-- ── FARMING ───────────────────────────────────────────
local TabFarm = Window:AddTab("🌾 Farming")
local FarmL   = TabFarm:AddLeftGroupbox("Farm Core")
local FarmR   = TabFarm:AddRightGroupbox("Options")

FarmL:AddLabel("Weapon:")
FarmL:AddDropdown("SelWeapon",{
    Title="⚔️ Select Weapon",
    Values={"Melee","Sword","Blox Fruit","Gun"},
    Default=_G.SelectWeapon or "Melee",
    Callback=function(v) _G.SelectWeapon=v end,
})
FarmL:AddToggle("AutoFarmLv",{
    Title="🌾 Auto Farm Level",
    Default=false,
    Callback=function(v) _G.Level=v; if not v then alreadyTeleported=false end end,
})
FarmL:AddToggle("AutoFarmNearT",{
    Title="🎯 Auto Farm Nearest",
    Default=false,
    Callback=function(v) _G.AutoFarmNear=v end,
})
FarmL:AddToggle("BringMobT",{
    Title="🧲 Bring Mob",
    Default=true,
    Callback=function(v) _B=v end,
})
FarmL:AddToggle("RandCF",{
    Title="🔀 Random CFrame (multi-pos)",
    Default=false,
    Callback=function(v) RandomCFrame=v end,
})

FarmR:AddToggle("FarmMastG",{
    Title="📈 Farm Mastery (Melee/Fruit)",
    Default=false,
    Callback=function(v) _G.FarmMastery_G=v end,
})
FarmR:AddToggle("FarmMastS",{
    Title="⚔️ Farm Mastery (Sword)",
    Default=false,
    Callback=function(v) _G.FarmMastery_S=v end,
})
FarmR:AddToggle("FastAtkT",{
    Title="⚡ Fast Attack (Seriality)",
    Default=false,
    Callback=function(v) _G.Seriality=v end,
})
FarmR:AddToggle("SafeModeT",{
    Title="🛡️ Safe Mode",
    Default=false,
    Callback=function(v) _G.Safemode=v end,
})

-- ── SKILLS ────────────────────────────────────────────
local TabSkill = Window:AddTab("🎮 Skills")
local SkillL   = TabSkill:AddLeftGroupbox("Auto Use Skills")
local SkillR   = TabSkill:AddRightGroupbox("Manual")

for _,sk in pairs({{"Z","🔵"},{"X","🔴"},{"C","🟢"},{"V","🟡"},{"F","🟣"}}) do
    local key,icon=sk[1],sk[2]
    SkillL:AddToggle("Sk"..key,{
        Title=icon.." Skill "..key,
        Default=false,
        Callback=function(v) Useskills[key]=v end,
    })
end
for _,key in pairs({"Z","X","C","V","F"}) do
    SkillR:AddButton({Title="▶️ "..key,Callback=function()
        VirtualInputManager:SendKeyEvent(true,key,false,game)
        task.wait(0.1)
        VirtualInputManager:SendKeyEvent(false,key,false,game)
    end})
end

-- ── KILL MOB ──────────────────────────────────────────
local TabMob = Window:AddTab("⚔️ Kill Mob")
local MobL   = TabMob:AddLeftGroupbox("Mob")
local MobR   = TabMob:AddRightGroupbox("Boss Select")

MobL:AddToggle("AutoKillMobT",{
    Title="🗡️ Auto Kill Mob (AuraBoss)",
    Default=false,
    Callback=function(v) _G.AuraBoss=v end,
})
MobL:AddToggle("AutoFarmAllBossT",{
    Title="💀 Auto Farm All Boss",
    Default=false,
    Callback=function(v) _G.AutoFarmAllBoss=v end,
})
MobL:AddToggle("FarmBossT",{
    Title="🎯 Farm Boss (Select)",
    Default=false,
    Callback=function(v) _G.FarmBoss=v end,
})
MobL:AddToggle("AcceptQuestBossT",{
    Title="📜 Accept Quest Boss",
    Default=false,
    Callback=function(v) _G.AcceptQuestBoss=v end,
})
MobL:AddButton({Title="📋 List Alive Enemies",Callback=function()
    local names,n={},0
    for _,v in pairs(workspace.Enemies:GetChildren()) do
        if v:FindFirstChild("Humanoid") and v.Humanoid.Health>0 then
            local c=v.Name:gsub(" %pLv. %d+%p","")
            if not table.find(names,c) then table.insert(names,c);n=n+1 end
        end
    end
    Library:Notify({Title=n.." Enemies",Description=table.concat(names,"\n"):sub(1,250),Duration=6})
end})

MobR:AddDropdown("SelBoss",{
    Title="☠️ Select Boss",
    Values={"Darkbeard","rip_indra True Form","Soul Reaper","Dough King","Cake Prince","Tyrant of the Skies","Cursed Captain"},
    Default="Darkbeard",
    Callback=function(v) _G.FindBoss=v end,
})
MobR:AddToggle("HopFindBossT",{
    Title="🌀 Hop Find Boss",
    Default=false,
    Callback=function(v)
        _G.AutoHopServer=v
        if v then spawn(function() Hop() end) end
    end,
})

-- ── BOSS FARM ─────────────────────────────────────────
local TabBoss = Window:AddTab("☠️ Boss Farm")
local BossL   = TabBoss:AddLeftGroupbox("Sea 2 Bosses")
local BossR   = TabBoss:AddRightGroupbox("Sea 3 Bosses")

BossL:AddToggle("AtkDark",{
    Title="🌑 Darkbeard",
    Default=false,
    Callback=function(v) _G.AtkDark_BH=v end,
})
BossL:AddToggle("AtkIndra",{
    Title="⚡ Rip Indra",
    Default=false,
    Callback=function(v) _G.AutoRipIngay=v end,
})
BossL:AddToggle("UnHakiT",{
    Title="✨ Auto Unlock Haki",
    Default=false,
    Callback=function(v) _G.AutoUnHaki=v end,
})

BossR:AddToggle("AtkSoul",{
    Title="💀 Soul Reaper (via Bone)",
    Default=false,
    Callback=function(v) _G.AutoHytHallow=v end,
})
BossR:AddToggle("AtkDough",{
    Title="🍩 Dough King",
    Default=false,
    Callback=function(v) _G.AutoDoughKing=v end,
})
BossR:AddToggle("AtkDoughDirect",{
    Title="⚔️ Attack Dough King Direct",
    Default=false,
    Callback=function(v) _G.AutoAttackDoughKing=v end,
})
BossR:AddToggle("KataT",{
    Title="🎂 Farm Katakuri (Cake Prince)",
    Default=false,
    Callback=function(v) _G.Auto_Cake_Prince=v end,
})
BossR:AddToggle("TyrantT",{
    Title="🦅 Farm Tyrant of the Skies",
    Default=false,
    Callback=function(v) _G.FarmTyrant=v end,
})
BossR:AddToggle("SummonTyrantT",{
    Title="🌀 Summon Tyrant (PhaBinh)",
    Default=false,
    Callback=function(v) _G.FarmPhaBinh=v end,
})

-- ── BONE & MATERIAL ───────────────────────────────────
local TabBone = Window:AddTab("💀 Bone & Mat")
local BoneL   = TabBone:AddLeftGroupbox("Bone Farm")
local BoneR   = TabBone:AddRightGroupbox("Material Farm")

BoneL:AddToggle("FarmBoneT",{
    Title="💀 Auto Farm Bone",
    Default=false,
    Callback=function(v) _G.AutoFarm_Bone=v end,
})
BoneL:AddToggle("AcceptBoneQT",{
    Title="📜 Accept Bone Quest",
    Default=false,
    Callback=function(v) _G.AcceptQuestB=v end,
})
BoneL:AddToggle("AutoSoulReanT",{
    Title="👻 Auto Soul Reaper (Hallow)",
    Default=false,
    Callback=function(v) _G.AutoHytHallow=v end,
})
BoneL:AddToggle("AutoRandBoneT",{
    Title="🎲 Auto Random Bones",
    Default=false,
    Callback=function(v) _G.Auto_Random_Bone=v end,
})
BoneL:AddToggle("TryLuckyT",{
    Title="🍀 Auto Try Luck Gravestone",
    Default=false,
    Callback=function(v) _G.TryLucky=v end,
})
BoneL:AddToggle("PrayT",{
    Title="🙏 Auto Pray Gravestone",
    Default=false,
    Callback=function(v) _G.Praying=v end,
})

BoneR:AddDropdown("SelMaterial",{
    Title="🪨 Select Material",
    Values=MaterialList or {"Scrap Metal"},
    Default=getgenv().SelectMaterial or "Scrap Metal",
    Callback=function(v) getgenv().SelectMaterial=v end,
})
BoneR:AddToggle("AutoMatT",{
    Title="🪨 Auto Farm Material",
    Default=false,
    Callback=function(v) getgenv().AutoMaterial=v end,
})

-- ── RAID ──────────────────────────────────────────────
local TabRaid = Window:AddTab("🛡️ Raid")
local RaidL   = TabRaid:AddLeftGroupbox("Auto Raid")
local RaidR   = TabRaid:AddRightGroupbox("Pirate Raid")

RaidL:AddDropdown("SelRaid",{
    Title="🎯 Select Raid",
    Values={"Light","Dark","Ice","Magma","Buddha","Flame","Sand","Control","Gravity","Love","Spider","Sound","Ghost","Leopard","Kitsune","Dragon","Blizzard","Phoenix"},
    Default="Light",
    Callback=function(v) _G.SelectRaid=v end,
})
RaidL:AddToggle("AutoRaidingT",{
    Title="⚔️ Auto Raid (Raiding)",
    Default=false,
    Callback=function(v) _G.Raiding=v end,
})
RaidL:AddToggle("AutoFarmRaidT",{
    Title="🗡️ Auto Farm Raid Enemies",
    Default=false,
    Callback=function(v) _G.AutoFarmRaid=v end,
})
RaidL:AddButton({Title="🛒 Buy Raid Chip",Callback=function()
    pcall(function()
        replicated.Remotes.CommF_:InvokeServer("BuyChip",_G.SelectRaid or "Light")
    end)
    Library:Notify({Title="Raid",Description="Buy chip: "..(_G.SelectRaid or "Light"),Duration=3})
end})

RaidR:AddToggle("AutoRaidCastleT",{
    Title="🏴‍☠️ Auto Pirate Raid",
    Default=false,
    Callback=function(v) _G.AutoRaidCastle=v end,
})
RaidR:AddToggle("AutoFactoryT",{
    Title="🏭 Auto Factory Raid",
    Default=false,
    Callback=function(v) _G.AutoFactory=v end,
})
RaidR:AddButton({Title="📍 TP Raid Castle",Callback=function()
    _tp(CFrame.new(-5496,313,-2841))
    Library:Notify({Title="TP",Description="Pirate Raid Castle",Duration=2})
end})

-- ── SEA EVENT ─────────────────────────────────────────
local TabSea = Window:AddTab("🌊 Sea")
local SeaL   = TabSea:AddLeftGroupbox("Sea Events")
local SeaR   = TabSea:AddRightGroupbox("Options")

SeaL:AddToggle("SeaBeastT",{
    Title="🐋 Auto Sea Beast",
    Default=false,
    Callback=function(v) _G.SeaBeast1=v end,
})
SeaL:AddToggle("TerrorSharkT",{
    Title="🦈 Auto Terrorshark",
    Default=false,
    Callback=function(v) _G.TerrorShark=v end,
})
SeaL:AddToggle("PiranhaT",{
    Title="🐟 Auto Piranha",
    Default=false,
    Callback=function(v) _G.Piranha=v end,
})
SeaL:AddToggle("LeviathanT",{
    Title="🌊 Auto Leviathan",
    Default=false,
    Callback=function(v) _G.Leviathan1=v; _G.Lvthan=v end,
})

SeaR:AddToggle("AutoPoleT",{
    Title="🎣 Auto Pole (Fishing spot)",
    Default=false,
    Callback=function(v) _G.AutoPole=v end,
})
SeaR:AddToggle("AutoPoleV2T",{
    Title="🎣 Auto Pole V2",
    Default=false,
    Callback=function(v) _G.AutoPoleV2=v end,
})
SeaR:AddToggle("AutoFishT",{
    Title="🐠 Auto Fish (Quest)",
    Default=false,
    Callback=function(v) _G.Auto_Fish=v end,
})

-- ── HAKI / OBS ────────────────────────────────────────
local TabHaki = Window:AddTab("👁️ Haki")
local HakiL   = TabHaki:AddLeftGroupbox("Observation")
local HakiR   = TabHaki:AddRightGroupbox("Haki Unlock")

HakiL:AddToggle("ObsFarmT",{
    Title="👁️ Farm Observation (Ken)",
    Default=false,
    Callback=function(v) _G.obsFarm=v end,
})
HakiL:AddToggle("CitizenQT",{
    Title="📜 Citizen Quest (Obs V2)",
    Default=false,
    Callback=function(v) _G.CitizenQuest=v end,
})
HakiL:AddToggle("RainHakiT",{
    Title="🌈 Auto Rainbow Haki",
    Default=false,
    Callback=function(v) _G.Auto_Rainbow_Haki=v end,
})

HakiR:AddToggle("UnHakiT2",{
    Title="✨ Auto Unlock Haki (Buso Color)",
    Default=false,
    Callback=function(v) _G.AutoUnHaki=v end,
})

-- ── ELITE / COLLECT ───────────────────────────────────
local TabExtra = Window:AddTab("🏆 Elite")
local ExtraL   = TabExtra:AddLeftGroupbox("Elite Hunter")
local ExtraR   = TabExtra:AddRightGroupbox("Collect")

ExtraL:AddToggle("EliteHuntT",{
    Title="🏆 Auto Elite Hunter",
    Default=false,
    Callback=function(v) _G.FarmEliteHunt=v end,
})
ExtraL:AddToggle("EliteHopT",{
    Title="🌀 Elite Hunter + Hop",
    Default=false,
    Callback=function(v) _G.FarmEliteHop=v end,
})

ExtraR:AddToggle("AutoChestT",{
    Title="📦 Auto Chest (Farm)",
    Default=false,
    Callback=function(v) _G.AutoFarmChest=v end,
})
ExtraR:AddToggle("AutoChestBPT",{
    Title="📦 Auto Chest (BypassTP)",
    Default=false,
    Callback=function(v) _G.AutoChestBP=v end,
})
ExtraR:AddToggle("AutoBerryT",{
    Title="🍓 Auto Berry",
    Default=false,
    Callback=function(v) _G.AutoBerry=v end,
})
ExtraR:AddToggle("AutoBerryHT",{
    Title="🍓 Auto Berry (Hop)",
    Default=false,
    Callback=function(v) _G.AutoBerryH=v end,
})

-- ── DUNGEON ───────────────────────────────────────────
local TabDun = Window:AddTab("🏛️ Dungeon")
local DunL   = TabDun:AddLeftGroupbox("Dungeon")
local DunR   = TabDun:AddRightGroupbox("Info")

DunL:AddToggle("AutoDungeonT",{
    Title="⚔️ Auto Farm Dungeon",
    Default=false,
    Callback=function(v) _G.AutoFarmDungeon=v end,
})
DunR:AddButton({Title="📊 Check Dungeon Status",Callback=function()
    local inDun=game.Players.LocalPlayer.PlayerGui:FindFirstChild("DungeonHUD")
    Library:Notify({Title="Dungeon",Description=inDun and "✅ In dungeon!" or "❌ Not in dungeon",Duration=3})
end})

-- ── WEBHOOK ───────────────────────────────────────────
local TabWH = Window:AddTab("🔗 Webhook")
local WHL   = TabWH:AddLeftGroupbox("Config")
local WHR   = TabWH:AddRightGroupbox("Events")

local webhookUrl=""
WHL:AddInput("WHUrl",{
    Title="🔗 Webhook URL",
    Default="",
    Placeholder="https://discord.com/api/webhooks/...",
    Numeric=false,
    Callback=function(v) webhookUrl=v; getgenv().WebhookUrl=v end,
})
WHL:AddButton({Title="📤 Test Webhook",Callback=function()
    if webhookUrl=="" then
        Library:Notify({Title="Error",Description="URL trống!",Duration=3}); return
    end
    pcall(function()
        local req=http_request or request; if not req then return end
        req({Url=webhookUrl,Method="POST",
            Headers={["Content-Type"]="application/json"},
            Body=game:GetService("HttpService"):JSONEncode({embeds={{
                title="🍌 Banana Hub Test",color=16684576,
                description="✅ Webhook hoạt động!",
                footer={text="Banana Hub v5.0"}
            }}})
        })
        Library:Notify({Title="Webhook",Description="✅ Sent!",Duration=3})
    end)
end})

WHR:AddToggle("WHBossT",{
    Title="⚠️ Notify Boss Spawn",
    Default=false,
    Callback=function(v) getgenv().WHBoss=v end,
})

-- ── SETTINGS ──────────────────────────────────────────
local TabSet = Window:AddTab("⚙️ Settings")
local SetL   = TabSet:AddLeftGroupbox("Player")
local SetR   = TabSet:AddRightGroupbox("System")

SetL:AddToggle("ChWalk",{
    Title="🏃 Change WalkSpeed",
    Default=false,
    Callback=function(v)
        if v then
            game:GetService("RunService").Heartbeat:Connect(function()
                local hum=game.Players.LocalPlayer.Character and game.Players.LocalPlayer.Character:FindFirstChild("Humanoid")
                if hum then hum.WalkSpeed=_G.WalkSpeedVal or 16 end
            end)
        end
    end,
})
SetL:AddSlider("WalkVal",{
    Title="💨 WalkSpeed",Min=16,Max=500,
    Default=16,Rounding=0,
    Callback=function(v) _G.WalkSpeedVal=v end,
})
SetL:AddToggle("NoclipT",{
    Title="👻 Noclip",
    Default=false,
    Callback=function(v)
        game:GetService("RunService").Heartbeat:Connect(function()
            if v and game.Players.LocalPlayer.Character then
                for _,p in pairs(game.Players.LocalPlayer.Character:GetDescendants()) do
                    if p:IsA("BasePart") then p.CanCollide=false end
                end
            end
        end)
    end,
})
SetL:AddToggle("BoostFpsT",{
    Title="⚡ Boost FPS",
    Default=false,
    Callback=function(v)
        if v then
            game.Lighting.GlobalShadows=false; game.Lighting.FogEnd=9e9
            spawn(function()
                while v do task.wait(5)
                    for _,x in pairs(workspace:GetDescendants()) do
                        if x:IsA("ParticleEmitter") or x:IsA("Trail") or x:IsA("Smoke") then x.Enabled=false end
                    end
                end
            end)
        end
    end,
})

SetR:AddToggle("AutoHopT",{
    Title="🌀 Auto Hop Server (timer)",
    Default=false,
    Callback=function(v) _G.AutoHopServer=v end,
})
SetR:AddSlider("HopDelayT",{
    Title="⏱️ Hop Delay (min)",Min=1,Max=60,
    Default=_G.HopDelay or 15,Rounding=0,
    Callback=function(v) _G.HopDelay=v end,
})
SetR:AddToggle("AutoRejoinT",{
    Title="🔄 Auto Reconnect",
    Default=true,
    Callback=function(v) _G.AutoRejoin=v end,
})
SetR:AddToggle("TogKeyT",{
    Title="⌨️ Toggle GUI (V key)",
    Default=true,
    Callback=function(v) _G.TogVKey=v end,
})
SetR:AddButton({Title="🌀 Hop Now",Callback=function()
    spawn(function() Hop() end)
end})
SetR:AddButton({Title="❌ Destroy GUI",Callback=function()
    Window:Destroy()
end})

-- V key toggle
_G.TogVKey=true
game:GetService("UserInputService").InputBegan:Connect(function(input,gp)
    if gp then return end
    if input.KeyCode==Enum.KeyCode.V and _G.TogVKey then
        local gui=game.Players.LocalPlayer.PlayerGui:FindFirstChild("MainGUI")
        if gui then gui.Enabled=not gui.Enabled end
    end
end)

-- Auto Reconnect
spawn(function()
    while true do task.wait(30)
        if _G.AutoRejoin then pcall(function()
            local e=game:GetService("CoreGui").RobloxPromptGui.ErrorPrompt.MessageArea.ErrorFrame.ErrorMessage.Text
            if not string.find(e,"Teleport") then
                game:GetService("TeleportService"):TeleportToPlaceInstance(game.PlaceId,game.JobId,plr)
            end
        end) end
    end
end)

-- Auto Hop timer
spawn(function()
    while true do task.wait(60)
        if _G.AutoHopServer then
            local delay=(_G.HopDelay or 15)*60
            task.wait(delay-60)
            if _G.AutoHopServer then spawn(function() Hop() end) end
        end
    end
end)

-- ── DONE ──────────────────────────────────────────────
task.wait(1)
Library:Notify({
    Title="🍌 Banana Hub Master v5.0",
    Description="✅ Core: bloxfruit.lua verbatim\n⌨️ V = Toggle GUI\n📊 Status tab cho task info",
    Duration=6,
})
print("╔══════════════════════════════════════════╗")
print("║  🍌 Banana Hub Master v5.0 — LOADED     ║")
print("║  ✅ bloxfruit.lua core: verbatim         ║")
print("║  ✅ GUI: UiBanana Linoria pattern        ║")
print("║  ✅ Toggles → _G.* flags → spawn loops  ║")
print("╚══════════════════════════════════════════╝")
