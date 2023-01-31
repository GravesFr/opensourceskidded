local Aiming = loadstring(game:HttpGet("https://raw.githubusercontent.com/GravesFr/opensourceskidded/main/s"))()
Aiming.TeamCheck(false)



local Workspace = game:GetService("Workspace")

local Players = game:GetService("Players")

local RunService = game:GetService("RunService")

local UserInputService = game:GetService("UserInputService")



local LocalPlayer = Players.LocalPlayer

local Mouse = LocalPlayer:GetMouse()

local CurrentCamera = Workspace.CurrentCamera


Aiming.FOV = getgenv().Feds.FovSize
Aiming.TargetPart = getgenv().Feds.Aimparts
Aiming.HitChance = getgenv().Feds.HitChance
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



local Script = {Functions = {}}



Script.Functions.getToolName = function(name)

    local split = string.split(string.split(name, "[")[2], "]")[1]

    return split

end



Script.Functions.getEquippedWeaponName = function(player)

   if (player.Character) and player.Character:FindFirstChildWhichIsA("Tool") then

      local Tool =  player.Character:FindFirstChildWhichIsA("Tool")

      if string.find(Tool.Name, "%[") and string.find(Tool.Name, "%]") and not string.find(Tool.Name, "Wallet") and not string.find(Tool.Name, "Phone") then 

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


