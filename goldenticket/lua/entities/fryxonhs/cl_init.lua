include("shared.lua")

function ENT:Draw()
    self:DrawModel()
end

net.Receive("Waffenhändler", function()
    MehmettTalk()

    Traininslager()
end)

function MehmettTalk()
    local Frame = vgui.Create("XeninUI.Frame")
    Frame:SetSize(600, 450)
    Frame:Center()
    Frame:SetTitle(" ")
    Frame:MakePopup()
    Frame:MoveTo(ScrW() / 2 - 200, ScrH() / 2 - 300, 0.5, 0.25)
    Abstand = 0
    local Panel = vgui.Create("XeninUI.Panel", Frame)
    Panel:SetSize(400, 150)
    Panel:SetPos(200, 150)

    surface.CreateFont("MehmettT_18", {
        font = "Roboto",
        size = 18,
        weight = 500,
    })

    Panel.Paint = function(self, w, h)
        surface.SetDrawColor(40, 41, 40)
        surface.DrawRect(0, 0, w, h)
        draw.SimpleText("Was willst du Gauner von mir?!", "MehmettT_18", w / 2, h / 2, Color(255, 255, 255), TEXT_ALIGN_CENTER, TEXT_ALIGN_CENTER)
    end

    local ModelImage = vgui.Create("SpawnIcon", Frame)
    ModelImage:SetPos(45, 50)
    ModelImage:SetSize(100, 100)
    ModelImage:SetModel("models/player/gman_high.mdl")

    surface.CreateFont("Mehmett_18", {
        font = "Roboto",
        size = 28,
        weight = 500,
    })

    local Mehmett = vgui.Create("XeninUI.Panel", Frame)
    Mehmett:SetSize(400, 150)
    Mehmett:SetPos(200, 50)

    Mehmett.Paint = function(self, w, h)
        draw.SimpleText("Mehmett el-Razor", "Mehmett_18", TEXT_ALIGN_CENTER, TEXT_ALIGN_CENTER)
    end
end

function OpenWaffenshop()
    local Frame = vgui.Create("XeninUI.Frame")
    Frame:SetSize(400, 450)
    Frame:Center()
    Frame:SetTitle("Waffenhändler Mehmett")
    Frame:MakePopup()
    Frame:MoveTo(ScrW() / 2 - 200, ScrH() / 2 - 300, 0.5, 0.25)
    Abstand = 0

    for key, v in ipairs(WAFFENAUSWAHL) do
        local Waffe_button = vgui.Create("XeninUI.ButtonV2", Frame)
        Abstand = Abstand + 90
        Waffe_button:SetPos(75, 10 + Abstand)
        Waffe_button:SetSize(250, 50)
        Waffe_button:SetText(v.text)
        Waffe_button:SetTextColor(color_white)
        Waffe_button:SetSolidColor(Color(0, 0, 0))

        Waffe_button.DoClick = function()
            net.Start("Schrotflinte")
            net.WriteInt(key, 5)
            net.SendToServer()
        end
    end
end

function ENT:Draw()
    self:DrawModel()
    local ply = LocalPlayer()
    local pos = self:GetPos()
    local eyePos = ply:GetPos()
    local dist = pos:Distance(eyePos)
    local alpha = math.Clamp(2500 - dist * 2.7, 0, 255)
    if (alpha <= 0) then return end
    local angle = self:GetAngles()
    local eyeAngle = ply:EyeAngles()
    local Namen = "Waffenhändler Mehmett"
    angle:RotateAroundAxis(angle:Forward(), 90)
    angle:RotateAroundAxis(angle:Right(), -90)
    cam.Start3D2D(pos + self:GetUp() * 90, Angle(0, eyeAngle.y - 90, 90), 0.04)

    XeninUI:DrawNPCOverhead(self, {
        alpha = alpha,
        text = Namen,
        icon = nil,
        sin = true,
        textOffset = 0,
        iconMargin = 0,
        color = XeninUI.Theme.Black
    })

    cam.End3D2D()
end