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
["Window"] = Color3.fromRGB(10, 10, 10),
["Tabs"] = Color3.fromRGB(8, 8, 8),
["Gradient"] = ColorSequence.new{ColorSequenceKeypoint.new(0, Color3.fromRGB(30,30,30)), ColorSequenceKeypoint.new(1, Color3.fromRGB(60,60,60))},
["Sector"] = Color3.fromRGB(18, 18, 18),
["Text"] = Color3.fromRGB(220, 220, 220),
["TabSelected"] = Color3.fromRGB(12, 12, 12),
["ElementBg"] = Color3.fromRGB(25, 25, 25),
["ElementOutline"] = Color3.fromRGB(40,40,40),
["DropdownSelected"] = Color3.fromRGB(0, 170, 255),
["Toggle"] = Color3.fromRGB(0, 170, 255),
["ToggleUnchecked"] = Color3.fromRGB(30,30,30),
["Slider"] = Color3.fromRGB(0, 170, 255),
["SliderBg"] = Color3.fromRGB(25, 25, 25),
["ButtonHover"] = Color3.fromRGB(35, 35, 35),
["ButtonPressed"] = Color3.fromRGB(40, 40, 40)
},
["light"] = {
["Window"] = Color3.fromRGB(240, 240, 240),
["Tabs"] = Color3.fromRGB(220, 220, 220),
["Gradient"] = ColorSequence.new{ColorSequenceKeypoint.new(0, Color3.fromRGB(100,150,255)), ColorSequenceKeypoint.new(1, Color3.fromRGB(255,100,200))},
["Sector"] = Color3.fromRGB(255, 255, 255),
["Text"] = Color3.fromRGB(30, 30, 30),
["TabSelected"] = Color3.fromRGB(230, 230, 230),
["ElementBg"] = Color3.fromRGB(245, 245, 245),
["ElementOutline"] = Color3.fromRGB(200,200,200),
["DropdownSelected"] = Color3.fromRGB(0, 120, 215),
["Toggle"] = Color3.fromRGB(0, 120, 215),
["ToggleUnchecked"] = Color3.fromRGB(210,210,210),
["Slider"] = Color3.fromRGB(0, 120, 215),
["SliderBg"] = Color3.fromRGB(245, 245, 245),
["ButtonHover"] = Color3.fromRGB(235, 235, 235),
["ButtonPressed"] = Color3.fromRGB(225, 225, 225)
},
["purple"] = {
["Window"] = Color3.fromRGB(15, 8, 20),
["Tabs"] = Color3.fromRGB(12, 6, 18),
["Gradient"] = ColorSequence.new{ColorSequenceKeypoint.new(0, Color3.fromRGB(138,43,226)), ColorSequenceKeypoint.new(1, Color3.fromRGB(75,0,130))},
["Sector"] = Color3.fromRGB(20, 12, 28),
["Text"] = Color3.fromRGB(200, 180, 255),
["TabSelected"] = Color3.fromRGB(25, 15, 35),
["ElementBg"] = Color3.fromRGB(30, 20, 45),
["ElementOutline"] = Color3.fromRGB(60,40,80),
["DropdownSelected"] = Color3.fromRGB(180, 100, 255),
["Toggle"] = Color3.fromRGB(180, 100, 255),
["ToggleUnchecked"] = Color3.fromRGB(40,30,55),
["Slider"] = Color3.fromRGB(180, 100, 255),
["SliderBg"] = Color3.fromRGB(30, 20, 45),
["ButtonHover"] = Color3.fromRGB(45, 35, 60),
["ButtonPressed"] = Color3.fromRGB(55, 45, 70)
},
["ocean"] = {
["Window"] = Color3.fromRGB(5, 15, 25),
["Tabs"] = Color3.fromRGB(3, 12, 22),
["Gradient"] = ColorSequence.new{ColorSequenceKeypoint.new(0, Color3.fromRGB(0,150,200)), ColorSequenceKeypoint.new(1, Color3.fromRGB(0,80,150))},
["Sector"] = Color3.fromRGB(10, 20, 35),
["Text"] = Color3.fromRGB(150, 220, 255),
["TabSelected"] = Color3.fromRGB(8, 18, 32),
["ElementBg"] = Color3.fromRGB(15, 30, 50),
["ElementOutline"] = Color3.fromRGB(30,60,90),
["DropdownSelected"] = Color3.fromRGB(0, 200, 255),
["Toggle"] = Color3.fromRGB(0, 200, 255),
["ToggleUnchecked"] = Color3.fromRGB(25,40,60),
["Slider"] = Color3.fromRGB(0, 200, 255),
["SliderBg"] = Color3.fromRGB(15, 30, 50),
["ButtonHover"] = Color3.fromRGB(25, 45, 70),
["ButtonPressed"] = Color3.fromRGB(35, 55, 80)
},
["blood"] = {
["Window"] = Color3.fromRGB(20, 5, 5),
["Tabs"] = Color3.fromRGB(18, 3, 3),
["Gradient"] = ColorSequence.new{ColorSequenceKeypoint.new(0, Color3.fromRGB(200,0,0)), ColorSequenceKeypoint.new(1, Color3.fromRGB(100,0,0))},
["Sector"] = Color3.fromRGB(28, 8, 8),
["Text"] = Color3.fromRGB(255, 80, 80),
["TabSelected"] = Color3.fromRGB(35, 10, 10),
["ElementBg"] = Color3.fromRGB(40, 15, 15),
["ElementOutline"] = Color3.fromRGB(80,30,30),
["DropdownSelected"] = Color3.fromRGB(255, 50, 50),
["Toggle"] = Color3.fromRGB(255, 50, 50),
["ToggleUnchecked"] = Color3.fromRGB(60,20,20),
["Slider"] = Color3.fromRGB(255, 50, 50),
["SliderBg"] = Color3.fromRGB(40, 15, 15),
["ButtonHover"] = Color3.fromRGB(60, 25, 25),
["ButtonPressed"] = Color3.fromRGB(80, 35, 35)
}
}
local services = {uis = game:GetService("UserInputService"), run = game:GetService("RunService"), tween = game:GetService("TweenService")}
local function gethui()
local coreGui = game:GetService("CoreGui")
if coreGui and (syn or getexecutorname) then return coreGui end
local playerGui = game.Players.LocalPlayer:FindFirstChild("PlayerGui")
return playerGui or game.Players.LocalPlayer:WaitForChild("PlayerGui")
end
local function protectgui(gui)
if syn and syn.protect_gui then syn.protect_gui(gui)
elseif get_hui_gui and type(get_hui_gui)=="function" then get_hui_gui(gui)
elseif gethui then gui.Parent = gethui() end
if identifyexecutor and string.find(string.lower(identifyexecutor()),"scriptware") then gui.Parent = gethui() end
end
lib.create_window = function(theme, menu_key)
local targetParent = gethui()
if targetParent:FindFirstChild("Mute") then targetParent:FindFirstChild("Mute"):Destroy() end
local window = {}
window.dragging = false
window.drag_input = nil
window.drag_start = nil
window.start_pos = nil
local Mute = Instance.new("ScreenGui")
protectgui(Mute)
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
end
end
window.drag_changed = function(input)
if input.UserInputType == Enum.UserInputType.MouseMovement or input.UserInputType == Enum.UserInputType.Touch then
window.drag_input = input
end
end
Tabs.InputBegan:Connect(window.drag_began)
Tabs.InputChanged:Connect(window.drag_changed)
Main.InputBegan:Connect(window.drag_began)
Main.InputChanged:Connect(window.drag_changed)
services.uis.InputChanged:Connect(function(input)
if input == window.drag_input and window.dragging then window.update_window(input) end
end)
services.uis.InputBegan:Connect(function(input)
if input.KeyCode == menu_key then Mute.Enabled = not Mute.Enabled end
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
Main.Position = UDim2.new(0.35, 0, 0.25, 0)
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
TopGradient.BorderSizePixel = 0
TopGradient.Size = UDim2.new(0, 684, 0, 2)
UIGradient.Color = themes[theme]["Gradient"]
UIGradient.Parent = TopGradient
Content.Name = "Content"
Content.Parent = Main
Content.BackgroundTransparency = 1
Content.BorderSizePixel = 0
Content.Position = UDim2.new(0.165, 0, 0.0247933883, 0)
Content.Size = UDim2.new(0, 553, 0, 579)
UIListLayout.Parent = Content
UIListLayout.FillDirection = Enum.FillDirection.Horizontal
UIListLayout.SortOrder = Enum.SortOrder.LayoutOrder
UIListLayout.Padding = UDim.new(0, 10)
window.tab_contents = {}
window.selected_tab = ""
window.show_tab = function(name)
for _, v in pairs(window.tab_contents) do
v[2].Visible = v[1] == name
end
end
window.tab_active = function(tab)
services.tween:Create(tab, TweenInfo.new(0.2, Enum.EasingStyle.Quad), {BackgroundTransparency = 0}):Play()
services.tween:Create(tab.Open, TweenInfo.new(0.2, Enum.EasingStyle.Quad), {ImageColor3 = Color3.fromRGB(209, 210, 208)}):Play()
end
window.tab_inactive = function(tab)
services.tween:Create(tab, TweenInfo.new(0.2, Enum.EasingStyle.Quad), {BackgroundTransparency = 1}):Play()
services.tween:Create(tab.Open, TweenInfo.new(0.2, Enum.EasingStyle.Quad), {ImageColor3 = Color3.fromRGB(90,90,90)}):Play()
end
window.create_tab = function(image)
local tab = {}
tab.sectorCount = 0
local Tab = Instance.new("TextButton")
local Open = Instance.new("ImageButton")
Tab.Name = image:sub(14)
Tab.Parent = Tabs
Tab.BackgroundColor3 = themes[theme]["TabSelected"]
Tab.BackgroundTransparency = 1
Tab.BorderSizePixel = 2
Tab.BorderColor3 = Color3.fromRGB(18, 18, 18)
Tab.Size = UDim2.new(0, 108, 0, 70)
Tab.AutoButtonColor = false
Tab.Text = ""
Open.Name = "Open"
Open.Parent = Tab
Open.BackgroundTransparency = 1
Open.Position = UDim2.new(0.162790701, 0, 0.18571429, 0)
Open.Size = UDim2.new(0, 43, 0, 43)
Open.Image = image
Open.ImageColor3 = Color3.fromRGB(90,90,90)
Open.MouseButton1Down:Connect(function()
window.selected_tab = Tab.Name
for _, t in pairs(Tabs:GetChildren()) do
if t:IsA("TextButton") then
if t.Name == Tab.Name then window.tab_active(t) else window.tab_inactive(t) end
end
end
window.show_tab(Tab.Name)
end)
tab.create_sector = function(name)
if tab.sectorCount >= 2 then error("Max 2 sectors per tab") end
tab.sectorCount += 1
local sector = {}
local Sector = Instance.new("Frame")
local Title = Instance.new("TextLabel")
local SectorContent = Instance.new("ScrollingFrame")
local ContentLayout = Instance.new("UIListLayout")
local ContentPadding = Instance.new("UIPadding")
Sector.Name = name
Sector.Parent = Content
Sector.BackgroundColor3 = themes[theme]["Sector"]
Sector.BorderColor3 = Color3.fromRGB(30, 30, 30)
Sector.Size = UDim2.new(0.5, -5, 1, 0)
Sector.Position = tab.sectorCount == 2 and UDim2.new(0.5, 5, 0, 0) or UDim2.new(0, 0, 0, 0)
Sector.Visible = false
Sector.ClipsDescendants = false
Title.Name = "Title"
Title.Parent = Sector
Title.BackgroundTransparency = 1
Title.Position = UDim2.new(0.0289, 0, 0, 0)
Title.Size = UDim2.new(0, 268, 0, 20)
Title.Font = Enum.Font.SourceSans
Title.TextColor3 = themes[theme]["Text"]
Title.TextSize = 18
Title.TextXAlignment = Enum.TextXAlignment.Left
Title.Text = name
SectorContent.Name = "SectorContent"
SectorContent.Parent = Sector
SectorContent.BackgroundTransparency = 1
SectorContent.Position = UDim2.new(0, 0, 0, 25)
SectorContent.Size = UDim2.new(1, 0, 1, -25)
SectorContent.CanvasSize = UDim2.new(0, 0, 0, 0)
SectorContent.ScrollBarThickness = 3
SectorContent.AutomaticCanvasSize = Enum.AutomaticSize.Y
SectorContent.ClipsDescendants = true
ContentLayout.Parent = SectorContent
ContentLayout.SortOrder = Enum.SortOrder.LayoutOrder
ContentLayout.Padding = UDim.new(0, 6)
ContentPadding.Parent = SectorContent
ContentPadding.PaddingLeft = UDim.new(0, 5)
ContentPadding.PaddingTop = UDim.new(0, 5)
sector.text = function(txt)
local obj = Instance.new("TextLabel")
obj.Parent = SectorContent
obj.BackgroundTransparency = 1
obj.Size = UDim2.new(1, -10, 0, 16)
obj.Font = Enum.Font.SourceSans
obj.Text = txt
obj.TextColor3 = themes[theme]["Text"]
obj.TextSize = 14
obj.TextXAlignment = Enum.TextXAlignment.Left
return {set = function(v) obj.Text = v end, delete = function() obj:Destroy() end}
end
sector.warning = function(txt)
local obj = sector.text(txt)
obj.TextColor3 = Color3.fromRGB(142, 127, 74)
return obj
end
sector.error = function(txt)
local obj = sector.text(txt)
obj.TextColor3 = Color3.fromRGB(142, 74, 65)
return obj
end
sector.info = function(txt)
local obj = sector.text(txt)
obj.TextColor3 = Color3.fromRGB(63, 110, 152)
return obj
end
sector.textbox = function(placeholder, default, callback)
local tb = Instance.new("TextBox")
tb.Parent = SectorContent
tb.BackgroundColor3 = themes[theme]["ElementBg"]
tb.BorderColor3 = themes[theme]["ElementOutline"]
tb.Size = UDim2.new(1, -10, 0, 24)
tb.ClearTextOnFocus = false
tb.PlaceholderText = placeholder
tb.Text = default or ""
tb.TextColor3 = themes[theme]["Text"]
tb.Font = Enum.Font.SourceSans
tb.TextSize = 14
tb.TextXAlignment = Enum.TextXAlignment.Left
local pad = Instance.new("UIPadding", tb)
pad.PaddingLeft = UDim.new(0, 5)
tb.FocusLost:Connect(function() callback(tb.Text) end)
callback(default or "")
return {set=function(v) tb.Text=v end, get=function() return tb.Text end, delete=function() tb:Destroy() end}
end
sector.button = function(txt, callback)
local btn = Instance.new("TextButton")
btn.Parent = SectorContent
btn.BackgroundColor3 = themes[theme]["ElementBg"]
btn.BorderColor3 = themes[theme]["ElementOutline"]
btn.Size = UDim2.new(1, -10, 0, 24)
btn.AutoButtonColor = false
btn.Text = txt
btn.TextColor3 = themes[theme]["Text"]
btn.Font = Enum.Font.SourceSans
btn.TextSize = 14
local tweenInfo = TweenInfo.new(0.2)
btn.MouseEnter:Connect(function() services.tween:Create(btn,tweenInfo,{BackgroundColor3=themes[theme]["ButtonHover"]}):Play() end)
btn.MouseLeave:Connect(function() services.tween:Create(btn,tweenInfo,{BackgroundColor3=themes[theme]["ElementBg"]}):Play() end)
btn.MouseButton1Down:Connect(function() services.tween:Create(btn,TweenInfo.new(0.1),{BackgroundColor3=themes[theme]["ButtonPressed"]}):Play() callback() end)
return {set=function(v) btn.Text=v end, delete=function() btn:Destroy() end}
end
sector.toggle = function(txt, default, callback)
local val = default
local frame = Instance.new("Frame")
frame.Parent = SectorContent
frame.BackgroundTransparency = 1
frame.Size = UDim2.new(1, -10, 0, 24)
local label = Instance.new("TextLabel", frame)
label.BackgroundTransparency = 1
label.Position = UDim2.new(0, 0, 0, 0)
label.Size = UDim2.new(1, -40, 1, 0)
label.Text = txt
label.TextColor3 = themes[theme]["Text"]
label.Font = Enum.Font.SourceSans
label.TextSize = 14
label.TextXAlignment = Enum.TextXAlignment.Left
local box = Instance.new("TextButton", frame)
box.BackgroundColor3 = default and themes[theme]["Toggle"] or themes[theme]["ToggleUnchecked"]
box.BorderColor3 = themes[theme]["ElementOutline"]
box.Position = UDim2.new(0, 5, 0.3, 0)
box.Size = UDim2.new(0, 16, 0, 16)
box.Text = ""
local function update(v)
services.tween:Create(box, TweenInfo.new(0.2), {BackgroundColor3 = v and themes[theme]["Toggle"] or themes[theme]["ToggleUnchecked"]}):Play()
callback(v)
end
frame.InputBegan:Connect(function(i) if i.UserInputType==Enum.UserInputType.MouseButton1 then val=not val update(val) end end)
update(default)
return {set=function(v) val=v update(v) end}
end
sector.slider = function(txt, min, max, default, callback, suffix)
suffix = suffix or ""
local frame = Instance.new("Frame")
frame.Parent = SectorContent
frame.BackgroundTransparency = 1
frame.Size = UDim2.new(1, -10, 0, 36)
local label = Instance.new("TextLabel", frame)
label.BackgroundTransparency = 1
label.Size = UDim2.new(1, -50, 0, 16)
label.Text = txt
label.TextColor3 = themes[theme]["Text"]
label.Font = Enum.Font.SourceSans
label.TextSize = 14
label.TextXAlignment = Enum.TextXAlignment.Left
local barbg = Instance.new("Frame", frame)
barbg.BackgroundColor3 = themes[theme]["SliderBg"]
barbg.BorderColor3 = themes[theme]["ElementOutline"]
barbg.Position = UDim2.new(0, 0, 0, 18)
barbg.Size = UDim2.new(1, 0, 0, 8)
local fill = Instance.new("Frame", barbg)
fill.BackgroundColor3 = themes[theme]["Slider"]
fill.Size = UDim2.new((default-min)/(max-min), 0, 1, 0)
local valuelabel = Instance.new("TextLabel", barbg)
valuelabel.BackgroundTransparency = 1
valuelabel.Position = UDim2.new(1, -50, 0, -10)
valuelabel.Size = UDim2.new(0, 50, 0, 16)
valuelabel.TextColor3 = themes[theme]["Text"]
valuelabel.Font = Enum.Font.SourceSans
valuelabel.TextSize = 12
valuelabel.TextXAlignment = Enum.TextXAlignment.Right
local dragging = false
local function set(v)
v = math.clamp(v, min, max)
fill.Size = UDim2.new((v-min)/(max-min), 0, 1, 0)
valuelabel.Text = tostring(math.round(v*100)/100)..suffix
callback(v)
end
barbg.InputBegan:Connect(function(i) if i.UserInputType==Enum.UserInputType.MouseButton1 then dragging=true end end)
barbg.InputEnded:Connect(function(i) if i.UserInputType==Enum.UserInputType.MouseButton1 then dragging=false end end)
services.uis.InputChanged:Connect(function(i)
if dragging and (i.UserInputType==Enum.UserInputType.MouseMovement or i.UserInputType==Enum.UserInputType.Touch) then
local rel = math.clamp((services.uis:GetMouseLocation().X - barbg.AbsolutePosition.X) / barbg.AbsoluteSize.X, 0, 1)
set(min + rel*(max-min))
end
end)
set(default)
return {set=set}
end
sector.dropdown = function(txt, items, default, callback)
local open = false
local selected = default or items[1]
local btn = Instance.new("TextButton")
btn.Parent = SectorContent
btn.BackgroundColor3 = themes[theme]["ElementBg"]
btn.BorderColor3 = themes[theme]["ElementOutline"]
btn.Size = UDim2.new(1, -10, 0, 24)
btn.AutoButtonColor = false
btn.Text = txt.." : "..selected
btn.TextColor3 = themes[theme]["Text"]
btn.Font = Enum.Font.SourceSans
btn.TextSize = 14
btn.TextXAlignment = Enum.TextXAlignment.Left
local arrow = Instance.new("ImageLabel", btn)
arrow.BackgroundTransparency = 1
arrow.Position = UDim2.new(1, -20, 0.5, -7)
arrow.Size = UDim2.new(0, 14, 0, 14)
arrow.Image = "rbxassetid://74187648454886"
arrow.ImageColor3 = Color3.fromRGB(115,115,115)
local list = Instance.new("ScrollingFrame", btn)
list.Visible = false
list.BackgroundColor3 = themes[theme]["ElementBg"]
list.BorderColor3 = themes[theme]["ElementOutline"]
list.Position = UDim2.new(0, 0, 1, 2)
list.Size = UDim2.new(1, 0, 0, 100)
list.CanvasSize = UDim2.new(0,0,0,0)
list.ScrollBarThickness = 3
local layout = Instance.new("UIListLayout", list)
layout.Padding = UDim.new(0, 2)
btn.MouseButton1Click:Connect(function()
open = not open
list.Visible = open
services.tween:Create(arrow, TweenInfo.new(0.2), {Rotation = open and 180 or 0}):Play()
services.tween:Create(list, TweenInfo.new(0.2), {Size = open and UDim2.new(1,0,0,100) or UDim2.new(1,0,0,0)}):Play()
end)
for _,v in pairs(items) do
local opt = Instance.new("TextButton", list)
opt.BackgroundColor3 = themes[theme]["ElementBg"]
opt.Size = UDim2.new(1, -6, 0, 22)
opt.Text = v
opt.TextColor3 = themes[theme]["Text"]
opt.AutoButtonColor = false
opt.MouseButton1Click:Connect(function()
selected = v
btn.Text = txt.." : "..v
callback(v)
open = false
list.Visible = false
services.tween:Create(arrow, TweenInfo.new(0.2), {Rotation = 0}):Play()
services.tween:Create(list, TweenInfo.new(0.2), {Size = UDim2.new(1,0,0,0)}):Play()
end)
end
list.CanvasSize = UDim2.new(0,0,0,layout.AbsoluteContentSize.Y + 10)
return {set=function(v) selected=v btn.Text=txt.." : "..v callback(v) end}
end
table.insert(window.tab_contents, {Tab.Name, Sector})
return sector
end
return tab
end
return window
end
return lib
