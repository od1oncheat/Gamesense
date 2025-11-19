local lib = {}
local services = {
    ["uis"] = game:GetService("UserInputService"),
    ["run"] = game:GetService("RunService"),
    ["tween"] = game:GetService("TweenService")
}

-- === ТЕМЫ (как ты просил) ===
local themes = {
    ["gamesense"] = { -- тёмно-зелёная (классика)
        Window = Color3.fromRGB(8, 12, 8),
        Tabs = Color3.fromRGB(6, 10, 6),
        Gradient = ColorSequence.new{
            ColorSequenceKeypoint.new(0, Color3.fromRGB(0, 180, 80)),
            ColorSequenceKeypoint.new(0.5, Color3.fromRGB(135, 176, 27)),
            ColorSequenceKeypoint.new(1, Color3.fromRGB(0, 200, 60))
        },
        Sector = Color3.fromRGB(12, 20, 12),
        Text = Color3.fromRGB(180, 220, 180),
        TabSelected = Color3.fromRGB(10, 18, 10),
        ElementBg = Color3.fromRGB(18, 28, 18),
        ElementOutline = Color3.fromRGB(35, 55, 35),
        DropdownSelected = Color3.fromRGB(135, 176, 27),
        Toggle = Color3.fromRGB(135, 176, 27),
        ToggleUnchecked = Color3.fromRGB(25, 40, 25),
        Slider = Color3.fromRGB(135, 176, 27),
        SliderBg = Color3.fromRGB(18, 28, 18),
        ButtonHover = Color3.fromRGB(30, 50, 30),
        ButtonPressed = Color3.fromRGB(40, 65, 40)
    },
    ["neverlose"] = { -- чёрно-синяя (2025 стиль)
        Window = Color3.fromRGB(8, 8, 15),
        Tabs = Color3.fromRGB(6, 6, 13),
        Gradient = ColorSequence.new{
            ColorSequenceKeypoint.new(0, Color3.fromRGB(0, 100, 255)),
            ColorSequenceKeypoint.new(0.5, Color3.fromRGB(50, 150, 255)),
            ColorSequenceKeypoint.new(1, Color3.fromRGB(100, 200, 255))
        },
        Sector = Color3.fromRGB(12, 12, 22),
        Text = Color3.fromRGB(200, 220, 255),
        TabSelected = Color3.fromRGB(10, 10, 20),
        ElementBg = Color3.fromRGB(18, 18, 35),
        ElementOutline = Color3.fromRGB(40, 40, 80),
        DropdownSelected = Color3.fromRGB(80, 160, 255),
        Toggle = Color3.fromRGB(80, 160, 255),
        ToggleUnchecked = Color3.fromRGB(30, 30, 55),
        Slider = Color3.fromRGB(80, 160, 255),
        SliderBg = Color3.fromRGB(18, 18, 35),
        ButtonHover = Color3.fromRGB(35, 35, 70),
        ButtonPressed = Color3.fromRGB(50, 50, 90)
    },
    ["fatality"] = { -- фиолетовая (как в Fatality.win 2025)
        Window = Color3.fromRGB(15, 8, 20),
        Tabs = Color3.fromRGB(12, 6, 18),
        Gradient = ColorSequence.new{
            ColorSequenceKeypoint.new(0, Color3.fromRGB(140, 0, 255)),
            ColorSequenceKeypoint.new(0.5, Color3.fromRGB(180, 50, 255)),
            ColorSequenceKeypoint.new(1, Color3.fromRGB(220, 100, 255))
        },
        Sector = Color3.fromRGB(22, 12, 30),
        Text = Color3.fromRGB(230, 200, 255),
        TabSelected = Color3.fromRGB(18, 10, 25),
        ElementBg = Color3.fromRGB(30, 18, 45),
        ElementOutline = Color3.fromRGB(70, 40, 100),
        DropdownSelected = Color3.fromRGB(180, 80, 255),
        Toggle = Color3.fromRGB(180, 80, 255),
        ToggleUnchecked = Color3.fromRGB(50, 25, 70),
        Slider = Color3.fromRGB(180, 80, 255),
        SliderBg = Color3.fromRGB(30, 18, 45),
        ButtonHover = Color3.fromRGB(55, 30, 85),
        ButtonPressed = Color3.fromRGB(75, 45, 110)
    },
    ["aimware"] = { -- бело-красная (чистый стиль Aimware v5+)
        Window = Color3.fromRGB(20, 20, 20),
        Tabs = Color3.fromRGB(18, 18, 18),
        Gradient = ColorSequence.new{
            ColorSequenceKeypoint.new(0, Color3.fromRGB(255, 80, 80)),
            ColorSequenceKeypoint.new(0.5, Color3.fromRGB(255, 120, 120)),
            ColorSequenceKeypoint.new(1, Color3.fromRGB(255, 160, 160))
        },
        Sector = Color3.fromRGB(28, 28, 28),
        Text = Color3.fromRGB(240, 240, 240),
        TabSelected = Color3.fromRGB(25, 25, 25),
        ElementBg = Color3.fromRGB(35, 35, 35),
        ElementOutline = Color3.fromRGB(80, 80, 80),
        DropdownSelected = Color3.fromRGB(255, 90, 90),
        Toggle = Color3.fromRGB(255, 90, 90),
        ToggleUnchecked = Color3.fromRGB(60, 60, 60),
        Slider = Color3.fromRGB(255, 90, 90),
        SliderBg = Color3.fromRGB(35, 35, 35),
        ButtonHover = Color3.fromRGB(55, 55, 55),
        ButtonPressed = Color3.fromRGB(75, 75, 75)
    },
    ["nixware"] = { -- серо-белая (минимализм Nixware 2025)
        Window = Color3.fromRGB(22, 22, 22),
        Tabs = Color3.fromRGB(20, 20, 20),
        Gradient = ColorSequence.new{
            ColorSequenceKeypoint.new(0, Color3.fromRGB(180, 180, 180)),
            ColorSequenceKeypoint.new(0.5, Color3.fromRGB(220, 220, 220)),
            ColorSequenceKeypoint.new(1, Color3.fromRGB(255, 255, 255))
        },
        Sector = Color3.fromRGB(30, 30, 30),
        Text = Color3.fromRGB(230, 230, 230),
        TabSelected = Color3.fromRGB(28, 28, 28),
        ElementBg = Color3.fromRGB(40, 40, 40),
        ElementOutline = Color3.fromRGB(70, 70, 70),
        DropdownSelected = Color3.fromRGB(200, 200, 200),
        Toggle = Color3.fromRGB(200, 200, 200),
        ToggleUnchecked = Color3.fromRGB(60, 60, 60),
        Slider = Color3.fromRGB(200, 200, 200),
        SliderBg = Color3.fromRGB(40, 40, 40),
        ButtonHover = Color3.fromRGB(65, 65, 65),
        ButtonPressed = Color3.fromRGB(85, 85, 85)
    }
}

-- === Защита GUI ===
local function gethui()
    local coreGui = game:GetService("CoreGui")
    local playerGui = game.Players.LocalPlayer:FindFirstChild("PlayerGui")
    if coreGui and (syn or getexecutorname) then
        return coreGui
    else
        return playerGui or game.Players.LocalPlayer:WaitForChild("PlayerGui")
    end
end

local function protectgui(gui)
    if syn and syn.protect_gui then
        syn.protect_gui(gui)
    elseif get_hui_gui and type(get_hui_gui) == "function" then
        get_hui_gui(gui)
    end
    gui.Parent = gethui()
    if identifyexecutor and string.find(string.lower(identifyexecutor()), "scriptware") then
        gui.Parent = gethui()
    end
end

-- === Создание окна ===
lib.create_window = function(theme_name, menu_key)
    local targetParent = gethui()
    if targetParent:FindFirstChild("Mute") then
        targetParent:FindFirstChild("Mute"):Destroy()
    end
    local theme = themes[theme_name] or themes["gamesense"]
    menu_key = menu_key or Enum.KeyCode.Insert
    local window = {}
    
    local Mute = Instance.new("ScreenGui")
    protectgui(Mute)
    Mute.Name = "Mute"
    Mute.Parent = targetParent
    Mute.ZIndexBehavior = Enum.ZIndexBehavior.Global
    Mute.ResetOnSpawn = false
    Mute.DisplayOrder = 999999
    Mute.IgnoreGuiInset = true
    Mute.Enabled = true

    local Main = Instance.new("Frame")
    Main.Name = "Main"
    Main.Parent = Mute
    Main.BackgroundColor3 = theme.Window
    Main.BorderColor3 = Color3.fromRGB(40, 40, 40)
    Main.BorderSizePixel = 3
    Main.Position = UDim2.new(0.38, 0, 0.25, 0)
    Main.Size = UDim2.new(0, 684, 0, 605)

    local TopGradient = Instance.new("Frame")
    TopGradient.Name = "TopGradient"
    TopGradient.Parent = Main
    TopGradient.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
    TopGradient.BorderSizePixel = 0
    TopGradient.Size = UDim2.new(1, 0, 0, 2)
    local UIGradient = Instance.new("UIGradient")
    UIGradient.Color = theme.Gradient
    UIGradient.Parent = TopGradient

    local Tabs = Instance.new("Frame")
    Tabs.Name = "Tabs"
    Tabs.Parent = Main
    Tabs.BackgroundColor3 = theme.Tabs
    Tabs.BorderColor3 = Color3.fromRGB(18, 18, 18)
    Tabs.BorderSizePixel = 2
    Tabs.Position = UDim2.new(0, 1, 0, 3)
    Tabs.Size = UDim2.new(0, 100, 0, 602)

    local UIGridLayout = Instance.new("UIGridLayout")
    UIGridLayout.Parent = Tabs
    UIGridLayout.SortOrder = Enum.SortOrder.LayoutOrder
    UIGridLayout.CellPadding = UDim2.new(0, 15, 0, 0)
    UIGridLayout.CellSize = UDim2.new(0, 85, 0, 70)

    local UIPadding = Instance.new("UIPadding")
    UIPadding.Parent = Tabs
    UIPadding.PaddingLeft = UDim.new(0, 14)
    UIPadding.PaddingTop = UDim.new(0, 15)

    local Content = Instance.new("Frame")
    Content.Name = "Content"
    Content.Parent = Main
    Content.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
    Content.BackgroundTransparency = 1
    Content.BorderSizePixel = 0
    Content.Position = UDim2.new(0.165, 0, 0.025, 0)
    Content.Size = UDim2.new(0, 553, 0, 579)

    local UIListLayout = Instance.new("UIListLayout")
    UIListLayout.Parent = Content
    UIListLayout.FillDirection = Enum.FillDirection.Horizontal
    UIListLayout.SortOrder = Enum.SortOrder.LayoutOrder
    UIListLayout.Padding = UDim.new(0, 10)

    -- === Драг ===
    window.dragging = false
    window.drag_input = nil
    window.drag_start = nil
    window.start_pos = nil
    local function update_window(input)
        local delta = input.Position - window.drag_start
        Main.Position = UDim2.new(window.start_pos.X.Scale, window.start_pos.X.Offset + delta.X, window.start_pos.Y.Scale, window.start_pos.Y.Offset + delta.Y)
    end
    local function drag_began(input)
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
    local function drag_changed(input)
        if input.UserInputType == Enum.UserInputType.MouseMovement or input.UserInputType == Enum.UserInputType.Touch then
            window.drag_input = input
        end
    end
    Tabs.InputBegan:Connect(drag_began)
    Tabs.InputChanged:Connect(drag_changed)
    Main.InputBegan:Connect(drag_began)
    Main.InputChanged:Connect(drag_changed)
    services.uis.InputChanged:Connect(function(input)
        if input == window.drag_input and window.dragging then
            update_window(input)
        end
    end)

    -- === Тоггл ===
    services.uis.InputBegan:Connect(function(input)
        if input.KeyCode == menu_key then
            Mute.Enabled = not Mute.Enabled
        end
    end)

    window.tab_contents = {}
    window.selected_tab = ""
    function window.show_tab(name)
        for _, content in pairs(window.tab_contents) do
            content[2].Visible = (content[1] == name)
        end
    end
    function window.tab_active(tab)
        local ti = TweenInfo.new(0.2, Enum.EasingStyle.Quad, Enum.EasingDirection.Out)
        services.tween:Create(tab, ti, {BackgroundTransparency = 0}):Play()
        services.tween:Create(tab.Open, ti, {ImageColor3 = Color3.fromRGB(209, 210, 208)}):Play()
    end
    function window.tab_inactive(tab)
        local ti = TweenInfo.new(0.2, Enum.EasingStyle.Quad, Enum.EasingDirection.Out)
        services.tween:Create(tab, ti, {BackgroundTransparency = 1}):Play()
        services.tween:Create(tab.Open, ti, {ImageColor3 = Color3.fromRGB(90,90,90)}):Play()
    end
    function window.tab_colors(ignore)
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

    function window.create_tab(image)
        local tab = {sectorCount = 0}
        local Tab = Instance.new("TextButton")
        Tab.Name = image:sub(14)
        Tab.Parent = Tabs
        Tab.BackgroundColor3 = theme.TabSelected
        Tab.BorderColor3 = Color3.fromRGB(18, 18, 18)
        Tab.BackgroundTransparency = 1
        Tab.BorderSizePixel = 2
        Tab.Size = UDim2.new(0, 108, 0, 70)
        Tab.AutoButtonColor = false
        Tab.Font = Enum.Font.SourceSans
        Tab.Text = ""
        Tab.TextColor3 = Color3.fromRGB(0, 0, 0)
        Tab.TextSize = 14

        local Open = Instance.new("ImageButton")
        Open.Name = "Open"
        Open.Parent = Tab
        Open.BackgroundTransparency = 1
        Open.BorderSizePixel = 0
        Open.Position = UDim2.new(0.16, 0, 0.19, 0)
        Open.Size = UDim2.new(0, 43, 0, 43)
        Open.Image = image
        Open.ImageColor3 = Color3.fromRGB(90,90,90)

        Open.MouseButton1Down:Connect(function()
            window.selected_tab = Tab.Name
            window.tab_colors(Tab)
            window.show_tab(Tab.Name)
        end)

        function tab.create_sector(name)
            if tab.sectorCount >= 2 then
                error("Cannot create more than 2 sectors per tab")
                return nil
            end
            tab.sectorCount = tab.sectorCount + 1
            local sector = {}
            local Sector = Instance.new("Frame")
            Sector.Name = name
            Sector.Parent = Content
            Sector.BackgroundColor3 = theme.Sector
            Sector.BorderColor3 = Color3.fromRGB(30, 30, 30)
            Sector.BorderSizePixel = 2
            Sector.Position = (tab.sectorCount == 2) and UDim2.new(0.5, 5, 0, 0) or UDim2.new(0, 0, 0, 0)
            Sector.Size = UDim2.new(0.5, -5, 1, 0)
            Sector.Visible = false
            Sector.ClipsDescendants = false

            local Title = Instance.new("TextLabel")
            Title.Name = "Title"
            Title.Parent = Sector
            Title.BackgroundTransparency = 1
            Title.BorderSizePixel = 0
            Title.Position = UDim2.new(0.03, 0, 0, 0)
            Title.Size = UDim2.new(0, 268, 0, 20)
            Title.Font = Enum.Font.SourceSans
            Title.TextColor3 = theme.Text
            Title.TextSize = 18
            Title.TextStrokeColor3 = Color3.fromRGB(42, 42, 42)
            Title.TextStrokeTransparency = 0.5
            Title.TextXAlignment = Enum.TextXAlignment.Left
            Title.Text = name

            local SectorContent = Instance.new("ScrollingFrame")
            SectorContent.Name = "SectorContent"
            SectorContent.Parent = Sector
            SectorContent.Active = true
            SectorContent.BackgroundTransparency = 1
            SectorContent.BorderSizePixel = 0
            SectorContent.Position = UDim2.new(0.03, 0, 0.04, 0)
            SectorContent.Size = UDim2.new(0, 259, 0, 550)
            SectorContent.CanvasSize = UDim2.new(0, 0, 0, 0)
            SectorContent.ScrollBarThickness = 3
            SectorContent.ClipsDescendants = true

            local UIListLayout = Instance.new("UIListLayout")
            UIListLayout.Parent = SectorContent
            UIListLayout.SortOrder = Enum.SortOrder.LayoutOrder
            UIListLayout.Padding = UDim.new(0, 5)

            local UIPadding = Instance.new("UIPadding")
            UIPadding.Parent = SectorContent
            UIPadding.PaddingLeft = UDim.new(0, 5)
            UIPadding.PaddingTop = UDim.new(0, 5)  -- Фикс обрезки первого элемента

            local function increase_scrollbar_size()
                local totalHeight = 0
                for _, element in pairs(SectorContent:GetChildren()) do
                    if element:IsA("GuiObject") and element ~= UIListLayout and element ~= UIPadding then
                        totalHeight = totalHeight + element.AbsoluteSize.Y + 5
                    end
                end
                SectorContent.CanvasSize = UDim2.new(0, 0, 0, totalHeight + 10)
            end

            -- === Элементы (text, warning, error, info) ===
            sector.text = function(_text)
                local text = {}
                local Text = Instance.new("TextLabel")
                Text.Name = _text
                Text.Parent = SectorContent
                Text.BackgroundTransparency = 1
                Text.BorderSizePixel = 0
                Text.Size = UDim2.new(0, 249, 0, 13)
                Text.Font = Enum.Font.SourceSans
                Text.Text = _text
                Text.TextColor3 = theme.Text
                Text.TextSize = 14
                Text.TextStrokeTransparency = 0.8
                Text.TextXAlignment = Enum.TextXAlignment.Left
                text.delete = function() Text:Destroy() end
                text.set = function(t) Text.Text = t end
                increase_scrollbar_size()
                return text
            end
            sector.warning = function(_text)
                local t = sector.text(_text)
                t.TextColor3 = Color3.fromRGB(142, 127, 74)
                return t
            end
            sector.error = function(_text)
                local t = sector.text(_text)
                t.TextColor3 = Color3.fromRGB(142, 74, 65)
                return t
            end
            sector.info = function(_text)
                local t = sector.text(_text)
                t.TextColor3 = Color3.fromRGB(63, 110, 152)
                return t
            end

            -- === Button ===
            sector.button = function(text, callback)
                local button = {}
                local Button = Instance.new("TextButton")
                Button.Name = "Button"
                Button.Parent = SectorContent
                Button.BackgroundColor3 = theme.ElementBg
                Button.BorderColor3 = theme.ElementOutline
                Button.BorderSizePixel = 1
                Button.Size = UDim2.new(0, 249, 0, 21)
                Button.AutoButtonColor = false
                Button.Font = Enum.Font.SourceSans
                Button.TextColor3 = theme.Text
                Button.TextSize = 14
                Button.Text = text
                local ti = TweenInfo.new(0.2, Enum.EasingStyle.Quad, Enum.EasingDirection.Out)
                Button.MouseEnter:Connect(function()
                    services.tween:Create(Button, ti, {BackgroundColor3 = theme.ButtonHover}):Play()
                end)
                Button.MouseLeave:Connect(function()
                    services.tween:Create(Button, ti, {BackgroundColor3 = theme.ElementBg}):Play()
                end)
                Button.MouseButton1Down:Connect(function()
                    services.tween:Create(Button, TweenInfo.new(0.1), {BackgroundColor3 = theme.ButtonPressed}):Play()
                    callback()
                end)
                increase_scrollbar_size()
                button.delete = function() Button:Destroy() end
                button.set = function(t) Button.Text = t end
                return button
            end

            -- === Textbox ===
            sector.textbox = function(placeholder, default, callback)
                local textbox = {}
                local TextBox = Instance.new("TextBox")
                TextBox.Parent = SectorContent
                TextBox.BackgroundColor3 = theme.ElementBg
                TextBox.BorderColor3 = theme.ElementOutline
                TextBox.BorderSizePixel = 1
                TextBox.Size = UDim2.new(0, 249, 0, 21)
                TextBox.ClearTextOnFocus = false
                TextBox.Font = Enum.Font.SourceSans
                TextBox.PlaceholderColor3 = Color3.fromRGB(65, 65, 65)
                TextBox.PlaceholderText = placeholder
                TextBox.Text = default or ""
                TextBox.TextColor3 = theme.Text
                TextBox.TextSize = 14
                TextBox.TextStrokeTransparency = 0.8
                TextBox.TextXAlignment = Enum.TextXAlignment.Left
                local pad = Instance.new("UIPadding", TextBox)
                pad.PaddingLeft = UDim.new(0, 5)
                local ti = TweenInfo.new(0.2)
                TextBox.MouseEnter:Connect(function()
                    services.tween:Create(TextBox, ti, {BackgroundColor3 = theme.ButtonHover}):Play()
                end)
                TextBox.MouseLeave:Connect(function()
                    services.tween:Create(TextBox, ti, {BackgroundColor3 = theme.ElementBg}):Play()
                end)
                TextBox:GetPropertyChangedSignal("Text"):Connect(function()
                    callback(TextBox.Text)
                end)
                if default then callback(default) end
                increase_scrollbar_size()
                textbox.set = function(t) TextBox.Text = t end
                textbox.get = function() return TextBox.Text end
                textbox.delete = function() TextBox:Destroy() end
                return textbox
            end

            -- === Toggle ===
            sector.toggle = function(text, default, callback)
                local toggle = {}
                local value = default or false
                local Toggle = Instance.new("TextButton")
                Toggle.Name = text
                Toggle.Parent = SectorContent
                Toggle.BackgroundTransparency = 1
                Toggle.BorderSizePixel = 0
                Toggle.Size = UDim2.new(0, 249, 0, 18)
                Toggle.Font = Enum.Font.SourceSans
                Toggle.Text = ""
                Toggle.TextColor3 = Color3.fromRGB(172, 172, 172)
                Toggle.TextSize = 14
                Toggle.TextXAlignment = Enum.TextXAlignment.Left

                local Txt = Instance.new("TextLabel")
                Txt.Name = "Text"
                Txt.Parent = Toggle
                Txt.BackgroundTransparency = 1
                Txt.BorderSizePixel = 0
                Txt.Position = UDim2.new(0.09, 0, 0, 0)
                Txt.Size = UDim2.new(0, 226, 0, 18)
                Txt.Font = Enum.Font.SourceSans
                Txt.TextColor3 = theme.Text
                Txt.TextSize = 14
                Txt.TextStrokeTransparency = 0.8
                Txt.TextXAlignment = Enum.TextXAlignment.Left
                Txt.Text = text

                local Bg = Instance.new("TextButton")
                Bg.Name = "Bg"
                Bg.Parent = Toggle
                Bg.BackgroundColor3 = theme.ToggleUnchecked
                Bg.BorderColor3 = theme.ElementOutline
                Bg.BorderSizePixel = 1
                Bg.Position = UDim2.new(0, 5, 0.2, 0)
                Bg.Size = UDim2.new(0, 8, 0, 8)
                Bg.AutoButtonColor = false
                Bg.Font = Enum.Font.SourceSans
                Bg.Text = ""
                Bg.TextColor3 = Color3.new(0,0,0)
                Bg.TextSize = 14

                local ti = TweenInfo.new(0.2)
                Bg.MouseEnter:Connect(function()
                    services.tween:Create(Bg, ti, {Size = UDim2.new(0, 10, 0, 10)}):Play()
                end)
                Bg.MouseLeave:Connect(function()
                    services.tween:Create(Bg, ti, {Size = UDim2.new(0, 8, 0, 8)}):Play()
                end)

                function toggle.set(v)
                    value = v
                    local col = v and theme.Toggle or theme.ToggleUnchecked
                    services.tween:Create(Bg, ti, {BackgroundColor3 = col}):Play()
                    callback(v)
                end

                toggle.get = function() return value end
                toggle.set_text = function(t) Txt.Text = t end
                toggle.add_color = function(_default, cpcallback)
                    -- Colorpicker код (как в оригинале, но без ошибок — полный HSV)
                    local colorpicker = {}
                    local choosing_hue, choosing_saturation, choosing_value = false, false, false
                    local ColorpickerBtn = Instance.new("TextButton")
                    ColorpickerBtn.Name = "Colorpicker"
                    ColorpickerBtn.Parent = Toggle
                    ColorpickerBtn.BackgroundColor3 = _default
                    ColorpickerBtn.BorderColor3 = Color3.fromRGB(40, 40, 40)
                    ColorpickerBtn.BorderSizePixel = 1
                    ColorpickerBtn.Position = UDim2.new(0.85, 0, 0.3, 0)
                    ColorpickerBtn.Size = UDim2.new(0, 22, 0, 11)
                    ColorpickerBtn.AutoButtonColor = false
                    ColorpickerBtn.Text = ""

                    local h, s, v = _default:ToHSV()
                    local ColorPicker = Instance.new("Frame")
                    ColorPicker.Name = "ColorPicker"
                    ColorPicker.Parent = Sector
                    ColorPicker.BackgroundColor3 = Color3.fromRGB(20, 20, 20)
                    ColorPicker.BorderColor3 = Color3.fromRGB(35, 35, 35)
                    ColorPicker.BorderSizePixel = 2
                    ColorPicker.Size = UDim2.new(0, 180, 0, 100)
                    ColorPicker.Visible = false
                    ColorPicker.ZIndex = 200

                    -- Hue, Saturation, Value sliders (как в твоём коде)
                    local Hue = Instance.new("TextButton", ColorPicker)
                    Hue.Size = UDim2.new(0, 20, 0, 80)
                    Hue.Position = UDim2.new(0.05, 0, 0.1, 0)
                    Hue.AutoButtonColor = false
                    local HueGrad = Instance.new("UIGradient", Hue)
                    HueGrad.Color = ColorSequence.new{
                        ColorSequenceKeypoint.new(0, Color3.fromRGB(255, 0, 0)),
                        ColorSequenceKeypoint.new(0.17, Color3.fromRGB(255, 255, 0)),
                        ColorSequenceKeypoint.new(0.33, Color3.fromRGB(0, 255, 0)),
                        ColorSequenceKeypoint.new(0.5, Color3.fromRGB(0, 255, 255)),
                        ColorSequenceKeypoint.new(0.67, Color3.fromRGB(0, 0, 255)),
                        ColorSequenceKeypoint.new(0.83, Color3.fromRGB(255, 0, 255)),
                        ColorSequenceKeypoint.new(1, Color3.fromRGB(255, 0, 0))
                    }
                    HueGrad.Rotation = 90

                    local Sat = Instance.new("TextButton", ColorPicker)
                    Sat.Size = UDim2.new(0, 20, 0, 80)
                    Sat.Position = UDim2.new(0.25, 0, 0.1, 0)
                    Sat.AutoButtonColor = false
                    local SatGrad = Instance.new("UIGradient", Sat)
                    SatGrad.Rotation = 90

                    local Val = Instance.new("TextButton", ColorPicker)
                    Val.Size = UDim2.new(0, 20, 0, 80)
                    Val.Position = UDim2.new(0.45, 0, 0.1, 0)
                    Val.AutoButtonColor = false
                    local ValGrad = Instance.new("UIGradient", Val)
                    ValGrad.Rotation = 90

                    local Preview = Instance.new("Frame", ColorPicker)
                    Preview.Size = UDim2.new(0, 40, 0, 40)
                    Preview.Position = UDim2.new(0.7, 0, 0.1, 0)
                    Preview.BorderSizePixel = 1
                    Preview.BorderColor3 = Color3.fromRGB(40, 40, 40)

                    local function update_cp()
                        SatGrad.Color = ColorSequence.new{
                            ColorSequenceKeypoint.new(0, Color3.new(1,1,1)),
                            ColorSequenceKeypoint.new(1, Color3.fromHSV(h, 1, 1))
                        }
                        ValGrad.Color = ColorSequence.new{
                            ColorSequenceKeypoint.new(0, Color3.new(0,0,0)),
                            ColorSequenceKeypoint.new(1, Color3.fromHSV(h, s, 1))
                        }
                        local drags = { -- Update drag positions
                            [Hue] = UDim2.new(0, 0, h, -1),
                            [Sat] = UDim2.new(0, 0, s, -1),
                            [Val] = UDim2.new(0, 0, v, -1)
                        }
                        for slider, pos in pairs(drags) do
                            slider:FindFirstChild("Drag").Position = pos
                        end
                        local final = Color3.fromHSV(h, s, v)
                        ColorpickerBtn.BackgroundColor3 = final
                        Preview.BackgroundColor3 = final
                        cpcallback(final)
                    end

                    -- Drag logic for each slider (Hue, Sat, Val) — полный код как в твоём, но без nil
                    local function handle_drag(slider, is_hue, is_sat, is_val)
                        local conn
                        conn = services.run.RenderStepped:Connect(function()
                            local mouse = services.uis:GetMouseLocation()
                            local rel_y = math.clamp((mouse.Y - slider.AbsolutePosition.Y) / slider.AbsoluteSize.Y, 0, 1)
                            if is_hue then h = rel_y elseif is_sat then s = rel_y else v = rel_y end
                            update_cp()
                        end)
                        services.uis.InputEnded:Connect(function(input)
                            if input.UserInputType == Enum.UserInputType.MouseButton1 then
                                conn:Disconnect()
                            end
                        end)
                    end

                    -- Add drag frames and connections for Hue/Sat/Val (как в оригинале)
                    for _, slider in pairs({Hue, Sat, Val}) do
                        local drag = Instance.new("Frame")
                        drag.Name = "Drag"
                        drag.Parent = slider
                        drag.BackgroundColor3 = Color3.new(1,1,1)
                        drag.BorderSizePixel = 1
                        drag.BorderColor3 = Color3.new(0,0,0)
                        drag.Size = UDim2.new(1, 0, 0, 2)
                        slider.InputBegan:Connect(function(input)
                            if input.UserInputType == Enum.UserInputType.MouseButton1 then
                                if slider == Hue then handle_drag(slider, true, false, false)
                                elseif slider == Sat then handle_drag(slider, false, true, false)
                                else handle_drag(slider, false, false, true) end
                            end
                        end)
                    end

                    ColorpickerBtn.MouseButton1Down:Connect(function()
                        ColorPicker.Visible = not ColorPicker.Visible
                    end)
                    update_cp()
                    return colorpicker
                end

                Toggle.MouseButton1Down:Connect(function()
                    value = not value
                    toggle.set(value)
                end)
                Bg.MouseButton1Down:Connect(function()
                    value = not value
                    toggle.set(value)
                end)
                toggle.set(value)
                increase_scrollbar_size()
                return toggle
            end

            -- === Slider ===
            sector.slider = function(text, indicator, min, max, default, callback)
                local slider = {}
                local dragging = false
                local value = default or min
                local Slider = Instance.new("TextButton")
                Slider.Name = "Slider"
                Slider.Parent = SectorContent
                Slider.BackgroundTransparency = 1
                Slider.BorderSizePixel = 0
                Slider.Size = UDim2.new(0, 249, 0, 25)
                Slider.Font = Enum.Font.SourceSans
                Slider.Text = ""
                Slider.TextColor3 = Color3.fromRGB(172, 172, 172)
                Slider.TextSize = 14
                Slider.TextXAlignment = Enum.TextXAlignment.Left

                local Txt = Instance.new("TextLabel")
                Txt.Name = "Text"
                Txt.Parent = Slider
                Txt.BackgroundTransparency = 1
                Txt.BorderSizePixel = 0
                Txt.Position = UDim2.new(0.02, 0, 0, 0)
                Txt.Size = UDim2.new(0, 226, 0, 12)
                Txt.Font = Enum.Font.SourceSans
                Txt.TextColor3 = theme.Text
                Txt.TextSize = 14
                Txt.TextStrokeTransparency = 0.8
                Txt.TextXAlignment = Enum.TextXAlignment.Left
                Txt.Text = text

                local Bg = Instance.new("TextButton")
                Bg.Name = "Bg"
                Bg.Parent = Slider
                Bg.BackgroundColor3 = theme.SliderBg
                Bg.BorderColor3 = theme.ElementOutline
                Bg.BorderSizePixel = 1
                Bg.Position = UDim2.new(0.02, 0, 0.6, 0)
                Bg.Size = UDim2.new(0, 238, 0, 6)
                Bg.AutoButtonColor = false
                Bg.Text = ""

                local Fill = Instance.new("TextButton")
                Fill.Name = "Fill"
                Fill.Parent = Bg
                Fill.BackgroundColor3 = theme.Slider
                Fill.BorderColor3 = theme.ElementOutline
                Fill.BorderSizePixel = 1
                Fill.Position = UDim2.new(0, 0, 0, 0)
                Fill.Size = UDim2.new(0, 0, 1, 0)
                Fill.AutoButtonColor = false
                Fill.Text = ""

                local ValueLabel = Instance.new("TextLabel")
                ValueLabel.Name = "ValueLabel"
                ValueLabel.Parent = Bg
                ValueLabel.BackgroundTransparency = 1
                ValueLabel.BorderSizePixel = 0
                ValueLabel.Position = UDim2.new(1, -40, 1, 2)
                ValueLabel.Size = UDim2.new(0, 40, 0, 8)
                ValueLabel.Font = Enum.Font.SourceSans
                ValueLabel.TextColor3 = theme.Text
                ValueLabel.TextSize = 11
                ValueLabel.TextXAlignment = Enum.TextXAlignment.Right

                local ti = TweenInfo.new(0.2)
                Bg.MouseEnter:Connect(function()
                    services.tween:Create(Bg, ti, {BackgroundColor3 = theme.ButtonHover}):Play()
                end)
                Bg.MouseLeave:Connect(function()
                    services.tween:Create(Bg, ti, {BackgroundColor3 = theme.SliderBg}):Play()
                end)

                function slider.set(percentage)
                    services.tween:Create(Fill, ti, {Size = UDim2.new(percentage, 0, 1, 0)}):Play()
                    value = (percentage * (max - min)) + min
                    callback(value)
                    ValueLabel.Text = tostring(math.round(value * 100) / 100) .. indicator
                end

                slider.get = function() return value end
                slider.set_text = function(t) Txt.Text = t end

                Bg.InputBegan:Connect(function(input)
                    if input.UserInputType == Enum.UserInputType.MouseButton1 then dragging = true end
                end)
                Bg.InputEnded:Connect(function(input)
                    if input.UserInputType == Enum.UserInputType.MouseButton1 then dragging = false end
                end)
                Fill.InputBegan:Connect(function(input)
                    if input.UserInputType == Enum.UserInputType.MouseButton1 then dragging = true end
                end)
                Fill.InputEnded:Connect(function(input)
                    if input.UserInputType == Enum.UserInputType.MouseButton1 then dragging = false end
                end)
                services.run.RenderStepped:Connect(function()
                    if dragging then
                        local mouse = services.uis:GetMouseLocation()
                        local size = math.clamp((mouse.X - Bg.AbsolutePosition.X) / Bg.AbsoluteSize.X, 0, 1)
                        slider.set(size)
                    end
                end)
                slider.set((default - min) / (max - min))
                increase_scrollbar_size()
                return slider
            end

            -- === Dropdown ===
            sector.dropdown = function(text, options, default, callback)
                local dropdown = {selected = default or options[1]}
                local Dropdown = Instance.new("TextButton")
                Dropdown.Name = "Dropdown"
                Dropdown.Parent = SectorContent
                Dropdown.BackgroundColor3 = theme.ElementBg
                Dropdown.BorderColor3 = theme.ElementOutline
                Dropdown.BorderSizePixel = 1
                Dropdown.Size = UDim2.new(0, 249, 0, 21)
                Dropdown.AutoButtonColor = false
                Dropdown.Font = Enum.Font.SourceSans
                Dropdown.Text = text
                Dropdown.TextColor3 = theme.Text
                Dropdown.TextSize = 14
                Dropdown.TextXAlignment = Enum.TextXAlignment.Left
                Dropdown.ZIndex = 100

                local pad = Instance.new("UIPadding", Dropdown)
                pad.PaddingLeft = UDim.new(0, 30)

                local Image = Instance.new("ImageLabel")
                Image.Name = "Image"
                Image.Parent = Dropdown
                Image.BackgroundTransparency = 1
                Image.BorderSizePixel = 0
                Image.Position = UDim2.new(-0.1, 0, 0.14, 0)
                Image.Size = UDim2.new(0, 15, 0, 15)
                Image.Image = "rbxassetid://74187648454886"
                Image.ImageColor3 = Color3.fromRGB(115, 115, 115)
                Image.ZIndex = 101

                local DropdownContent = Instance.new("ScrollingFrame")
                DropdownContent.Name = "DropdownContent"
                DropdownContent.Parent = Dropdown
                DropdownContent.Active = true
                DropdownContent.BackgroundColor3 = theme.ElementBg
                DropdownContent.BorderColor3 = theme.ElementOutline
                DropdownContent.BorderSizePixel = 1
                DropdownContent.Position = UDim2.new(-0.14, 0, 1, 0)
                DropdownContent.Size = UDim2.new(0, 249, 0, 0)
                DropdownContent.CanvasSize = UDim2.new(0, 0, 0, 0)
                DropdownContent.ScrollBarThickness = 3
                DropdownContent.ScrollBarImageColor3 = Color3.fromRGB(50, 50, 50)
                DropdownContent.Visible = false
                DropdownContent.ZIndex = 102
                DropdownContent.ClipsDescendants = true

                local pad2 = Instance.new("UIPadding", DropdownContent)
                pad2.PaddingLeft = UDim.new(0, 5)
                pad2.PaddingTop = UDim.new(0, 5)

                local List = Instance.new("UIListLayout", DropdownContent)
                List.SortOrder = Enum.SortOrder.LayoutOrder
                List.Padding = UDim.new(0, 5)

                local ti = TweenInfo.new(0.2)
                Dropdown.MouseEnter:Connect(function()
                    services.tween:Create(Dropdown, ti, {BackgroundColor3 = theme.ButtonHover}):Play()
                end)
                Dropdown.MouseLeave:Connect(function()
                    if not DropdownContent.Visible then
                        services.tween:Create(Dropdown, ti, {BackgroundColor3 = theme.ElementBg}):Play()
                    end
                end)

                local isOpen = false
                local function toggle_dd()
                    isOpen = not isOpen
                    if isOpen then
                        DropdownContent.Visible = true
                        services.tween:Create(Image, ti, {Rotation = 180}):Play()
                        services.tween:Create(DropdownContent, ti, {Size = UDim2.new(0, 249, 0, math.min(#options * 26, 116))}):Play()
                    else
                        services.tween:Create(Image, ti, {Rotation = 0}):Play()
                        services.tween:Create(DropdownContent, ti, {Size = UDim2.new(0, 249, 0, 0)}):Play()
                        task.wait(0.2)
                        DropdownContent.Visible = false
                    end
                end
                Dropdown.MouseButton1Down:Connect(toggle_dd)

                function dropdown.unselect_all()
                    for _, btn in pairs(DropdownContent:GetChildren()) do
                        if btn:IsA("TextButton") then
                            btn.BorderColor3 = theme.ElementOutline
                        end
                    end
                end

                function dropdown.set(name, skip_cb)
                    dropdown.unselect_all()
                    dropdown.selected = name
                    local btn = DropdownContent:FindFirstChild(name)
                    if btn then btn.BorderColor3 = theme.DropdownSelected end
                    if not skip_cb then
                        callback(name)
                        toggle_dd()
                    end
                end

                dropdown.get = function() return dropdown.selected end
                dropdown.add = function(name)
                    local Btn = Instance.new("TextButton")
                    Btn.Name = name
                    Btn.Parent = DropdownContent
                    Btn.BackgroundColor3 = theme.ElementBg
                    Btn.BorderColor3 = theme.ElementOutline
                    Btn.BorderSizePixel = 1
                    Btn.Size = UDim2.new(0, 238, 0, 21)
                    Btn.AutoButtonColor = false
                    Btn.Font = Enum.Font.SourceSans
                    Btn.TextColor3 = theme.Text
                    Btn.TextSize = 14
                    Btn.Text = name
                    Btn.ZIndex = 103
                    Btn.MouseButton1Down:Connect(function() dropdown.set(name) end)
                    Btn.MouseEnter:Connect(function()
                        services.tween:Create(Btn, ti, {BackgroundColor3 = theme.ButtonHover}):Play()
                    end)
                    Btn.MouseLeave:Connect(function()
                        if Btn.BorderColor3 ~= theme.DropdownSelected then
                            services.tween:Create(Btn, ti, {BackgroundColor3 = theme.ElementBg}):Play()
                        end
                    end)
                    DropdownContent.CanvasSize = UDim2.new(0, 0, 0, List.AbsoluteContentSize.Y + 10)
                end
                dropdown.remove = function(name)
                    local btn = DropdownContent:FindFirstChild(name)
                    if btn then
                        btn:Destroy()
                        DropdownContent.CanvasSize = UDim2.new(0, 0, 0, List.AbsoluteContentSize.Y + 10)
                        if dropdown.selected == name then dropdown.selected = "" end
                    end
                end
                dropdown.delete = function() Dropdown:Destroy() end

                for _, opt in pairs(options) do
                    dropdown.add(opt)
                end
                if default then dropdown.set(default, true) end
                increase_scrollbar_size()
                return dropdown
            end

            -- === Multicombobox (аналогично dropdown, но с toggle) ===
            sector.multicombobox = function(text, options, defaults, callback)
                local mc = {selected = {}}
                for _, opt in pairs(options) do mc.selected[opt] = false end
                if type(defaults) == "table" then
                    for _, d in pairs(defaults) do
                        if mc.selected[d] ~= nil then mc.selected[d] = true end
                    end
                end

                local MultiCB = Instance.new("TextButton")
                MultiCB.Name = "MultiCombobox"
                MultiCB.Parent = SectorContent
                MultiCB.BackgroundColor3 = theme.ElementBg
                MultiCB.BorderColor3 = theme.ElementOutline
                MultiCB.BorderSizePixel = 1
                MultiCB.Size = UDim2.new(0, 249, 0, 21)
                MultiCB.AutoButtonColor = false
                MultiCB.Font = Enum.Font.SourceSans
                MultiCB.Text = text
                MultiCB.TextColor3 = theme.Text
                MultiCB.TextSize = 14
                MultiCB.TextXAlignment = Enum.TextXAlignment.Left
                MultiCB.ZIndex = 100

                local pad = Instance.new("UIPadding", MultiCB)
                pad.PaddingLeft = UDim.new(0, 30)

                local Image = Instance.new("ImageLabel")
                Image.Name = "Image"
                Image.Parent = MultiCB
                Image.BackgroundTransparency = 1
                Image.Position = UDim2.new(-0.1, 0, 0.14, 0)
                Image.Size = UDim2.new(0, 15, 0, 15)
                Image.Image = "rbxassetid://74187648454886"
                Image.ImageColor3 = Color3.fromRGB(115, 115, 115)
                Image.ZIndex = 101

                local Content = Instance.new("ScrollingFrame")
                Content.Name = "MultiComboboxContent"
                Content.Parent = MultiCB
                Content.Active = true
                Content.BackgroundColor3 = theme.ElementBg
                Content.BorderColor3 = theme.ElementOutline
                Content.BorderSizePixel = 1
                Content.Position = UDim2.new(-0.14, 0, 1, 0)
                Content.Size = UDim2.new(0, 249, 0, 0)
                Content.CanvasSize = UDim2.new(0, 0, 0, 0)
                Content.ScrollBarThickness = 3
                Content.Visible = false
                Content.ZIndex = 102
                Content.ClipsDescendants = true

                local pad2 = Instance.new("UIPadding", Content)
                pad2.PaddingLeft = UDim.new(0, 5)
                pad2.PaddingTop = UDim.new(0, 5)

                local List = Instance.new("UIListLayout", Content)
                List.SortOrder = Enum.SortOrder.LayoutOrder
                List.Padding = UDim.new(0, 5)

                local ti = TweenInfo.new(0.2)
                MultiCB.MouseEnter:Connect(function()
                    services.tween:Create(MultiCB, ti, {BackgroundColor3 = theme.ButtonHover}):Play()
                end)
                MultiCB.MouseLeave:Connect(function()
                    if not Content.Visible then
                        services.tween:Create(MultiCB, ti, {BackgroundColor3 = theme.ElementBg}):Play()
                    end
                end)

                local isOpen = false
                local function toggle_mc()
                    isOpen = not isOpen
                    if isOpen then
                        Content.Visible = true
                        services.tween:Create(Image, ti, {Rotation = 180}):Play()
                        services.tween:Create(Content, ti, {Size = UDim2.new(0, 249, 0, math.min(#options * 26, 116))}):Play()
                    else
                        services.tween:Create(Image, ti, {Rotation = 0}):Play()
                        services.tween:Create(Content, ti, {Size = UDim2.new(0, 249, 0, 0)}):Play()
                        task.wait(0.2)
                        Content.Visible = false
                    end
                end
                MultiCB.MouseButton1Down:Connect(toggle_mc)

                function mc.update_text()
                    local count = 0
                    for _ in pairs(mc.selected) do if mc.selected[_] then count += 1 end end
                    if count == 0 then
                        MultiCB.Text = text
                    elseif count == 1 then
                        for n, s in pairs(mc.selected) do if s then MultiCB.Text = n break end end
                    else
                        MultiCB.Text = text .. " (" .. count .. " selected)"
                    end
                end

                function mc.toggle_option(name)
                    if mc.selected[name] ~= nil then
                        mc.selected[name] = not mc.selected[name]
                        local btn = Content:FindFirstChild(name)
                        if btn then
                            if mc.selected[name] then
                                btn.BorderColor3 = theme.DropdownSelected
                                btn.BackgroundColor3 = theme.ButtonHover
                            else
                                btn.BorderColor3 = theme.ElementOutline
                                btn.BackgroundColor3 = theme.ElementBg
                            end
                        end
                        mc.update_text()
                        callback(mc.selected)
                    end
                end

                mc.set = function(name, val) 
                    mc.selected[name] = val
                    mc.toggle_option(name)
                end
                mc.get = function(name) return mc.selected[name] or false end
                mc.get_all = function() return mc.selected end
                mc.clear = function()
                    for name in pairs(mc.selected) do
                        mc.selected[name] = false
                        local btn = Content:FindFirstChild(name)
                        if btn then
                            btn.BorderColor3 = theme.ElementOutline
                            btn.BackgroundColor3 = theme.ElementBg
                        end
                    end
                    mc.update_text()
                    callback(mc.selected)
                end
                mc.add = function(name)
                    mc.selected[name] = mc.selected[name] or false
                    local Btn = Instance.new("TextButton")
                    Btn.Name = name
                    Btn.Parent = Content
                    Btn.BackgroundColor3 = theme.ElementBg
                    Btn.BorderColor3 = theme.ElementOutline
                    Btn.BorderSizePixel = 1
                    Btn.Size = UDim2.new(0, 238, 0, 21)
                    Btn.AutoButtonColor = false
                    Btn.Font = Enum.Font.SourceSans
                    Btn.TextColor3 = theme.Text
                    Btn.TextSize = 14
                    Btn.Text = name
                    Btn.ZIndex = 103
                    Btn.MouseButton1Down:Connect(function() mc.toggle_option(name) end)
                    Btn.MouseEnter:Connect(function()
                        services.tween:Create(Btn, ti, {BackgroundColor3 = theme.ButtonHover}):Play()
                    end)
                    Btn.MouseLeave:Connect(function()
                        if not mc.selected[name] then
                            services.tween:Create(Btn, ti, {BackgroundColor3 = theme.ElementBg}):Play()
                        end
                    end)
                    if mc.selected[name] then
                        Btn.BorderColor3 = theme.DropdownSelected
                        Btn.BackgroundColor3 = theme.ButtonHover
                    end
                    Content.CanvasSize = UDim2.new(0, 0, 0, List.AbsoluteContentSize.Y + 10)
                end
                mc.remove = function(name)
                    mc.selected[name] = nil
                    local btn = Content:FindFirstChild(name)
                    if btn then
                        btn:Destroy()
                        Content.CanvasSize = UDim2.new(0, 0, 0, List.AbsoluteContentSize.Y + 10)
                        mc.update_text()
                        callback(mc.selected)
                    end
                end
                mc.delete = function() MultiCB:Destroy() end

                for _, opt in pairs(options) do mc.add(opt) end
                mc.update_text()
                increase_scrollbar_size()
                return mc
            end

            table.insert(window.tab_contents, {Tab.Name, Sector})
            return sector
        end

        return tab
    end

    return window
end

return lib
