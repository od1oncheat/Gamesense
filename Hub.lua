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
        ["ElementOutline"] = Color3.fromRGB(35,35,35),
        ["DropdownSelected"] = Color3.fromRGB(135, 176, 27),
        ["Toggle"] = Color3.fromRGB(135, 176, 27),
        ["ToggleUnchecked"] = Color3.fromRGB(27,27,27),
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

lib.create_window = function(theme, menu_key)
    if gethui():FindFirstChild("Mute") then
        gethui():FindFirstChild("Mute"):Destroy()
    end

    local window = {}
    window.dragging = false
    window.drag_start = nil
    window.start_pos = nil

    local Mute = Instance.new("ScreenGui")
    Mute.Name = "Mute"
    Mute.Parent = gethui()
    Mute.ZIndexBehavior = Enum.ZIndexBehavior.Sibling
    Mute.ResetOnSpawn = false
    Mute.DisplayOrder = 9999
    Mute.IgnoreGuiInset = true

    local Main = Instance.new("Frame")
    Main.Name = "Main"
    Main.Parent = Mute
    Main.BackgroundColor3 = themes[theme]["Window"]
    Main.BorderColor3 = Color3.fromRGB(45, 45, 45)
    Main.BorderSizePixel = 4
    Main.Position = UDim2.new(0.3, 0, 0.2, 0)
    Main.Size = UDim2.new(0, 740, 0, 640)  -- Увеличена высота

    local Tabs = Instance.new("Frame")
    Tabs.Name = "Tabs"
    Tabs.Parent = Main
    Tabs.BackgroundColor3 = themes[theme]["Tabs"]
    Tabs.BorderColor3 = Color3.fromRGB(21, 21, 21)
    Tabs.Position = UDim2.new  = UDim2.new(0, 1, 0.003, 0)
    Tabs.Size = UDim2.new(0, 120, 0, 637)  -- Увеличены табы по X

    local UIGridLayout = Instance.new("UIGridLayout")
    UIGridLayout.Parent = Tabs
    UIGridLayout.SortOrder = Enum.SortOrder.LayoutOrder
    UIGridLayout.CellPadding = UDim2.new(0, 12, 0, 0)
    UIGridLayout.CellSize = UDim2.new(0, 105, 0, 70)  -- Увеличены кнопки табов

    local UIPadding = Instance.new("UIPadding")
    UIPadding.Parent = Tabs
    UIPadding.PaddingLeft = UDim.new(0, 8)
    UIPadding.PaddingTop = UDim.new(0, 15)

    local TopGradient = Instance.new("Frame")
    TopGradient.Name = "TopGradient"
    TopGradient.Parent = Main
    TopGradient.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
    TopGradient.BorderSizePixel = 0
    TopGradient.Size = UDim2.new(0, 740, 0, 2)

    local UIGradient = Instance.new("UIGradient")
    UIGradient.Color = themes[theme]["Gradient"]
    UIGradient.Parent = TopGradient

    local Content = Instance.new("Frame")
    Content.Name = "Content"
    Content.Parent = Main
    Content.BackgroundTransparency = 1
    Content.Position = UDim2.new(0.165, 0, 0.024, 0)
    Content.Size = UDim2.new(0, 610, 0, 610)  -- Увеличена высота

    local UIListLayout = Instance.new("UIListLayout")
    UIListLayout.Parent = Content
    UIListLayout.FillDirection = Enum.FillDirection.Horizontal
    UIListLayout.SortOrder = Enum.SortOrder.LayoutOrder
    UIListLayout.Padding = UDim.new(0, 12)

    -- Dragging
    local function update(input)
        local delta = input.Position - window.drag_start
        Main.Position = UDim2.new(window.start_pos.X.Scale, window.start_pos.X.Offset + delta.X, window.start_pos.Y.Scale, window.start_pos.Y.Offset + delta.Y)
    end

    Main.InputBegan:Connect(function(input)
        if input.UserInputType == Enum.UserInputType.MouseButton1 then
            window.dragging = true
            window.drag_start = input.Position
            window.start_pos = Main.Position
        end
    end)

    Main.InputEnded:Connect(function(input)
        if input.UserInputType == Enum.UserInputType.MouseButton1 then
            window.dragging = false
        end
    end)

    services.uis.InputChanged:Connect(function(input)
        if window.dragging and input.UserInputType == Enum.UserInputType.MouseMovement then
            update(input)
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
        for _, v in pairs(window.tab_contents) do
            v[2].Visible = (v[1] == name)
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
            if tab:IsA("TextButton") then
                if tab.Name ~= ignore.Name then
                    window.tab_inactive(tab)
                else
                    window.tab_active(tab)
                end
            end
        end
    end

    local function createHover(element)
        local orig = element.BackgroundColor3
        local hover = orig:lerp(Color3.fromRGB(255,255,255), 0.1)
        local press = orig:lerp(Color3.fromRGB(0,0,0), 0.1)
        local tween = TweenInfo.new(0.15, Enum.EasingStyle.Quad)

        element.MouseEnter:Connect(function()
            services.tween:Create(element, tween, {BackgroundColor3 = hover}):Play()
        end)
        element.MouseLeave:Connect(function()
            services.tween:Create(element, tween, {BackgroundColor3 = orig}):Play()
        end)
        element.MouseButton1Down:Connect(function()
            services.tween:Create(element, tween, {BackgroundColor3 = press}):Play()
        end)
        element.MouseButton1Up:Connect(function()
            services.tween:Create(element, tween, {BackgroundColor3 = hover}):Play()
        end)
    end

    window.create_tab = function(image)
        local tab = {}
        local Tab = Instance.new("TextButton")
        Tab.Name = image:sub(14)
        Tab.Parent = Tabs
        Tab.BackgroundColor3 = themes[theme]["TabSelected"]
        Tab.BackgroundTransparency = 1
        Tab.BorderSizePixel = 2
        Tab.BorderColor3 = Color3.fromRGB(20, 20, 20)
        Tab.Size = UDim2.new(0, 105, 0, 70)
        Tab.AutoButtonColor = false
        Tab.Font = Enum.Font.Gotham
        Tab.Text = ""

        local Open = Instance.new("ImageButton")
        Open.Name = "Open"
        Open.Parent = Tab
        Open.BackgroundTransparency = 1
        Open.Position = UDim2.new(0.2, 0, 0.2, 0)
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
            local Sector = Instance.new("Frame")
            Sector.Name = name
            Sector.Parent = Content
            Sector.BackgroundColor3 = themes[theme]["Sector"]
            Sector.BorderColor3 = Color3.fromRGB(34, 34, 34)
            Sector.Position = UDim2.new((column-1)*0.5, 0, 0.03, 0)
            Sector.Size = UDim2.new(0.5, -6, 0.95, 0)
            Sector.Visible = false

            local Title = Instance.new("TextLabel")
            Title.Parent = Sector
            Title.BackgroundTransparency = 1
            Title.Position = UDim2.new(0.03, 0, -0.015, 0)
            Title.Size = UDim2.new(0, 200, 0, 18)
            Title.Font = Enum.Font.Gotham
            Title.Text = name
            Title.TextColor3 = themes[theme]["Text"]
            Title.TextSize = 18
            Title.TextXAlignment = Enum.TextXAlignment.Left

            local SectorContent = Instance.new("ScrollingFrame")
            SectorContent.Parent = Sector
            SectorContent.BackgroundTransparency = 1
            SectorContent.Position = UDim2.new(0.03, 0, 0.05, 0)
            SectorContent.Size = UDim2.new(0, 275, 0, 540)  -- Увеличено
            SectorContent.CanvasSize = UDim2.new(0, 0, 0, 0)
            SectorContent.ScrollBarThickness = 3

            local UIListLayout = Instance.new("UIListLayout")
            UIListLayout.Parent = SectorContent
            UIListLayout.SortOrder = Enum.SortOrder.LayoutOrder
            UIListLayout.Padding = UDim.new(0, 8)  -- Увеличены отступы между элементами

            local UIPadding = Instance.new("UIPadding")
            UIPadding.Parent = SectorContent
            UIPadding.PaddingLeft = UDim.new(0, 8)
            UIPadding.PaddingRight = UDim.new(0, 8)

            sector.increase_scrollbar_size = function()
                local h = 0
                for _, el in pairs(SectorContent:GetChildren()) do
                    if el:IsA("GuiObject") then h += el.AbsoluteSize.Y + 8 end
                end
                SectorContent.CanvasSize = UDim2.new(0, 0, 0, h)
            end

            -- Общий стиль для всех элементов
            local function create_element(size_y)
                local frame = Instance.new("Frame")
                frame.Size = UDim2.new(1, 0, 0, size_y)
                frame.BackgroundColor3 = themes[theme]["ElementBg"]
                frame.BorderColor3 = themes[theme]["ElementOutline"]
                frame.Parent = SectorContent
                return frame
            end

            sector.text = function(txt)
                local el = Instance.new("TextLabel")
                el.Parent = create_element(20)
                el.BackgroundTransparency = 1
                el.Size = UDim2.new(1, -16, 1, 0)
                el.Position = UDim2.new(0, 8, 0, 0)
                el.Font = Enum.Font.Gotham
                el.Text = txt
                el.TextColor3 = themes[theme]["Text"]
                el.TextSize = 14
                el.TextXAlignment = Enum.TextXAlignment.Left
                sector.increase_scrollbar_size()
            end

            sector.button = function(txt, callback)
                local btn = create_element(28)
                local label = Instance.new("TextLabel")
                label.Parent = btn
                label.BackgroundTransparency = 1
                label.Size = UDim2.new(1, -16, 1, 0)
                label.Position = UDim2.new(0, 8, 0, 0)
                label.Font = Enum.Font.Gotham
                label.Text = txt
                label.TextColor3 = themes[theme]["Text"]
                label.TextSize = 14
                label.TextXAlignment = Enum.TextXAlignment.Left

                btn.MouseButton1Down:Connect(callback)
                createHover(btn)
                sector.increase_scrollbar_size()
            end

            sector.textbox = function(placeholder, default, callback)
                local box = create_element(28)
                local tb = Instance.new("TextBox")
                tb.Parent = box
                tb.Size = UDim2.new(1, -16, 1, -8)
                tb.Position = UDim2.new(0, 8, 0, 4)
                tb.BackgroundTransparency = 1
                tb.Font = Enum.Font.Gotham
                tb.PlaceholderText = placeholder
                tb.Text = default
                tb.TextColor3 = themes[theme]["Text"]
                tb.TextSize = 14
                tb.TextXAlignment = Enum.TextXAlignment.Left

                tb:GetPropertyChangedSignal("Text"):Connect(function()
                    callback(tb.Text)
                end)
                callback(default)
                sector.increase_scrollbar_size()
            end

            sector.dropdown = function(txt, opts, def, callback)
                local drop = create_element(28)
                local btn = Instance.new("TextButton")
                btn.Parent = drop
                btn.Size = UDim2.new(1, -16, 1, -8)
                btn.Position = UDim2.new(0, 8, 0, 4)
                btn.BackgroundColor3 = themes[theme]["ElementBg"]
                btn.BorderColor3 = themes[theme]["ElementOutline"]
                btn.Text = txt
                btn.TextColor3 = themes[theme]["Text"]
                btn.Font = Enum.Font.Gotham
                btn.TextSize = 14
                btn.TextXAlignment = Enum.TextXAlignment.Left
                btn.AutoButtonColor = false

                local arrow = Instance.new("ImageLabel")
                arrow.Parent = btn
                arrow.Size = UDim2.new(0, 14, 0, 14)
                arrow.Position = UDim2.new(1, -20, 0.5, -7)
                arrow.BackgroundTransparency = 1
                arrow.Image = "rbxassetid://74187648454886"
                arrow.ImageColor3 = Color3.fromRGB(115,115,115)

                local content = Instance.new("ScrollingFrame")
                content.Parent = drop
                content.Size = UDim2.new(1, -16, 0, 100)
                content.Position = UDim2.new(0, 8, 1, 4)
                content.BackgroundColor3 = themes[theme]["ElementBg"]
                content.BorderColor3 = themes[theme]["ElementOutline"]
                content.Visible = false
                content.ScrollBarThickness = 3

                local list = Instance.new("UIListLayout")
                list.Parent = content
                list.Padding = UDim.new(0, 4)

                local selected = def
                local function update()
                    callback(selected)
                end

                btn.MouseButton1Down:Connect(function()
                    content.Visible = not content.Visible
                    arrow.Image = content.Visible and "rbxassetid://97940921082727" or "rbxassetid://74187648454886"
                end)

                for _, opt in pairs(opts) do
                    local optbtn = Instance.new("TextButton")
                    optbtn.Parent = content
                    optbtn.Size = UDim2.new(1, -10, 0, 24)
                    optbtn.BackgroundColor3 = themes[theme]["ElementBg"]
                    optbtn.BorderColor3 = themes[theme]["ElementOutline"]
                    optbtn.Text = opt
                    optbtn.TextColor3 = themes[theme]["Text"]
                    optbtn.Font = Enum.Font.Gotham
                    optbtn.TextSize = 14

                    optbtn.MouseButton1Down:Connect(function()
                        selected = opt
                        update()
                        content.Visible = false
                    end)

                    if opt == def then
                        selected = opt
                        update()
                    end
                end

                createHover(btn)
                sector.increase_scrollbar_size()
            end

            sector.toggle = function(txt, def, callback)
                local frame = create_element(22)
                local label = Instance.new("TextLabel")
                label.Parent = frame
                label.BackgroundTransparency = 1
                label.Size = UDim2.new(1, -40, 1, 0)
                label.Position = UDim2.new(0, 8, 0, 0)
                label.Font = Enum.Font.Gotham
                label.Text = txt
                label.TextColor3 = themes[theme]["Text"]
                label.TextSize = 14
                label.TextXAlignment = Enum.TextXAlignment.Left

                local bg = Instance.new("Frame")
                bg.Parent = frame
                bg.Size = UDim2.new(0, 32, 0, 16)
                bg.Position = UDim2.new(1, -40, 0.5, -8)
                bg.BackgroundColor3 = def and themes[theme]["Toggle"] or themes[theme]["ToggleUnchecked"]
                bg.BorderColor3 = themes[theme]["ElementOutline"]

                local fill = Instance.new("Frame")
                fill.Parent = bg
                fill.Size = def and UDim2.new(0, 14, 0, 14) or UDim2.new(0, 0, 0, 0)
                fill.Position = def and UDim2.new(1, -15, 0.5, -7) or UDim2.new(0, 1, 0.5, -7)
                fill.BackgroundColor3 = Color3.fromRGB(255,255,255)
                fill.BorderSizePixel = 0

                local function set(val)
                    services.tween:Create(bg, TweenInfo.new(0.15), {BackgroundColor3 = val and themes[theme]["Toggle"] or themes[theme]["ToggleUnchecked"]}):Play()
                    services.tween:Create(fill, TweenInfo.new(0.15), {
                        Size = val and UDim2.new(0, 14, 0, 14) or UDim2.new(0, 0, 0, 0),
                        Position = val and UDim2.new(1, -15, 0.5, -7) or UDim2.new(0, 1, 0.5, -7)
                    }):Play()
                    callback(val)
                end

                frame.InputBegan:Connect(function(i)
                    if i.UserInputType == Enum.UserInputType.MouseButton1 then
                        set(not (fill.Size.X.Offset > 0))
                    end
                end)

                set(def)
                sector.increase_scrollbar_size()
            end

            sector.slider = function(txt, suffix, min, max, def, callback)
                local frame = create_element(36)
                local label = Instance.new("TextLabel")
                label.Parent = frame
                label.BackgroundTransparency = 1
                label.Size = UDim2.new(1, -16, 0, 16)
                label.Position = UDim2.new(0, 8, 0, 2)
                label.Font = Enum.Font.Gotham
                label.Text = txt
                label.TextColor3 = themes[theme]["Text"]
                label.TextSize = 14
                label.TextXAlignment = Enum.TextXAlignment.Left

                local bg = Instance.new("Frame")
                bg.Parent = frame
                bg.Size = UDim2.new(1, -16, 0, 8)
                bg.Position = UDim2.new(0, 8, 0, 20)
                bg.BackgroundColor3 = themes[theme]["SliderBg"]
                bg.BorderColor3 = themes[theme]["ElementOutline"]

                local fill = Instance.new("Frame")
                fill.Parent = bg
                fill.BackgroundColor3 = themes[theme]["Slider"]
                fill.BorderColor3 = themes[theme]["ElementOutline"]
                fill.Size = UDim2.new(0, 0, 1, 0)

                local value_label = Instance.new("TextLabel")
                value_label.Parent = frame
                value_label.BackgroundTransparency = 1
                value_label.Font = Enum.Font.Gotham
                value_label.TextColor3 = themes[theme]["Text"]
                value_label.TextSize = 12
                value_label.Text = ""
                value_label.Size = UDim2.new(0, 60, 0, 14)
                value_label.Position = UDim2.new(0, 8, 0, 18)

                local dragging = false
                local function update(val)
                    local frac = (val - min) / (max - min)
                    fill.Size = UDim2.new(frac, 0, 1, 0)
                    value_label.Text = tostring(math.round(val * 100)/100) .. suffix

                    -- Центрируем текст в слайдере
                    local text_w = value_label.TextBounds.X
                    local bar_w = bg.AbsoluteSize.X
                    local pos_x = math.clamp(8 + frac * bar_w - text_w / 2, 8, 8 + bar_w - text_w - 4)
                    value_label.Position = UDim2.new(0, pos_x, 0, 18)
                    callback(val)
                end

                bg.InputBegan:Connect(function(i) if i.UserInputType == Enum.UserInputType.MouseButton1 then dragging = true end end)
                bg.InputEnded:Connect(function(i) if i.UserInputType == Enum.UserInputType.MouseButton1 then dragging = false end end)
                fill.InputBegan:Connect(function(i) if i.UserInputType == Enum.UserInputType.MouseButton1 then dragging = true end end)
                fill.InputEnded:Connect(function(i) if i.UserInputType == Enum.UserInputType.MouseButton1 then dragging = false end end)

                services.run.RenderStepped:Connect(function()
                    if dragging then
                        local mouse = services.uis:GetMouseLocation()
                        local rel = math.clamp((mouse.X - bg.AbsolutePosition.X) / bg.AbsoluteSize.X, 0, 1)
                        update(min + rel * (max - min))
                    end
                end)

                update(def)
                sector.increase_scrollbar_size()
            end

            table.insert(window.tab_contents, {Tab.Name, Sector})
            return sector
        end
        return tab
    end
    return window
end

return lib
