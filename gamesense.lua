local lib = {}
local themes = {
["gamesense"] = {
["Window"] = Color3.fromRGB(5, 5, 5),
["Tabs"] = Color3.fromRGB(4, 4, 4),
["Gradient"] = ColorSequence.new{ColorSequenceKeypoint.new(0.00, Color3.fromRGB(61, 130, 162)), ColorSequenceKeypoint.new(0.50, Color3.fromRGB(156, 59, 145)), ColorSequenceKeypoint.new(1.00, Color3.fromRGB(155, 161, 48))},
["Sector"] = Color3.fromRGB(12, 12, 12),
["Text"] = Color3.fromRGB(200, 200, 200),
["TabSelected"] = Color3.fromRGB(8, 8, 8),
["ElementBg"] = Color3.fromRGB(18, 18, 18),
["ElementOutline"] = Color3.fromRGB(30,30,30),
["DropdownSelected"] = Color3.fromRGB(150, 195, 40),
["Toggle"] = Color3.fromRGB(150, 195, 40),
["ToggleUnchecked"] = Color3.fromRGB(22,22,22),
["Slider"] = Color3.fromRGB(150, 195, 40),
["SliderBg"] = Color3.fromRGB(18, 18, 18),
["ButtonHover"] = Color3.fromRGB(28, 28, 28),
["ButtonPressed"] = Color3.fromRGB(33, 33, 33)
}
}
local services = {
["uis"] = game:GetService("UserInputService"),
["run"] = game:GetService("RunService"),
["tween"] = game:GetService("TweenService")
}
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
elseif gethui then
gui.Parent = gethui()
end
if identifyexecutor and string.find(string.lower(identifyexecutor()), "scriptware") then
gui.Parent = gethui()
end
end
lib.create_window = function(theme, menu_key)
local targetParent = gethui()
if targetParent:FindFirstChild("Mute") then
targetParent:FindFirstChild("Mute"):Destroy()
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
math.randomseed(os.time())
Mute.Name = tostring(math.random(0,9999999))
end)
services.uis.InputBegan:Connect(function(input)
if input.KeyCode == menu_key then
Mute.Enabled = not Mute.Enabled
end
end)
Mute.Name = "Mute"
Mute.Parent = targetParent
Mute.ZIndexBehavior = Enum.ZIndexBehavior.Global
Mute.ResetOnSpawn = false
Mute.DisplayOrder = 999999
Mute.IgnoreGuiInset = true
Main.Name = "Main"
Main.Parent = Mute
Main.BackgroundColor3 = themes[theme]["Window"]
Main.BorderColor3 = Color3.fromRGB(0, 0, 0)
Main.BorderSizePixel = 1
Main.Position = UDim2.new(0.38166827, 0, 0.249408439, 0)
Main.Size = UDim2.new(0, 684, 0, 605)
Tabs.Name = "Tabs"
Tabs.Parent = Main
Tabs.BackgroundColor3 = themes[theme]["Tabs"]
Tabs.BorderColor3 = Color3.fromRGB(0, 0, 0)
Tabs.BorderSizePixel = 1
Tabs.Position = UDim2.new(0, 0, 0.00330578513, 0)
Tabs.Size = UDim2.new(0, 110, 0, 602)
UIGridLayout.Parent = Tabs
UIGridLayout.SortOrder = Enum.SortOrder.LayoutOrder
UIGridLayout.CellPadding = UDim2.new(0, 15, 0, 0)
UIGridLayout.CellSize = UDim2.new(0, 95, 0, 70)
UIPadding.Parent = Tabs
UIPadding.PaddingLeft = UDim.new(0, 8)
UIPadding.PaddingTop = UDim.new(0, 15)
TopGradient.Name = "TopGradient"
TopGradient.Parent = Main
TopGradient.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
TopGradient.BorderColor3 = Color3.fromRGB(0, 0, 0)
TopGradient.BorderSizePixel = 1
TopGradient.Size = UDim2.new(0, 684, 0, 3)
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
local tweenInfo = TweenInfo.new(0.2, Enum.EasingStyle.Quad, Enum.EasingDirection.Out)
services.tween:Create(tab, tweenInfo, {BackgroundTransparency = 0}):Play()
services.tween:Create(tab.Open, tweenInfo, {ImageColor3 = Color3.fromRGB(209, 210, 208)}):Play()
end
window.tab_inactive = function(tab)
local tweenInfo = TweenInfo.new(0.2, Enum.EasingStyle.Quad, Enum.EasingDirection.Out)
services.tween:Create(tab, tweenInfo, {BackgroundTransparency = 1}):Play()
services.tween:Create(tab.Open, tweenInfo, {ImageColor3 = Color3.fromRGB(90,90,90)}):Play()
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
tab.sectorCount = 0
local Tab = Instance.new("TextButton")
local Open = Instance.new("ImageButton")
Tab.Name = image:sub(14)
Tab.Parent = Tabs
Tab.BackgroundColor3 = themes[theme]["TabSelected"]
Tab.BorderColor3 = Color3.fromRGB(18, 18, 18)
Tab.BackgroundTransparency = 1
Tab.BorderSizePixel = 2
Tab.Position = UDim2.new(0, 0, 0.14480409, 0)
Tab.Size = UDim2.new(0, 108, 0, 70)
Tab.AutoButtonColor = false
Tab.Font = Enum.Font.SourceSans
Tab.Text = ""
Tab.TextColor3 = Color3.fromRGB(0, 0, 0)
Tab.TextSize = 14.000
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
Open.MouseButton1Down:Connect(function()
window.selected_tab = Tab.Name
window.tab_colors(Tab)
window.show_tab(Tab.Name)
end)
tab.create_sector = function(name)
if tab.sectorCount >= 2 then
error("Cannot create more than 2 sectors per tab")
return nil
end
tab.sectorCount = tab.sectorCount + 1
local sector = {}
local Sector = Instance.new("Frame")
local Title = Instance.new("TextLabel")
local SectorContent = Instance.new("ScrollingFrame")
local UIListLayout = Instance.new("UIListLayout")
local UIPadding = Instance.new("UIPadding")
Sector.Name = name
Sector.Parent = Content
Sector.BackgroundColor3 = themes[theme]["Sector"]
Sector.BorderColor3 = Color3.fromRGB(30, 30, 30)
Sector.Position = UDim2.new(-0.00108384306, 0, -0.0011133909, 0)
Sector.Size = UDim2.new(0.5, -5, 1, 0)
Sector.Visible = false
Sector.ClipsDescendants = false
if tab.sectorCount == 2 then
Sector.Position = UDim2.new(0.5, 5, -0.0011133909, 0)
end
Title.Name = "Title"
Title.Parent = Sector
Title.BackgroundTransparency = 1
Title.BorderSizePixel = 0
Title.Position = UDim2.new(0, 0, 0, -10)
Title.Size = UDim2.new(1, 0, 0, 20)
Title.Font = Enum.Font.SourceSansBold
Title.TextColor3 = themes[theme]["Text"]
Title.TextSize = 18
Title.Text = name
Title.TextXAlignment = Enum.TextXAlignment.Left
Title.TextYAlignment = Enum.TextYAlignment.Bottom
Title.ZIndex = 5
SectorContent.Name = "SectorContent"
SectorContent.Parent = Sector
SectorContent.Active = true
SectorContent.BackgroundTransparency = 1
SectorContent.BorderSizePixel = 0
SectorContent.Position = UDim2.new(0, 0, 0, 20)
SectorContent.Size = UDim2.new(1, 0, 1, -20)
SectorContent.CanvasSize = UDim2.new(0, 0, 0, 0)
SectorContent.ScrollBarThickness = 3
SectorContent.ClipsDescendants = true
UIListLayout.Parent = SectorContent
UIListLayout.SortOrder = Enum.SortOrder.LayoutOrder
UIListLayout.Padding = UDim.new(0, 11)
UIPadding.Parent = SectorContent
UIPadding.PaddingLeft = UDim.new(0, 10)
UIPadding.PaddingTop = UDim.new(0, 8)
local UIGradient = Instance.new("UIGradient")
UIGradient.Color = ColorSequence.new{
ColorSequenceKeypoint.new(0.00, Color3.fromRGB(255, 255, 255)),
ColorSequenceKeypoint.new(1.00, Color3.fromRGB(180,180,180))
}
UIGradient.Rotation = 90
UIGradient.Parent = Sector
sector.increase_scrollbar_size = function()
local totalHeight = 0
for _, element in pairs(SectorContent:GetChildren()) do
if element:IsA("GuiObject") then
totalHeight = totalHeight + element.AbsoluteSize.Y + 11
end
end
SectorContent.CanvasSize = UDim2.new(0, 0, 0, totalHeight + 20)
end
sector.text = function(_text)
local text = {}
local Text = Instance.new("TextLabel")
Text.Name = _text
Text.Parent = SectorContent
Text.BackgroundTransparency = 1
Text.BorderSizePixel = 0
Text.Size = UDim2.new(0, 249, 0, 16)
Text.Font = Enum.Font.SourceSans
Text.Text = _text
Text.TextColor3 = themes[theme]["Text"]
Text.TextSize = 15.000
Text.TextStrokeTransparency = 0.800
Text.TextXAlignment = Enum.TextXAlignment.Left
text.delete = function()
Text:Destroy()
end
text.set = function(text)
Text.Text = text
end
sector.increase_scrollbar_size()
return text
end
sector.warning = function(_text)
local text = {}
local Text = Instance.new("TextLabel")
Text.Name = _text
Text.Parent = SectorContent
Text.BackgroundTransparency = 1
Text.BorderSizePixel = 0
Text.Size = UDim2.new(0, 249, 0, 16)
Text.Font = Enum.Font.SourceSans
Text.Text = _text
Text.TextColor3 = Color3.fromRGB(142, 127, 74)
Text.TextSize = 15.000
Text.TextStrokeTransparency = 0.800
Text.TextXAlignment = Enum.TextXAlignment.Left
text.delete = function()
Text:Destroy()
end
text.set = function(text)
Text.Text = text
end
sector.increase_scrollbar_size()
return text
end
sector.error = function(_text)
local text = {}
local Text = Instance.new("TextLabel")
Text.Name = _text
Text.Parent = SectorContent
Text.BackgroundTransparency = 1
Text.BorderSizePixel = 0
Text.Size = UDim2.new(0, 249, 0, 16)
Text.Font = Enum.Font.SourceSans
Text.Text = _text
Text.TextColor3 = Color3.fromRGB(142, 74, 65)
Text.TextSize = 15.000
Text.TextStrokeTransparency = 0.800
Text.TextXAlignment = Enum.TextXAlignment.Left
text.delete = function()
Text:Destroy()
end
text.set = function(text)
Text.Text = text
end
sector.increase_scrollbar_size()
return text
end
sector.info = function(_text)
local text = {}
local Text = Instance.new("TextLabel")
Text.Name = _text
Text.Parent = SectorContent
Text.BackgroundTransparency = 1
Text.BorderSizePixel = 0
Text.Size = UDim2.new(0, 249, 0, 16)
Text.Font = Enum.Font.SourceSans
Text.Text = _text
Text.TextColor3 = Color3.fromRGB(63, 110, 152)
Text.TextSize = 15.000
Text.TextStrokeTransparency = 0.800
Text.TextXAlignment = Enum.TextXAlignment.Left
text.delete = function()
Text:Destroy()
end
text.set = function(text)
Text.Text = text
end
sector.increase_scrollbar_size()
return text
end
sector.textbox = function(placeholder,default, callback)
local textbox = {}
local Label = Instance.new("TextLabel")
local TextBox = Instance.new("TextBox")
local UIPadding = Instance.new("UIPadding")
Label.Name = "Label"
Label.Parent = SectorContent
Label.BackgroundTransparency = 1
Label.Size = UDim2.new(1, 0, 0, 16)
Label.Font = Enum.Font.SourceSans
Label.TextColor3 = themes[theme]["Text"]
Label.TextSize = 14
Label.TextXAlignment = Enum.TextXAlignment.Left
Label.Text = placeholder
TextBox.Parent = SectorContent
TextBox.BackgroundColor3 = themes[theme]["ElementBg"]
TextBox.BorderColor3 = themes[theme]["ElementOutline"]
TextBox.Size = UDim2.new(0, 249, 0, 24)
TextBox.ClearTextOnFocus = false
TextBox.Font = Enum.Font.SourceSans
TextBox.PlaceholderColor3 = Color3.fromRGB(65, 65, 65)
TextBox.PlaceholderText = ""
TextBox.Text = default
TextBox.TextColor3 = themes[theme]["Text"]
TextBox.TextSize = 14.000
TextBox.TextStrokeTransparency = 0.800
TextBox.TextXAlignment = Enum.TextXAlignment.Left
UIPadding.Parent = TextBox
UIPadding.PaddingLeft = UDim.new(0, 5)
local tweenInfo = TweenInfo.new(0.2, Enum.EasingStyle.Quad, Enum.EasingDirection.Out)
TextBox.MouseEnter:Connect(function()
services.tween:Create(TextBox, tweenInfo, {BackgroundColor3 = themes[theme]["ButtonHover"]}):Play()
end)
TextBox.MouseLeave:Connect(function()
services.tween:Create(TextBox, tweenInfo, {BackgroundColor3 = themes[theme]["ElementBg"]}):Play()
end)
textbox.set = function(text)
TextBox.Text = text
end
textbox.get = function()
return TextBox.Text
end
textbox.delete = function()
Label:Destroy()
TextBox:Destroy()
end
TextBox:GetPropertyChangedSignal("Text"):Connect(function()
callback(TextBox.Text)
end)
callback(default)
sector.increase_scrollbar_size()
return textbox
end
sector.button = function(text,callback)
local button = {}
local Label = Instance.new("TextLabel")
local Button = Instance.new("TextButton")
Label.Name = "Label"
Label.Parent = SectorContent
Label.BackgroundTransparency = 1
Label.Size = UDim2.new(1, 0, 0, 16)
Label.Font = Enum.Font.SourceSans
Label.TextColor3 = themes[theme]["Text"]
Label.TextSize = 14
Label.TextXAlignment = Enum.TextXAlignment.Left
Label.Text = text
Button.Name = "Button"
Button.Parent = SectorContent
Button.BackgroundColor3 = themes[theme]["ElementBg"]
Button.BorderColor3 = themes[theme]["ElementOutline"]
Button.Size = UDim2.new(0, 249, 0, 24)
Button.AutoButtonColor = false
Button.Font = Enum.Font.SourceSans
Button.Text = ""
Button.TextColor3 = themes[theme]["Text"]
Button.TextSize = 14.000
local tweenInfo = TweenInfo.new(0.2, Enum.EasingStyle.Quad, Enum.EasingDirection.Out)
Button.MouseEnter:Connect(function()
services.tween:Create(Button, tweenInfo, {BackgroundColor3 = themes[theme]["ButtonHover"]}):Play()
end)
Button.MouseLeave:Connect(function()
services.tween:Create(Button, tweenInfo, {BackgroundColor3 = themes[theme]["ElementBg"]}):Play()
end)
Button.MouseButton1Down:Connect(function()
services.tween:Create(Button, TweenInfo.new(0.1, Enum.EasingStyle.Quad, Enum.EasingDirection.Out), {BackgroundColor3 = themes[theme]["ButtonPressed"]}):Play()
end)
Button.MouseButton1Up:Connect(function()
services.tween:Create(Button, tweenInfo, {BackgroundColor3 = themes[theme]["ButtonHover"]}):Play()
end)
Button.MouseButton1Down:Connect(function()
callback()
end)
sector.increase_scrollbar_size()
button.delete = function()
Label:Destroy()
Button:Destroy()
end
button.set = function(text)
Label.Text = text
end
return button
end
sector.dropdown = function(text, options, default, callback)
    local dropdown = {}
    dropdown.selected = default or options[1]
    local Label = Instance.new("TextLabel")
    local Dropdown = Instance.new("TextButton")
    local UIPadding = Instance.new("UIPadding")
    local Image = Instance.new("ImageLabel")
    local DropdownContent = Instance.new("ScrollingFrame")
    local UIPadding_2 = Instance.new("UIPadding")
    local UIListLayout = Instance.new("UIListLayout")
    Label.Name = "Label"
    Label.Parent = SectorContent
    Label.BackgroundTransparency = 1
    Label.Size = UDim2.new(1, 0, 0, 16)
    Label.Font = Enum.Font.SourceSans
    Label.TextColor3 = themes[theme]["Text"]
    Label.TextSize = 14
    Label.TextXAlignment = Enum.TextXAlignment.Left
    Label.Text = text
    Dropdown.Name = "Dropdown"
    Dropdown.Parent = SectorContent
    Dropdown.BackgroundColor3 = themes[theme]["ElementBg"]
    Dropdown.BorderColor3 = themes[theme]["ElementOutline"]
    Dropdown.Size = UDim2.new(0, 249, 0, 24)
    Dropdown.AutoButtonColor = false
    Dropdown.Font = Enum.Font.SourceSans
    Dropdown.Text = default or "None"
    Dropdown.TextColor3 = themes[theme]["Text"]
    Dropdown.TextSize = 14.000
    Dropdown.TextXAlignment = Enum.TextXAlignment.Left
    Dropdown.ZIndex = 100
    UIPadding.Parent = Dropdown
    UIPadding.PaddingLeft = UDim.new(0, 5)
    Image.Name = "Image"
    Image.Parent = Dropdown
    Image.BackgroundTransparency = 1
    Image.Position = UDim2.new(1, -22, 0.5, 0)
    Image.AnchorPoint = Vector2.new(0.5, 0.5)
    Image.Size = UDim2.new(0, 15, 0, 15)
    Image.Image = "rbxassetid://74187648454886"
    Image.ImageColor3 = Color3.fromRGB(115, 115, 115)
    Image.ZIndex = 101
    DropdownContent.Name = "DropdownContent"
    DropdownContent.Parent = Dropdown
    DropdownContent.Active = true
    DropdownContent.BackgroundColor3 = themes[theme]["ElementBg"]
    DropdownContent.BorderColor3 = themes[theme]["ElementOutline"]
    DropdownContent.Position = UDim2.new(0, 0, 1, 2)
    DropdownContent.Size = UDim2.new(1, 0, 0, 0)
    DropdownContent.CanvasSize = UDim2.new(0, 0, 0, 0)
    DropdownContent.ScrollBarThickness = 3
    DropdownContent.ScrollBarImageColor3 = Color3.fromRGB(50, 50, 50)
    DropdownContent.Visible = false
    DropdownContent.ZIndex = 102
    DropdownContent.ClipsDescendants = true
    UIPadding_2.Parent = DropdownContent
    UIPadding_2.PaddingLeft = UDim.new(0, 5)
    UIPadding_2.PaddingTop = UDim.new(0, 5)
    UIListLayout.Parent = DropdownContent
    UIListLayout.SortOrder = Enum.SortOrder.LayoutOrder
    UIListLayout.Padding = UDim.new(0, 5)
    local tweenInfo = TweenInfo.new(0.2, Enum.EasingStyle.Quad, Enum.EasingDirection.Out)
    Dropdown.MouseEnter:Connect(function()
        services.tween:Create(Dropdown, tweenInfo, {BackgroundColor3 = themes[theme]["ButtonHover"]}):Play()
    end)
    Dropdown.MouseLeave:Connect(function()
        if not DropdownContent.Visible then
            services.tween:Create(Dropdown, tweenInfo, {BackgroundColor3 = themes[theme]["ElementBg"]}):Play()
        end
    end)
    local isOpen = false
    local function toggleDropdown()
        isOpen = not isOpen
        if isOpen then
            DropdownContent.Visible = true
            services.tween:Create(Image, tweenInfo, {Rotation = 180}):Play()
            services.tween:Create(DropdownContent, tweenInfo, {Size = UDim2.new(1, 0, 0, 116)}):Play()
        else
            services.tween:Create(Image, tweenInfo, {Rotation = 0}):Play()
            services.tween:Create(DropdownContent, tweenInfo, {Size = UDim2.new(1, 0, 0, 0)}):Play()
            task.wait(0.2)
            DropdownContent.Visible = false
        end
    end
    Dropdown.MouseButton1Click:Connect(toggleDropdown)
    dropdown.unselect_all = function()
        for _, button in pairs(DropdownContent:GetChildren()) do
            if button:IsA("TextButton") then
                button.BorderColor3 = themes[theme]["ElementOutline"]
            end
        end
    end
    dropdown.set = function(name, skipCallback)
        dropdown.unselect_all()
        dropdown.selected = name
        Dropdown.Text = name
        local selectedButton = DropdownContent:FindFirstChild(name)
        if selectedButton then
            selectedButton.BorderColor3 = themes[theme]["DropdownSelected"]
        end
        if not skipCallback then
            callback(name)
            toggleDropdown()
        end
    end
    dropdown.set_text = function(_text)
        Label.Text = _text
    end
    dropdown.get = function()
        return dropdown.selected
    end
    dropdown.add = function(name, skipSelection)
        local Button = Instance.new("TextButton")
        Button.Name = name
        Button.Parent = DropdownContent
        Button.BackgroundColor3 = themes[theme]["ElementBg"]
        Button.BorderColor3 = themes[theme]["ElementOutline"]
        Button.Size = UDim2.new(1, -10, 0, 21)
        Button.Font = Enum.Font.SourceSans
        Button.TextColor3 = themes[theme]["Text"]
        Button.TextSize = 14.000
        Button.Text = name
        Button.AutoButtonColor = false
        Button.ZIndex = 103
        local tweenInfo = TweenInfo.new(0.2, Enum.EasingStyle.Quad, Enum.EasingDirection.Out)
        Button.MouseEnter:Connect(function()
            services.tween:Create(Button, tweenInfo, {BackgroundColor3 = themes[theme]["ButtonHover"]}):Play()
        end)
        Button.MouseLeave:Connect(function()
            if Button.BorderColor3 ~= themes[theme]["DropdownSelected"] then
                services.tween:Create(Button, tweenInfo, {BackgroundColor3 = themes[theme]["ElementBg"]}):Play()
            end
        end)
        Button.MouseButton1Down:Connect(function()
            dropdown.set(name)
        end)
        if name == default and not skipSelection then
            dropdown.set(name, true)
        end
        DropdownContent.CanvasSize = DropdownContent.CanvasSize + UDim2.new(0, 0, 0, 27)
    end
    dropdown.remove = function(name)
        local button = DropdownContent FinchFirstChild(name)
        if button then
            DropdownContent.CanvasSize = DropdownContent.CanvasSize - UDim2.new(0, 0, 0, 27)
            button:Destroy()
            if dropdown.selected == name then
                dropdown.selected = ""
                Dropdown.Text = "None"
            end
        end
    end
    dropdown.delete = function()
        Label:Destroy()
        Dropdown:Destroy()
    end
    for _, option in pairs(options) do
        dropdown.add(option, true)
    end
    if default then
        dropdown.set(default, true)
    end
    sector.increase_scrollbar_size()
    return dropdown
end
sector.multicombobox = function(text, options, defaults, callback)
    local multicombobox = {}
    multicombobox.selected = {}
    multicombobox.options = {}
    if type(defaults) == "table" then
        for _, v in pairs(options) do multicombobox.selected[v] = false end
        for _, v in pairs(defaults) do if multicombobox.selected[v] ~= nil then multicombobox.selected[v] = true end end
    else
        for _, v in pairs(options) do multicombobox.selected[v] = false end
    end
    local Label = Instance.new("TextLabel")
    local MultiCombobox = Instance.new("TextButton")
    local UIPadding = Instance.new("UIPadding")
    local Image = Instance.new("ImageLabel")
    local MultiComboboxContent = Instance.new("ScrollingFrame")
    local UIPadding_2 = Instance.new("UIPadding")
    local UIListLayout = Instance.new("UIListLayout")
    Label.Name = "Label"
    Label.Parent = SectorContent
    Label.BackgroundTransparency = 1
    Label.Size = UDim2.new(1, 0, 0, 16)
    Label.Font = Enum.Font.SourceSans
    Label.TextColor3 = themes[theme]["Text"]
    Label.TextSize = 14
    Label.TextXAlignment = Enum.TextXAlignment.Left
    Label.Text = text
    MultiCombobox.Name = "MultiCombobox"
    MultiCombobox.Parent = SectorContent
    MultiCombobox.BackgroundColor3 = themes[theme]["ElementBg"]
    MultiCombobox.BorderColor3 = themes[theme]["ElementOutline"]
    MultiCombobox.Size = UDim2.new(0, 249, 0, 24)
    MultiCombobox.AutoButtonColor = false
    MultiCombobox.Font = Enum.Font.SourceSans
    MultiCombobox.Text = "None"
    MultiCombobox.TextColor3 = themes[theme]["Text"]
    MultiCombobox.TextSize = 14.000
    MultiCombobox.TextXAlignment = Enum.TextXAlignment.Left
    MultiCombobox.ZIndex = 100
    UIPadding.Parent = MultiCombobox
    UIPadding.PaddingLeft = UDim.new(0, 5)
    Image.Name = "Image"
    Image.Parent = MultiCombobox
    Image.BackgroundTransparency = 1
    Image.Position = UDim2.new(1, -22, 0.5, 0)
    Image.AnchorPoint = Vector2.new(0.5, 0.5)
    Image.Size = UDim2.new(0, 15, 0, 15)
    Image.Image = "rbxassetid://74187648454886"
    Image.ImageColor3 = Color3.fromRGB(115, 115, 115)
    Image.ZIndex = 101
    MultiComboboxContent.Name = "MultiComboboxContent"
    MultiComboboxContent.Parent = MultiCombobox
    MultiComboboxContent.Active = true
    MultiComboboxContent.BackgroundColor3 = themes[theme]["ElementBg"]
    MultiComboboxContent.BorderColor3 = themes[theme]["ElementOutline"]
    MultiComboboxContent.Position = UDim2.new(0, 0, 1, 2)
    MultiComboboxContent.Size = UDim2.new(1, 0, 0, 0)
    MultiComboboxContent.CanvasSize = UDim2.new(0, 0, 0, 0)
    MultiComboboxContent.ScrollBarThickness = 3
    MultiComboboxContent.ScrollBarImageColor3 = Color3.fromRGB(50, 50, 50)
    MultiComboboxContent.Visible = false
    MultiComboboxContent.ZIndex = 102
    MultiComboboxContent.ClipsDescendants = true
    UIPadding_2.Parent = MultiComboboxContent
    UIPadding_2.PaddingLeft = UDim.new(0, 5)
    UIPadding_2.PaddingTop = UDim.new(0, 5)
    UIListLayout.Parent = MultiComboboxContent
    UIListLayout.SortOrder = Enum.SortOrder.LayoutOrder
    UIListLayout.Padding = UDim.new(0, 5)
    local tweenInfo = TweenInfo.new(0.2, Enum.EasingStyle.Quad, Enum.EasingDirection.Out)
    MultiCombobox.MouseEnter:Connect(function()
        services.tween:Create(MultiCombobox, tweenInfo, {BackgroundColor3 = themes[theme]["ButtonHover"]}):Play()
    end)
    MultiCombobox.MouseLeave:Connect(function()
        if not MultiComboboxContent.Visible then
            services.tween:Create(MultiCombobox, tweenInfo, {BackgroundColor3 = themes[theme]["ElementBg"]}):Play()
        end
    end)
    local isOpen = false
    local function toggleMultiCombobox()
        isOpen = not isOpen
        if isOpen then
            MultiComboboxContent.Visible = true
            services.tween:Create(Image, tweenInfo, {Rotation = 180}):Play()
            services.tween:Create(MultiComboboxContent, tweenInfo, {Size = UDim2.new(1, 0, 0, 116)}):Play()
        else
            services.tween:Create(Image, tweenInfo, {Rotation = 0}):Play()
            services.tween:Create(MultiComboboxContent, tweenInfo, {Size = UDim2.new(1, 0, 0, 0)}):Play()
            task.wait(0.2)
            MultiComboboxContent.Visible = false
        end
    end
    MultiCombobox.MouseButton1Click:Connect(toggleMultiCombobox)
    multicombobox.update_text = function()
        local selectedCount = 0
        local selectedNames = {}
        for name, sel in pairs(multicombobox.selected) do
            if sel then
                selectedCount += 1
                table.insert(selectedNames, name)
            end
        end
        if selectedCount == 0 then
            MultiCombobox.Text = "None"
        elseif selectedCount == 1 then
            MultiCombobox.Text = selectedNames[1]
        else
            MultiCombobox.Text = selectedCount.." selected"
        end
    end
    multicombobox.toggle_option = function(name)
        if multicombobox.selected[name] ~= nil then
            multicombobox.selected[name] = not multicombobox.selected[name]
            local btn = MultiComboboxContent:FindFirstChild(name)
            if btn then
                btn.BorderColor3 = multicombobox.selected[name] and themes[theme]["DropdownSelected"] or themes[theme]["ElementOutline"]
                btn.BackgroundColor3 = multicombobox.selected[name] and themes[theme]["ButtonHover"] or themes[theme]["ElementBg"]
            end
            multicombobox.update_text()
            callback(multicombobox.selected)
        end
    end
    multicombobox.set = function(name, value)
        if multicombobox.selected[name] ~= nil then
            multicombobox.selected[name] = value
            multicombobox.toggle_option(name)
        end
    end
    multicombobox.get_all = function() return multicombobox.selected end
    multicombobox.clear = function()
        for name,_ in pairs(multicombobox.selected) do
            multicombobox.selected[name] = false
            local btn = MultiComboboxContent:FindFirstChild(name)
            if btn then
                btn.BorderColor3 = themes[theme]["ElementOutline"]
                btn.BackgroundColor3 = themes[theme]["ElementBg"]
            end
        end
        multicombobox.update_text()
        callback(multicombobox.selected)
    end
    multicombobox.add = function(name)
        local Button = Instance.new("TextButton")
        Button.Name = name
        Button.Parent = MultiComboboxContent
        Button.BackgroundColor3 = themes[theme]["ElementBg"]
        Button.BorderColor3 = themes[theme]["ElementOutline"]
        Button.Size = UDim2.new(1, -10, 0, 21)
        Button.Font = Enum.Font.SourceSans
        Button.TextColor3 = themes[theme]["Text"]
        Button.TextSize = 14.000
        Button.Text = name
        Button.AutoButtonColor = false
        Button.ZIndex = 103
        Button.MouseEnter:Connect(function()
            services.tween:Create(Button, tweenInfo, {BackgroundColor3 = themes[theme]["ButtonHover"]}):Play()
        end)
        Button.MouseLeave:Connect(function()
            if not multicombobox.selected[name] then
                services.tween:Create(Button, tweenInfo, {BackgroundColor3 = themes[theme]["ElementBg"]}):Play()
            end
        end)
        Button.MouseButton1Down:Connect(function()
            multicombobox.toggle_option(name)
        end)
        if multicombobox.selected[name] then
            Button.BorderColor3 = themes[theme]["DropdownSelected"]
            Button.BackgroundColor3 = themes[theme]["ButtonHover"]
        end
        MultiComboboxContent.CanvasSize += UDim2.new(0, 0, 0, 27)
    end
    for _, opt in pairs(options) do multicombobox.add(opt) end
    multicombobox.update_text()
    sector.increase_scrollbar_size()
    multicombobox.delete = function()
        Label:Destroy()
        MultiCombobox:Destroy()
    end
    return multicombobox
end
sector.toggle = function(text,default,callback)
local toggle = {}
local value = default
local Label = Instance.new("TextLabel")
local Toggle = Instance.new("TextButton")
local Bg = Instance.new("TextButton")
Label.Name = "Label"
Label.Parent = SectorContent
Label.BackgroundTransparency = 1
Label.Size = UDim2.new(0, 249, 0, 16)
Label.Font = Enum.Font.SourceSans
Label.TextColor3 = themes[theme]["Text"]
Label.TextSize = 14
Label.TextXAlignment = Enum.TextXAlignment.Left
Label.Text = text
Toggle.Name = "Toggle"
Toggle.Parent = SectorContent
Toggle.BackgroundTransparency = 1
Toggle.Size = UDim2.new(0, 249, 0, 20)
Toggle.Text = ""
Bg.Name = "Bg"
Bg.Parent = Toggle
Bg.BackgroundColor3 = value and themes[theme]["Toggle"] or themes[theme]["ToggleUnchecked"]
Bg.BorderColor3 = themes[theme]["ElementOutline"]
Bg.Position = UDim2.new(0, 0, 0.1, 0)
Bg.Size = UDim2.new(0, 12, 0, 12)
Bg.AutoButtonColor = false
local tweenInfo = TweenInfo.new(0.2, Enum.EasingStyle.Quad, Enum.EasingDirection.Out)
Bg.MouseEnter:Connect(function()
services.tween:Create(Bg, tweenInfo, {Size = UDim2.new(0, 14, 0, 14)}):Play()
end)
Bg.MouseLeave:Connect(function()
services.tween:Create(Bg, tweenInfo, {Size = UDim2.new(0, 12, 0, 12)}):Play()
end)
toggle.set = function(val)
value = val
services.tween:Create(Bg, tweenInfo, {BackgroundColor3 = val and themes[theme]["Toggle"] or themes[theme]["ToggleUnchecked"]}):Play()
callback(val)
end
toggle.set_text = function(txt) Label.Text = txt end
Toggle.MouseButton1Click:Connect(function()
toggle.set(not value)
end)
Bg.MouseButton1Click:Connect(function()
toggle.set(not value)
end)
toggle.set(value)
sector.increase_scrollbar_size()
toggle.delete = function()
Label:Destroy()
Toggle:Destroy()
end
return toggle
end
sector.slider = function(text, indicator, min, max, default, callback)
local slider = {}
local dragging = false
local value = default
local Label = Instance.new("TextLabel")
local Slider = Instance.new("TextButton")
local Bg = Instance.new("TextButton")
local Fill = Instance.new("TextButton")
local ValueLabel = Instance.new("TextLabel")
Label.Name = "Label"
Label.Parent = SectorContent
Label.BackgroundTransparency = 1
Label.Size = UDim2.new(0, 249, 0, 16)
Label.Font = Enum.Font.SourceSans
Label.TextColor3 = themes[theme]["Text"]
Label.TextSize = 14
Label.TextXAlignment = Enum.TextXAlignment.Left
Label.Text = text
Slider.Name = "Slider"
Slider.Parent = SectorContent
Slider.BackgroundTransparency = 1
Slider.Size = UDim2.new(0, 249, 0, 28)
Slider.Text = ""
Bg.Name = "Bg"
Bg.Parent = Slider
Bg.BackgroundColor3 = themes[theme]["SliderBg"]
Bg.BorderColor3 = themes[theme]["ElementOutline"]
Bg.Position = UDim2.new(0, 0, 0.5, 0)
Bg.Size = UDim2.new(1, 0, 0, 8)
Bg.AutoButtonColor = false
Fill.Name = "Fill"
Fill.Parent = Bg
Fill.BackgroundColor3 = themes[theme]["Slider"]
Fill.BorderSizePixel = 0
Fill.Size = UDim2.new((default - min) / (max - min), 0, 1, 0)
ValueLabel.Name = "ValueLabel"
ValueLabel.Parent = Bg
ValueLabel.BackgroundTransparency = 1
ValueLabel.Size = UDim2.new(0, 50, 1, 0)
ValueLabel.Position = UDim2.new(1, -55, 0, 0)
ValueLabel.Font = Enum.Font.SourceSans
ValueLabel.TextColor3 = themes[theme]["Text"]
ValueLabel.TextSize = 13
ValueLabel.TextXAlignment = Enum.TextXAlignment.Right
ValueLabel.Text = tostring(math.round(default * 100)/100)..(indicator or "")
local tweenInfo = TweenInfo.new(0.2, Enum.EasingStyle.Quad, Enum.EasingDirection.Out)
Bg.MouseEnter:Connect(function()
services.tween:Create(Bg, tweenInfo, {BackgroundColor3 = themes[theme]["ButtonHover"]}):Play()
end)
Bg.MouseLeave:Connect(function()
services.tween:Create(Bg, tweenInfo, {BackgroundColor3 = themes[theme]["SliderBg"]}):Play()
end)
slider.set = function(val)
value = val
local percent = (val - min) / (max - min)
services.tween:Create(Fill, tweenInfo, {Size = UDim2.new(percent, 0, 1, 0)}):Play()
ValueLabel.Position = UDim2.new(percent, -25, 0, 0)
ValueLabel.Text = tostring(math.round(val * 100)/100)..(indicator or "")
callback(val)
end
slider.get = function() return value end
slider.set_text = function(txt) Label.Text = txt end
local function updateSlider(input)
local mouseX = services.uis:GetMouseLocation().X
local absX = Bg.AbsolutePosition.X
local width = Bg.AbsoluteSize.X
local percent = math.clamp((mouseX - absX) / width, 0, 1)
local newVal = min + percent * (max - min)
slider.set(newVal)
end
Bg.InputBegan:Connect(function(input)
if input.UserInputType == Enum.UserInputType.MouseButton1 then
dragging = true
updateSlider(input)
end
end)
Bg.InputEnded:Connect(function(input)
if input.UserInputType == Enum.UserInputType.MouseButton1 then
dragging = false
end
end)
services.run.RenderStepped:Connect(function()
if dragging then
updateSlider()
end
end)
sector.increase_scrollbar_size()
slider.delete = function()
Label:Destroy()
Slider:Destroy()
end
return slider
end
table.insert(window.tab_contents,{
Tab.Name,
Sector
})
return sector
end
return tab
end
return window
end
return lib
