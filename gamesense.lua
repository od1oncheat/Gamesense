local lib = {}
local themes = {
["gamesense"] = {
["Window"] = Color3.fromRGB(6, 6, 6),
["Tabs"] = Color3.fromRGB(4, 4, 4),
["Gradient"] = ColorSequence.new{ColorSequenceKeypoint.new(0.00, Color3.fromRGB(61, 130, 162)), ColorSequenceKeypoint.new(0.50, Color3.fromRGB(156, 59, 145)), ColorSequenceKeypoint.new(1.00, Color3.fromRGB(155, 161, 48))},
["Sector"] = Color3.fromRGB(12, 12, 12),
["Text"] = Color3.fromRGB(200, 200, 200),
["TabSelected"] = Color3.fromRGB(8, 8, 8),
["ElementBg"] = Color3.fromRGB(18, 18, 18),
["ElementOutline"] = Color3.fromRGB(30,30,30),
["DropdownSelected"] = Color3.fromRGB(150, 200, 50),
["Toggle"] = Color3.fromRGB(150, 200, 50),
["ToggleUnchecked"] = Color3.fromRGB(22,22,22),
["Slider"] = Color3.fromRGB(150, 200, 50),
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

-- Watermark + фон с узором
local watermark_tex_data = "\x14\x14\x14\xFF\x14\x14\x14\xFF\x14\x14\x14\xFF\x0c\x0c\x0c\xFF\x14\x14\x14\xFF\x0c\x0c\x0c\xFF\x14\x14\x14\xFF\x0c\x0c\x0c\xFF\x14\x14\x14\xFF\x0c\x0c\x0c\xFF\x14\x14\x14\xFF\x14\x14\x14\xFF\x14\x14\x14\xFF\x0c\x0c\x0c\xFF\x14\x14\x14\xFF\x0c\x0c\x0c\xFF"
local watermark_texture = Instance.new("ImageLabel")
watermark_texture.Name = "Pattern"
watermark_texture.BackgroundTransparency = 1
watermark_texture.Image = "rbxassetid://0"
watermark_texture.ImageColor3 = Color3.fromRGB(255,255,255)
watermark_texture.Size = UDim2.new(1,0,1,0)
watermark_texture.TileSize = UDim2.new(0,16,0,16)
watermark_texture.Visible = true
watermark_texture.ZIndex = 0

-- FPS счётчик для watermark
local ft = 0
local function get_fps()
    ft = ft * 0.9 + services.run.Heartbeat:Wait() * 0.1
    return math.floor(1 / ft + 0.5)
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

-- Watermark
local Watermark = Instance.new("Frame")
Watermark.Name = "Watermark"
Watermark.Parent = Mute
Watermark.BackgroundTransparency = 1
Watermark.Position = UDim2.new(1, -200, 0, 10)
Watermark.Size = UDim2.new(0, 180, 0, 26)
Watermark.ZIndex = 9999

local WMCorner = Instance.new("UICorner")
WMCorner.CornerRadius = UDim.new(0, 4)
WMCorner.Parent = Watermark

local WMBorder = Instance.new("Frame")
WMBorder.Name = "Border"
WMBorder.Parent = Watermark
WMBorder.BackgroundColor3 = Color3.fromRGB(0,0,0)
WMBorder.BorderSizePixel = 0
WMBorder.Size = UDim2.new(1,2,1,2)
WMBorder.Position = UDim2.new(0,-1,0,-1)
WMBorder.ZIndex = 0

local WMInner = Instance.new("Frame")
WMInner.Parent = Watermark
WMInner.BackgroundColor3 = Color3.fromRGB(62,62,62)
WMInner.BorderSizePixel = 0
WMInner.Size = UDim2.new(1,0,1,0)

local WMPattern = watermark_texture:Clone()
WMPattern.Parent = WMInner
WMPattern.ImageTransparency = 0.9

local WMGradientLine = Instance.new("Frame")
WMGradientLine.Parent = WMInner
WMGradientLine.BackgroundColor3 = Color3.new(1,1,1)
WMGradientLine.Position = UDim2.new(0,5,0,4)
WMGradientLine.Size = UDim2.new(1,-10,0,1)
local WMGrad = Instance.new("UIGradient")
WMGrad.Color = themes[theme]["Gradient"]
WMGrad.Parent = WMGradientLine

local WMText = Instance.new("TextLabel")
WMText.Parent = WMInner
WMText.BackgroundTransparency = 1
WMText.Position = UDim2.new(0,8,0,0)
WMText.Size = UDim2.new(1,-16,1,0)
WMText.Font = Enum.Font.Gotham
WMText.Text = "gamesense | 0 fps"
WMText.TextColor3 = Color3.fromRGB(255,255,255)
WMText.TextTransparency = 0.1
WMText.TextSize = 12
WMText.TextXAlignment = Enum.TextXAlignment.Left

services.run.Heartbeat:Connect(function()
    WMText.Text = "gamesense | "..get_fps().." fps"
end)

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

-- Фон с узором для всего меню
local PatternBg = watermark_texture:Clone()
PatternBg.Parent = Main
PatternBg.ImageTransparency = 0.93
PatternBg.ZIndex = 0

Main.Name = "Main"
Main.Parent = Mute
Main.BackgroundColor3 = themes[theme]["Window"]
Main.BorderColor3 = Color3.fromRGB(0,0,0)
Main.BorderSizePixel = 1
Main.Position = UDim2.new(0.38166827, 0, 0.249408439, 0)
Main.Size = UDim2.new(0, 684, 0, 605)

Tabs.Name = "Tabs"
Tabs.Parent = Main
Tabs.BackgroundColor3 = themes[theme]["Tabs"]
Tabs.BorderColor3 = Color3.fromRGB(0,0,0)
Tabs.BorderSizePixel = 1
Tabs.Position = UDim2.new(0, 0, 0.00330578513, 0)
Tabs.Size = UDim2.new(0, 120, 0, 602)
UIGridLayout.Parent = Tabs
UIGridLayout.SortOrder = Enum.SortOrder.LayoutOrder
UIGridLayout.CellPadding = UDim2.new(0, 15, 0, 0)
UIGridLayout.CellSize = UDim2.new(0, 105, 0, 70)
UIPadding.Parent = Tabs
UIPadding.PaddingLeft = UDim.new(0, 8)
UIPadding.PaddingTop = UDim.new(0, 15)

TopGradient.Name = "TopGradient"
TopGradient.Parent = Main
TopGradient.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
TopGradient.BorderColor3 = Color3.fromRGB(0,0,0)
TopGradient.BorderSizePixel = 1
TopGradient.Size = UDim2.new(0, 684, 0, 2)
UIGradient.Color = themes[theme]["Gradient"]
UIGradient.Parent = TopGradient

Content.Name = "Content"
Content.Parent = Main
Content.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
Content.BackgroundTransparency = 1.000
Content.BorderColor3 = Color3.fromRGB(0, 0, 0)
Content.BorderSizePixel = 0
Content.Position = UDim2.new(0.175, 0, 0.0247933883, 0)
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
Tab.BorderColor3 = Color3.fromRGB(0, 0, 0)
Tab.BorderSizePixel = 1
Tab.BackgroundTransparency = 1
Tab.Size = UDim2.new(0, 108, 0, 70)
Tab.AutoButtonColor = false
Tab.Font = Enum.Font.SourceSans
Tab.Text = ""
Tab.TextColor3 = Color3.fromRGB(0, 0, 0)
Tab.TextSize = 14.000
Open.Name = "Open"
Open.Parent = Tab
Open.BackgroundTransparency = 1.000
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
Sector.BorderColor3 = Color3.fromRGB(0,0,0)
Sector.BorderSizePixel = 1
Sector.Position = UDim2.new(-0.00108384306, 0, -0.0011133909, 0)
Sector.Size = UDim2.new(0.5, -5, 1, 0)
Sector.Visible = false
Sector.ClipsDescendants = false
if tab.sectorCount == 2 then
Sector.Position = UDim2.new(0.5, 5, -0.0011133909, 0)
end
Title.Name = "Title"
Title.Parent = Sector
Title.BackgroundTransparency = 1.000
Title.BorderSizePixel = 0
Title.Position = UDim2.new(0.028933093, 0, -0.04, 0)
Title.Size = UDim2.new(0, 268, 0, 20)
Title.Font = Enum.Font.GothamBold
Title.TextColor3 = themes[theme]["Text"]
Title.TextSize = 16.000
Title.TextStrokeTransparency = 0.800
Title.TextXAlignment = Enum.TextXAlignment.Left
Title.Text = name

SectorContent.Name = "SectorContent"
SectorContent.Parent = Sector
SectorContent.Active = true
SectorContent.BackgroundTransparency = 1.000
SectorContent.BorderSizePixel = 0
SectorContent.Position = UDim2.new(0, 0, 0, 28)
SectorContent.Size = UDim2.new(1, 0, 1, -28)
SectorContent.CanvasSize = UDim2.new(0, 0, 0, 0)
SectorContent.ScrollBarThickness = 3
SectorContent.ClipsDescendants = true
UIListLayout.Parent = SectorContent
UIListLayout.SortOrder = Enum.SortOrder.LayoutOrder
UIListLayout.Padding = UDim.new(0, 12)
UIPadding.Parent = SectorContent
UIPadding.PaddingLeft = UDim.new(0, 10)
UIPadding.PaddingTop = UDim.new(0, 8)

sector.increase_scrollbar_size = function()
local totalHeight = 0
for _, element in pairs(SectorContent:GetChildren()) do
if element:IsA("GuiObject") then
totalHeight = totalHeight + element.AbsoluteSize.Y + 12
end
end
SectorContent.CanvasSize = UDim2.new(0, 0, 0, totalHeight + 20)
end

sector.text = function(_text)
local text = {}
local Text = Instance.new("TextLabel")
Text.Name = _text
Text.Parent = SectorContent
Text.BackgroundTransparency = 1.000
Text.BorderSizePixel = 0
Text.Size = UDim2.new(0, 249, 0, 16)
Text.Font = Enum.Font.SourceSans
Text.Text = _text
Text.TextColor3 = themes[theme]["Text"]
Text.TextSize = 14.000
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

sector.warning = function(_text) -- такие же как text но другие цвета
local text = {}
local Text = Instance.new("TextLabel")
Text.Name = _text
Text.Parent = SectorContent
Text.BackgroundTransparency = 1.000
Text.Size = UDim2.new(0, 249, 0, 16)
Text.Font = Enum.Font.SourceSans
Text.Text = _text
Text.TextColor3 = Color3.fromRGB(142, 127, 74)
Text.TextSize = 14.000
Text.TextStrokeTransparency = 0.800
Text.TextXAlignment = Enum.TextXAlignment.Left
text.delete = function() Text:Destroy() end
text.set = function(t) Text.Text = t end
sector.increase_scrollbar_size()
return text
end

sector.error = function(_text)
local text = {}
local Text = Instance.new("TextLabel")
Text.Name = _text
Text.Parent = SectorContent
Text.BackgroundTransparency = 1.000
Text.Size = UDim2.new(0, 249, 0, 16)
Text.Font = Enum.Font.SourceSans
Text.Text = _text
Text.TextColor3 = Color3.fromRGB(142, 74, 65)
Text.TextSize = 14.000
Text.TextStrokeTransparency = 0.800
Text.TextXAlignment = Enum.TextXAlignment.Left
text.delete = function() Text:Destroy() end
text.set = function(t) Text.Text = t end
sector.increase_scrollbar_size()
return text
end

sector.info = function(_text)
local text = {}
local Text = Instance.new("TextLabel")
Text.Name = _text
Text.Parent = SectorContent
Text.BackgroundTransparency = 1.000
Text.Size = UDim2.new(0, 249, 0, 16)
Text.Font = Enum.Font.SourceSans
Text.Text = _text
Text.TextColor3 = Color3.fromRGB(63, 110, 152)
Text.TextSize = 14.000
Text.TextStrokeTransparency = 0.800
Text.TextXAlignment = Enum.TextXAlignment.Left
text.delete = function() Text:Destroy() end
text.set = function(t) Text.Text = t end
sector.increase_scrollbar_size()
return text
end

sector.textbox = function(placeholder,default, callback)
local textbox = {}
local TextBox = Instance.new("TextBox")
local UIPadding = Instance.new("UIPadding")
TextBox.Parent = SectorContent
TextBox.BackgroundColor3 = themes[theme]["ElementBg"]
TextBox.BorderColor3 = themes[theme]["ElementOutline"]
TextBox.Size = UDim2.new(0, 249, 0, 24)
TextBox.ClearTextOnFocus = false
TextBox.Font = Enum.Font.SourceSans
TextBox.PlaceholderColor3 = Color3.fromRGB(65, 65, 65)
TextBox.PlaceholderText = placeholder
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
textbox.set = function(text) TextBox.Text = text end
textbox.get = function() return TextBox.Text end
textbox.delete = function() TextBox:Destroy() end
TextBox:GetPropertyChangedSignal("Text"):Connect(function() callback(TextBox.Text) end)
callback(default)
sector.increase_scrollbar_size()
return textbox
end

sector.button = function(text,callback)
local button = {}
local Button = Instance.new("TextButton")
Button.Name = "Button"
Button.Parent = SectorContent
Button.BackgroundColor3 = themes[theme]["ElementBg"]
Button.BorderColor3 = themes[theme]["ElementOutline"]
Button.Size = UDim2.new(0, 249, 0, 24)
Button.AutoButtonColor = false
Button.Font = Enum.Font.SourceSans
Button.TextColor3 = themes[theme]["Text"]
Button.TextSize = 14.000
Button.Text = text
local tweenInfo = TweenInfo.new(0.2, Enum.EasingStyle.Quad, Enum.EasingDirection.Out)
Button.MouseEnter:Connect(function()
services.tween:Create(Button, tweenInfo, {BackgroundColor3 = themes[theme]["ButtonHover"]}):Play()
end)
Button.MouseLeave:Connect(function()
services.tween:Create(Button, tweenInfo, {BackgroundColor3 = themes[theme]["ElementBg"]}):Play()
end)
Button.MouseButton1Down:Connect(function()
services.tween:Create(Button, TweenInfo.new(0.1, Enum.EasingStyle.Quad), {BackgroundColor3 = themes[theme]["ButtonPressed"]}):Play()
end)
Button.MouseButton1Up:Connect(function()
services.tween:Create(Button, tweenInfo, {BackgroundColor3 = themes[theme]["ButtonHover"]}):Play()
end)
Button.MouseButton1Down:Connect(callback)
sector.increase_scrollbar_size()
button.delete = function() Button:Destroy() end
button.set = function(t) Button.Text = t end
return button
end

sector.dropdown = function(text, options, default, callback)
    local dropdown = {}
    dropdown.selected = default or options[1]
    local Label = Instance.new("TextLabel")
    local Dropdown = Instance.new("TextButton")
    local Arrow = Instance.new("ImageLabel")
    local DropdownContent = Instance.new("ScrollingFrame")
    local UIListLayout = Instance.new("UIListLayout")
    local UIPadding = Instance.new("UIPadding")

    Label.Parent = SectorContent
    Label.BackgroundTransparency = 1
    Label.Size = UDim2.new(0,249,0,16)
    Label.Font = Enum.Font.SourceSans
    Label.Text = text
    Label.TextColor3 = themes[theme]["Text"]
    Label.TextSize = 14
    Label.TextXAlignment = Enum.TextXAlignment.Left

    Dropdown.Parent = SectorContent
    Dropdown.BackgroundColor3 = themes[theme]["ElementBg"]
    Dropdown.BorderColor3 = themes[theme]["ElementOutline"]
    Dropdown.Size = UDim2.new(0, 249, 0, 24)
    Dropdown.AutoButtonColor = false
    Dropdown.Font = Enum.Font.SourceSans
    Dropdown.Text = dropdown.selected
    Dropdown.TextColor3 = themes[theme]["Text"]
    Dropdown.TextSize = 14.000
    Dropdown.TextXAlignment = Enum.TextXAlignment.Left

    Arrow.Name = "Arrow"
    Arrow.Parent = Dropdown
    Arrow.BackgroundTransparency = 1
    Arrow.Position = UDim2.new(1, -22, 0.5, -7)
    Arrow.Size = UDim2.new(0, 15, 0, 15)
    Arrow.Image = "rbxassetid://74187648454886"
    Arrow.ImageColor3 = Color3.fromRGB(115, 115, 115)

    DropdownContent.Parent = Dropdown
    DropdownContent.BackgroundColor3 = themes[theme]["ElementBg"]
    DropdownContent.BorderColor3 = themes[theme]["ElementOutline"]
    DropdownContent.Position = UDim2.new(0, 0, 1, 2)
    DropdownContent.Size = UDim2.new(1, 0, 0, 0)
    DropdownContent.CanvasSize = UDim2.new(0,0,0,0)
    DropdownContent.ScrollBarThickness = 3
    DropdownContent.Visible = false
    DropdownContent.ZIndex = 102
    UIListLayout.Parent = DropdownContent
    UIListLayout.Padding = UDim.new(0,4)
    UIPadding.Parent = DropdownContent
    UIPadding.PaddingLeft = UDim.new(0,5)
    UIPadding.PaddingTop = UDim.new(0,4)

    local isOpen = false
    local function toggle()
        isOpen = not isOpen
        if isOpen then
            DropdownContent.Visible = true
            services.tween:Create(DropdownContent, TweenInfo.new(0.2), {Size = UDim2.new(1,0,0,120)}):Play()
            services.tween:Create(Arrow, TweenInfo.new(0.2), {Rotation = 180}):Play()
        else
            services.tween:Create(DropdownContent, TweenInfo.new(0.2), {Size = UDim2.new(1,0,0,0)}):Play()
            services.tween:Create(Arrow, TweenInfo.new(0.2), {Rotation = 0}):Play()
            task.delay(0.2, function() DropdownContent.Visible = false end)
        end
    end
    Dropdown.MouseButton1Click:Connect(toggle)

    dropdown.add = function(name)
        local btn = Instance.new("TextButton")
        btn.Name = name
        btn.Parent = DropdownContent
        btn.BackgroundColor3 = themes[theme]["ElementBg"]
        btn.BorderColor3 = themes[theme]["ElementOutline"]
        btn.Size = UDim2.new(1, -10, 0, 22)
        btn.Text = name
        btn.TextColor3 = themes[theme]["Text"]
        btn.AutoButtonColor = false
        btn.MouseButton1Click:Connect(function()
            dropdown.selected = name
            Dropdown.Text = name
            callback(name)
            toggle()
        end)
        DropdownContent.CanvasSize = DropdownContent.CanvasSize + UDim2.new(0,0,0,26)
    end

    for _, opt in pairs(options) do dropdown.add(opt) end
    if default then dropdown.selected = default Dropdown.Text = default end
    sector.increase_scrollbar_size()
    return dropdown
end

sector.multicombobox = function(text, options, defaults, callback)
    local multicombobox = {}
    multicombobox.selected = {}
    for _, v in pairs(options) do multicombobox.selected[v] = false end
    if type(defaults) == "table" then
        for _, v in pairs(defaults) do if multicombobox.selected[v] ~= nil then multicombobox.selected[v] = true end end
    end

    local Label = Instance.new("TextLabel")
    local MainBtn = Instance.new("TextButton")
    local Arrow = Instance.new("ImageLabel")
    local Content = Instance.new("ScrollingFrame")
    local UIList = Instance.new("UIListLayout")
    local Pad = Instance.new("UIPadding")

    Label.Parent = SectorContent
    Label.BackgroundTransparency = 1
    Label.Size = UDim2.new(0,249,0,16)
    Label.Font = Enum.Font.SourceSans
    Label.Text = text
    Label.TextColor3 = themes[theme]["Text"]
    Label.TextSize = 14
    Label.TextXAlignment = Enum.TextXAlignment.Left

    MainBtn.Parent = SectorContent
    MainBtn.BackgroundColor3 = themes[theme]["ElementBg"]
    MainBtn.BorderColor3 = themes[theme]["ElementOutline"]
    MainBtn.Size = UDim2.new(0,249,0,24)
    MainBtn.Text = text
    MainBtn.TextColor3 = themes[theme]["Text"]
    MainBtn.TextXAlignment = Enum.TextXAlignment.Left
    MainBtn.AutoButtonColor = false

    Arrow.Parent = MainBtn
    Arrow.BackgroundTransparency = 1
    Arrow.Position = UDim2.new(1, -22, 0.5, -7)
    Arrow.Size = UDim2.new(0,15,0,15)
    Arrow.Image = "rbxassetid://74187648454886"
    Arrow.ImageColor3 = Color3.fromRGB(115,115,115)

    Content.Parent = MainBtn
    Content.BackgroundColor3 = themes[theme]["ElementBg"]
    Content.BorderColor3 = themes[theme]["ElementOutline"]
    Content.Position = UDim2.new(0,0,1,2)
    Content.Size = UDim2.new(1,0,0,0)
    Content.CanvasSize = UDim2.new(0,0,0,0)
    Content.ScrollBarThickness = 3
    Content.Visible = false
    Content.ZIndex = 102
    UIList.Parent = Content
    UIList.Padding = UDim.new(0,4)
    Pad.Parent = Content
    Pad.PaddingLeft = UDim.new(0,5)
    Pad.PaddingTop = UDim.new(0,4)

    local function update_text()
        local cnt = 0
        for _,v in pairs(multicombobox.selected) do if v then cnt += 1 end end
        if cnt == 0 then MainBtn.Text = text
        elseif cnt == 1 then for k,v in pairs(multicombobox.selected) do if v then MainBtn.Text = k break end end
        else MainBtn.Text = text.." ("..cnt.." selected)" end
    end

    local isOpen = false
    local function toggle()
        isOpen = not isOpen
        if isOpen then
            Content.Visible = true
            services.tween:Create(Content, TweenInfo.new(0.2), {Size = UDim2.new(1,0,0,120)}):Play()
            services.tween:Create(Arrow, TweenInfo.new(0.2), {Rotation = 180}):Play()
        else
            services.tween:Create(Content, TweenInfo.new(0.2), {Size = UDim2.new(1,0,0,0)}):Play()
            services.tween:Create(Arrow, TweenInfo.new(0.2), {Rotation = 0}):Play()
            task.delay(0.2, function() Content.Visible = false end)
        end
    end
    MainBtn.MouseButton1Click:Connect(toggle)

    multicombobox.add = function(name)
        local btn = Instance.new("TextButton")
        btn.Name = name
        btn.Parent = Content
        btn.BackgroundColor3 = themes[theme]["ElementBg"]
        btn.BorderColor3 = themes[theme]["ElementOutline"]
        btn.Size = UDim2.new(1,-10,0,22)
        btn.Text = name
        btn.TextColor3 = themes[theme]["Text"]
        btn.AutoButtonColor = false
        btn.MouseButton1Click:Connect(function()
            multicombobox.selected[name] = not multicombobox.selected[name]
            btn.BorderColor3 = multicombobox.selected[name] and themes[theme]["DropdownSelected"] or themes[theme]["ElementOutline"]
            update_text()
            callback(multicombobox.selected)
        end)
        if multicombobox.selected[name] then btn.BorderColor3 = themes[theme]["DropdownSelected"] end
        Content.CanvasSize = Content.CanvasSize + UDim2.new(0,0,0,26)
    end

    for _, opt in pairs(options) do multicombobox.add(opt) end
    update_text()
    sector.increase_scrollbar_size()
    return multicombobox
end

sector.toggle = function(text,default,callback)
local toggle = {}
local value = default
local Container = Instance.new("Frame")
local Text = Instance.new("TextLabel")
local Bg = Instance.new("TextButton")
Container.Parent = SectorContent
Container.BackgroundTransparency = 1
Container.Size = UDim2.new(0,249,0,22)
Text.Parent = Container
Text.BackgroundTransparency = 1
Text.Position = UDim2.new(0,0,0,-6)
Text.Size = UDim2.new(0,200,0,16)
Text.Font = Enum.Font.SourceSans
Text.Text = text
Text.TextColor3 = themes[theme]["Text"]
Text.TextSize = 14
Text.TextXAlignment = Enum.TextXAlignment.Left
Bg.Parent = Container
Bg.BackgroundColor3 = value and themes[theme]["Toggle"] or themes[theme]["ToggleUnchecked"]
Bg.BorderColor3 = themes[theme]["ElementOutline"]
Bg.Position = UDim2.new(0,5,0.5,-6)
Bg.Size = UDim2.new(0,12,0,12)
Bg.AutoButtonColor = false
Bg.MouseButton1Click:Connect(function()
    value = not value
    services.tween:Create(Bg, TweenInfo.new(0.2), {BackgroundColor3 = value and themes[theme]["Toggle"] or themes[theme]["ToggleUnchecked"]}):Play()
    callback(value)
end)
toggle.set = function(v)
    value = v
    services.tween:Create(Bg, TweenInfo.new(0.2), {BackgroundColor3 = v and themes[theme]["Toggle"] or themes[theme]["ToggleUnchecked"]}):Play()
    callback(v)
end
toggle.get = function() return value end
sector.increase_scrollbar_size()
return toggle
end

sector.slider = function(text, indicator, min, max, default, callback)
local slider = {}
local dragging = false
local value = default
local Container = Instance.new("Frame")
local Label = Instance.new("TextLabel")
local SliderBg = Instance.new("TextButton")
local Fill = Instance.new("Frame")
local ValueLabel = Instance.new("TextLabel")

Container.Parent = SectorContent
Container.BackgroundTransparency = 1
Container.Size = UDim2.new(0,249,0,36)

Label.Parent = Container
Label.BackgroundTransparency = 1
Label.Position = UDim2.new(0,0,0,-8)
Label.Size = UDim2.new(0,200,0,16)
Label.Font = Enum.Font.SourceSans
Label.Text = text
Label.TextColor3 = themes[theme]["Text"]
Label.TextSize = 14
Label.TextXAlignment = Enum.TextXAlignment.Left

SliderBg.Parent = Container
SliderBg.BackgroundColor3 = themes[theme]["SliderBg"]
SliderBg.BorderColor3 = themes[theme]["ElementOutline"]
SliderBg.Position = UDim2.new(0,0,0,12)
SliderBg.Size = UDim2.new(0,249,0,8)
SliderBg.AutoButtonColor = false

Fill.Parent = SliderBg
Fill.BackgroundColor3 = themes[theme]["Slider"]
Fill.BorderSizePixel = 0
Fill.Size = UDim2.new((default-min)/(max-min),0,1,0)

ValueLabel.Parent = SliderBg
ValueLabel.BackgroundTransparency = 1
ValueLabel.Position = UDim2.new(1,-45,0,-2)
ValueLabel.Size = UDim2.new(0,40,0,12)
ValueLabel.Font = Enum.Font.SourceSans
ValueLabel.TextColor3 = themes[theme]["Text"]
ValueLabel.TextSize = 11
ValueLabel.TextXAlignment = Enum.TextXAlignment.Right
ValueLabel.Text = tostring(math.round(default*100)/100)..indicator

local function update(val)
    value = val
    local perc = (val - min) / (max - min)
    services.tween:Create(Fill, TweenInfo.new(0.1), {Size = UDim2.new(perc,0,1,0)}):Play()
    ValueLabel.Position = UDim2.new(perc, -20, 0, -2)
    ValueLabel.Text = tostring(math.round(val*100)/100)..indicator
    callback(val)
end

SliderBg.InputBegan:Connect(function(i) if i.UserInputType == Enum.UserInputType.MouseButton1 then dragging = true end end)
SliderBg.InputEnded:Connect(function(i) if i.UserInputType == Enum.UserInputType.MouseButton1 then dragging = false end end)
services.uis.InputChanged:Connect(function(i)
    if dragging and (i.UserInputType == Enum.UserInputType.MouseMovement or i.UserInputType == Enum.UserInputType.Touch) then
        local mouse = services.uis:GetMouseLocation()
        local rel = math.clamp((mouse.X - SliderBg.AbsolutePosition.X) / SliderBg.AbsoluteSize.X, 0, 1)
        update(min + (max - min) * rel)
    end
end)

update(default)
sector.increase_scrollbar_size()
return slider
end

table.insert(window.tab_contents,{Tab.Name,Sector})
return sector
end
return tab
end
return window
end
return lib
