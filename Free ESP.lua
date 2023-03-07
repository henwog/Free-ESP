 --// Main ESP -()
    local Config = {
      Esp = {
        Box               = true,
        BoxFilled         = true,
        BoxOutline        = true,
        BoxTransparency   = 0,
        BoxColor          = Color3.fromRGB(149,111,255),
        BoxOutlineColor   = Color3.fromRGB(149,111,255),
      },
    }
  
    function CreateEsp(Player)
      local Box,BoxOutline,Name,HealthBar,HealthBarOutline = Drawing.new("Square"),Drawing.new("Square"),Drawing.new("Text"),Drawing.new("Square"),Drawing.new("Square")
      local Updater = game:GetService("RunService").RenderStepped:Connect(function()
      if Player ~= nil and Player:FindFirstChild("Humanoid") ~= nil and Player:FindFirstChild("HumanoidRootPart") ~= nil and Player.Humanoid.Health > 0 and Player:FindFirstChild("Head") ~= nil then
        local Target2dPosition,IsVisible = workspace.CurrentCamera:WorldToViewportPoint(Player.HumanoidRootPart.Position)
        local scale_factor = 1 / (Target2dPosition.Z * math.tan(math.rad(workspace.CurrentCamera.FieldOfView * 0.5)) * 2) * 100
        local width, height = math.floor(40 * scale_factor), math.floor(60 * scale_factor)
        if Config.Esp.Box  then
          Box.Visible = IsVisible
          Box.Color = Config.Esp.BoxColor
          Box.Size = Vector2.new(width,height)
          Box.Position = Vector2.new(Target2dPosition.X - Box.Size.X / 2,Target2dPosition.Y - Box.Size.Y / 2)
          Box.Filled = Config.Esp.BoxFilled
          Box.Thickness = 1
          Box.Transparency = Config.Esp.BoxTransparency
          Box.ZIndex = 69
          if Config.Esp.BoxOutline then
            BoxOutline.Visible = IsVisible
            BoxOutline.Color = Config.Esp.BoxOutlineColor
            BoxOutline.Size = Vector2.new(width,height)
            BoxOutline.Position = Vector2.new(Target2dPosition.X - Box.Size.X / 2,Target2dPosition.Y - Box.Size.Y / 2)
            BoxOutline.Filled = false
            BoxOutline.Thickness = 1
            BoxOutline.ZIndex = 1
          else
            BoxOutline.Visible = false
          end
        else
          Box.Visible = false
          BoxOutline.Visible = false
        end
        if Config.Esp.Names then
          Name.Visible = IsVisible
          Name.Color = Config.Esp.NamesColor
          Name.Center = true
          Name.Outline = Config.Esp.NamesOutline
          Name.OutlineColor = Config.Esp.NamesOutlineColor
          Name.Position = Vector2.new(Target2dPosition.X,Target2dPosition.Y - height * 0.5 + -14)
          Name.Font = Config.Esp.NamesFont
          Name.Size = Config.Esp.NamesSize
        else
          Name.Visible = true
        end
      else
        Box.Visible = false
        BoxOutline.Visible = false
        Name.Visible = false
        if not Player then
          Box:Remove()
          BoxOutline:Remove()
          Name:Remove()
          Updater:Disconnect()
        end
      end
      end)
    end
    for _,i in pairs(game:GetService("Workspace"):GetChildren()) do
      if i:FindFirstChild("Humanoid") and i ~= game.Players.LocalPlayer.Character and i:FindFirstChild("HumanoidRootPart") and i.Head:FindFirstChild("Nametag") then
        CreateEsp(i)
      end
    end
  
    game.Workspace.DescendantAdded:Connect(function(i)
    if i:FindFirstChild("Humanoid") and i ~= game.Players.LocalPlayer.Character and i:FindFirstChild("HumanoidRootPart") and i.Head:FindFirstChild("Nametag") then
      CreateEsp(i)
    end
    end)