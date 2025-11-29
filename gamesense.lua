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
}
}
local services = {
uis = game:GetService("UserInputService"),
run = game:GetService("RunService"),
tween = game:GetService("TweenService")
}
local function gethui()
local core = game:GetService("CoreGui")
local playerGui = game.Players.LocalPlayer:FindFirstChild("PlayerGui")
if core and (syn or getexecutorname) then return core end
return playerGui or game.Players.LocalPlayer:WaitForChild("PlayerGui")
end
local function protectgui(gui)
if syn and syn.protect_gui then syn.protect_gui(gui)
elseif get_hui_gui then get_hui_gui(gui)
elseif gethui then gui.Parent = gethui() end
if identifyexecutor and string.find(string.lower(identifyexecutor()), "scriptware") then gui.Parent = gethui() end
end
lib.create_window = function(theme, key)
local parent = gethui()
if parent:FindFirstChild("Mute") then parent:FindFirstChild("Mute"):Destroy() end
local window = {}
window.dragging = false
local gui = Instance.new("ScreenGui")
protectgui(gui)
gui.Name = "Mute"
gui.Parent = parent
gui.ZIndexBehavior = Enum.ZIndexBehavior.Global
gui.ResetOnSpawn = false
gui.DisplayOrder = 999999
gui.IgnoreGuiInset = true
local main = Instance.new("Frame")
main.Name = "Main"
main.Parent = gui
main.BackgroundColor3 = themes[theme]["Window"]
main.BorderColor3 = Color3.fromRGB(40, 40, 40)
main.BorderSizePixel = 3
main.Position = UDim2.new(0.38, 0, 0.25, 0)
main.Size = UDim2.new(0, 684, 0, 605)
local tabs = Instance.new("Frame")
tabs.Name = "Tabs"
tabs.Parent = main
tabs.BackgroundColor3 = themes[theme]["Tabs"]
tabs.BorderColor3 = Color3.fromRGB(18, 18, 18)
tabs.Position = UDim2.new(0, 1, 0.003, 0)
tabs.Size = UDim2.new(0, 100, 0, 602)
local grid = Instance.new("UIGridLayout")
grid.Parent = tabs
grid.SortOrder = Enum.SortOrder.LayoutOrder
grid.CellPadding = UDim2.new(0, 15, 0, 0)
grid.CellSize = UDim2.new(0, 85, 0, 70)
local pad = Instance.new("UIPadding")
pad.Parent = tabs
pad.PaddingLeft = UDim.new(0, 14)
pad.PaddingTop = UDim.new(0, 15)
local topgrad = Instance.new("Frame")
topgrad.Name = "TopGradient"
topgrad.Parent = main
topgrad.BackgroundColor3 = Color3.new(1,1,1)
topgrad.BorderSizePixel = 0
topgrad.Size = UDim2.new(1, 0, 0, 2)
local grad = Instance.new("UIGradient")
grad.Color = themes[theme]["Gradient"]
grad.Parent = topgrad
local content = Instance.new("Frame")
content.Name = "Content"
content.Parent = main
content.BackgroundTransparency = 1
content.Position = UDim2.new(0.165, 0, 0.025, 0)
content.Size = UDim2.new(0, 553, 0, 579)
local list = Instance.new("UIListLayout")
list.Parent = content
list.FillDirection = Enum.FillDirection.Horizontal
list.SortOrder = Enum.SortOrder.LayoutOrder
list.Padding = UDim.new(0, 10)
local dragStart, startPos
local function update(input)
local delta = input.Position - dragStart
main.Position = UDim2.new(startPos.X.Scale, startPos.X.Offset + delta.X, startPos.Y.Scale, startPos.Y.Offset + delta.Y)
end
main.InputBegan:Connect(function(input)
if input.UserInputType == Enum.UserInputType.MouseButton1 then
dragStart = input.Position
startPos = main.Position
window.dragging = true
input.Changed:Connect(function()
if input.UserInputState == Enum.UserInputState.End then window.dragging = false end
end)
end
end)
services.uis.InputChanged:Connect(function(input)
if window.dragging and input.UserInputType == Enum.UserInputType.MouseMovement then update(input) end
end)
services.uis.InputBegan:Connect(function(input)
if input.KeyCode == key then gui.Enabled = not gui.Enabled end
end)
window.tab_contents = {}
window.selected = ""
window.show = function(name)
for _,v in pairs(window.tab_contents) do
v[2].Visible = v[1] == name
end
end
window.create_tab = function(img)
local tab = {}
tab.count = 0
local btn = Instance.new("TextButton")
btn.Name = img:sub(14)
btn.Parent = tabs
btn.BackgroundTransparency = 1
btn.BackgroundColor3 = themes[theme]["TabSelected"]
btn.BorderSizePixel = 2
btn.BorderColor3 = Color3.fromRGB(18,18,18)
btn.Size = UDim2.new(0, 108, 0, 70)
btn.AutoButtonColor = false
btn.Text = ""
local icon = Instance.new("ImageButton")
icon.Name = "Open"
icon.Parent = btn
icon.BackgroundTransparency = 1
icon.Position = UDim2.new(0.163, 0, 0.186, 0)
icon.Size = UDim2.new(0, 43, 0, 43)
icon.Image = img
icon.ImageColor3 = Color3.fromRGB(90,90,90)
icon.MouseButton1Click:Connect(function()
window.selected = btn.Name
window.show(btn.Name)
for _,t in pairs(tabs:GetChildren()) do
if t:IsA("TextButton") then
services.tween:Create(t, TweenInfo.new(0.2), t == btn and {BackgroundTransparency = 0} or {BackgroundTransparency = 1}):Play()
services.tween:Create(t.Open, TweenInfo.new(0.2), t == btn and {ImageColor3 = Color3.fromRGB(209,210,208)} or {ImageColor3 = Color3.fromRGB(90,90,90)}):Play()
end
end
end)
tab.create_sector = function(name)
if tab.count >= 2 then error("max 2 sectors") end
tab.count += 1
local sector = {}
local frame = Instance.new("Frame")
frame.Name = name
frame.Parent = content
frame.BackgroundColor3 = themes[theme]["Sector"]
frame.BorderColor3 = Color3.fromRGB(30,30,30)
frame.Size = UDim2.new(0.5, -5, 1, 0)
frame.Position = tab.count == 2 and UDim2.new(0.5, 5, 0, 0) or UDim2.new(0, 0, 0, 0)
frame.Visible = false
local title = Instance.new("TextLabel")
title.Parent = frame
title.BackgroundTransparency = 1
title.Position = UDim2.new(0.03, 0, 0, 0)
title.Size = UDim2.new(1, -10, 0, 20)
title.Font = Enum.Font.SourceSansBold
title.Text = name
title.TextColor3 = themes[theme]["Text"]
title.TextSize = 17
title.TextXAlignment = Enum.TextXAlignment.Left
local scroll = Instance.new("ScrollingFrame")
scroll.Parent = frame
scroll.BackgroundTransparency = 1
scroll.Position = UDim2.new(0.03, 0, 0.04, 0)
scroll.Size = UDim2.new(0.94, 0, 0.94, 0)
scroll.CanvasSize = UDim2.new(0, 0, 0, 0)
scroll.ScrollBarThickness = 3
scroll.AutomaticCanvasSize = Enum.AutomaticSize.Y
local layout = Instance.new("UIListLayout")
layout.Parent = scroll
layout.Padding = UDim.new(0, 6)
local pad = Instance.new("UIPadding")
pad.Parent = scroll
pad.PaddingTop = UDim.new(0, 4)
pad.PaddingLeft = UDim.new(0, 4)
pad.PaddingRight = UDim.new(0, 4)
local function resize()
local h = 0
for _,v in pairs(scroll:GetChildren()) do
if v:IsA("GuiObject") then h += v.AbsoluteSize.Y + 6 end
end
scroll.CanvasSize = UDim2.new(0, 0, 0, h)
end
sector.text = function(txt)
local lbl = Instance.new("TextLabel")
lbl.Parent = scroll
lbl.BackgroundTransparency = 1
lbl.Size = UDim2.new(1, 0, 0, 16)
lbl.Font = Enum.Font.SourceSans
lbl.Text = txt
lbl.TextColor3 = themes[theme]["Text"]
lbl.TextSize = 14
lbl.TextXAlignment = Enum.TextXAlignment.Left
resize()
return {set=function(t) lbl.Text = t end, delete=function() lbl:Destroy() resize() end}
end
sector.warning = function(txt)
local w = sector.text(txt)
w.set = function(t) w.Text = t end
w.delete = function() w:Destroy() resize() end
w.TextColor3 = Color3.fromRGB(142,127,74)
return w
end
sector.error = function(txt)
local e = sector.text(txt)
e.TextColor3 = Color3.fromRGB(142,74,65)
return e
end
sector.info = function(txt)
local i = sector.text(txt)
i.TextColor3 = Color3.fromRGB(63,110,152)
return i
end
sector.button = function(txt,cb)
local btn = Instance.new("TextButton")
btn.Parent = scroll
btn.BackgroundColor3 = themes[theme]["ElementBg"]
btn.BorderColor3 = themes[theme]["ElementOutline"]
btn.Size = UDim2.new(1, 0, 0, 26)
btn.AutoButtonColor = false
btn.Font = Enum.Font.SourceSans
btn.Text = txt
btn.TextColor3 = themes[theme]["Text"]
btn.TextSize = 14
btn.MouseEnter:Connect(function() services.tween:Create(btn,TweenInfo.new(0.2),{BackgroundColor3=themes[theme]["ButtonHover"]}):Play() end)
btn.MouseLeave:Connect(function() services.tween:Create(btn,TweenInfo.new(0.2),{BackgroundColor3=themes[theme]["ElementBg"]}):Play() end)
btn.MouseButton1Down:Connect(function() services.tween:Create(btn,TweenInfo.new(0.1),{BackgroundColor3=themes[theme]["ButtonPressed"]}):Play() end)
btn.MouseButton1Up:Connect(function() services.tween:Create(btn,TweenInfo.new(0.2),{BackgroundColor3=themes[theme]["ButtonHover"]}):Play() end)
btn.MouseButton1Click:Connect(cb)
resize()
return {set=function(t) btn.Text = t end, delete=function() btn:Destroy() resize() end}
end
sector.toggle = function(txt,def,cb)
local val = def
local frame = Instance.new("Frame")
frame.Parent = scroll
frame.BackgroundTransparency = 1
frame.Size = UDim2.new(1, 0, 0, 22)
local label = Instance.new("TextLabel")
label.Parent = frame
label.BackgroundTransparency = 1
label.Position = UDim2.new(0, 0, 0, 2)
label.Size = UDim2.new(0.85, 0, 1, 0)
label.Font = Enum.Font.SourceSans
label.Text = txt
label.TextColor3 = themes[theme]["Text"]
label.TextSize = 14
label.TextXAlignment = Enum.TextXAlignment.Left
local bg = Instance.new("TextButton")
bg.Parent = frame
bg.BackgroundColor3 = val and themes[theme]["Toggle"] or themes[theme]["ToggleUnchecked"]
bg.BorderColor3 = themes[theme]["ElementOutline"]
bg.Position = UDim2.new(0.9, -30, 0.25, 0)
bg.Size = UDim2.new(0, 36, 0, 18)
bg.AutoButtonColor = false
bg.Text = ""
bg.MouseButton1Click:Connect(function()
val = not val
services.tween:Create(bg,TweenInfo.new(0.2),{BackgroundColor3 = val and themes[theme]["Toggle"] or themes[theme]["ToggleUnchecked"]}):Play()
cb(val)
end)
resize()
return {set=function(v) val=v services.tween:Create(bg,TweenInfo.new(0.2),{BackgroundColor3 = v and themes[theme]["Toggle"] or themes[theme]["ToggleUnchecked"]}):Play() cb(v) end}
end
sector.slider = function(txt,ind,min,max,def,cb)
local val = def
local frame = Instance.new("Frame")
frame.Parent = scroll
frame.BackgroundTransparency = 1
frame.Size = UDim2.new(1, 0, 0, 36)
local label = Instance.new("TextLabel")
label.Parent = frame
label.BackgroundTransparency = 1
label.Size = UDim2.new(1, 0, 0, 16)
label.Font = Enum.Font.SourceSans
label.Text = txt
label.TextColor3 = themes[theme]["Text"]
label.TextSize = 14
label.TextXAlignment = Enum.TextXAlignment.Left
local bg = Instance.new("Frame")
bg.Parent = frame
bg.BackgroundColor3 = themes[theme]["SliderBg"]
bg.BorderColor3 = themes[theme]["ElementOutline"]
bg.Position = UDim2.new(0, 0, 0.5, 0)
bg.Size = UDim2.new(1, 0, 0, 8)
local fill = Instance.new("Frame")
fill.Parent = bg
fill.BackgroundColor3 = themes[theme]["Slider"]
fill.BorderSizePixel = 0
fill.Size = UDim2.new((def-min)/(max-min), 0, 1, 0)
local valLbl = Instance.new("TextLabel")
valLbl.Parent = bg
valLbl.BackgroundTransparency = 1
valLbl.Position = UDim2.new(1, -40, 0, -12)
valLbl.Size = UDim2.new(0, 40, 0, 12)
valLbl.Font = Enum.Font.SourceSans
valLbl.TextColor3 = themes[theme]["Text"]
valLbl.TextSize = 12
valLbl.TextXAlignment = Enum.TextXAlignment.Right
valLbl.Text = tostring(def)..ind
local dragging = false
local function set(v)
v = math.clamp(v, min, max)
val = v
fill.Size = UDim2.new((v-min)/(max-min), 0, 1, 0)
valLbl.Text = tostring(math.round(v*100)/100)..ind
cb(v)
end
bg.InputBegan:Connect(function(i) if i.UserInputType == Enum.UserInputType.MouseButton1 then dragging = true end end)
bg.InputEnded:Connect(function(i) if i.UserInputType == Enum.UserInputType.MouseButton1 then dragging = false end end)
services.run.RenderStepped:Connect(function()
if dragging then
local m = services.uis:GetMouseLocation()
local rel = math.clamp((m.X - bg.AbsolutePosition.X) / bg.AbsoluteSize.X, 0, 1)
set(min + rel * (max - min))
end
end)
set(def)
resize()
return {set=set}
end
sector.dropdown = function(txt, opts, def, cb)
local selected = def
local frame = Instance.new("TextButton")
frame.Parent = scroll
frame.BackgroundColor3 = themes[theme]["ElementBg"]
frame.BorderColor3 = themes[theme]["ElementOutline"]
frame.Size = UDim2.new(1, 0, 0, 26)
frame.AutoButtonColor = false
frame.Text = txt
frame.TextColor3 = themes[theme]["Text"]
frame.TextSize = 14
frame.TextXAlignment = Enum.TextXAlignment.Left
local pad = Instance.new("UIPadding")
pad.Parent = frame
pad.PaddingLeft = UDim.new(0, 8)
local arrow = Instance.new("ImageLabel")
arrow.Parent = frame
arrow.BackgroundTransparency = 1
arrow.Position = UDim2.new(1, -22, 0.5, -6)
arrow.Size = UDim2.new(0, 12, 0, 12)
arrow.Image = "rbxassetid://74187648454886"
arrow.ImageColor3 = Color3.fromRGB(115,115,115)
local drop = Instance.new("ScrollingFrame")
drop.Parent = frame
drop.BackgroundColor3 = themes[theme]["ElementBg"]
drop.BorderColor3 = themes[theme]["ElementOutline"]
drop.Position = UDim2.new(0, 0, 1, 2)
drop.Size = UDim2.new(1, 0, 0, 0)
drop.Visible = false
drop.ScrollBarThickness = 3
local dlayout = Instance.new("UIListLayout")
dlayout.Parent = drop
dlayout.Padding = UDim.new(0, 2)
local dpad = Instance.new("UIPadding")
dpad.Parent = drop
dpad.PaddingLeft = UDim.new(0, 4)
local open = false
local function toggle()
open = not open
services.tween:Create(arrow,TweenInfo.new(0.2),{Rotation = open and 180 or 0}):Play()
services.tween:Create(drop,TweenInfo.new(0.2),{Size = open and UDim2.new(1,0,0,math.min(#opts*26,150)) or UDim2.new(1,0,0,0)}):Play()
if not open then task.delay(0.2,function() drop.Visible = false end) end
end
frame.MouseButton1Click:Connect(toggle)
local function makeopt(name)
local opt = Instance.new("TextButton")
opt.Parent = drop
opt.BackgroundColor3 = themes[theme]["ElementBg"]
opt.BorderColor3 = themes[theme]["ElementOutline"]
opt.Size = UDim2.new(1, -8, 0, 24)
opt.AutoButtonColor = false
opt.Text = name
opt.TextColor3 = themes[theme]["Text"]
opt.TextSize = 14
opt.MouseEnter:Connect(function() services.tween:Create(opt,TweenInfo.new(0.2),{BackgroundColor3=themes[theme]["ButtonHover"]}):Play() end)
opt.MouseLeave:Connect(function() services.tween:Create(opt,TweenInfo.new(0.2),{BackgroundColor3=themes[theme]["ElementBg"]}):Play() end)
opt.MouseButton1Click:Connect(function()
selected = name
frame.Text = txt.." : "..name
toggle()
cb(name)
end)
if name == def then opt.BorderColor3 = themes[theme]["DropdownSelected"] end
return opt
end
for _,v in ipairs(opts) do makeopt(v) end
local obj = {}
obj.set = function(v) selected=v frame.Text = txt.." : "..v end
obj.add = function(v) makeopt(v) end
obj.remove = function(v) if drop:FindFirstChild(v) then drop:FindFirstChild(v):Destroy() end end
obj.get = function() return selected end
resize()
return obj
end
sector.multicombobox = function(txt, opts, defs, cb)
local sel = {}
for _,v in ipairs(opts) do sel[v] = false end
if type(defs)=="table" then for _,v in ipairs(defs) do if sel[v]~=nil then sel[v]=true end end end
local frame = Instance.new("TextButton")
frame.Parent = scroll
frame.BackgroundColor3 = themes[theme]["ElementBg"]
frame.BorderColor3 = themes[theme]["ElementOutline"]
frame.Size = UDim2.new(1, 0, 0, 26)
frame.AutoButtonColor = false
frame.Text = txt
frame.TextColor3 = themes[theme]["Text"]
frame.TextSize = 14
frame.TextXAlignment = Enum.TextXAlignment.Left
local pad = Instance.new("UIPadding")
pad.Parent = frame
pad.PaddingLeft = UDim.new(0, 8)
local arrow = Instance.new("ImageLabel")
arrow.Parent = frame
arrow.BackgroundTransparency = 1
arrow.Position = UDim2.new(1, -22, 0.5, -6)
arrow.Size = UDim2.new(0, 12, 0, 12)
arrow.Image = "rbxassetid://74187648454886"
arrow.ImageColor3 = Color3.fromRGB(115,115,115)
local drop = Instance.new("ScrollingFrame")
drop.Parent = frame
drop.BackgroundColor3 = themes[theme]["ElementBg"]
drop.BorderColor3 = themes[theme]["ElementOutline"]
drop.Position = UDim2.new(0, 0, 1, 2)
drop.Size = UDim2.new(1, 0, 0, 0)
drop.Visible = false
drop.ScrollBarThickness = 3
local dlayout = Instance.new("UIListLayout")
dlayout.Parent = drop
dlayout.Padding = UDim.new(0, 2)
local function update()
local cnt = 0
for _,v in pairs(sel) do if v then cnt+=1 end end
if cnt==0 then frame.Text = txt
elseif cnt==1 then for k,v in pairs(sel) do if v then frame.Text = k break end end
else frame.Text = txt.." ("..cnt..")" end
end
local open = false
local function toggle()
open = not open
services.tween:Create(arrow,TweenInfo.new(0.2),{Rotation = open and 180 or 0}):Play()
services.tween:Create(drop,TweenInfo.new(0.2),{Size = open and UDim2.new(1,0,0,math.min(#opts*26,150)) or UDim2.new(1,0,0,0)}):Play()
end
frame.MouseButton1Click:Connect(toggle)
local function make(v)
local btn = Instance.new("TextButton")
btn.Parent = drop
btn.BackgroundColor3 = themes[theme]["ElementBg"]
btn.BorderColor3 = sel[v] and themes[theme]["DropdownSelected"] or themes[theme]["ElementOutline"]
btn.Size = UDim2.new(1, -8, 0, 24)
btn.AutoButtonColor = false
btn.Text = v
btn.TextColor3 = themes[theme]["Text"]
btn.TextSize = 14
btn.MouseButton1Click:Connect(function()
sel[v] = not sel[v]
btn.BorderColor3 = sel[v] and themes[theme]["DropdownSelected"] or themes[theme]["ElementOutline"]
update()
cb(sel)
end)
end
for _,v in ipairs(opts) do make(v) end
update()
resize()
return {set=function(k,v) sel[k]=v update() end, get=function() return sel end}
end
table.insert(window.tab_contents,{btn.Name,frame})
return sector
end
return tab
end
return window
end
return lib
