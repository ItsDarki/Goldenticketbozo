util.AddNetworkString("Trainingslager")
util.AddNetworkString("Schrotflinte")
util.AddNetworkString("Sturmgewehr")

--util.AddNetworkString("Pistole")
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

    if (CheckIfPlayerIsAdmin(ply)) then
        print("SPIELER IST ADMIN")
    else
        print("SPIELER IST KEIN ADMIN")
    end

end)

function CheckIfPlayerIsAdmin(ply)
    if ply:IsValid() and ply:IsAdmin() then
        return true
    else
        return false
    end
end