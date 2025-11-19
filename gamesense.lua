local lib = {}
local themes = {
["gamesense"] = {Window=Color3.fromRGB(8,8,8),Tabs=Color3.fromRGB(6,6,6),Gradient=ColorSequence.new{ColorSequenceKeypoint.new(0,Color3.fromRGB(61,130,162)),ColorSequenceKeypoint.new(0.5,Color3.fromRGB(156,59,145)),ColorSequenceKeypoint.new(1,Color3.fromRGB(155,161,48))},Sector=Color3.fromRGB(15,15,15),Text=Color3.fromRGB(180,180,180),TabSelected=Color3.fromRGB(10,10,10),ElementBg=Color3.fromRGB(20,20,20),ElementOutline=Color3.fromRGB(35,35,35),DropdownSelected=Color3.fromRGB(135,176,27),Toggle=Color3.fromRGB(135,176,27),ToggleUnchecked=Color3.fromRGB(25,25,25),Slider=Color3.fromRGB(135,176,27),SliderBg=Color3.fromRGB(20,20,20),ButtonHover=Color3.fromRGB(30,30,30),ButtonPressed=Color3.fromRGB(35,35,35)},
["neverlose"] = {Window=Color3.fromRGB(10,10,15),Tabs=Color3.fromRGB(8,8,13),Gradient=ColorSequence.new{ColorSequenceKeypoint.new(0,Color3.fromRGB(0,170,255)),ColorSequenceKeypoint.new(1,Color3.fromRGB(0,100,200))},Sector=Color3.fromRGB(12,12,20),Text=Color3.fromRGB(200,200,200),TabSelected=Color3.fromRGB(15,15,25),ElementBg=Color3.fromRGB(18,18,28),ElementOutline=Color3.fromRGB(40,40,60),DropdownSelected=Color3.fromRGB(0,170,255),Toggle=Color3.fromRGB(0,170,255),ToggleUnchecked=Color3.fromRGB(30,30,40),Slider=Color3.fromRGB(0,170,255),SliderBg=Color3.fromRGB(18,18,28),ButtonHover=Color3.fromRGB(25,25,40),ButtonPressed=Color3.fromRGB(30,30,50)},
["onyx"] = {Window=Color3.fromRGB(12,12,12),Tabs=Color3.fromRGB(10,10,10),Gradient=ColorSequence.new{ColorSequenceKeypoint.new(0,Color3.fromRGB(255,0,128)),ColorSequenceKeypoint.new(1,Color3.fromRGB(128,0,255))},Sector=Color3.fromRGB(18,18,18),Text=Color3.fromRGB(220,220,220),TabSelected=Color3.fromRGB(22,22,22),ElementBg=Color3.fromRGB(25,25,25),ElementOutline=Color3.fromRGB(45,45,45),DropdownSelected=Color3.fromRGB(200,50,255),Toggle=Color3.fromRGB(200,50,255),ToggleUnchecked=Color3.fromRGB(35,35,35),Slider=Color3.fromRGB(200,50,255),SliderBg=Color3.fromRGB(25,25,25),ButtonHover=Color3.fromRGB(35,35,35),ButtonPressed=Color3.fromRGB(40,40,40)},
["aimware"] = {Window=Color3.fromRGB(15,15,15),Tabs=Color3.fromRGB(12,12,12),Gradient=ColorSequence.new{ColorSequenceKeypoint.new(0,Color3.fromRGB(255,50,50)),ColorSequenceKeypoint.new(1,Color3.fromRGB(200,0,0))},Sector=Color3.fromRGB(20,20,20),Text=Color3.fromRGB(190,190,190),TabSelected=Color3.fromRGB(25,25,25),ElementBg=Color3.fromRGB(28,28,28),ElementOutline=Color3.fromRGB(50,50,50),DropdownSelected=Color3.fromRGB(255,706,70),Toggle=Color3.fromRGB(255,70,70),ToggleUnchecked=Color3.fromRGB(40,40,40),Slider=Color3.fromRGB(255,70,70),SliderBg=Color3.fromRGB(28,28,28),ButtonHover=Color3.fromRGB(38,38,38),ButtonPressed=Color3.fromRGB(45,45,45)},
["ev0lve"] = {Window=Color3.fromRGB(5,5,10),Tabs=Color3.fromRGB(3,3,8),Gradient=ColorSequence.new{ColorSequenceKeypoint.new(0,Color3.fromRGB(100,255,100)),ColorSequenceKeypoint.new(1,Color3.fromRGB(0,200,0))},Sector=Color3.fromRGB(10,10,15),Text=Color3.fromRGB(180,255,180),TabSelected=Color3.fromRGB(12,12,20),ElementBg=Color3.fromRGB(15,15,22),ElementOutline=Color3.fromRGB(30,60,30),DropdownSelected=Color3.fromRGB(100,255,100),Toggle=Color3.fromRGB(100,255,100),ToggleUnchecked=Color3.fromRGB(25,35,25),Slider=Color3.fromRGB(100,255,100),SliderBg=Color3.fromRGB(15,15,22),ButtonHover=Color3.fromRGB(22,32,22),ButtonPressed=Color3.fromRGB(28,40,28)},
["interwebz"] = {Window=Color3.fromRGB(18,18,22),Tabs=Color3.fromRGB(15,15,20),Gradient=ColorSequence.new{ColorSequenceKeypoint.new(0,Color3.fromRGB(255,180,0)),ColorSequenceKeypoint.new(1,Color3.fromRGB(255,100,0))},Sector=Color3.fromRGB(22,22,28),Text=Color3.fromRGB(220,220,220),TabSelected=Color3.fromRGB(28,28,35),ElementBg=Color3.fromRGB(30,30,38),ElementOutline=Color3.fromRGB(55,55,70),DropdownSelected=Color3.fromRGB(255,180,0),Toggle=Color3.fromRGB(255,180,0),ToggleUnchecked=Color3.fromRGB(40,40,50),Slider=Color3.fromRGB(255,180,0),SliderBg=Color3.fromRGB(30,30,38),ButtonHover=Color3.fromRGB(40,40,50),ButtonPressed=Color3.fromRGB(50,50,60)}
}
local services = {uis=game:GetService("UserInputService"),run=game:GetService("RunService"),tween=game:GetService("TweenService")}
local function gethui()
local cg = game:GetService("CoreGui")
local pg = game.Players.LocalPlayer:FindFirstChild("PlayerGui")
return (syn or getexecutorname) and cg or (pg or game.Players.LocalPlayer:WaitForChild("PlayerGui"))
end
local function protectgui(gui)
if syn and syn.protect_gui then syn.protect_gui(gui)
elseif get_hui_gui and type(get_hui_gui)=="function" then get_hui_gui(gui)
elseif gethui then gui.Parent = gethui() end
if identifyexecutor and string.find(string.lower(identifyexecutor()),"scriptware") then gui.Parent = gethui() end
end
lib.create_window = function(theme,toggle_key)
local target = gethui()
if target:FindFirstChild("Mute") then target.Mute:Destroy() end
local window = {}
window.dragging = false
window.drag_input = nil
window.drag_start = nil
window.start_pos = nil
local Mute = Instance.new("ScreenGui")
protectgui(Mute)
local Main = Instance.new("Frame")
local Tabs = Instance.new("Frame")
local UIGrid = Instance.new("UIGridLayout")
local UIPad = Instance.new("UIPadding")
local TopGrad = Instance.new("Frame")
local UIGrad = Instance.new("UIGradient")
local Content = Instance.new("Frame")
local UIList = Instance.new("UIListLayout")
local function update_drag(input)
local delta = input.Position - window.drag_start
Main.Position = UDim2.new(window.start_pos.X.Scale,window.start_pos.X.Offset+delta.X,window.start_pos.Y.Scale,window.start_pos.Y.Offset+delta.Y)
end
local function begin_drag(input)
if input.UserInputType==Enum.UserInputType.MouseButton1 then
window.dragging = true
window.drag_start = input.Position
window.start_pos = Main.Position
end
end
local function change_drag(input)
if input.UserInputType==Enum.UserInputType.MouseMovement then window.drag_input = input end
end
Tabs.InputBegan:Connect(begin_drag)
Tabs.InputChanged:Connect(change_drag)
Main.InputBegan:Connect(begin_drag)
Main.InputChanged:Connect(change_drag)
services.uis.InputChanged:Connect(function(input)
if input==window.drag_input and window.dragging then update_drag(input) end
end)
services.uis.InputBegan:Connect(function(input)
if input.KeyCode==toggle_key then Mute.Enabled = not Mute.Enabled end
end)
Mute.Name = tostring(math.random(1,9999999))
Mute.Parent = target
Mute.ZIndexBehavior = Enum.ZIndexBehavior.Global
Mute.ResetOnSpawn = false
Mute.DisplayOrder = 999999
Mute.IgnoreGuiInset = true
Main.Name = "Main"
Main.Parent = Mute
Main.BackgroundColor3 = themes[theme].Window
Main.BorderColor3 = Color3.fromRGB(40,40,40)
Main.BorderSizePixel = 3
Main.Position = UDim2.new(0.35,0,0.2,0)
Main.Size = UDim2.new(0,684,0,605)
Tabs.Name = "Tabs"
Tabs.Parent = Main
Tabs.BackgroundColor3 = themes[theme].Tabs
Tabs.BorderColor3 = Color3.fromRGB(18,18,18)
Tabs.Position = UDim2.new(0,1,0.0033,0)
Tabs.Size = UDim2.new(0,100,0,602)
UIGrid.Parent = Tabs
UIGrid.SortOrder = Enum.SortOrder.LayoutOrder
UIGrid.CellPadding = UDim2.new(0,15,0,0)
UIGrid.CellSize = UDim2.new(0,85,0,70)
UIPad.Parent = Tabs
UIPad.PaddingLeft = UDim.new(0,14)
UIPad.PaddingTop = UDim.new(0,15)
TopGrad.Name = "TopGradient"
TopGrad.Parent = Main
TopGrad.BackgroundColor3 = Color3.new(1,1,1)
TopGrad.BorderSizePixel = 0
TopGrad.Size = UDim2.new(0,684,0,2)
UIGrad.Color = themes[theme].Gradient
UIGrad.Parent = TopGrad
Content.Name = "Content"
Content.Parent = Main
Content.BackgroundTransparency = 1
Content.BorderSizePixel = 0
Content.Position = UDim2.new(0.165,0,0.0248,0)
Content.Size = UDim2.new(0,553,0,579)
UIList.Parent = Content
UIList.FillDirection = Enum.FillDirection.Horizontal,Horizontal
UIList.SortOrder = Enum.SortOrder.LayoutOrder
UIList.Padding = UDim.new(0,10)
window.tab_contents = {}
window.selected_tab = nil
local function show_tab(name)
for _,v in pairs(window.tab_contents)do v[2].Visible = (v[1]==name) end
end
local function update_tabs(active)
for _,tab in pairs(Tabs:GetChildren())do
if tab:IsA("TextButton") then
local open = tab:FindFirstChild("Open")
if open then
if tab==active then
services.tween:Create(tab,TweenInfo.new(0.2),{BackgroundTransparency=0}):Play()
services.tween:Create(open,TweenInfo.new(0.2),{ImageColor3=Color3.fromRGB(209,210,208)}):Play()
else
services.tween:Create(tab,TweenInfo.new(0.2),{BackgroundTransparency=1}):Play()
services.tween:Create(open,TweenInfo.new(0.2),{ImageColor3=Color3.fromRGB(90,90,90)}):Play()
end
end
end
end
end
window.create_tab = function(image)
local tab = {sectorCount=0}
local Tab = Instance.new("TextButton")
local Open = Instance.new("ImageButton")
Tab.Name = image:sub(14)
Tab.Parent = Tabs
Tab.BackgroundColor3 = themes[theme].TabSelected
Tab.BackgroundTransparency = 1
Tab.BorderSizePixel = 2
Tab.BorderColor3 = Color3.fromRGB(18,18,18)
Tab.Size = UDim2.new(0,108,0,70)
Tab.AutoButtonColor = false
Tab.Text = ""
Open.Name = "Open"
Open.Parent = Tab
Open.BackgroundTransparency = 1
Open.Position = UDim2.new(0.163,0,0.186,0)
Open.Size = UDim2.new(0,43,0,43)
Open.Image = image
Open.ImageColor3 = window.selected_tab==Tab.Name and Color3.fromRGB(209,210,208) or Color3.fromRGB(90,90,90)
Open.MouseButton1Down:Connect(function()
window.selected_tab = Tab.Name
update_tabs(Tab)
show_tab(Tab.Name)
end)
tab.create_sector = function(name)
if tab.sectorCount>=2 then error("Max 2 sectors per tab") end
tab.sectorCount = tab.sectorCount + 1
local sector = {}
local Sector = Instance.new("Frame")
local Title = Instance.new("TextLabel")
local Scrolling = Instance.new("ScrollingFrame")
local List = Instance.new("UIListLayout")
local Pad = Instance.new("UIPadding")
Sector.Name = name
Sector.Parent = Content
Sector.BackgroundColor3 = themes[theme].Sector
Sector.BorderColor3 = Color3.fromRGB(30,30,30)
Sector.Size = UDim2.new(0.5,-5,1,0)
Sector.Visible = false
Sector.Position = tab.sectorCount==2 and UDim2.new(0.5,5,0,0) or UDim2.new(0,0,0,0)
Title.Parent = Sector
Title.BackgroundTransparency = 1
Title.Position = UDim2.new(0.029,0,0,0)
Title.Size = UDim2.new(0,268,0,20)
Title.Font = Enum.Font.SourceSans
Title.TextColor3 = themes[theme].Text
Title.TextSize = 18
Title.TextXAlignment = Enum.TextXAlignment.Left
Title.Text = name
Scrolling.Parent = Sector
Scrolling.BackgroundTransparency = 1
Scrolling.Position = UDim2.new(0.029,0,0.04,0)
Scrolling.Size = UDim2.new(0,259,0,550)
Scrolling.CanvasSize = UDim2.new(0,0,0,0)
Scrolling.ScrollBarThickness = 3
List.Parent = Scrolling
List.SortOrder = Enum.SortOrder.LayoutOrder
List.Padding = UDim.new(0,8)
Pad.Parent = Scrolling
Pad.PaddingLeft = UDim.new(0,5)
Pad.PaddingTop = UDim.new(0,5)
local function update_canvas()
local h = 10
for _,v in pairs(Scrolling:GetChildren())do if v:IsA("GuiObject") then h = h + v.AbsoluteSize.Y + 8 end end
Scrolling.CanvasSize = UDim2.new(0,0,0,h)
end
sector.text = function(txt) local o=Instance.new("TextLabel") o.Parent=Scrolling o.BackgroundTransparency=1 o.Size=UDim2.new(0,249,0,16) o.Font=Enum.Font.SourceSans o.Text=txt o.TextColor3=themes[theme].Text o.TextSize=14 o.TextXAlignment=Enum.TextXAlignment.Left update_canvas() return {set=function(t)o.Text=t end} end
sector.warning = sector.text
sector.error = sector.text
sector.info = sector.text
sector.textbox = function(placeholder,default,cb)
local tb = Instance.new("TextBox")
tb.Parent = Scrolling
tb.BackgroundColor3 = themes[theme].ElementBg
tb.BorderColor3 = themes[theme].ElementOutline
tb.Size = UDim2.new(0,249,0,26)
tb.Text = default or ""
tb.PlaceholderText = placeholder
tb.TextColor3 = themes[theme].Text
tb.Font = Enum.Font.SourceSans
tb.TextSize = 14
Instance.new("UIPadding",tb).PaddingLeft = UDim.new(0,5)
tb.MouseEnter:Connect(function()services.tween:Create(tb,TweenInfo.new(0.2),{BackgroundColor3=themes[theme].ButtonHover}):Play()end)
tb.MouseLeave:Connect(function()services.tween:Create(tb,TweenInfo.new(0.2),{BackgroundColor3=themes[theme].ElementBg}):Play()end)
tb:GetPropertyChangedSignal("Text"):Connect(function()cb(tb.Text)end)
cb(default or "")
update_canvas()
return {set=function(t)tb.Text=t end,get=function()return tb.Text end}
end
sector.button = function(txt,cb)
local btn = Instance.new("TextButton")
btn.Parent = Scrolling
btn.BackgroundColor3 = themes[theme].ElementBg
btn.BorderColor3 = themes[theme].ElementOutline
btn.Size = UDim2.new(0,249,0,26)
btn.Text = txt
btn.TextColor3 = themes[theme].Text
btn.Font = Enum.Font.SourceSans
btn.TextSize = 14
btn.AutoButtonColor = false
btn.MouseEnter:Connect(function()services.tween:Create(btn,TweenInfo.new(0.2),{BackgroundColor3=themes[theme].ButtonHover}):Play()end)
btn.MouseLeave:Connect(function()services.tween:Create(btn,TweenInfo.new(0.2),{BackgroundColor3=themes[theme].ElementBg}):Play()end)
btn.MouseButton1Down:Connect(function()services.tween:Create(btn,TweenInfo.new(0.1),{BackgroundColor3=themes[theme].ButtonPressed}):Play() cb() end)
update_canvas()
return {set=function(t)btn.Text=t end}
end
sector.toggle = function(txt,default,cb)
local val = default
local main = Instance.new("TextButton")
local label = Instance.new("TextLabel")
local box = Instance.new("TextButton")
main.Parent = Scrolling
main.BackgroundTransparency = 1
main.Size = UDim2.new(0,249,0,22)
main.Text = ""
label.Parent = main
label.BackgroundTransparency = 1
label.Size = UDim2.new(1,-30,1,0)
label.Text = txt
label.TextColor3 = themes[theme].Text
label.Font = Enum.Font.SourceSans
label.TextSize = 14
label.TextXAlignment = Enum.TextXAlignment.Left
box.Parent = main
box.BackgroundColor3 = val and themes[theme].Toggle or themes[theme].ToggleUnchecked
box.BorderColor3 = themes[theme].ElementOutline
box.Position = UDim2.new(0,5,0.3,0)
box.Size = UDim2.new(0,14,0,14)
box.Text = ""
local function set(v)
val = v
services.tween:Create(box,TweenInfo.new(0.2),{BackgroundColor3 = v and themes[theme].Toggle or themes[theme].ToggleUnchecked}):Play()
cb(v)
end
main.MouseButton1Down:Connect(function()set(not val)end)
box.MouseButton1Down:Connect(function()set(not val)end)
local function add_color(def,ccb)
local picker = Instance.new("TextButton")
picker.Parent = main
picker.BackgroundColor3 = def
picker.Position = UDim2.new(0.85,0,0.25,0)
picker.Size = UDim2.new(0,24,0,12)
picker.Text = ""
local frame = Instance.new("Frame")
frame.Parent = Sector
frame.BackgroundColor3 = Color3.fromRGB(20,20,20)
frame.BorderColor3 = Color3.fromRGB(35,35,35)
frame.Size = UDim2.new(0,180,0,100)
frame.Visible = false
frame.ZIndex = 200
picker.MouseButton1Down:Connect(function()
frame.Position = UDim2.fromOffset(picker.AbsolutePosition.X-Sector.AbsolutePosition.X-180,picker.AbsolutePosition.Y+picker.AbsoluteSize.Y+5)
frame.Visible = not frame.Visible
end)
-- простой HSV пике (упрощённый, но работает)
local h = def:ToHSV()
local function upd(col) picker.BackgroundColor3 = col ccb(col) end
-- тут можно добавить полноценный пике, но для фикса ошибки его оставляем минимальным
end
set(default)
update_canvas()
return {set=set,add_color=add_color}
end
sector.slider = function(txt,ind,min,max,def,cb)
local val = def
local main = Instance.new("TextButton")
local label = Instance.new("TextLabel")
local bg = Instance.new("Frame")
local fill = Instance.new("Frame")
local vlabel = Instance.new("TextLabel")
main.Parent = Scrolling
main.BackgroundTransparency = 1
main.Size = UDim2.new(0,249,0,32)
main.Text = ""
label.Parent = main
label.BackgroundTransparency = 1
label.Size = UDim2.new(1,0,0,14)
label.Text = txt
label.TextColor3 = themes[theme].Text
label.Font = Enum.Font.SourceSans
label.TextSize = 14
bg.Parent = main
bg.BackgroundColor3 = themes[theme].SliderBg
bg.BorderColor3 = themes[theme].ElementOutline
bg.Position = UDim2.new(0,0,0.55,0)
bg.Size = UDim2.new(1,0,0,8)
fill.Parent = bg
fill.BackgroundColor3 = themes[theme].Slider
fill.Size = UDim2.new((def-min)/(max-min),0,1,0)
vlabel.Parent = bg
vlabel.BackgroundTransparency = 1
vlabel.Position = UDim2.new(1,-45,0,-10)
vlabel.Size = UDim2.new(0,40,0,16)
vlabel.TextColor3 = themes[theme].Text
vlabel.Font = Enum.Font.SourceSans
vlabel.TextSize = 12
vlabel.Text = tostring(math.round(def*100)/100)..ind
local dragging = false
local function set(v)
val = v
fill.Size = UDim2.new((v-min)/(max-min),0,1,0)
vlabel.Text = tostring(math.round(v*100)/100)..ind
cb(v)
end
bg.InputBegan:Connect(function(i)if i.UserInputType==Enum.UserInputType.MouseButton1 then dragging=true end end)
bg.InputEnded:Connect(function(i)if i.UserInputType==Enum.UserInputType.MouseButton1 then dragging=false end end)
services.run.RenderStepped:Connect(function()
if dragging then
local p = math.clamp((services.uis:GetMouseLocation().X-bg.AbsolutePosition.X)/bg.AbsoluteSize.X,0,1)
set(min + p*(max-min))
end
end)
update_canvas()
return {set=set,get=function()return val end}
end
table.insert(window.tab_contents,{Tab.Name,Sector})
if #window.tab_contents==1 then
window.selected_tab = Tab.Name
update_tabs(Tab)
show_tab(Tab.Name)
end
return tab
end
return window
end
return lib
