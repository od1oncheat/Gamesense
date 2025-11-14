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
    Tabs.Size = UDim2.new(0, 130, 0, 602)
    UIGridLayout.Parent = Tabs
    UIGridLayout.SortOrder = Enum.SortOrder.LayoutOrder
    UIGridLayout.CellPadding = UDim2.new(0, 15, 0, 0)
    UIGridLayout.CellSize = UDim2.new(0, 100, 0, 70)
    UIPadding.Parent = Tabs
    UIPadding.PaddingLeft = UDim.new(0, 15)
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
    Content.Position = UDim2.new(0.195, 0, 0.0247933883, 0)
    Content.Size = UDim2.new(0, 523, 0, 579)
    UIListLayout.Parent = Content
    UIListLayout.FillDirection = Enum.FillDirection.Horizontal
    UIListLayout.SortOrder = Enum.SortOrder.LayoutOrder
    UIListLayout.Padding = UDim.new(0, 8)
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
    window.tab_contents = {}
    window.selected_tab = ""
    window.show_tab = function(name)
        for _, content in pairs(window.tab_contents) do
            content[2].Visible = (content[1] == name)
        end
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
            Sector.Size = UDim2.new(0.5, -3, 1, 0)
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
            UIListLayout.Padding = UDim.new(0,5)
            UIPadding.Parent = SectorContent
            UIPadding.PaddingLeft = UDim.new(0, 5)
            local UIGradient = Instance.new("UIGradient")
            UIGradient.Color = ColorSequence.new{
                ColorSequenceKeypoint.new(0.00, Color3.fromRGB(255, 255, 255)),
                ColorSequenceKeypoint.new(1.00, Color3.fromRGB(200,200,200))
            }
            UIGradient.Rotation = 90
            UIGradient.Parent = Sector
            sector.increase_scrollbar_size = function()
                local totalHeight = 0
                for _, element in pairs(SectorContent:GetChildren()) do
                    if element:IsA("GuiObject") and element.Name ~= "UIListLayout" and element.Name ~= "UIPadding" then
                        totalHeight = totalHeight + element.AbsoluteSize.Y + 5
                    end
                end
                SectorContent.CanvasSize = UDim2.new(0, 0, 0, totalHeight)
            end
            sector.checkbox = function(text, default, callback)
                local checkbox = {}
                local value = default
                local Checkbox = Instance.new("TextButton")
                local Text = Instance.new("TextLabel")
                local Bg = Instance.new("TextButton")
                local UIGradient = Instance.new("UIGradient")
                Checkbox.Name = ""
                Checkbox.Parent = SectorContent
                Checkbox.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
                Checkbox.BackgroundTransparency = 1.000
                Checkbox.BorderColor3 = Color3.fromRGB(0, 0, 0)
                Checkbox.BorderSizePixel = 0
                Checkbox.Size = UDim2.new(0, 249, 0, 21)
                Checkbox.Font = Enum.Font.SourceSans
                Checkbox.Text = ""
                Checkbox.TextColor3 = Color3.fromRGB(172, 172, 172)
                Checkbox.TextSize = 14.000
                Checkbox.TextXAlignment = Enum.TextXAlignment.Left
                Checkbox.AutoButtonColor = false
                Text.Name = "Text"
                Text.Parent = Checkbox
                Text.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
                Text.BackgroundTransparency = 1.000
                Text.BorderColor3 = Color3.fromRGB(0, 0, 0)
                Text.BorderSizePixel = 0
                Text.Position = UDim2.new(0, 0, 0, 0)
                Text.Size = UDim2.new(0, 226, 0, 21)
                Text.Font = Enum.Font.SourceSans
                Text.TextColor3 = themes[theme]["Text"]
                Text.TextSize = 14.000
                Text.TextStrokeTransparency = 0.800
                Text.TextXAlignment = Enum.TextXAlignment.Left
                Text.Text = text
                Bg.Name = "Bg"
                Bg.Parent = Checkbox
                Bg.BackgroundColor3 = themes[theme]["ToggleUnchecked"]
                Bg.BorderColor3 = themes[theme]["ElementOutline"]
                Bg.BorderSizePixel = 1
                Bg.Position = UDim2.new(1, -15, 0.5, -5)
                Bg.Size = UDim2.new(0, 8, 0, 8)
                Bg.Font = Enum.Font.SourceSans
                Bg.Text = ""
                Bg.TextColor3 = Color3.fromRGB(0, 0, 0)
                Bg.TextSize = 14.000
                Bg.AutoButtonColor = false
                UIGradient.Color = ColorSequence.new{ColorSequenceKeypoint.new(0.00, Color3.fromRGB(255, 255, 255)), ColorSequenceKeypoint.new(1.00, Color3.fromRGB(175, 175, 175))}
                UIGradient.Rotation = 90
                UIGradient.Parent = Bg
                checkbox.set = function(state)
                    value = state
                    Bg.BackgroundColor3 = value and themes[theme]["Toggle"] or themes[theme]["ToggleUnchecked"]
                    callback(value)
                end
                checkbox.set_text = function(new_text)
                    Text.Text = new_text
                end
                checkbox.get = function()
                    return value
                end
                Checkbox.MouseButton1Down:Connect(function()
                    value = not value
                    checkbox.set(value)
                end)
                Bg.MouseButton1Down:Connect(function()
                    value = not value
                    checkbox.set(value)
                end)
                checkbox.set(value)
                sector.increase_scrollbar_size()
                return checkbox
            end
            sector.checkpicker = function(text, default, color_default, callback, color_callback)
                local checkpicker = {}
                local value = default
                local Checkpicker = Instance.new("TextButton")
                local Text = Instance.new("TextLabel")
                local Colorpicker = Instance.new("TextButton")
                local CheckboxBg = Instance.new("TextButton")
                local UIGradient = Instance.new("UIGradient")
                Checkpicker.Name = ""
                Checkpicker.Parent = SectorContent
                Checkpicker.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
                Checkpicker.BackgroundTransparency = 1.000
                Checkpicker.BorderColor3 = Color3.fromRGB(0, 0, 0)
                Checkpicker.BorderSizePixel = 0
                Checkpicker.Size = UDim2.new(0, 249, 0, 21)
                Checkpicker.Font = Enum.Font.SourceSans
                Checkpicker.Text = ""
                Checkpicker.TextColor3 = Color3.fromRGB(172, 172, 172)
                Checkpicker.TextSize = 14.000
                Checkpicker.TextXAlignment = Enum.TextXAlignment.Left
                Checkpicker.AutoButtonColor = false
                Text.Name = "Text"
                Text.Parent = Checkpicker
                Text.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
                Text.BackgroundTransparency = 1.000
                Text.BorderColor3 = Color3.fromRGB(0, 0, 0)
                Text.BorderSizePixel = 0
                Text.Position = UDim2.new(0, 0, 0, 0)
                Text.Size = UDim2.new(0, 180, 0, 21)
                Text.Font = Enum.Font.SourceSans
                Text.TextColor3 = themes[theme]["Text"]
                Text.TextSize = 14.000
                Text.TextStrokeTransparency = 0.800
                Text.TextXAlignment = Enum.TextXAlignment.Left
                Text.Text = text
                Colorpicker.Name = "Colorpicker"
                Colorpicker.Parent = Checkpicker
                Colorpicker.BackgroundColor3 = color_default
                Colorpicker.BorderColor3 = Color3.fromRGB(40, 40, 40)
                Colorpicker.BorderSizePixel = 1
                Colorpicker.Position = UDim2.new(1, -55, 0.5, -4)
                Colorpicker.Size = UDim2.new(0, 20, 0, 8)
                Colorpicker.AutoButtonColor = false
                Colorpicker.Font = Enum.Font.SourceSans
                Colorpicker.Text = ""
                Colorpicker.TextColor3 = Color3.fromRGB(0, 0, 0)
                Colorpicker.TextSize = 14.000
                CheckboxBg.Name = "CheckboxBg"
                CheckboxBg.Parent = Checkpicker
                CheckboxBg.BackgroundColor3 = themes[theme]["ToggleUnchecked"]
                CheckboxBg.BorderColor3 = themes[theme]["ElementOutline"]
                CheckboxBg.BorderSizePixel = 1
                CheckboxBg.Position = UDim2.new(1, -15, 0.5, -4)
                CheckboxBg.Size = UDim2.new(0, 8, 0, 8)
                CheckboxBg.Font = Enum.Font.SourceSans
                CheckboxBg.Text = ""
                CheckboxBg.TextColor3 = Color3.fromRGB(0, 0, 0)
                CheckboxBg.TextSize = 14.000
                CheckboxBg.AutoButtonColor = false
                UIGradient.Color = ColorSequence.new{ColorSequenceKeypoint.new(0.00, Color3.fromRGB(255, 255, 255)), ColorSequenceKeypoint.new(1.00, Color3.fromRGB(175, 175, 175))}
                UIGradient.Rotation = 90
                UIGradient.Parent = CheckboxBg
                local default_hue, default_saturation, default_value = color_default:ToHSV()
                local hue_value = default_hue
                local sat_value = default_saturation
                local value_value = default_value
                local ColorPicker = Instance.new("Frame")
                local Hue = Instance.new("ImageButton")
                local HueDrag = Instance.new("Frame")
                local Saturation = Instance.new("TextButton")
                local ValueGradient = Instance.new("UIGradient")
                local SaturationDrag = Instance.new("Frame")
                ColorPicker.Name = "ColorPicker"
                ColorPicker.Parent = Sector
                ColorPicker.BackgroundColor3 = Color3.fromRGB(27, 27, 27)
                ColorPicker.BorderColor3 = Color3.fromRGB(40, 40, 40)
                ColorPicker.BorderSizePixel = 2
                ColorPicker.Size = UDim2.new(0, 120, 0, 80)
                ColorPicker.Visible = false
                ColorPicker.Active = true
                ColorPicker.Draggable = false
                Hue.Name = "Hue"
                Hue.Parent = ColorPicker
                Hue.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
                Hue.BorderColor3 = Color3.fromRGB(0, 0, 0)
                Hue.BorderSizePixel = 0
                Hue.Position = UDim2.new(0.08, 0, 0.1, 0)
                Hue.Size = UDim2.new(0, 20, 0, 60)
                Hue.Image = "rbxassetid://12966903157"
                Hue.AutoButtonColor = false
                HueDrag.Name = "HueDrag"
                HueDrag.Parent = Hue
                HueDrag.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
                HueDrag.BorderColor3 = Color3.fromRGB(0, 0, 0)
                HueDrag.BorderSizePixel = 1
                HueDrag.Size = UDim2.new(1, 0, 0, 4)
                HueDrag.Position = UDim2.new(0, 0, 1 - hue_value, 0)
                Saturation.Name = "Saturation"
                Saturation.Parent = ColorPicker
                Saturation.BackgroundColor3 = Color3.fromHSV(hue_value, 1, 1)
                Saturation.BorderColor3 = Color3.fromRGB(0, 0, 0)
                Saturation.BorderSizePixel = 0
                Saturation.Position = UDim2.new(0.3, 0, 0.1, 0)
                Saturation.Size = UDim2.new(0, 60, 0, 60)
                Saturation.Font = Enum.Font.SourceSans
                Saturation.Text = ""
                Saturation.TextColor3 = Color3.fromRGB(0, 0, 0)
                Saturation.TextSize = 14.000
                Saturation.AutoButtonColor = false
                ValueGradient.Color = ColorSequence.new{
                    ColorSequenceKeypoint.new(0.00, Color3.fromRGB(255, 255, 255)),
                    ColorSequenceKeypoint.new(1.00, Color3.fromRGB(0, 0, 0))
                }
                ValueGradient.Rotation = 90
                ValueGradient.Parent = Saturation
                SaturationDrag.Name = "SaturationDrag"
                SaturationDrag.Parent = Saturation
                SaturationDrag.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
                SaturationDrag.BorderColor3 = Color3.fromRGB(0, 0, 0)
                SaturationDrag.BorderSizePixel = 1
                SaturationDrag.Size = UDim2.new(0, 4, 0, 4)
                SaturationDrag.Position = UDim2.new(sat_value, -2, 1 - value_value, -2)
                local function updateColor()
                    local color = Color3.fromHSV(hue_value, sat_value, value_value)
                    Saturation.BackgroundColor3 = Color3.fromHSV(hue_value, 1, 1)
                    Colorpicker.BackgroundColor3 = color
                    color_callback(color)
                end
                local function set_cp(h, s, v)
                    hue_value = h or hue_value
                    sat_value = s or sat_value
                    value_value = v or value_value
                    SaturationDrag.Position = UDim2.new(sat_value, -2, 1 - value_value, -2)
                    HueDrag.Position = UDim2.new(0, 0, 1 - hue_value, 0)
                    updateColor()
                end
                local draggingConnection
                Saturation.InputBegan:Connect(function(input)
                    if input.UserInputType == Enum.UserInputType.MouseButton1 then
                        draggingConnection = services.run.RenderStepped:Connect(function()
                            if not services.uis:IsMouseButtonPressed(Enum.UserInputType.MouseButton1) then
                                draggingConnection:Disconnect()
                                return
                            end
                            local mouse = game.Players.LocalPlayer:GetMouse()
                            local mouse_pos = Vector2.new(mouse.X, mouse.Y)
                            local abs_pos = Saturation.AbsolutePosition
                            local abs_size = Saturation.AbsoluteSize
                            local x = math.clamp((mouse_pos.X - abs_pos.X) / abs_size.X, 0, 1)
                            local y = math.clamp((mouse_pos.Y - abs_pos.Y) / abs_size.Y, 0, 1)
                            sat_value = x
                            value_value = 1 - y
                            set_cp(hue_value, sat_value, value_value)
                        end)
                    end
                end)
                Hue.InputBegan:Connect(function(input)
                    if input.UserInputType == Enum.UserInputType.MouseButton1 then
                        draggingConnection = services.run.RenderStepped:Connect(function()
                            if not services.uis:IsMouseButtonPressed(Enum.UserInputType.MouseButton1) then
                                draggingConnection:Disconnect()
                                return
                            end
                            local mouse = game.Players.LocalPlayer:GetMouse()
                            local mouse_pos = Vector2.new(mouse.X, mouse.Y)
                            local abs_pos = Hue.AbsolutePosition
                            local abs_size = Hue.AbsoluteSize
                            local y = math.clamp((mouse_pos.Y - abs_pos.Y) / abs_size.Y, 0, 1)
                            hue_value = 1 - y
                            set_cp(hue_value, sat_value, value_value)
                        end)
                    end
                end)
                Colorpicker.MouseButton1Down:Connect(function()
                    for _, element in pairs(Sector:GetChildren()) do
                        if element.Name == "ColorPicker" and element ~= ColorPicker then
                            element.Visible = false
                        end
                    end
                    local abs_pos = Colorpicker.AbsolutePosition
                    ColorPicker.Position = UDim2.new(0, abs_pos.X - Sector.AbsolutePosition.X - 120, 0, abs_pos.Y - Sector.AbsolutePosition.Y + 15)
                    ColorPicker.Visible = not ColorPicker.Visible
                    if draggingConnection then
                        draggingConnection:Disconnect()
                    end
                end)
                set_cp(default_hue, default_saturation, default_value)
                checkpicker.set = function(state)
                    value = state
                    CheckboxBg.BackgroundColor3 = value and themes[theme]["Toggle"] or themes[theme]["ToggleUnchecked"]
                    callback(value)
                end
                checkpicker.set_text = function(new_text)
                    Text.Text = new_text
                end
                checkpicker.get = function()
                    return value
                end
                checkpicker.get_color = function()
                    return Colorpicker.BackgroundColor3
                end
                checkpicker.set_color = function(color)
                    local h, s, v = color:ToHSV()
                    set_cp(h, s, v)
                end
                Checkpicker.MouseButton1Down:Connect(function()
                    value = not value
                    checkpicker.set(value)
                end)
                CheckboxBg.MouseButton1Down:Connect(function()
                    value = not value
                    checkpicker.set(value)
                end)
                checkpicker.set(value)
                sector.increase_scrollbar_size()
                return checkpicker
            end
            sector.slider = function(text, indicator, min, max, default, callback)
                local slider = {}
                local value = default
                local dragging = false
                local Slider = Instance.new("Frame")
                local Text = Instance.new("TextLabel")
                local Bg = Instance.new("TextButton")
                local UIGradient = Instance.new("UIGradient")
                local Fill = Instance.new("TextButton")
                local UIGradient_2 = Instance.new("UIGradient")
                Slider.Name = "Slider"
                Slider.Parent = SectorContent
                Slider.BackgroundTransparency = 1
                Slider.Size = UDim2.new(0, 249, 0, 30)
                Text.Name = "Text"
                Text.Parent = Slider
                Text.BackgroundTransparency = 1
                Text.Position = UDim2.new(0, 0, 0, 0)
                Text.Size = UDim2.new(0, 226, 0, 14)
                Text.Font = Enum.Font.SourceSans
                Text.TextColor3 = themes[theme]["Text"]
                Text.TextSize = 14.000
                Text.TextStrokeTransparency = 0.800
                Text.TextXAlignment = Enum.TextXAlignment.Left
                Text.Text = text .. " " .. default .. indicator
                Bg.Name = "Bg"
                Bg.Parent = Slider
                Bg.BackgroundColor3 = themes[theme]["SliderBg"]
                Bg.BorderColor3 = themes[theme]["ElementOutline"]
                Bg.Position = UDim2.new(0, 0, 0.6, 0)
                Bg.Size = UDim2.new(0, 238, 0, 8)
                Bg.AutoButtonColor = false
                Bg.Font = Enum.Font.SourceSans
                Bg.Text = ""
                Bg.TextColor3 = Color3.fromRGB(0, 0, 0)
                Bg.TextSize = 14.000
                UIGradient.Color = ColorSequence.new{
                    ColorSequenceKeypoint.new(0.00, Color3.fromRGB(255, 255, 255)),
                    ColorSequenceKeypoint.new(1.00, Color3.fromRGB(175, 175, 175))
                }
                UIGradient.Rotation = 90
                UIGradient.Parent = Bg
                Fill.Name = "Fill"
                Fill.Parent = Bg
                Fill.BackgroundColor3 = themes[theme]["Slider"]
                Fill.BorderSizePixel = 0
                Fill.Position = UDim2.new(0, 0, 0, 0)
                Fill.Size = UDim2.new(((default - min) / (max - min)), 0, 1, 0)
                Fill.AutoButtonColor = false
                Fill.Font = Enum.Font.SourceSans
                Fill.Text = ""
                Fill.TextColor3 = Color3.fromRGB(0, 0, 0)
                Fill.TextSize = 14.000
                UIGradient_2.Color = ColorSequence.new{
                    ColorSequenceKeypoint.new(0.00, Color3.fromRGB(255, 255, 255)),
                    ColorSequenceKeypoint.new(1.00, Color3.fromRGB(175, 175, 175))
                }
                UIGradient_2.Rotation = 90
                UIGradient_2.Parent = Fill
                local function updateSlider(percentage)
                    local clamped = math.clamp(percentage, 0, 100)
                    local scale = clamped / 100
                    Fill.Size = UDim2.new(scale, 0, 1, 0)
                    value = min + (max - min) * scale
                    local rounded = math.floor(value * 100 + 0.5) / 100
                    Text.Text = text .. " " .. rounded .. indicator
                    callback(value)
                end
                slider.set = function(percentage)
                    updateSlider(percentage)
                end
                slider.get = function()
                    return value
                end
                slider.set_text = function(new_text)
                    text = new_text
                    local rounded = math.floor(value * 100 + 0.5) / 100
                    Text.Text = new_text .. " " .. rounded .. indicator
                end
                local conn
                conn = services.run.RenderStepped:Connect(function()
                    if dragging then
                        local mouse = game.Players.LocalPlayer:GetMouse()
                        local abs_pos = Bg.AbsolutePosition
                        local abs_size = Bg.AbsoluteSize
                        local relative_x = (mouse.X - abs_pos.X) / abs_size.X * 100
                        updateSlider(relative_x)
                    end
                end)
                Bg.InputBegan:Connect(function(input)
                    if input.UserInputType == Enum.UserInputType.MouseButton1 then
                        dragging = true
                    end
                end)
                Bg.InputEnded:Connect(function(input)
                    if input.UserInputType == Enum.UserInputType.MouseButton1 then
                        dragging = false
                    end
                end)
                Fill.InputBegan:Connect(function(input)
                    if input.UserInputType == Enum.UserInputType.MouseButton1 then
                        dragging = true
                    end
                end)
                Fill.InputEnded:Connect(function(input)
                    if input.UserInputType == Enum.UserInputType.MouseButton1 then
                        dragging = false
                    end
                end)
                slider.delete = function()
                    if conn then
                        conn:Disconnect()
                    end
                    Slider:Destroy()
                    sector.increase_scrollbar_size()
                end
                local initial_percentage = ((default - min) / (max - min)) * 100
                updateSlider(initial_percentage)
                sector.increase_scrollbar_size()
                return slider
            end
            table.insert(window.tab_contents, {Tab.Name, Sector})
            if #window.tab_contents == 1 then
                window.selected_tab = Tab.Name
                window.tab_colors(Tab)
                window.show_tab(Tab.Name)
            end
            return sector
        end
        return tab
    end
    return window
end
return lib
