local lib = {}
local themes = {
    ["gamesense"] = {
        ["Window"] = Color3.fromRGB(16, 16, 16),
        ["Tabs"] = Color3.fromRGB(12, 12, 12),
        ["Gradient"] = ColorSequence.new{ColorSequenceKeypoint.new(0.00, Color3.fromRGB(61, 130, 162)), ColorSequenceKeypoint.new(0.50, Color3.fromRGB(156, 59, 145)), ColorSequenceKeypoint.new(1.00, Color3.fromRGB(155, 161, 48))},
        ["Sector"] = Color3.fromRGB(23, 23, 23),
        ["Text"] = Color3.fromRGB(161, 161, 161),
        ["TabSelected"] = Color3.fromRGB(17, 17, 17),
        ["ElementBg"] = Color3.fromRGB(27, 27, 27),
        ["ElementOutline"] = Color3.fromRGB(40,40,40),
        ["DropdownSelected"] = Color3.fromRGB(135, 176, 27),
        ["Toggle"] = Color3.fromRGB(135, 176, 27),
        ["ToggleUnchecked"] = Color3.fromRGB(30,30,30),
        ["Slider"] = Color3.fromRGB(135, 176, 27),
        ["SliderBg"] = Color3.fromRGB(27, 27, 27)
    }
}
local services = {
    ["uis"] = game:GetService("UserInputService"),
    ["run"] = game:GetService("RunService")
}
local function gethui()
    return game.Players.LocalPlayer.PlayerGui
end
local function protectgui()
end
lib.create_window = function(theme, menu_key)
    if gethui():FindFirstChild("Mute") then
        gethui():FindFirstChild("Mute"):Destroy()
    end
    local window = {}
    local protect_gui = protectgui or (syn and syn.protect_gui) or (function() end)
    window.dragging = nil
    window.drag_input = nil
    window.drag_start = nil
    window.start_pos = nil
    local Mute = Instance.new("ScreenGui")
    math.randomseed(os.time())
    Mute.Name = tostring(math.random(0,9999999))
    protect_gui(Mute)
    local Main = Instance.new("Frame")
    local Tabs = Instance.new("Frame")
    local UIGridLayout = Instance.new("UIGridLayout")
    local UIPadding = Instance.new("UIPadding")
    local TopGradient = Instance.new("Frame")
    local UIGradient = Instance.new("UIGradient")
    local Content = Instance.new("Frame")
    local UIListLayout = Instance.new("UIListLayout")
    -- dragging
    window.update_window = function(input)
        local delta = input.Position - window.drag_start
        Main.Position = UDim2.new(window.start_pos.X.Scale, window.start_pos.X.Offset + delta.X, window.start_pos.Y.Scale, window.start_pos.Y.Offset + delta.Y)
    end
    window.drag_began = function(input)
        if input.UserInputType == Enum.UserInputType.MouseButton1 or input.UserInputType == Enum.UserInputType.Touch then
            window.dragging = true
            window.drag_start = input.Position
            window.start_pos = Main.Position
            input.Changed:Connect(function()
                if input.UserInputState == Enum.UserInputState.End then
                    window.dragging = false
                end
            end)
        end
    end
    window.drag_changed = function(input)
        if input.UserInputType == Enum.UserInputType.MouseMovement or input.UserInputType == Enum.UserInputType.Touch then
            window.drag_input = input
        end
    end
    Mute.Parent = gethui()
    Mute.ZIndexBehavior = Enum.ZIndexBehavior.Sibling
    Mute.ResetOnSpawn = false
    Mute.DisplayOrder = 9999
    Mute.IgnoreGuiInset = true
    Main.Name = "Main"
    Main.Parent = Mute
    Main.BackgroundColor3 = themes[theme]["Window"]
    Main.BorderColor3 = Color3.fromRGB(45, 45, 45)
    Main.BorderSizePixel = 3
    Main.Position = UDim2.new(0.38166827, 0, 0.249408439, 0)
    Main.Size = UDim2.new(0, 684, 0, 605)
    Tabs.Name = "Tabs"
    Tabs.Parent = Main
    Tabs.BackgroundColor3 = themes[theme]["Tabs"]
    Tabs.BorderColor3 = Color3.fromRGB(21, 21, 21)
    Tabs.Position = UDim2.new(0, 1, 0.00330578513, 0)
    Tabs.Size = UDim2.new(0, 100, 0, 602)
    UIGridLayout.Parent = Tabs
    UIGridLayout.SortOrder = Enum.SortOrder.LayoutOrder
    UIGridLayout.CellPadding = UDim2.new(0, 15, 0, 0)
    UIGridLayout.CellSize = UDim2.new(0, 85, 0, 70)
    UIPadding.Parent = Tabs
    UIPadding.PaddingLeft = UDim.new(0, 14)
    UIPadding.PaddingTop = UDim.new(0, 15)
    TopGradient.Name = "TopGradient"
    TopGradient.Parent = Main
    TopGradient.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
    TopGradient.BorderColor3 = Color3.fromRGB(0, 0, 0)
    TopGradient.BorderSizePixel = 0
    TopGradient.Size = UDim2.new(0, 684, 0, 1)
    UIGradient.Color = themes[theme]["Gradient"]
    UIGradient.Parent = TopGradient
    Content.Name = "Content"
    Content.Parent = Main
    Content.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
    Content.BackgroundTransparency = 1.000
    Content.BorderColor3 = Color3.fromRGB(0, 0, 0)
    Content.BorderSizePixel = 0
    Content.Position = UDim2.new(0.165000007, 0, 0.0247933883, 0)
    Content.Size = UDim2.new(0, 553, 0, 579)
    UIListLayout.Parent = Content
    UIListLayout.FillDirection = Enum.FillDirection.Horizontal
    UIListLayout.SortOrder = Enum.SortOrder.LayoutOrder
    UIListLayout.Padding = UDim.new(0, 10)
    Tabs.InputBegan:Connect(function(input)
        window.drag_began(input)
    end)
    Tabs.InputChanged:Connect(function(input)
        window.drag_changed(input)
    end)
    Main.InputBegan:Connect(function(input)
        window.drag_began(input)
    end)
    Main.InputChanged:Connect(function(input)
        window.drag_changed(input)
    end)
    services.uis.InputChanged:Connect(function(input)
        if input == window.drag_input and window.dragging then
            window.update_window(input)
        end
    end)
    services.uis.InputBegan:Connect(function(input)
        if input.KeyCode == menu_key then
            Mute.Enabled = not Mute.Enabled
        end
    end)
    window.tab_sectors = {}
    window.selected_tab = ""
    window.show_tab = function(name)
        for tab_name, sectors in pairs(window.tab_sectors) do
            local visible = (tab_name == name)
            for _, sector in pairs(sectors) do
                sector.Visible = visible
            end
        end
        task.spawn(function()
            task.wait()
        end)
    end
    window.tab_active = function(tab)
        tab.BackgroundTransparency = 0
        if tab:FindFirstChild("Open") then
            tab.Open.ImageColor3 = Color3.fromRGB(209, 210, 208)
        end
    end
    window.tab_inactive = function(tab)
        tab.BackgroundTransparency = 1
        if tab:FindFirstChild("Open") then
            tab.Open.ImageColor3 = Color3.fromRGB(90,90,90)
        end
    end
    window.tab_colors = function(ignore)
        for _, tab in pairs(Tabs:GetChildren()) do
            if not tab:IsA("UIGridLayout") and not tab:IsA("UIPadding") and not tab:IsA("UIListLayout") then
                if tab.Name ~= ignore.Name then
                    window.tab_inactive(tab)
                else
                    window.tab_active(tab)
                end
            end
        end
    end
    window.create_tab = function(image)
        local tab = {}
        tab.sectors = {}
        local Tab = Instance.new("TextButton")
        local Open = Instance.new("ImageButton")
        Tab.Name = image:sub(14)
        Tab.Parent = Tabs
        Tab.BackgroundColor3 = themes[theme]["TabSelected"]
        Tab.BorderColor3 = Color3.fromRGB(20, 20, 20)
        Tab.BackgroundTransparency = 1
        Tab.BorderSizePixel = 2
        Tab.Size = UDim2.new(0, 120, 0, 70)
        Tab.Position = UDim2.new(0, -10, 0, 0)
        Tab.AutoButtonColor = false
        Tab.Font = Enum.Font.SourceSans
        Tab.Text = ""
        Tab.TextColor3 = Color3.fromRGB(0, 0, 0)
        Tab.TextSize = 14.000
        local switch_func = function()
            window.selected_tab = Tab.Name
            window.tab_colors(Tab)
            window.show_tab(Tab.Name)
        end
        Tab.MouseButton1Down:Connect(switch_func)
        Open.Name = "Open"
        Open.Parent = Tab
        Open.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
        Open.BackgroundTransparency = 1.000
        Open.BorderColor3 = Color3.fromRGB(0, 0, 0)
        Open.BorderSizePixel = 0
        Open.Position = UDim2.new(0.162790701, 0, 0.18571429, 0)
        Open.Size = UDim2.new(0, 43, 0, 43)
        Open.Image = image
        Open.ImageColor3 = Color3.fromRGB(90,90,90)
        Open.MouseButton1Down:Connect(switch_func)
        tab.create_sector = function(name)
            local sector = {}
            local Sector = Instance.new("Frame")
            local Title = Instance.new("TextLabel")
            local SectorContent = Instance.new("ScrollingFrame")
            local UIListLayout = Instance.new("UIListLayout")
            local UIPadding = Instance.new("UIPadding")
            Sector.Name = name
            Sector.Parent = Content
            Sector.BackgroundColor3 = themes[theme]["Sector"]
            Sector.BorderColor3 = Color3.fromRGB(34, 34, 34)
            Sector.BorderSizePixel = 1
            Sector.Position = UDim2.new(0, 5, 0, 0)
            Sector.Size = UDim2.new(0.5, -5, 1, 0)
            Sector.Visible = false
            Title.Name = "Title"
            Title.Parent = Sector
            Title.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
            Title.BackgroundTransparency = 1.000
            Title.BorderColor3 = Color3.fromRGB(0, 0, 0)
            Title.BorderSizePixel = 0
            Title.Position = UDim2.new(0.028933093, 0, -0.0120898103, 0)
            Title.Size = UDim2.new(0, 268, 0, 15)
            Title.Font = Enum.Font.SourceSans
            Title.TextColor3 = themes[theme]["Text"]
            Title.TextSize = 18.000
            Title.TextStrokeColor3 = Color3.fromRGB(42, 42, 42)
            Title.TextStrokeTransparency = 0.500
            Title.TextXAlignment = Enum.TextXAlignment.Left
            Title.Text = name
            SectorContent.Name = "SectorContent"
            SectorContent.Parent = Sector
            SectorContent.Active = true
            SectorContent.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
            SectorContent.BackgroundTransparency = 1.000
            SectorContent.BorderColor3 = Color3.fromRGB(0, 0, 0)
            SectorContent.BorderSizePixel = 0
            SectorContent.Position = UDim2.new(0.028933093, 0, 0.025906736, 0)
            SectorContent.Size = UDim2.new(0, 259, 0, 558)
            SectorContent.CanvasSize = UDim2.new(0, 0, 0, 0)
            SectorContent.ScrollBarThickness = 3
            UIListLayout.Parent = SectorContent
            UIListLayout.SortOrder = Enum.SortOrder.LayoutOrder
            UIListLayout.Padding = UDim.new(0,7)
            UIPadding.Parent = SectorContent
            UIPadding.PaddingLeft = UDim.new(0, 5)
            local UIGradient = Instance.new("UIGradient")
            UIGradient.Color = ColorSequence.new{
                ColorSequenceKeypoint.new(0.00, Color3.fromRGB(255, 255, 255)),
                ColorSequenceKeypoint.new(1.00, Color3.fromRGB(200,200,200))
            }
            UIGradient.Rotation = 90
            UIGradient.Parent = Sector
            table.insert(tab.sectors, Sector)
            table.insert(window.tab_sectors, {Tab.Name, tab.sectors})
            sector.increase_scrollbar_size = function()
                local totalHeight = 0
                for _, element in pairs(SectorContent:GetChildren()) do
                    if element:IsA("GuiObject") and element.Name ~= "UIListLayout" and element.Name ~= "UIPadding" then
                        totalHeight = totalHeight + element.AbsoluteSize.Y + 7
                    end
                end
                SectorContent.CanvasSize = UDim2.new(0, 0, 0, totalHeight)
            end
            sector.text = function(_text)
                local text = {}
                local Text = Instance.new("TextLabel")
                Text.Name = _text
                Text.Parent = SectorContent
                Text.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
                Text.BackgroundTransparency = 1.000
                Text.BorderColor3 = Color3.fromRGB(0, 0, 0)
                Text.BorderSizePixel = 0
                Text.Size = UDim2.new(0, 249, 0, 13)
                Text.Font = Enum.Font.SourceSans
                Text.Text = _text
                Text.TextColor3 = themes[theme]["Text"]
                Text.TextSize = 14.000
                Text.TextStrokeTransparency = 0.800
                Text.TextXAlignment = Enum.TextXAlignment.Left
                text.delete = function()
                    Text:Destroy()
                    sector.increase_scrollbar_size()
                end
                text.set = function(new_text)
                    Text.Text = new_text
                end
                sector.increase_scrollbar_size()
                return text
            end
            sector.warning = function(_text)
                local text = {}
                local Text = Instance.new("TextLabel")
                Text.Name = _text
                Text.Parent = SectorContent
                Text.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
                Text.BackgroundTransparency = 1.000
                Text.BorderColor3 = Color3.fromRGB(0, 0, 0)
                Text.BorderSizePixel = 0
                Text.Size = UDim2.new(0, 249, 0, 13)
                Text.Font = Enum.Font.SourceSans
                Text.Text = _text
                Text.TextColor3 = Color3.fromRGB(142, 127, 74)
                Text.TextSize = 14.000
                Text.TextStrokeTransparency = 0.800
                Text.TextXAlignment = Enum.TextXAlignment.Left
                text.delete = function()
                    Text:Destroy()
                    sector.increase_scrollbar_size()
                end
                text.set = function(new_text)
                    Text.Text = new_text
                end
                sector.increase_scrollbar_size()
                return text
            end
            sector.error = function(_text)
                local text = {}
                local Text = Instance.new("TextLabel")
                Text.Name = _text
                Text.Parent = SectorContent
                Text.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
                Text.BackgroundTransparency = 1.000
                Text.BorderColor3 = Color3.fromRGB(0, 0, 0)
                Text.BorderSizePixel = 0
                Text.Size = UDim2.new(0, 249, 0, 13)
                Text.Font = Enum.Font.SourceSans
                Text.Text
