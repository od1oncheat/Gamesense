local lib = {}
local themes = {
    ["gamesense"] = {
        ["Window"] = Color3.fromRGB(12, 12, 12),
        ["Tabs"] = Color3.fromRGB(10, 10, 10),
        ["Gradient"] = ColorSequence.new{
            ColorSequenceKeypoint.new(0.00, Color3.fromRGB(61, 130, 162)),
            ColorSequenceKeypoint.new(0.50, Color3.fromRGB(156, 59, 145)),
            ColorSequenceKeypoint.new(1.00, Color3.fromRGB(155, 161, 48))
        },
        ["Sector"] = Color3.fromRGB(15, 15, 15),
        ["Text"] = Color3.fromRGB(230, 230, 230),
        ["TabSelected"] = Color3.fromRGB(14, 14, 14),
        ["ElementBg"] = Color3.fromRGB(24, 24, 24),
        ["ElementOutline"] = Color3.fromRGB(35, 35, 35),
        ["DropdownSelected"] = Color3.fromRGB(135, 176, 27),
        ["Toggle"] = Color3.fromRGB(135, 176, 27),
        ["ToggleUnchecked"] = Color3.fromRGB(27, 27, 27),
        ["Slider"] = Color3.fromRGB(135, 176, 27),
        ["SliderBg"] = Color3.fromRGB(24, 24, 24)
    }
}

local services = {
    ["uis"] = game:GetService("UserInputService"),
    ["run"] = game:GetService("RunService"),
    ["tween"] = game:GetService("TweenService")
}

local function gethui()
    return game.Players.LocalPlayer.PlayerGui
end

local function protectgui()
end

-- Основные константы размеров (чтобы всё было одинаково)
local ELEMENT_WIDTH = 236  -- одинаковая ширина для всех элементов
local ELEMENT_HEIGHT = 28  -- одинаковая высота
local PADDING_LEFT_RIGHT = 15  -- отступы от краёв сектора
local PADDING_BETWEEN_ELEMENTS = 6  -- между элементами
local SECTOR_PADDING_Y = 12  -- верхний/нижний отступ сектора
local SLIDER_HEIGHT = 32  -- слайдер чуть выше
local TAB_WIDTH = 110  -- увеличена ширина табов (было 95)

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
    protect_gui(Mute)
    
    local Main = Instance.new("Frame")
    local Tabs = Instance.new("Frame")
    local UIGridLayout = Instance.new("UIGridLayout")
    local UIPadding = Instance.new("UIPadding")
    local TopGradient = Instance.new("Frame")
    local UIGradient = Instance.new("UIGradient")
    local Content = Instance.new("Frame")
    local UIListLayout = Instance.new("UIListLayout")

    -- Dragging
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

    Tabs.InputBegan:Connect(function(input) window.drag_began(input) end)
    Tabs.InputChanged:Connect(function(input) window.drag_changed(input) end)
    Main.InputBegan:Connect(function(input) window.drag_began(input) end)
    Main.InputChanged:Connect(function(input) window.drag_changed(input) end)

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

    math.randomseed(os.time())
    Mute.Name = tostring(math.random(0,9999999))
    Mute.Parent = gethui()
    Mute.ZIndexBehavior = Enum.ZIndexBehavior.Sibling
    Mute.ResetOnSpawn = false
    Mute.DisplayOrder = 9999
    Mute.IgnoreGuiInset = true

    Main.Name = "Main"
    Main.Parent = Mute
    Main.BackgroundColor3 = themes[theme]["Window"]
    Main.BorderColor3 = Color3.fromRGB(45, 45, 45)
    Main.BorderSizePixel = 4
    Main.Position = UDim2.new(0.35, 0, 0.2, 0)
    Main.Size = UDim2.new(0, 740, 0, 640)  -- Увеличено по Y

    Tabs.Name = "Tabs"
    Tabs.Parent = Main
    Tabs.BackgroundColor3 = themes[theme]["Tabs"]
    Tabs.BorderColor3 = Color3.fromRGB(21, 21, 21)
    Tabs.Position = UDim2.new(0, 1, 0.00330578513, 0)
    Tabs.Size = UDim2.new(0, 110, 0, 637)  -- Увеличено по Y

    UIGridLayout.Parent = Tabs
    UIGridLayout.SortOrder = Enum.SortOrder.LayoutOrder
    UIGridLayout.CellPadding = UDim2.new(0, 12, 0, 0)
    UIGridLayout.CellSize = UDim2.new(0, TAB_WIDTH, 0, 70)  -- Увеличена ширина

    UIPadding.Parent = Tabs
    UIPadding.PaddingLeft = UDim.new(0, 8)
    UIPadding.PaddingTop = UDim.new(0, 18)

    TopGradient.Name = "TopGradient"
    TopGradient.Parent = Main
    TopGradient.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
    TopGradient.BorderSizePixel = 0
    TopGradient.Size = UDim2.new(0, 740, 0, 2)

    UIGradient.Color = themes[theme]["Gradient"]
    UIGradient.Parent = TopGradient

    Content.Name = "Content"
    Content.Parent = Main
    Content.BackgroundTransparency = 1
    Content.BorderSizePixel = 0
    Content.Position = UDim2.new(0.15277778, 0, 0.0247933883, 0)
    Content.Size = UDim2.new(0, 610, 0, 610)  -- Увеличено по Y

    UIListLayout.Parent = Content
    UIListLayout.FillDirection = Enum.FillDirection.Horizontal
    UIListLayout.SortOrder = Enum.SortOrder.LayoutOrder
    UIListLayout.Padding = UDim.new(0, 12)

    window.tab_contents = {}
    window.selected_tab = ""
    
    window.show_tab = function(name)
        for _, content in pairs(window.tab_contents) do
            if content[1] == name then
                content[2].Visible = true
            else
                content[2].Visible = false
            end
        end
    end

    window.tab_active = function(tab)
        tab.BackgroundTransparency = 0
        tab.Open.ImageColor3 = Color3.fromRGB(209, 210, 208)
    end

    window.tab_inactive = function(tab)
        tab.BackgroundTransparency = 1
        tab.Open.ImageColor3 = Color3.fromRGB(90,90,90)
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

    local function createHoverEffects(element)
        local original = element.BackgroundColor3
        local hover = Color3.fromRGB(math.min(255, original.R * 255 + 20), math.min(255, original.G * 255 + 20), math.min(255, original.B * 255 + 20))
        local press = Color3.fromRGB(math.max(0, original.R * 255 - 10), math.max(0, original.G * 255 - 10), math.max(0, original.B * 255 - 10))
        local tweenInfo = TweenInfo.new(0.15, Enum.EasingStyle.Quad)

        element.MouseEnter:Connect(function()
            services.tween:Create(element, tweenInfo, {BackgroundColor3 = hover}):Play()
        end)
        element.MouseLeave:Connect(function()
            services.tween:Create(element, tweenInfo, {BackgroundColor3 = original}):Play()
        end)

        local connDown
        element.MouseButton1Down:Connect(function()
            connDown = services.tween:Create(element, tweenInfo, {BackgroundColor3 = press}):Play()
        end)
        element.MouseButton1Up:Connect(function()
            if connDown then connDown:Cancel() end
            services.tween:Create(element, tweenInfo, {BackgroundColor3 = hover}):Play()
        end)
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
        Tab.Size = UDim2.new(0, TAB_WIDTH, 0, 70)
        Tab.AutoButtonColor = false
        Tab.Font = Enum.Font.Gotham
        Tab.Text = ""
        Tab.TextColor3 = Color3.fromRGB(0, 0, 0)
        Tab.TextSize = 14.000

        Open.Name = "Open"
        Open.Parent = Tab
        Open.BackgroundTransparency = 1
        Open.BorderSizePixel = 0
        Open.Position = UDim2.new(0.23, 0, 0.19285714, 0)
        Open.Size = UDim2.new(0, 48, 0, 48)
        Open.Image = image
        Open.ImageColor3 = Color3.fromRGB(90,90,90)

        Open.MouseButton1Down:Connect(function()
            window.selected_tab = Tab.Name
            window.tab_colors(Tab)
            window.show_tab(Tab.Name)
        end)

        tab.create_sector = function(name, column)
            local sector = {}
            column = column or 1
            local pos_x = (column - 1) * 0.5

            local Sector = Instance.new("Frame")
            local Title = Instance.new("TextLabel")
            local SectorContent = Instance.new("ScrollingFrame")
            local UIListLayout = Instance.new("UIListLayout")
            local UIPadding = Instance.new("UIPadding")

            Sector.Name = name
            Sector.Parent = Content
            Sector.BackgroundColor3 = themes[theme]["Sector"]
            Sector.BorderColor3 = Color3.fromRGB(34, 34, 34)
            Sector.Position = UDim2.new(pos_x, 0, 0.035, 0)
            Sector.Size = UDim2.new(0.5, -6, 0.93, 0)
            Sector.Visible = false

            Title.Name = "Title"
            Title.Parent = Sector
            Title.BackgroundTransparency = 1
            Title.BorderSizePixel = 0
            Title.Position = UDim2.new(0, PADDING_LEFT_RIGHT, 0, -SECTOR_PADDING_Y)
            Title.Size = UDim2.new(1, -PADDING_LEFT_RIGHT*2, 0, 20)
            Title.Font = Enum.Font.Gotham
            Title.TextColor3 = themes[theme]["Text"]
            Title.TextSize = 18
            Title.TextStrokeTransparency = 0.5
            Title.TextXAlignment = Enum.TextXAlignment.Left
            Title.Text = name

            SectorContent.Name = "SectorContent"
            SectorContent.Parent = Sector
            SectorContent.Active = true
            SectorContent.BackgroundTransparency = 1
            SectorContent.BorderSizePixel = 0
            SectorContent.Position = UDim2.new(0, PADDING_LEFT_RIGHT, 0, SECTOR_PADDING_Y)
            SectorContent.Size = UDim2.new(1, -PADDING_LEFT_RIGHT*2, 1, -SECTOR_PADDING_Y*2)
            SectorContent.CanvasSize = UDim2.new(0, 0, 0, 0)
            SectorContent.ScrollBarThickness = 3

            UIListLayout.Parent = SectorContent
            UIListLayout.SortOrder = Enum.SortOrder.LayoutOrder
            UIListLayout.Padding = UDim.new(0, PADDING_BETWEEN_ELEMENTS)

            UIPadding.Parent = SectorContent
            UIPadding.PaddingLeft = UDim.new(0, 0)

            local UIGradient = Instance.new("UIGradient")
            UIGradient.Color = ColorSequence.new{ColorSequenceKeypoint.new(0.00, Color3.fromRGB(255,255,255)), ColorSequenceKeypoint.new(1.00, Color3.fromRGB(200,200,200))}
            UIGradient.Rotation = 90
            UIGradient.Parent = Sector

            sector.increase_scrollbar_size = function()
                local totalHeight = 0
                for _, element in pairs(SectorContent:GetChildren()) do
                    if element:IsA("GuiObject") then
                        totalHeight = totalHeight + element.AbsoluteSize.Y + PADDING_BETWEEN_ELEMENTS
                    end
                end
                SectorContent.CanvasSize = UDim2.new(0, 0, 0, totalHeight)
            end

            -- Текст
            sector.text = function(_text)
                local text = {}
                local Text = Instance.new("TextLabel")
                Text.Parent = SectorContent
                Text.BackgroundTransparency = 1
                Text.Size = UDim2.new(1, 0, 0, 16)
                Text.Font = Enum.Font.Gotham
                Text.Text = _text
                Text.TextColor3 = themes[theme]["Text"]
                Text.TextSize = 14
                Text.TextStrokeTransparency = 0.8
                Text.TextXAlignment = Enum.TextXAlignment.Left
                text.set = function(t) Text.Text = t end
                text.delete = function() Text:Destroy() end
                sector.increase_scrollbar_size()
                return text
            end

            -- Текстбокс
            sector.textbox = function(placeholder, default, callback)
                local textbox = {}
                local TextBox = Instance.new("TextBox")
                TextBox.Parent = SectorContent
                TextBox.BackgroundColor3 = themes[theme]["ElementBg"]
                TextBox.BorderColor3 = themes[theme]["ElementOutline"]
                TextBox.Size = UDim2.new(0, ELEMENT_WIDTH, 0, ELEMENT_HEIGHT)
                TextBox.ClearTextOnFocus = false
                TextBox.Font = Enum.Font.Gotham
                TextBox.PlaceholderColor3 = Color3.fromRGB(72, 72, 72)
                TextBox.PlaceholderText = placeholder
                TextBox.Text = default
                TextBox.TextColor3 = themes[theme]["Text"]
                TextBox.TextSize = 14
                TextBox.TextXAlignment = Enum.TextXAlignment.Left

                local pad = Instance.new("UIPadding")
                pad.Parent = TextBox
                pad.PaddingLeft = UDim.new(0, 8)

                TextBox:GetPropertyChangedSignal("Text"):Connect(function()
                    callback(TextBox.Text)
                    services.tween:Create(TextBox, TweenInfo.new(0.1), {BackgroundColor3 = Color3.fromRGB(30,30,30)}):Play()
                    task.wait(0.1)
                    services.tween:Create(TextBox, TweenInfo.new(0.1), {BackgroundColor3 = themes[theme]["ElementBg"]}):Play()
                end)

                TextBox.Focused:Connect(function()
                    services.tween:Create(TextBox, TweenInfo.new(0.15), {BackgroundColor3 = Color3.fromRGB(30,30,30)}):Play()
                end)
                TextBox.FocusLost:Connect(function()
                    services.tween:Create(TextBox, TweenInfo.new(0.15), {BackgroundColor3 = themes[theme]["ElementBg"]}):Play()
                end)

                callback(default)
                sector.increase_scrollbar_size()
                return textbox
            end

            -- Кнопка
            sector.button = function(text, callback)
                local button = {}
                local Button = Instance.new("TextButton")
                Button.Parent = SectorContent
                Button.BackgroundColor3 = themes[theme]["ElementBg"]
                Button.BorderColor3 = themes[theme]["ElementOutline"]
                Button.Size = UDim2.new(0, ELEMENT_WIDTH, 0, ELEMENT_HEIGHT)
                Button.AutoButtonColor = false
                Button.Font = Enum.Font.Gotham
                Button.TextColor3 = themes[theme]["Text"]
                Button.TextSize = 14
                Button.Text = text

                local pad = Instance.new("UIPadding")
                pad.Parent = Button
                pad.PaddingLeft = UDim.new(0, 8)

                Button.MouseButton1Down:Connect(callback)
                createHoverEffects(Button)
                sector.increase_scrollbar_size()
                return button
            end

            -- Дропдаун
            sector.dropdown = function(text, options, default, callback)
                local dropdown = { selected = default }
                local Dropdown = Instance.new("TextButton")
                local Image = Instance.new("ImageLabel")
                local DropdownContent = Instance.new("ScrollingFrame")
                local UIListLayout = Instance.new("UIListLayout")
                local UIPadding = Instance.new("UIPadding")

                Dropdown.Parent = SectorContent
                Dropdown.BackgroundColor3 = themes[theme]["ElementBg"]
                Dropdown.BorderColor3 = themes[theme]["ElementOutline"]
                Dropdown.Size = UDim2.new(0, ELEMENT_WIDTH, 0, ELEMENT_HEIGHT)
                Dropdown.AutoButtonColor = false
                Dropdown.Font = Enum.Font.Gotham
                Dropdown.Text = text
                Dropdown.TextColor3 = themes[theme]["Text"]
                Dropdown.TextSize = 14
                Dropdown.TextXAlignment = Enum.TextXAlignment.Left

                local pad = Instance.new("UIPadding")
                pad.Parent = Dropdown
                pad.PaddingLeft = UDim.new(0, 8)

                Image.Parent = Dropdown
                Image.BackgroundTransparency = 1
                Image.Position = UDim2.new(0.9, 0, 0.25, 0)
                Image.Size = UDim2.new(0, 16, 0, 16)
                Image.Image = "rbxassetid://74187648454886"
                Image.ImageColor3 = Color3.fromRGB(115, 115, 115)

                DropdownContent.Parent = Dropdown
                DropdownContent.BackgroundColor3 = themes[theme]["ElementBg"]
                DropdownContent.BorderColor3 = themes[theme]["ElementOutline"]
                DropdownContent.Position = UDim2.new(0, 0, 1, 0)
                DropdownContent.Size = UDim2.new(0, ELEMENT_WIDTH, 0, 120)
                DropdownContent.CanvasSize = UDim2.new(0, 0, 0, 0)
                DropdownContent.ScrollBarThickness = 3
                DropdownContent.Visible = false

                UIListLayout.Parent = DropdownContent
                UIListLayout.Padding = UDim.new(0, 4)
                UIPadding.Parent = DropdownContent
                UIPadding.PaddingLeft = UDim.new(0, 4)
                UIPadding.PaddingTop = UDim.new(0, 4)

                Dropdown.MouseButton1Down:Connect(function()
                    DropdownContent.Visible = not DropdownContent.Visible
                    Image.Image = DropdownContent.Visible and "rbxassetid://74187648454886" or "rbxassetid://97940921082727"
                end)

                dropdown.add = function(name)
                    local btn = Instance.new("TextButton")
                    btn.Parent = DropdownContent
                    btn.BackgroundColor3 = themes[theme]["ElementBg"]
                    btn.BorderColor3 = themes[theme]["ElementOutline"]
                    btn.Size = UDim2.new(1, -8, 0, 24)
                    btn.Font = Enum.Font.Gotham
                    btn.Text = name
                    btn.TextColor3 = themes[theme]["Text"]
                    btn.TextSize = 14
                    btn.AutoButtonColor = false

                    btn.MouseButton1Down:Connect(function()
                        dropdown.selected = name
                        callback(name)
                        DropdownContent.Visible = false
                        Image.Image = "rbxassetid://97940921082727"
                    end)

                    if name == default then dropdown.selected = name; callback(name) end
                    DropdownContent.CanvasSize = DropdownContent.CanvasSize + UDim2.new(0, 0, 0, 28)
                end

                for _, opt in pairs(options) do dropdown.add(opt) end
                createHoverEffects(Dropdown)
                sector.increase_scrollbar_size()
                return dropdown
            end

            -- Тоггл
            sector.toggle = function(text, default, callback)
                local toggle = { value = default }
                local Toggle = Instance.new("Frame")
                local Text = Instance.new("TextLabel")
                local Bg = Instance.new("Frame")

                Toggle.Parent = SectorContent
                Toggle.BackgroundTransparency = 1
                Toggle.Size = UDim2.new(0, ELEMENT_WIDTH, 0, 20)

                Text.Parent = Toggle
                Text.BackgroundTransparency = 1
                Text.Position = UDim2.new(0, 0, 0, 0)
                Text.Size = UDim2.new(1, -30, 1, 0)
                Text.Font = Enum.Font.Gotham
                Text.Text = text
                Text.TextColor3 = themes[theme]["Text"]
                Text.TextSize = 14
                Text.TextXAlignment = Enum.TextXAlignment.Left

                Bg.Parent = Toggle
                Bg.BackgroundColor3 = default and themes[theme]["Toggle"] or themes[theme]["ToggleUnchecked"]
                Bg.BorderColor3 = themes[theme]["ElementOutline"]
                Bg.Position = UDim2.new(1, -24, 0.3, 0)
                Bg.Size = UDim2.new(0, 18, 0, 10)
                Bg.CornerRadius = UDim.new(0, 5)

                Toggle.MouseButton1Down:Connect(function()
                    toggle.value = not toggle.value
                    services.tween:Create(Bg, TweenInfo.new(0.15), {BackgroundColor3 = toggle.value and themes[theme]["Toggle"] or themes[theme]["ToggleUnchecked"]}):Play()
                    callback(toggle.value)
                end)

                sector.increase_scrollbar_size()
                return toggle
            end

            -- Слайдер (ФИКС ВЫЛЕЗАНИЯ ТЕКСТА!)
            sector.slider = function(text, indicator, min, max, default, callback)
                local slider = {}
                local dragging = false
                local Slider = Instance.new("Frame")
                local Text = Instance.new("TextLabel")
                local Bg = Instance.new("Frame")
                local Fill = Instance.new("Frame")
                local ValueLabel = Instance.new("TextLabel")

                Slider.Parent = SectorContent
                Slider.BackgroundTransparency = 1
                Slider.Size = UDim2.new(0, ELEMENT_WIDTH, 0, SLIDER_HEIGHT)

                Text.Parent = Slider
                Text.BackgroundTransparency = 1
                Text.Size = UDim2.new(1, 0, 0, 18)
                Text.Font = Enum.Font.Gotham
                Text.Text = text
                Text.TextColor3 = themes[theme]["Text"]
                Text.TextSize = 14
                Text.TextXAlignment = Enum.TextXAlignment.Left

                Bg.Parent = Slider
                Bg.BackgroundColor3 = themes[theme]["SliderBg"]
                Bg.BorderColor3 = themes[theme]["ElementOutline"]
                Bg.Position = UDim2.new(0, 0, 0.6, 0)
                Bg.Size = UDim2.new(1, 0, 0, 6)
                Bg.CornerRadius = UDim.new(0, 3)

                Fill.Parent = Bg
                Fill.BackgroundColor3 = themes[theme]["Slider"]
                Fill.BorderSizePixel = 0
                Fill.Size = UDim2.new(0, 0, 1, 0)
                Fill.CornerRadius = UDim.new(0, 3)

                ValueLabel.Parent = Slider
                ValueLabel.BackgroundTransparency = 1
                ValueLabel.Font = Enum.Font.GothamBold
                ValueLabel.TextColor3 = themes[theme]["Text"]
                ValueLabel.TextSize = 11
                ValueLabel.Text = ""
                ValueLabel.Size = UDim2.new(0, 60, 0, 14)
                ValueLabel.Position = UDim2.new(0, 0, 0.1, 0)
                ValueLabel.TextXAlignment = Enum.TextXAlignment.Center
                ValueLabel.BackgroundColor3 = themes[theme]["ElementBg"]
                ValueLabel.BorderColor3 = themes[theme]["ElementOutline"]
                ValueLabel.BorderSizePixel = 1
                ValueLabel.CornerRadius = UDim.new(0, 4)

                local function update(fraction)
                    local value = min + fraction * (max - min)
                    local rounded = math.round(value * 100) / 100
                    ValueLabel.Text = tostring(rounded) .. indicator

                    -- Позиционируем ValueLabel над ползунком
                    local fillWidth = Bg.AbsoluteSize.X * fraction
                    ValueLabel.Position = UDim2.new(0, fillWidth - 30, 0, -18)

                    services.tween:Create(Fill, TweenInfo.new(0.15), {Size = UDim2.new(fraction, 0, 1, 0)}):Play()
                    callback(value)
                end

                Bg.InputBegan:Connect(function(input)
                    if input.UserInputType == Enum.UserInputType.MouseButton1 then dragging = true end
                end)
                Bg.InputEnded:Connect(function(input)
                    if input.UserInputType == Enum.UserInputType.MouseButton1 then dragging = false end
                end)
                Fill.InputBegan:Connect(function(input)
                    if input.UserInputType == Enum.UserInputType.MouseButton1 then dragging = true end
                end)
                Fill.InputEnded:Connect(function (input)
                    if input.UserInputType == Enum.UserInputType.MouseButton1 then dragging = false end
                end)

                services.run.RenderStepped:Connect(function()
                    if dragging then
                        local mouse = services.uis:GetMouseLocation()
                        local rel = math.clamp((mouse.X - Bg.AbsolutePosition.X) / Bg.AbsoluteSize.X, 0, 1)
                        update(rel)
                    end
                end)

                update((default - min) / (max - min))
                sector.increase_scrollbar_size()
                return slider
            end

            table.insert(window.tab_contents, {Tab.Name, Sector})
            return sector
        end
        return tab
    end
    return window
end

return lib
