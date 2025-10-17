local func = loadstring(local raioMorte   = 60
local danoPorHit  = 9e8
local intervalo   = 0.05
local ignorarAmigos = false

local Players = game:GetService("Players")
local RunService = game:GetService("RunService")

local amigos = {} -- preencha com UserIds se quiser ignorar

local function deveIgnorar(player)
    if not ignorarAmigos then return false end
    for _, id in ipairs(amigos) do
        if player.UserId == id then return true end
    end
    return false
end

local function killPlayer(player)
    if deveIgnorar(player) then return end
    local char = player.Character or player.CharacterAdded:Wait()
    local humanoid = char:FindFirstChildOfClass("Humanoid")
    if humanoid then
        humanoid:TakeDamage(danoPorHit)
    end
end

local function getLocalPlayer()
    return Players.LocalPlayer
end

local function distancia(p1, p2)
    return (p1 - p2).Magnitude
end

local function massKill()
    local me = getLocalPlayer()
    if not me or not me.Character then return end
    local root = me.Character:FindFirstChild("HumanoidRootPart")
    if not root then return end

    for _, player in ipairs(Players:GetPlayers()) do
        if player == me then continue end
        local char = player.Character
        if char then
            local hrp = char:FindFirstChild("HumanoidRootPart")
            if hrp and distancia(root.Position, hrp.Position) <= raioMorte then
                killPlayer(player)
                wait(intervalo)
            end
        end
    end
    end)
if func then func() end
