local raioMorte   = 60
local danoPorHit  = 9e8
local intervalo   = 0.05
local ignorarAmigos = false

local Players = game:GetService("Players")
local RunService = game:GetService("RunService")
local amigos = {}     -- coloque UserIds aqui se quiser ignorar

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
    local h = char:FindFirstChildOfClass("Humanoid")
    if h then h:TakeDamage(danoPorHit) end
end

local function localPlayer() return Players.LocalPlayer end

local function dist(p1, p2) return (p1 - p2).Magnitude end

local function massKill()
    local me = localPlayer()
    if not (me and me.Character) then return end
    local root = me.Character:FindFirstChild("HumanoidRootPart")
    if not root then return end

    for _, ply in ipairs(Players:GetPlayers()) do
        if ply == me then continue end
        local c = ply.Character
        local hrp = c and c:FindFirstChild("HumanoidRootPart")
        if hrp and dist(root.Position, hrp.Position) <= raioMorte then
            killPlayer(ply)
            task.wait(intervalo)
        end
    end
end

-- Ativa com a tecla P (opcional)
local UserInput = game:GetService("UserInputService")
local ativo = false
UserInput.InputBegan:Connect(function(inp, gp)
    if gp then return end
    if inp.KeyCode == Enum.KeyCode.P then
        ativo = not ativo
        if ativo then
            massKill()
            ativo = false
        end
    end
end)
