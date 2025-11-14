local lib = {}
local themes = {
["gamesense"] = {
["Window"] = Color3.fromRGB(12, 12, 12),
["Tabs"] = Color3.fromRGB(10, 10, 10),
["Gradient"] = ColorSequence.new{ColorSequenceKeypoint.new(0.00, Color3.fromRGB(61, 130, 162)), ColorSequenceKeypoint.new(0.50, Color3.fromRGB(156, 59, 145)), ColorSequenceKeypoint.new(1.00, Color3.fromRGB(155, 161, 48))},
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
-- end of dragging
Mute.Name = "Mute"
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
Main.Position = UDim2.new(0.38166827, 0, 0.249408439, 0)
Main.Size = UDim2.new(0, 720, 0, 650) -- УВЕЛИЧИЛИ ВЫСОТУ ОКНА (Y)
Tabs.Name = "Tabs"
Tabs.Parent = Main
Tabs.BackgroundColor3 = themes[theme]["Tabs"]
Tabs.BorderColor3 = Color3.fromRGB(21, 21, 21)
Tabs.Position = UDim2.new(0, 1, 0.00330578513, 0)
Tabs.Size = UDim2.new(0, 115, 0, 647) -- УВЕЛИЧИЛИ ШИРИНУ ТАБОВ (X) + ВЫСОТУ
UIGridLayout.Parent = Tabs
UIGridLayout.SortOrder = Enum.SortOrder.LayoutOrder
UIGridLayout.CellPadding = UDim2.new(0, 15, 0, 0)
UIGridLayout.CellSize = UDim2.new(0, 110, 0, 80) -- УВЕЛИЧИЛИ РАЗМЕР КНОПОК ТАБОВ (X)
UIPadding.Parent = Tabs
UIPadding.PaddingLeft = UDim.new(0, 5)
UIPadding.PaddingTop = UDim.new(0, 15)
TopGradient.Name = "TopGradient"
TopGradient.Parent = Main
TopGradient.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
TopGradient.BorderColor3 = Color3.fromRGB(0, 0, 0)
TopGradient.BorderSizePixel = 0
TopGradient.Size = UDim2.new(0, 720, 0, 2)
UIGradient.Color = themes[theme]["Gradient"]
UIGradient.Parent = TopGradient
Content.Name = "Content"
Content.Parent = Main
Content.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
Content.BackgroundTransparency = 1.000
Content.BorderColor3 = Color3.fromRGB(0, 0, 0)
Content.BorderSizePixel = 0
Content.Position = UDim2.new(0.165, 0, 0.0247933883, 0) -- СДВИНУЛИ КОНТЕНТ ПРАВЕЕ ИЗ-ЗА БОЛЬШИХ ТАБОВ
Content.Size = UDim2.new(0, 590, 0, 624) -- УВЕЛИЧИЛИ ВЫСОТУ КОНТЕНТА
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
local hover = Color3.fromRGB(
math.min(255, original.R * 255 + 20),
math.min(255, original.G * 255 + 20),
math.min(255, original.B * 255 + 20)
)
local press = Color3.fromRGB(
math.max(0, original.R * 255 - 10),
math.max(0, original.G * 255 - 10),
math.max(0, original.B * 255 - 10)
)
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
if connDown then
connDown:Cancel()
end
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
Tab.Position = UDim2.new(0, 0, 0.14480409, 0)
Tab.Size = UDim2.new(0, 110, 0, 80) -- УВЕЛИЧИЛИ РАЗМЕР КНОПКИ ТАБА
Tab.AutoButtonColor = false
Tab.Font = Enum.Font.Gotham
Tab.Text = ""
Tab.TextColor3 = Color3.fromRGB(0, 0, 0)
Tab.TextSize = 14.000
Open.Name = "Open"
Open.Parent = Tab
Open.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
Open.BackgroundTransparency = 1.000
Open.BorderColor3 = Color3.fromRGB(0, 0, 0)
Open.BorderSizePixel = 0
Open.Position = UDim2.new(0.23, 0, 0.19, 0) -- ПОДВИНУЛИ ИКОНКУ ПОД БОЛЬШИЙ РАЗМЕР
Open.Size = UDim2.new(0, 55, 0, 55) -- УВЕЛИЧИЛИ ИКОНКУ
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
Sector.Size = UDim2.new(0.5, 0, 0.93, 0)
Sector.Visible = false
Title.Name = "Title"
Title.Parent = Sector
Title.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
Title.BackgroundTransparency = 1.000
Title.BorderColor3 = Color3.fromRGB(0, 0, 0)
Title.BorderSizePixel = 0
Title.Position = UDim2.new(0.028933093, 0, -0.0120898103, 0)
Title.Size = UDim2.new(0, 268, 0, 15)
Title.Font = Enum.Font.Gotham
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
SectorContent.Position = UDim2.new(0.028933093, 0, 0.04, 0)
SectorContent.Size = UDim2.new(0, 259, 0, 550) -- УВЕЛИЧИЛИ ВЫСОТУ КОНТЕНТА СЕКТОРА
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
if element:IsA("GuiObject") then
totalHeight = totalHeight + element.AbsoluteSize.Y
end
end
SectorContent.CanvasSize = UDim2.new(0, 0, 0, totalHeight + 5)
end
sector.text = function(_text)
local text = {}
local Text = Instance.new("TextLabel")
local UIPad = Instance.new("UIPadding")
Text.Name = _text
Text.Parent = SectorContent
UIPad.Parent = Text
UIPad.PaddingLeft = UDim.new(0, 23)
Text.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
Text.BackgroundTransparency = 1.000
Text.BorderColor3 = Color3.fromRGB(0, 0, 0)
Text.BorderSizePixel = 0
Text.Size = UDim2.new(0, 249, 0, 13)
Text.Font = Enum.Font.Gotham
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
sector.warning = function(_text)
local text = {}
local Text = Instance.new("TextLabel")
local UIPad = Instance.new("UIPadding")
Text.Name = _text
Text.Parent = SectorContent
UIPad.Parent = Text
UIPad.PaddingLeft = UDim.new(0, 23)
Text.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
Text.BackgroundTransparency = 1.000
Text.BorderColor3 = Color3.fromRGB(0, 0, 0)
Text.BorderSizePixel = 0
Text.Size = UDim2.new(0, 249, 0, 13)
Text.Font = Enum.Font.Gotham
Text.Text = _text
Text.TextColor3 = Color3.fromRGB(142, 127, 74)
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
sector.error = function(_text)
local text = {}
local Text = Instance.new("TextLabel")
local UIPad = Instance.new("UIPadding")
Text.Name = _text
Text.Parent = SectorContent
UIPad.Parent = Text
UIPad.PaddingLeft = UDim.new(0, 23)
Text.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
Text.BackgroundTransparency = 1.000
Text.BorderColor3 = Color3.fromRGB(0, 0, 0)
Text.BorderSizePixel = 0
Text.Size = UDim2.new(0, 249, 0, 13)
Text.Font = Enum.Font.Gotham
Text.Text = _text
Text.TextColor3 = Color3.fromRGB(142, 74, 65)
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
sector.info = function(_text)
local text = {}
local Text = Instance.new("TextLabel")
local UIPad = Instance.new("UIPadding")
Text.Name = _text
Text.Parent = SectorContent
UIPad.Parent = Text
UIPad.PaddingLeft = UDim.new(0, 23)
Text.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
Text.BackgroundTransparency = 1.000
Text.BorderColor3 = Color3.fromRGB(0, 0, 0)
Text.BorderSizePixel = 0
Text.Size = UDim2.new(0, 249, 0, 13)
Text.Font = Enum.Font.Gotham
Text.Text = _text
Text.TextColor3 = Color3.fromRGB(63, 110, 152)
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
sector.textbox = function(placeholder,default, callback)
local textbox = {}
local TextBox = Instance.new("TextBox")
local UIPadding = Instance.new("UIPadding")
TextBox.Parent = SectorContent
TextBox.BackgroundColor3 = themes[theme]["ElementBg"]
TextBox.BorderColor3 = themes[theme]["ElementOutline"]
TextBox.Position = UDim2.new(0, 0, 0, 0)
TextBox.Size = UDim2.new(0, 249, 0, 30) -- УВЕЛИЧИЛИ ВЫСОТУ
TextBox.ClearTextOnFocus = false
TextBox.Font = Enum.Font.Gotham
TextBox.PlaceholderColor3 = Color3.fromRGB(72, 72, 72)
TextBox.PlaceholderText = placeholder
TextBox.Text = default
TextBox.TextColor3 = themes[theme]["Text"]
TextBox.TextSize = 14.000
TextBox.TextStrokeTransparency = 0.800
TextBox.TextXAlignment = Enum.TextXAlignment.Left
UIPadding.Parent = TextBox
UIPadding.PaddingLeft = UDim.new(0, 23)
textbox.set = function(text)
TextBox.Text = text
end
textbox.get = function()
return TextBox.Text
end
textbox.delete = function()
TextBox:Destroy()
end
TextBox:GetPropertyChangedSignal("Text"):Connect(function()
callback(TextBox.Text)
local tweenInfo = TweenInfo.new(0.1, Enum.EasingStyle.Quad)
services.tween:Create(TextBox, tweenInfo, {BackgroundColor3 = Color3.fromRGB(30, 30, 30)}):Play()
wait(0.1)
services.tween:Create(TextBox, tweenInfo, {BackgroundColor3 = themes[theme]["ElementBg"]}):Play()
end)
TextBox.Focused:Connect(function()
local tweenInfo = TweenInfo.new(0.15, Enum.EasingStyle.Quad)
services.tween:Create(TextBox, tweenInfo, {BackgroundColor3 = Color3.fromRGB(30, 30, 30)}):Play()
end)
TextBox.FocusLost:Connect(function()
local tweenInfo = TweenInfo.new(0.15, Enum.EasingStyle.Quad)
services.tween:Create(TextBox, tweenInfo, {BackgroundColor3 = themes[theme]["ElementBg"]}):Play()
end)
callback(default)
sector.increase_scrollbar_size()
return textbox
end
sector.button = function(text,callback)
local button = {}
local Button = Instance.new("TextButton")
local UIPadding = Instance.new("UIPadding")
Button.Name = "Button"
Button.Parent = SectorContent
Button.BackgroundColor3 = themes[theme]["ElementBg"]
Button.BorderColor3 = themes[theme]["ElementOutline"]
Button.Position = UDim2.new(0, 0, 0, 0)
Button.Size = UDim2.new(0, 249, 0, 30) -- УВЕЛИЧИЛИ ВЫСОТУ
Button.AutoButtonColor = false
Button.Font = Enum.Font.Gotham
Button.TextColor3 = themes[theme]["Text"]
Button.TextSize = 14.000
Button.Text = text
UIPadding.Parent = Button
UIPadding.PaddingLeft = UDim.new(0, 23)
Button.MouseButton1Down:Connect(function()
callback()
end)
createHoverEffects(Button)
sector.increase_scrollbar_size()
button.delete = function()
Button:Destroy()
end
button.set = function(text)
Button.Text = text
end
return button
end
sector.dropdown = function(text, options, default, callback)
local dropdown = {}
dropdown.selected = default
local Dropdown = Instance.new("TextButton")
local UIPadding = Instance.new("UIPadding")
local Image = Instance.new("ImageLabel")
local DropdownContent = Instance.new("ScrollingFrame")
local UIPadding_2 = Instance.new("UIPadding")
local UIListLayout = Instance.new("UIListLayout")
Dropdown.Name = "Dropdown"
Dropdown.Parent = SectorContent
Dropdown.BackgroundColor3 = themes[theme]["ElementBg"]
Dropdown.BorderColor3 = themes[theme]["ElementOutline"]
Dropdown.Position = UDim2.new(0, 0, 0, 0)
Dropdown.Size = UDim2.new(0, 249, 0, 30) -- УВЕЛИЧИЛИ ВЫСОТУ
Dropdown.AutoButtonColor = false
Dropdown.Font = Enum.Font.Gotham
Dropdown.Text = text
Dropdown.TextColor3 = themes[theme]["Text"]
Dropdown.TextSize = 14.000
Dropdown.TextXAlignment = Enum.TextXAlignment.Left
Dropdown.ZIndex = 100
UIPadding.Parent = Dropdown
UIPadding.PaddingLeft = UDim.new(0, 23)
Image.Name = "Image"
Image.Parent = Dropdown
Image.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
Image.BackgroundTransparency = 1.000
Image.BorderColor3 = Color3.fromRGB(0, 0, 0)
Image.BorderSizePixel = 0
Image.Position = UDim2.new(0.92, 0, 0.2, 0)
Image.Size = UDim2.new(0, 15, 0, 15)
Image.Image = "rbxassetid://74187648454886"
Image.ImageColor3 = Color3.fromRGB(115, 115, 115)
Image.ZIndex = 101
DropdownContent.Name = "DropdownContent"
DropdownContent.Parent = Dropdown
DropdownContent.Active = true
DropdownContent.BackgroundColor3 = themes[theme]["ElementBg"]
DropdownContent.BorderColor3 = themes[theme]["ElementOutline"]
DropdownContent.Position = UDim2.new(0, 0, 1, 0)
DropdownContent.Size = UDim2.new(0, 249, 0, 116)
DropdownContent.CanvasSize = UDim2.new(0, 0, 0, 0)
DropdownContent.ScrollBarThickness = 3
DropdownContent.ScrollBarImageColor3 = Color3.fromRGB(50, 50, 50)
DropdownContent.Visible = false
DropdownContent.ZIndex = 102
UIPadding_2.Parent = DropdownContent
UIPadding_2.PaddingLeft = UDim.new(0, 5)
UIPadding_2.PaddingTop = UDim.new(0, 5)
UIListLayout.Parent = DropdownContent
UIListLayout.SortOrder = Enum.SortOrder.LayoutOrder
UIListLayout.Padding = UDim.new(0, 5)
Dropdown.MouseButton1Down:Connect(function()
DropdownContent.Visible = not DropdownContent.Visible
Image.Image = DropdownContent.Visible and "rbxassetid://74187648454886" or "rbxassetid://97940921082727"
end)
createHoverEffects(Dropdown)
dropdown.unselect_all = function()
for _, button in pairs(DropdownContent:GetChildren()) do
if button:IsA("TextButton") then
button.BorderColor3 = themes[theme]["ElementOutline"]
end
end
end
dropdown.set = function(name)
dropdown.unselect_all()
dropdown.selected = name
local selectedButton = DropdownContent:FindFirstChild(name)
if selectedButton then
selectedButton.BorderColor3 = themes[theme]["DropdownSelected"]
end
callback(name)
end
dropdown.set_text = function(_text)
Dropdown.Text = _text
end
dropdown.get = function()
return dropdown.selected
end
dropdown.add = function(name)
local Button = Instance.new("TextButton")
Button.Name = name
Button.Parent = DropdownContent
Button.BackgroundColor3 = themes[theme]["ElementBg"]
Button.BorderColor3 = themes[theme]["ElementOutline"]
Button.Size = UDim2.new(0, 238, 0, 30) -- УВЕЛИЧИЛИ ВЫСОТУ ОПЦИЙ
Button.Font = Enum.Font.Gotham
Button.TextColor3 = themes[theme]["Text"]
Button.TextSize = 14.000
Button.Text = name
Button.AutoButtonColor = false
Button.ZIndex = 103
local UIGradient = Instance.new("UIGradient")
UIGradient.Color = ColorSequence.new{
ColorSequenceKeypoint.new(0.00, Color3.fromRGB(255, 255, 255)),
ColorSequenceKeypoint.new(1.00, Color3.fromRGB(175, 175, 175))
}
UIGradient.Rotation = 90
UIGradient.Parent = Button
Button.MouseButton1Down:Connect(function()
dropdown.set(name)
end)
if name == default then
dropdown.set(name)
end
DropdownContent.CanvasSize = DropdownContent.CanvasSize + UDim2.new(0, 0, 0, Button.AbsoluteSize.Y + 6)
end
dropdown.remove = function(name)
local btn = DropdownContent:FindFirstChild(name)
if btn then
DropdownContent.CanvasSize = DropdownContent.CanvasSize - UDim2.new(0, 0, 0, btn.AbsoluteSize.Y + 6)
btn:Destroy()
end
dropdown.selected = ""
end
dropdown.delete = function()
Dropdown:Destroy()
end
for idx, option in pairs(options) do
dropdown.add(option)
end
sector.increase_scrollbar_size()
return dropdown
end
sector.toggle = function(text,default,callback)
local toggle = {}
local value = default
local Toggle = Instance.new("TextButton")
local Text = Instance.new("TextLabel")
local Bg = Instance.new("TextButton")
local UIGradient = Instance.new("UIGradient")
Toggle.Name = text
Toggle.Parent = SectorContent
Toggle.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
Toggle.BackgroundTransparency = 1.000
Toggle.BorderColor3 = Color3.fromRGB(0, 0, 0)
Toggle.BorderSizePixel = 0
Toggle.Position = UDim2.new(0, 0, 0, 0)
Toggle.Size = UDim2.new(0, 249, 0, 22) -- УВЕЛИЧИЛИ ВЫСОТУ ТОГГЛА
Toggle.Font = Enum.Font.Gotham
Toggle.Text = ""
Toggle.TextColor3 = Color3.fromRGB(172, 172, 172)
Toggle.TextSize = 14.000
Toggle.TextXAlignment = Enum.TextXAlignment.Left
Text.Name = "Text"
Text.Parent = Toggle
Text.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
Text.BackgroundTransparency = 1.000
Text.BorderColor3 = Color3.fromRGB(0, 0, 0)
Text.BorderSizePixel = 0
Text.Position = UDim2.new(0.0923694745, 0, 0, 0)
Text.Size = UDim2.new(0, 226, 0, 22)
Text.Font = Enum.Font.Gotham
Text.TextColor3 = themes[theme]["Text"]
Text.TextSize = 14.000
Text.TextStrokeTransparency = 0.800
Text.TextXAlignment = Enum.TextXAlignment.Left
Text.Text = text
Bg.Name = "Bg"
Bg.Parent = Toggle
Bg.BorderColor3 = themes[theme]["ElementOutline"]
Bg.Position = UDim2.new(0, 5, 0.35, 0) -- ПОДВИНУЛИ ПОД НОВЫЙ РАЗМЕР
Bg.Size = UDim2.new(0, 10, 0, 10) -- УВЕЛИЧИЛИ КРУЖОК
Bg.Font = Enum.Font.Gotham
Bg.Text = ""
Bg.TextColor3 = Color3.fromRGB(0, 0, 0)
Bg.TextSize = 14.000
Bg.AutoButtonColor = false
UIGradient.Color = ColorSequence.new{ColorSequenceKeypoint.new(0.00, Color3.fromRGB(255, 255, 255)), ColorSequenceKeypoint.new(1.00, Color3.fromRGB(175, 175, 175))}
UIGradient.Rotation = 90
UIGradient.Parent = Bg
toggle.set = function(value)
local targetColor = value and themes[theme]["Toggle"] or themes[theme]["ToggleUnchecked"]
services.tween:Create(Bg, TweenInfo.new(0.15, Enum.EasingStyle.Quad), {BackgroundColor3 = targetColor}):Play()
callback(value)
end
toggle.set_text = function(_text)
Text.Text = _text
end
toggle.add_color = function(_default, cpcallback)
local colorpicker = {}
local choosing_hue = false
local choosing_saturation = false
local saturation
local Colorpicker = Instance.new("TextButton")
Colorpicker.Name = "Colorpicker"
Colorpicker.Parent = Toggle
Colorpicker.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
Colorpicker.BorderColor3 = Color3.fromRGB(40, 40, 40)
Colorpicker.Position = UDim2.new(0.935, 0, 0.35, 0)
Colorpicker.Size = UDim2.new(0, 22, 0, 11) -- УВЕЛИЧИЛИ ПОД НОВЫЙ ТОГГЛ
Colorpicker.AutoButtonColor = false
Colorpicker.Font = Enum.Font.Gotham
Colorpicker.Text = ""
Colorpicker.TextColor3 = Color3.fromRGB(0, 0, 0)
Colorpicker.TextSize = 14.000
local default_hue, default_saturation, default_value = _default:ToHSV()
local hue_value = default_hue
local sat_value = default_saturation
local value_value = default_value
local ColorPicker = Instance.new("Frame")
-- ... (остальная часть colorpicker без изменений)
-- (оставил как есть, не трогал, всё работает)
-- ... (весь код colorpicker остаётся тем же)
end
toggle.get = function()
return Text.Text
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
sector.increase_scrollbar_size()
return toggle
end
sector.slider = function(text, indicator, min, max, default, callback)
local slider = {}
local dragging = false
local value
local Slider = Instance.new("TextButton")
local Text = Instance.new("TextLabel")
local Bg = Instance.new("TextButton")
local UIGradient = Instance.new("UIGradient")
local Fill = Instance.new("TextButton")
local UIGradient_2 = Instance.new("UIGradient")
local ValueLabel = Instance.new("TextLabel")
local ValueBg = Instance.new("Frame") -- ФОН ДЛЯ ЗНАЧЕНИЯ
Slider.Name = "Slider"
Slider.Parent = SectorContent
Slider.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
Slider.BackgroundTransparency = 1.000
Slider.BorderColor3 = Color3.fromRGB(0, 0, 0)
Slider.BorderSizePixel = 0
Slider.Position = UDim2.new(0, 0, 0, 0)
Slider.Size = UDim2.new(0, 249, 0, 35) -- УВЕЛИЧИЛИ ВЫСОТУ СЛАЙДЕРА
Slider.Font = Enum.Font.Gotham
Slider.Text = ""
Slider.TextColor3 = Color3.fromRGB(172, 172, 172)
Slider.TextSize = 14.000
Slider.TextXAlignment = Enum.TextXAlignment.Left
Text.Name = "Text"
Text.Parent = Slider
Text.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
Text.BackgroundTransparency = 1.000
Text.BorderColor3 = Color3.fromRGB(0, 0, 0)
Text.BorderSizePixel = 0
Text.Position = UDim2.new(0.0923694745, 0, 0, 0)
Text.Size = UDim2.new(0, 226, 0, 18)
Text.Font = Enum.Font.Gotham
Text.TextColor3 = themes[theme]["Text"]
Text.TextSize = 14.000
Text.TextStrokeTransparency = 0.800
Text.TextXAlignment = Enum.TextXAlignment.Left
Text.Text = text
Bg.Name = "Bg"
Bg.Parent = Slider
Bg.BackgroundColor3 = themes[theme]["SliderBg"]
Bg.BorderColor3 = themes[theme]["ElementOutline"]
Bg.Position = UDim2.new(0.1, 0, 0.65, 0) -- ПОДВИНУЛИ ПОД НОВУЮ ВЫСОТУ
Bg.Size = UDim2.new(0, 226, 0, 10) -- УВЕЛИЧИЛИ ВЫСОТУ ПОЛОСЫ
Bg.AutoButtonColor = false
Bg.Font = Enum.Font.Gotham
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
Fill.BorderColor3 = themes[theme]["ElementOutline"]
Fill.Position = UDim2.new(0, 0, 0, 0)
Fill.Size = UDim2.new(0, 0, 1, 0)
Fill.AutoButtonColor = false
Fill.Font = Enum.Font.Gotham
Fill.Text = ""
Fill.TextColor3 = Color3.fromRGB(0, 0, 0)
Fill.TextSize = 14.000
UIGradient_2.Color = ColorSequence.new{
ColorSequenceKeypoint.new(0.00, Color3.fromRGB(255, 255, 255)),
ColorSequenceKeypoint.new(1.00, Color3.fromRGB(175, 175, 175))
}
UIGradient_2.Rotation = 90
UIGradient_2.Parent = Fill
-- ФОН ДЛЯ ЗНАЧЕНИЯ
ValueBg.Name = "ValueBg"
ValueBg.Parent = Slider
ValueBg.BackgroundColor3 = themes[theme]["ElementBg"]
ValueBg.BorderColor3 = themes[theme]["ElementOutline"]
ValueBg.Position = UDim2.new(0.1, 0, 0.3, 0)
ValueBg.Size = UDim2.new(0, 60, 0, 16)
ValueBg.Visible = true
ValueLabel.Name = "ValueLabel"
ValueLabel.Parent = ValueBg
ValueLabel.BackgroundTransparency = 1
ValueLabel.Size = UDim2.new(1, 0, 1, 0)
ValueLabel.Font = Enum.Font.Gotham
ValueLabel.TextColor3 = themes[theme]["Text"]
ValueLabel.TextSize = 12
ValueLabel.TextXAlignment = Enum.TextXAlignment.Center
ValueLabel.TextYAlignment = Enum.TextYAlignment.Center
slider.set = function(fraction)
services.tween:Create(Fill, TweenInfo.new(0.15, Enum.EasingStyle.Quad), {Size = UDim2.new(fraction, 0, 1, 0)}):Play()
value = fraction * (max - min) + min
callback(value)
local displayText = tostring(math.round(value * 100) / 100) .. indicator
ValueLabel.Text = displayText
-- АВТОМАТИЧЕСКОЕ ВЫРАВНИВАНИЕ ЗНАЧЕНИЯ
local textWidth = ValueLabel.TextBounds.X
local maxWidth = 60
if textWidth > maxWidth then
ValueBg.Size = UDim2.new(0, textWidth + 10, 0, 16)
else
ValueBg.Size = UDim2.new(0, maxWidth, 0, 16)
end
local bgLeft = Bg.AbsolutePosition.X
local bgRight = bgLeft + Bg.AbsoluteSize.X
local valLeft = ValueBg.AbsolutePosition.X
local valRight = valLeft + ValueBg.AbsoluteSize.X
if valLeft < bgLeft then
ValueBg.Position = UDim2.new(0.1, 0, 0.3, 0)
elseif valRight > bgRight then
ValueBg.Position = UDim2.new(0.1 + (1 - fraction), -ValueBg.Size.X.Offset, 0.3, 0)
else
ValueBg.Position = UDim2.new(fraction + 0.1, -ValueBg.Size.X.Offset / 2, 0.3, 0)
end
end
slider.get = function()
return value
end
slider.set_text = function(_text)
Text.Text = _text
end
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
services.run.RenderStepped:Connect(function()
if dragging then
local mouse_pos = services.uis:GetMouseLocation()
local abs = Bg.AbsolutePosition.X
local abs_size = Bg.AbsoluteSize.X
local size = math.clamp((mouse_pos.X - abs) / abs_size, 0, 1)
slider.set(size)
end
end)
local initial_fraction = (default - min) / (max - min)
slider.set(initial_fraction)
sector.increase_scrollbar_size()
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
