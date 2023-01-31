local Aiming = loadstring(game:HttpGet("https://raw.githubusercontent.com/GravesFr/opensourceskidded/main/s"))()
Aiming.TeamCheck(false)



local Workspace = game:GetService("Workspace")

local Players = game:GetService("Players")

local RunService = game:GetService("RunService")

local UserInputService = game:GetService("UserInputService")



local LocalPlayer = Players.LocalPlayer

local Mouse = LocalPlayer:GetMouse()

local CurrentCamera = Workspace.CurrentCamera

getgenv().Feds = {
    
    -- // Main silent stuff (sorry for not organizing better im lazy)
    Prediction = 0.125,
    AimParts = {"Head", "LeftHand", "RightHand", "LeftLowerArm", "RightLowerArm", "LeftUpperArm", "RightUpperArm", "LeftFoot", "LeftLowerLeg", "UpperTorso", "HumanoidRootPart", "LeftUpperLeg", "RightLowerLeg", "RightFoot", "LowerTorso"},
    FovSize = 10,
    Resolver = true,
    Keybind = 'P',
    
    -- // fov ranges
    FovRange = true,
    CloseRangeFov = 20,
    MidRangeFov = 10,
    LongRangeFov = 5,
    -- // prediction ranges 
    PredictionRange = true,
    CloseRangePrediction = 0.131, -- bad sets
    MidRangePrediction = 0.1281, -- bad sets
    FarRangePrediction = 0.1261, -- bad sets
    
    -- // Auto prediction
    AutoPrediction = true,
    AutoP20 = 0.113, -- 20 ping auto prediction
    AutoP30 = 0.1173, -- 30 ping auto prediction
    AutoP40 = 0.1215, -- 40 ping auto prediction
    AutoP50 = 0.1235,-- 50 ping auto prediction
    AutoP60 = 0.1253, -- 60 ping auto prediction
    AutoP70 = 0.1269, -- 70 ping auto prediction
    AutoP80 = 0.1285, -- 80 ping auto prediction
    AutoP90 = 0.1315, -- 90 ping auto prediction
    AutoP100 = 0.134 -- 100 ping auto prediction
}

Aiming.FOV = 15
--------------------------------------------------
--------------------------------------------------- -fov 5.5-6.6 is legit

function Aiming.Check()

    if not (Aiming.Enabled == true and Aiming.Selected ~= LocalPlayer and Aiming.SelectedPart ~= nil) then

        return false

    end

    local Character = Aiming.Character(Aiming.Selected)

    local KOd = Character:WaitForChild("BodyEffects")["K.O"].Value

    local Grabbed = Character:FindFirstChild("GRABBING_CONSTRAINT") ~= nil

    if (KOd or Grabbed) then

        return false

    end

    return true

end



task.spawn(function()

    while task.wait() do

        if getgenv().Feds.Resolver and Aiming.Selected ~= nil and (Aiming.Selected.Character)  then

            local oldVel = game.Players[Aiming.Selected.Name].Character.HumanoidRootPart.Velocity

            game.Players[Aiming.Selected.Name].Character.HumanoidRootPart.Velocity = Vector3.new(oldVel.X, -0, oldVel.Z)

        end 

    end

end)

game:GetService("RunService").Heartbeat:Connect(
                                function()
                                    if
                                        getgenv().Feds.FovRange == true and Aiming.Selected ~= nil and (Aiming.Selected.Character)  then
                                        if
                                            (game.Players[Aiming.Selected.Name].Character.HumanoidRootPart.Position -
                                                game.Players.LocalPlayer.Character.HumanoidRootPart.Position).Magnitude <
                                                25
                                         then
                                            Aiming.FOV = getgenv().Feds.CloseRangeFov
                                        elseif
                                            (game.Players[Aiming.Selected.Name].Character.HumanoidRootPart.Position -
                                                game.Players.LocalPlayer.Character.HumanoidRootPart.Position).Magnitude <
                                                90
                                         then
                                            Aiming.FOV = getgenv().Feds.MidRangeFov
                                        elseif
                                            (game.Players[Aiming.Selected.Name].Character.HumanoidRootPart.Position -
                                                game.Players.LocalPlayer.Character.HumanoidRootPart.Position).Magnitude <
                                                math.huge
                                         then
                                            Aiming.FOV = getgenv().Feds.LongRangeFov
                                        end
                                    end
                                end
                            )
                            
                            game:GetService("RunService").Heartbeat:Connect(
                                function()
                                    if
                                        getgenv().Feds.PredictionRange == true and Aiming.Selected ~= nil and (Aiming.Selected.Character)  then
                                        if
                                            (game.Players[Aiming.Selected.Name].Character.HumanoidRootPart.Position -
                                                game.Players.LocalPlayer.Character.HumanoidRootPart.Position).Magnitude <
                                                25
                                         then
                                            getgenv().Feds.Prediction = getgenv().Feds.CloseRangePrediction
                                        elseif
                                            (game.Players[Aiming.Selected.Name].Character.HumanoidRootPart.Position -
                                                game.Players.LocalPlayer.Character.HumanoidRootPart.Position).Magnitude <
                                                90
                                         then
                                            getgenv().Feds.Prediction = getgenv().Feds.MidRangePrediction
                                        elseif
                                            (game.Players[Aiming.Selected.Name].Character.HumanoidRootPart.Position -
                                                game.Players.LocalPlayer.Character.HumanoidRootPart.Position).Magnitude <
                                                math.huge
                                         then
                                            getgenv().Feds.Prediction = getgenv().Feds.LongRangePrediction
                                        end
                                    end
                                end
                            )
                        



local Script = {Functions = {}}



Script.Functions.getToolName = function(name)
-- MAD3 BY F3DS S0NNY
    local split = string.split(string.split(name, "[")[2], "]")[1]

    return split

end



Script.Functions.getEquippedWeaponName = function(player)

   if (player.Character) and player.Character:FindFirstChildWhichIsA("Tool") then

      local Tool =  player.Character:FindFirstChildWhichIsA("Tool")

      if string.find(Tool.Name, "%[") and string.find(Tool.Name, "%]") and not string.find(Tool.Name, "Wallet") and not string.find(Tool.Name, "Phone") then 
-- M4D3 BY F33DS S0NN7
         return Script.Functions.getToolName(Tool.Name)

      end

   end

   return nil

end



game:GetService("RunService").RenderStepped:Connect(function()

    if Script.Functions.getEquippedWeaponName(game.Players.LocalPlayer) ~= nil then

        local WeaponSettings = GunSettings[Script.Functions.getEquippedWeaponName(game.Players.LocalPlayer)]

        if WeaponSettings ~= nil then

            Aiming.FOV = WeaponSettings.FOV

        else

            Aiming.FOV = 5

        end

    end    

end)

local __index

__index = hookmetamethod(game, "__index", function(t, k)

    if (t:IsA("Mouse") and (k == "Hit" or k == "Target") and Aiming.Check()) then

        local SelectedPart = Aiming.SelectedPart

        if (getgenv().Feds.SilentAim and (k == "Hit" or k == "Target")) then

            local Hit = SelectedPart.CFrame + (SelectedPart.Velocity * getgenv().Feds.Prediction)

            return (k == "Hit" and Hit or SelectedPart)

        end

    end



    return __index(t, k)

end)



RunService:BindToRenderStep("AimLock", 0, function()

    if (getgenv().Feds.AimLock and Aiming.Check() and UserInputService:IsKeyDown(getgenv().Feds.AimLockKeybind)) then

        local SelectedPart = Aiming.SelectedPart

        local Hit = SelectedPart.CFrame + (SelectedPart.Velocity * getgenv().Feds.Prediction)

        CurrentCamera.CFrame = CFrame.lookAt(CurrentCamera.CFrame.Position, Hit.Position)

    end
end)

while getgenv().Feds.AutoPrediction == true do
    local ping = game:GetService("Stats").Network.ServerStatsItem["Data Ping"]:GetValueString()
    local pingValue = string.split(ping, " ")[1]
    local pingNumber = tonumber(pingValue)
   
    if pingNumber < 30 then
        Feds.Prediction = (getgenv().Feds.AutoP20)
    elseif pingNumber < 40 then
        Feds.Prediction = (getgenv().Feds.AutoP30)
    elseif pingNumber < 50 then
        Feds.Prediction = (getgenv().Feds.AutoP40)
    elseif pingNumber < 60 then
        Feds.Prediction = (getgenv().Feds.AutoP50)
    elseif pingNumber < 70 then
        Feds.Prediction = (getgenv().Feds.AutoP60)
    elseif pingNumber < 80 then
        Feds.Prediction = (getgenv().Feds.AutoP70)
    elseif pingNumber < 90 then
        Feds.Prediction = (getgenv().Feds.AutoP80)
    elseif pingNumber < 100 then
        Feds.Prediction = (getgenv().Feds.AutoP90)
    elseif pingNumber < 110 then
        Feds.Prediction = (getgenv().Feds.AutoP100)
    end
 
    wait(0.5)
end
mouse.KeyDown:Connect(function(key)
    if key == getgenv().Feds.Keybind then
    if Aiming.Enabled == false then
    Aiming.Enabled = true
    else
    Aiming.Enabled = false
end
end
end)

