local lib = {}
local themes = {
["gamesense"] = {
["Window"] = Color3.fromRGB(8, 8, 8),
["Tabs"] = Color3.fromRGB(6, 6, 6),
["Gradient"] = ColorSequence.new{ColorSequenceKeypoint.new(0.00, Color3.fromRGB(61, 130, 162)), ColorSequenceKeypoint.new(0.50, Color3.fromRGB(156, 59, 145)), ColorSequenceKeypoint.new(1.00, Color3.fromRGB(155, 161, 48))},
["Sector"] = Color3.fromRGB(15, 15, 15),
["Text"] = Color3.fromRGB(180, 180, 180),
["TabSelected"] = Color3.fromRGB(10, 10, 10),
["ElementBg"] = Color3.fromRGB(20, 20, 20),
["ElementOutline"] = Color3.fromRGB(35,35,35),
["DropdownSelected"] = Color3.fromRGB(135, 176, 27),
["Toggle"] = Color3.fromRGB(135, 176, 27),
["ToggleUnchecked"] = Color3.fromRGB(25,25,25),
["Slider"] = Color3.fromRGB(135, 176, 27),
["SliderBg"] = Color3.fromRGB(20, 20, 20),
["ButtonHover"] = Color3.fromRGB(30, 30, 30),
["ButtonPressed"] = Color3.fromRGB(35, 35, 35)
},
["dark"] = {
["Window"] = Color3.fromRGB(10,10,10),
["Tabs"] = Color3.fromRGB(8,8,8),
["Gradient"] = ColorSequence.new{ColorSequenceKeypoint.new(0,Color3.fromRGB(30,30,30)),ColorSequenceKeypoint.new(1,Color3.fromRGB(60,60,60))},
["Sector"] = Color3.fromRGB(18,18,18),
["Text"] = Color3.fromRGB(220,220,220),
["TabSelected"] = Color3.fromRGB(15,15,15),
["ElementBg"] = Color3.fromRGB(25,25,25),
["ElementOutline"] = Color3.fromRGB(40,40,40),
["DropdownSelected"] = Color3.fromRGB(80,180,255),
["Toggle"] = Color3.fromRGB(80,180,255),
["ToggleUnchecked"] = Color3.fromRGB(30,30,30),
["Slider"] = Color3.fromRGB(80,180,255),
["SliderBg"] = Color3.fromRGB(25,25,25),
["ButtonHover"] = Color3.fromRGB(35,35,35),
["ButtonPressed"] = Color3.fromRGB(45,45,45)
},
["light"] = {
["Window"] = Color3.fromRGB(240,240,240),
["Tabs"] = Color3.fromRGB(220,220,220),
["Gradient"] = ColorSequence.new{ColorSequenceKeypoint.new(0,Color3.fromRGB(100,180,255)),ColorSequenceKeypoint.new(1,Color3.fromRGB(255,100,180))},
["Sector"] = Color3.fromRGB(230,230,230),
["Text"] = Color3.fromRGB(40,40,40),
["TabSelected"] = Color3.fromRGB(210,210,210),
["ElementBg"] = Color3.fromRGB(245,245,245),
["ElementOutline"] = Color3.fromRGB(200,200,200),
["DropdownSelected"] = Color3.fromRGB(0,120,215),
["Toggle"] = Color3.fromRGB(0,120,215),
["ToggleUnchecked"] = Color3.fromRGB(220,220,220),
["Slider"] = Color3.fromRGB(0,120,215),
["SliderBg"] = Color3.fromRGB(240,240,240),
["ButtonHover"] = Color3.fromRGB(230,230,230),
["ButtonPressed"] = Color3.fromRGB(210,210,210)
},
["purple"] = {
["Window"] = Color3.fromRGB(15,10,20),
["Tabs"] = Color3.fromRGB(12,8,16),
["Gradient"] = ColorSequence.new{ColorSequenceKeypoint.new(0,Color3.fromRGB(130,60,180)),ColorSequenceKeypoint.new(1,Color3.fromRGB(200,80,255))},
["Sector"] = Color3.fromRGB(22,18,28),
["Text"] = Color3.fromRGB(220,200,255),
["TabSelected"] = Color3.fromRGB(30,20,40),
["ElementBg"] = Color3.fromRGB(35,25,50),
["ElementOutline"] = Color3.fromRGB(60,40,80),
["DropdownSelected"] = Color3.fromRGB(180,80,255),
["Toggle"] = Color3.fromRGB(180,80,255),
["ToggleUnchecked"] = Color3.fromRGB(40,30,55),
["Slider"] = Color3.fromRGB(180,80,255),
["SliderBg"] = Color3.fromRGB(35,25,50),
["ButtonHover"] = Color3.fromRGB(50,35,70),
["ButtonPressed"] = Color3.fromRGB(70,50,90)
},
["ocean"] = {
["Window"] = Color3.fromRGB(5,15,25),
["Tabs"] = Color3.fromRGB(3,12,22),
["Gradient"] = ColorSequence.new{ColorSequenceKeypoint.new(0,Color3.fromRGB(0,150,200)),ColorSequenceKeypoint.new(1,Color3.fromRGB(0,220,255))},
["Sector"] = Color3.fromRGB(10,25,40),
["Text"] = Color3.fromRGB(180,240,255),
["TabSelected"] = Color3.fromRGB(15,35,55),
["ElementBg"] = Color3.fromRGB(20,40,60),
["ElementOutline"] = Color3.fromRGB(40,70,100),
["DropdownSelected"] = Color3.fromRGB(0,200,255),
["Toggle"] = Color3.fromRGB(0,200,255),
["ToggleUnchecked"] = Color3.fromRGB(25,45,65),
["Slider"] = Color3.fromRGB(0,200,255),
["SliderBg"] = Color3.fromRGB(20,40,60),
["ButtonHover"] = Color3.fromRGB(30,60,90),
["ButtonPressed"] = Color3.fromRGB(40,80,110)
},
["blood"] = {
["Window"] = Color3.fromRGB(20,5,5),
["Tabs"] = Color3.fromRGB(18,3,3),
["Gradient"] = ColorSequence.new{ColorSequenceKeypoint.new(0,Color3.fromRGB(180,20,20)),ColorSequenceKeypoint.new(1,Color3.fromRGB(255,60,60))},
["Sector"] = Color3.fromRGB(30,10,10),
["Text"] = Color3.fromRGB(255,180,180),
["TabSelected"] = Color3.fromRGB(40,15,15),
["ElementBg"] = Color3.fromRGB(45,15,15),
["ElementOutline"] = Color3.fromRGB(80,30,30),
["DropdownSelected"] = Color3.fromRGB(255,80,80),
["Toggle"] = Color3.fromRGB(255,80,80),
["ToggleUnchecked"] = Color3.fromRGB(50,20,20),
["Slider"] = Color3.fromRGB(255,80,80),
["SliderBg"] = Color3.fromRGB(45,15,15),
["ButtonHover"] = Color3.fromRGB(70,25,25),
["ButtonPressed"] = Color3.fromRGB(90,35,35)
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
Main.BorderColor3 = Color3.fromRGB(40, 40, 40)
Main.BorderSizePixel = 3
Main.Position = UDim2.new(0.38166827, 0, 0.249408439, 0)
Main.Size = UDim2.new(0, 684, 0, 605)
Tabs.Name = "Tabs"
Tabs.Parent = Main
Tabs.BackgroundColor3 = themes[theme]["Tabs"]
Tabs.BorderColor3 = Color3.fromRGB(18, 18, 18)
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
TopGradient.Size = UDim2.new(0, 684, 0, 2)
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
Sector.Position = UDim2.new(0,0,0,0)
Sector.Size = UDim2.new(0.5, -5, 1, 0)
Sector.Visible = false
Sector.ClipsDescendants = false
if tab.sectorCount == 2 then
Sector.Position = UDim2.new(0.5, 5, 0, 0)
end
Title.Name = "Title"
Title.Parent = Sector
Title.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
Title.BackgroundTransparency = 1.000
Title.BorderColor3 = Color3.fromRGB(0, 0, 0)
Title.BorderSizePixel = 0
Title.Position = UDim2.new(0.03, 0, 0, 0)
Title.Size = UDim2.new(0, 268, 0, 20)
Title.Font = Enum.Font.SourceSans
Title.TextColor3 = themes[theme]["Text"]
Title.TextSize = 18.000
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
SectorContent.Position = UDim2.new(0, 0, 0, 25)
SectorContent.Size = UDim2.new(1, 0, 1, -25)
SectorContent.CanvasSize = UDim2.new(0, 0, 0, 0)
SectorContent.ScrollBarThickness = 3
SectorContent.ClipsDescendants = true
UIListLayout.Parent = SectorContent
UIListLayout.SortOrder = Enum.SortOrder.LayoutOrder
UIListLayout.Padding = UDim.new(0, 6)
UIPadding.Parent = SectorContent
UIPadding.PaddingLeft = UDim.new(0, 8)
UIPadding.PaddingTop = UDim.new(0, 6)
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
totalHeight = totalHeight + element.AbsoluteSize.Y + 6
end
end
SectorContent.CanvasSize = UDim2.new(0, 0, 0, totalHeight + 10)
end
sector.text = function(_text)
local text = {}
local Text = Instance.new("TextLabel")
Text.Name = _text
Text.Parent = SectorContent
Text.BackgroundTransparency = 1
Text.Size = UDim2.new(1, -16, 0, 16)
Text.Font = Enum.Font.SourceSans
Text.Text = _text
Text.TextColor3 = themes[theme]["Text"]
Text.TextSize = 14
Text.TextStrokeTransparency = 0.8
Text.TextXAlignment = Enum.TextXAlignment.Left
text.delete = function() Text:Destroy() end
text.set = function(t) Text.Text = t end
sector.increase_scrollbar_size()
return text
end
sector.warning = function(_text)
local text = {}
local Text = Instance.new("TextLabel")
Text.Name = _text
Text.Parent = SectorContent
Text.BackgroundTransparency = 1
Text.Size = UDim2.new(1, -16, 0, 16)
Text.Font = Enum.Font.SourceSans
Text.Text = _text
Text.TextColor3 = Color3.fromRGB(142, 127, 74)
Text.TextSize = 14
Text.TextStrokeTransparency = 0.8
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
Text.BackgroundTransparency = 1
Text.Size = UDim2.new(1, -16, 0, 16)
Text.Font = Enum.Font.SourceSans
Text.Text = _text
Text.TextColor3 = Color3.fromRGB(142, 74, 65)
Text.TextSize = 14
Text.TextStrokeTransparency = 0.8
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
Text.BackgroundTransparency = 1
Text.Size = UDim2.new(1, -16, 0, 16)
Text.Font = Enum.Font.SourceSans
Text.Text = _text
Text.TextColor3 = Color3.fromRGB(63, 110, 152)
Text.TextSize = 14
Text.TextStrokeTransparency = 0.8
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
TextBox.Size = UDim2.new(1, -16, 0, 24)
TextBox.ClearTextOnFocus = false
TextBox.Font = Enum.Font.SourceSans
TextBox.PlaceholderColor3 = Color3.fromRGB(65, 65, 65)
TextBox.PlaceholderText = placeholder
TextBox.Text = default or ""
TextBox.TextColor3 = themes[theme]["Text"]
TextBox.TextSize = 14
TextBox.TextStrokeTransparency = 0.8
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
callback(default or "")
sector.increase_scrollbar_size()
return textbox
end
sector.button = function(text,callback)
local button = {}
local Button = Instance.new("TextButton")
Button.Parent = SectorContent
Button.BackgroundColor3 = themes[theme]["ElementBg"]
Button.BorderColor3 = themes[theme]["ElementOutline"]
Button.Size = UDim2.new(1, -16, 0, 24)
Button.AutoButtonColor = false
Button.Font = Enum.Font.SourceSans
Button.TextColor3 = themes[theme]["Text"]
Button.TextSize = 14
Button.Text = text
local tweenInfo = TweenInfo.new(0.2, Enum.EasingStyle.Quad, Enum.EasingDirection.Out)
Button.MouseEnter:Connect(function()
services.tween:Create(Button, tweenInfo, {BackgroundColor3 = themes[theme]["ButtonHover"]}):Play()
end)
Button.MouseLeave:Connect(function()
services.tween:Create(Button, tweenInfo, {BackgroundColor3 = themes[theme]["ElementBg"]}):Play()
end)
Button.MouseButton1Down:Connect(function()
services.tween:Create(Button, TweenInfo.new(0.1), {BackgroundColor3 = themes[theme]["ButtonPressed"]}):Play()
callback()
end)
Button.MouseButton1Up:Connect(function()
services.tween:Create(Button, tweenInfo, {BackgroundColor3 = themes[theme]["ButtonHover"]}):Play()
end)
sector.increase_scrollbar_size()
button.delete = function() Button:Destroy() end
button.set = function(t) Button.Text = t end
return button
end
sector.dropdown = function(text, options, default, callback)
local dropdown = {}
dropdown.selected = default or options[1]
local Dropdown = Instance.new("TextButton")
local UIPadding = Instance.new("UIPadding")
local Image = Instance.new("ImageLabel")
local DropdownContent = Instance.new("ScrollingFrame")
local UIPadding_2 = Instance.new("UIPadding")
local UIListLayout = Instance.new("UIListLayout")
Dropdown.Parent = SectorContent
Dropdown.BackgroundColor3 = themes[theme]["ElementBg"]
Dropdown.BorderColor3 = themes[theme]["ElementOutline"]
Dropdown.Size = UDim2.new(1, -16, 0, 24)
Dropdown.AutoButtonColor = false
Dropdown.Font = Enum.Font.SourceSans
Dropdown.Text = text
Dropdown.TextColor3 = themes[theme]["Text"]
Dropdown.TextSize = 14
Dropdown.TextXAlignment = Enum.TextXAlignment.Left
Dropdown.ZIndex = 100
UIPadding.Parent = Dropdown
UIPadding.PaddingLeft = UDim.new(0, 30)
Image.Name = "Image"
Image.Parent = Dropdown
Image.BackgroundTransparency = 1
Image.Position = UDim2.new(0, 5, 0.5, -7)
Image.Size = UDim2.new(0, 14, 0, 14)
Image.Image = "rbxassetid://74187648454886"
Image.ImageColor3 = Color3.fromRGB(115, 115, 115)
Image.ZIndex = 101
DropdownContent.Parent = Dropdown
DropdownContent.BackgroundColor3 = themes[theme]["ElementBg"]
DropdownContent.BorderColor3 = themes[theme]["ElementOutline"]
DropdownContent.Position = UDim2.new(0, 0, 1, 2)
DropdownContent.Size = UDim2.new(1, 0, 0, 0)
DropdownContent.CanvasSize = UDim2.new(0, 0, 0, 0)
DropdownContent.ScrollBarThickness = 3
DropdownContent.Visible = false
DropdownContent.ZIndex = 102
DropdownContent.ClipsDescendants = true
UIPadding_2.Parent = DropdownContent
UIPadding_2.PaddingLeft = UDim.new(0, 5)
UIPadding_2.PaddingTop = UDim.new(0, 5)
UIListLayout.Parent = DropdownContent
UIListLayout.SortOrder = Enum.SortOrder.LayoutOrder
UIListLayout.Padding = UDim.new(0, 3)
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
local function toggle()
isOpen = not isOpen
if isOpen then
DropdownContent.Visible = true
services.tween:Create(Image, tweenInfo, {Rotation = 180}):Play()
services.tween:Create(DropdownContent, tweenInfo, {Size = UDim2.new(1, 0, 0, math.min(#options*27, 120))}):Play()
else
services.tween:Create(Image, tweenInfo, {Rotation = 0}):Play()
services.tween:Create(DropdownContent, tweenInfo, {Size = UDim2.new(1, 0, 0, 0)}):Play()
task.wait(0.2)
DropdownContent.Visible = false
end
end
Dropdown.MouseButton1Down:Connect(toggle)
dropdown.set = function(val, skip)
dropdown.selected = val
Dropdown.Text = val
for _,v in DropdownContent:GetChildren() do
if v:IsA("TextButton") then
v.BorderColor3 = v.Name == val and themes[theme]["DropdownSelected"] or themes[theme]["ElementOutline"]
end
end
if not skip then callback(val) toggle() end
end
dropdown.add = function(name)
local btn = Instance.new("TextButton")
btn.Name = name
btn.Parent = DropdownContent
btn.BackgroundColor3 = themes[theme]["ElementBg"]
btn.BorderColor3 = themes[theme]["ElementOutline"]
btn.Size = UDim2.new(1, -10, 0, 24)
btn.Text = name
btn.TextColor3 = themes[theme]["Text"]
btn.TextSize = 14
btn.AutoButtonColor = false
btn.ZIndex = 103
btn.MouseEnter:Connect(function()
services.tween:Create(btn, tweenInfo, {BackgroundColor3 = themes[theme]["ButtonHover"]}):Play()
end)
btn.MouseLeave:Connect(function()
if btn.BorderColor3 ~= themes[theme]["DropdownSelected"] then
services.tween:Create(btn, tweenInfo, {BackgroundColor3 = themes[theme]["ElementBg"]}):Play()
end
end)
btn.MouseButton1Down:Connect(function()
dropdown.set(name)
end)
DropdownContent.CanvasSize = DropdownContent.CanvasSize + UDim2.new(0,0,0,27)
end
for _,opt in options do dropdown.add(opt) end
dropdown.set(default or options[1], true)
sector.increase_scrollbar_size()
return dropdown
end
sector.multicombobox = function(text, options, defaults, callback)
local multicombobox = {}
multicombobox.selected = {}
for _,opt in options do multicombobox.selected[opt] = false end
if type(defaults)=="table" then for _,v in defaults do if multicombobox.selected[v]~=nil then multicombobox.selected[v]=true end end end
local Multi = Instance.new("TextButton")
local UIPadding = Instance.new("UIPadding")
local Image = Instance.new("ImageLabel")
local Content = Instance.new("ScrollingFrame")
local UIList = Instance.new("UIListLayout")
local Pad = Instance.new("UIPadding")
Multi.Parent = SectorContent
Multi.BackgroundColor3 = themes[theme]["ElementBg"]
Multi.BorderColor3 = themes[theme]["ElementOutline"]
Multi.Size = UDim2.new(1, -16, 0, 24)
Multi.Text = text
Multi.TextColor3 = themes[theme]["Text"]
Multi.TextSize = 14
Multi.TextXAlignment = Enum.TextXAlignment.Left
Multi.AutoButtonColor = false
UIPadding.Parent = Multi
UIPadding.PaddingLeft = UDim.new(0,30)
Image.Parent = Multi
Image.BackgroundTransparency = 1
Image.Position = UDim2.new(0,5,0.5,-7)
Image.Size = UDim2.new(0,14,0,14)
Image.Image = "rbxassetid://74187648454886"
Image.ImageColor3 = Color3.fromRGB(115,115,115)
Content.Parent = Multi
Content.BackgroundColor3 = themes[theme]["ElementBg"]
Content.BorderColor3 = themes[theme]["ElementOutline"]
Content.Position = UDim2.new(0,0,1,2)
Content.Size = UDim2.new(1,0,0,0)
Content.CanvasSize = UDim2.new(0,0,0,0)
Content.ScrollBarThickness = 3
Content.Visible = false
Content.ClipsDescendants = true
Pad.Parent = Content
Pad.PaddingLeft = UDim.new(0,5)
Pad.PaddingTop = UDim.new(0,5)
UIList.Parent = Content
UIList.Padding = UDim.new(0,3)
local open = false
local function toggle()
open = not open
if open then
Content.Visible = true
services.tween:Create(Image,tweenInfo,{Rotation=180}):Play()
services.tween:Create(Content,tweenInfo,{Size=UDim2.new(1,0,0,math.min(#options*27,120))}):Play()
else
services.tween:Create(Image,tweenInfo,{Rotation=0}):Play()
services.tween:Create(Content,tweenInfo,{Size=UDim2.new(1,0,0,0)}):Play()
task.wait(0.2)
Content.Visible = false
end
end
Multi.MouseButton1Down:Connect(toggle)
local function update_text()
local sel = {}
for k,v in multicombobox.selected do if v then table.insert(sel,k) end end
if #sel==0 then Multi.Text = text
elseif #sel==1 then Multi.Text = sel[1]
else Multi.Text = text.." ("..#sel..")" end
end
multicombobox.toggle = function(name)
if multicombobox.selected[name]~=nil then
multicombobox.selected[name] = not multicombobox.selected[name]
local btn = Content:FindFirstChild(name)
if btn then
btn.BorderColor3 = multicombobox.selected[name] and themes[theme]["DropdownSelected"] or themes[theme]["ElementOutline"]
btn.BackgroundColor3 = multicombobox.selected[name] and themes[theme]["ButtonHover"] or themes[theme]["ElementBg"]
end
update_text()
callback(multicombobox.selected)
end
end
for _,opt in options do
local btn = Instance.new("TextButton")
btn.Name = opt
btn.Parent = Content
btn.BackgroundColor3 = themes[theme]["ElementBg"]
btn.BorderColor3 = multicombobox.selected[opt] and themes[theme]["DropdownSelected"] or themes[theme]["ElementOutline"]
btn.Size = UDim2.new(1,-10,0,24)
btn.Text = opt
btn.TextColor3 = themes[theme]["Text"]
btn.TextSize = 14
btn.AutoButtonColor = false
btn.MouseButton1Down:Connect(function() multicombobox.toggle(opt) end)
Content.CanvasSize = Content.CanvasSize + UDim2.new(0,0,0,27)
end
update_text()
sector.increase_scrollbar_size()
return multicombobox
end
sector.toggle = function(text,default,callback)
local toggle = {}
local val = default or false
local Toggle = Instance.new("TextButton")
local Label = Instance.new("TextLabel")
local Check = Instance.new("Frame")
Toggle.Parent = SectorContent
Toggle.BackgroundTransparency = 1
Toggle.Size = UDim2.new(1,-16,0,24)
Toggle.Text = ""
Label.Parent = Toggle
Label.BackgroundTransparency = 1
Label.Size = UDim2.new(1,-40,1,0)
Label.Position = UDim2.new(0,30,0,0)
Label.Text = text
Label.TextColor3 = themes[theme]["Text"]
Label.TextSize = 14
Label.TextXAlignment = Enum.TextXAlignment.Left
Check.Parent = Toggle
Check.BackgroundColor3 = val and themes[theme]["Toggle"] or themes[theme]["ToggleUnchecked"]
Check.BorderColor3 = themes[theme]["ElementOutline"]
Check.Position = UDim2.new(0,5,0.5,-6)
Check.Size = UDim2.new(0,12,0,12)
local tweenInfo = TweenInfo.new(0.2)
Toggle.MouseButton1Down:Connect(function()
val = not val
services.tween:Create(Check,tweenInfo,{BackgroundColor3=val and themes[theme]["Toggle"] or themes[theme]["ToggleUnchecked"]}):Play()
callback(val)
end)
toggle.set = function(v)
val = v
services.tween:Create(Check,tweenInfo,{BackgroundColor3=v and themes[theme]["Toggle"] or themes[theme]["ToggleUnchecked"]}):Play()
callback(v)
end
toggle.get = function() return val end
sector.increase_scrollbar_size()
return toggle
end
sector.slider = function(text, min, max, default, callback, indicator)
indicator = indicator or ""
local slider = {}
local val = default or min
local Slider = Instance.new("Frame")
local Label = Instance.new("TextLabel")
local Bar = Instance.new("Frame")
local Fill = Instance.new("Frame")
local ValLabel = Instance.new("TextLabel")
Slider.Parent = SectorContent
Slider.BackgroundTransparency = 1
Slider.Size = UDim2.new(1,-16,0,30)
Label.Parent = Slider
Label.BackgroundTransparency = 1
Label.Size = UDim2.new(1,0,0,15)
Label.Text = text
Label.TextColor3 = themes[theme]["Text"]
Label.TextSize = 14
Label.TextXAlignment = Enum.TextXAlignment.Left
Bar.Parent = Slider
Bar.BackgroundColor3 = themes[theme]["SliderBg"]
Bar.BorderColor3 = themes[theme]["ElementOutline"]
Bar.Position = UDim2.new(0,0,0,15)
Bar.Size = UDim2.new(1,0,0,8)
Fill.Parent = Bar
Fill.BackgroundColor3 = themes[theme]["Slider"]
Fill.BorderColor3 = themes[theme]["ElementOutline"]
Fill.Size = UDim2.new((val-min)/(max-min),0,1,0)
ValLabel.Parent = Bar
ValLabel.BackgroundTransparency = 1
ValLabel.Position = UDim2.new(1,-40,0,-2)
ValLabel.Size = UDim2.new(0,40,0,12)
ValLabel.TextColor3 = themes[theme]["Text"]
ValLabel.TextSize = 12
ValLabel.Text = tostring(math.round(val*100)/100)..indicator
local dragging = false
local function update(v)
val = v
Fill.Size = UDim2.new((v-min)/(max-min),0,1,0)
ValLabel.Text = tostring(math.round(v*100)/100)..indicator
callback(v)
end
Bar.InputBegan:Connect(function(i) if i.UserInputType==Enum.UserInputType.MouseButton1 then dragging=true end end)
Bar.InputEnded:Connect(function(i) if i.UserInputType==Enum.UserInputType.MouseButton1 then dragging=false end end)
Fill.InputBegan:Connect(function(i) if i.UserInputType==Enum.UserInputType.MouseButton1 then dragging=true end end)
Fill.InputEnded:Connect(function(i) if i.UserInputType==Enum.UserInputType.MouseButton1 then dragging=false end end)
services.run.RenderStepped:Connect(function()
if dragging then
local mouse = services.uis:GetMouseLocation()
local rel = math.clamp((mouse.X - Bar.AbsolutePosition.X)/Bar.AbsoluteSize.X,0,1)
update(min + rel*(max-min))
end
end)
update(val)
sector.increase_scrollbar_size()
return {set=function(v) update(math.clamp(v,min,max)) end,get=function()return val end}
end
table.insert(window.tab_contents,{Tab.Name,Sector})
return sector
end
return tab
end
return window
end
return lib
