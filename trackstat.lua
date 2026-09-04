-- ████████████████████████████████████████████████
-- ThlongPremium | Blox Fruit Stat Tracker v1.0
-- Gửi toàn bộ stat acc lên web dashboard
-- ████████████████████████████████████████████████

local API_URL    = "https://trackstat-eight.vercel.app/api/update"
local API_SECRET = "ThlongPremium2024"  -- đổi khớp với biến môi trường Vercel

-- ── HTTP (Synapse / Delta / Fluxus / Krnl / Script-Ware) ──
local Http   = game:GetService("HttpService")
local Player = game.Players.LocalPlayer

local function post(payload)
    local b = Http:JSONEncode(payload)
    local h = {
        ["Content-Type"]  = "application/json",
        ["Authorization"] = "Bearer " .. API_SECRET
    }
    if syn      and syn.request   then return syn.request({Url=API_URL,Method="POST",Headers=h,Body=b}) end
    if request                    then return request({Url=API_URL,Method="POST",Headers=h,Body=b}) end
    if http     and http.request  then return http.request({Url=API_URL,Method="POST",Headers=h,Body=b}) end
    if fluxus   and fluxus.request then return fluxus.request({Url=API_URL,Method="POST",Headers=h,Body=b}) end
end

-- ── Thu thập mọi Value instance trong player ──
local function scan(obj)
    local t  = {}
    local ok, desc = pcall(function() return obj:GetDescendants() end)
    if not ok then return t end
    for _, v in ipairs(desc) do
        local isVal = v:IsA("NumberValue") or v:IsA("IntValue")
                   or v:IsA("StringValue") or v:IsA("BoolValue")
        if isVal then
            t[v.Name] = v.Value
        end
    end
    return t
end

local function collect()
    local raw = {}

    -- Scan tất cả folders/models trong player
    for _, child in ipairs(Player:GetChildren()) do
        if child:IsA("Folder") or child:IsA("Configuration") then
            for k, v in pairs(scan(child)) do raw[k] = v end
        end
    end

    -- Leaderstats luôn đọc riêng (ưu tiên)
    local ls = Player:FindFirstChild("leaderstats")
    if ls then
        for _, v in ipairs(ls:GetChildren()) do
            raw[v.Name] = v.Value
        end
    end

    -- Thử các remote function phổ biến của BF
    pcall(function()
        local rem = game.ReplicatedStorage:WaitForChild("Remotes", 2)
        if rem then
            local gd = rem:FindFirstChild("GetData") or rem:FindFirstChild("CommF_")
            if gd and gd:IsA("RemoteFunction") then
                local result = gd:InvokeServer()
                if type(result) == "table" then
                    for k, v in pairs(result) do
                        if type(v) ~= "table" and type(v) ~= "function" then
                            raw["remote_" .. tostring(k)] = v
                        end
                    end
                end
            end
        end
    end)

    return {
        key         = API_SECRET,
        account_key = Player.Name .. "_" .. tostring(Player.UserId),
        data = {
            username     = Player.Name,
            display_name = Player.DisplayName,
            user_id      = Player.UserId,
            -- Core stats
            level        = raw.Level    or raw.Lvl       or raw.remote_Level    or 0,
            beli         = raw.Beli     or raw.remote_Beli                      or 0,
            bounty       = raw.Bounty   or raw.remote_Bounty                    or 0,
            honor        = raw.Honor    or raw.remote_Honor                     or 0,
            fragments    = raw.Fragments or raw.remote_Fragments               or 0,
            -- Stat allocation
            stat_melee   = raw.Melee    or raw.MeleeStat or raw.remote_Melee   or 0,
            stat_defense = raw.Defense  or raw.DefStat   or raw.remote_Defense  or 0,
            stat_sword   = raw.Sword    or raw.SwordStat or raw.remote_Sword   or 0,
            stat_gun     = raw.Gun      or raw.GunStat   or raw.remote_Gun     or 0,
            stat_fruit   = raw.Fruit    or raw.FruitStat or raw.remote_Fruit   or 0,
            -- Identity
            race         = raw.Race     or raw.remote_Race                     or "Human",
            devil_fruit  = raw.DevilFruit or raw.FruitName or raw.CurrentFruit
                        or raw.remote_DevilFruit                               or "None",
            sea          = raw.Sea      or raw.remote_Sea                      or 1,
            -- Full dump — web hiện raw data section
            raw_dump     = raw
        }
    }
end

-- ── Notification nhỏ góc màn hình ──
local function notif(msg, color)
    color = color or Color3.fromRGB(147, 51, 234)
    pcall(function()
        local old = game.CoreGui:FindFirstChild("_ThlongNotif")
        if old then old:Destroy() end

        local g = Instance.new("ScreenGui", game.CoreGui)
        g.Name = "_ThlongNotif"; g.ResetOnSpawn = false

        local f = Instance.new("Frame", g)
        f.Size            = UDim2.new(0, 280, 0, 40)
        f.Position        = UDim2.new(1, -296, 0, 12)
        f.BackgroundColor3 = Color3.fromRGB(12, 8, 22)
        f.BorderSizePi
