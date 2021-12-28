AddCSLuaFile("cl_init.lua")
AddCSLuaFile("shared.lua")
include("shared.lua")
util.AddNetworkString("Trainingslager")
util.AddNetworkString("Schrotflinte")
util.AddNetworkString("Sturmgewehr")
util.AddNetworkString("Waffenhändler")


function ENT:Initialize()
    self:SetModel("models/player/gman_high.mdl")
    self:PhysicsInit(SOLID_VPHYSICS)
    self:SetMoveType(MOVETYPE_VPHYSICS)
    self:SetSolid(SOLID_BBOX)
    self:SetNPCState(NPC_STATE_SCRIPT)
    self:SetUseType(SIMPLE_USE)
end



function ENT:Use(ply)
    net.Start("Waffenhändler")
    net.Send(ply)
end

hook.Add("PlayerSay", "Trainingslager", function(ply, text)
    if (string.lower(text) == "/menu") then
        net.Start("Trainingslager")
        net.Send(ply)

        return ""
    end
end)

net.Receive("Schrotflinte", function(len, ply)
    local auswahl = net.ReadInt(5)
    local waffe = WAFFENAUSWAHL[auswahl].waffe
    ply:Give(waffe)
    ply:SelectWeapon(waffe)
end)