net.Receive("Trainingslager", function()
    Traininslager()
end)

function Traininslager()
    local Frame = vgui.Create("XeninUI.Frame")
    Frame:SetSize(400, 450)
    Frame:Center()
    Frame:SetTitle("Trainingslager")
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


