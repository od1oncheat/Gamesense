local lib = {}
local themes = {
["gamesense"] = {Window=Color3.fromRGB(8,8,8),Tabs=Color3.fromRGB(6,6,6),Gradient=ColorSequence.new{ColorSequenceKeypoint.new(0,Color3.fromRGB(61,130,162)),ColorSequenceKeypoint.new(0.5,Color3.fromRGB(156,59,145)),ColorSequenceKeypoint.new(1,Color3.fromRGB(155,161,48))},Sector=Color3.fromRGB(15,15,15),Text=Color3.fromRGB(180,180,180),TabSelected=Color3.fromRGB(10,10,10),ElementBg=Color3.fromRGB(20,20,20),ElementOutline=Color3.fromRGB(35,35,35),DropdownSelected=Color3.fromRGB(135,176,27),Toggle=Color3.fromRGB(135,176,27),ToggleUnchecked=Color3.fromRGB(25,25,25),Slider=Color3.fromRGB(135,176,27),SliderBg=Color3.fromRGB(20,20,20),ButtonHover=Color3.fromRGB(30,30,30),ButtonPressed=Color3.fromRGB(35,35,35)},
["dark"] = {Window=Color3.fromRGB(10,10,10),Tabs=Color3.fromRGB(8,8,8),Gradient=ColorSequence.new{ColorSequenceKeypoint.new(0,Color3.fromRGB(100,50,200)),ColorSequenceKeypoint.new(1,Color3.fromRGB(50,200,150))},Sector=Color3.fromRGB(18,18,18),Text=Color3.fromRGB(220,220,220),TabSelected=Color3.fromRGB(12,12,12),ElementBg=Color3.fromRGB(25,25,25),ElementOutline=Color3.fromRGB(40,40,40),DropdownSelected=Color3.fromRGB(0,170,255),Toggle=Color3.fromRGB(0,170,255),ToggleUnchecked=Color3.fromRGB(30,30,30),Slider=Color3.fromRGB(0,170,255),SliderBg=Color3.fromRGB(25,25,25),ButtonHover=Color3.fromRGB(35,35,35),ButtonPressed=Color3.fromRGB(45,45,45)},
["light"] = {Window=Color3.fromRGB(240,240,240),Tabs=Color3.fromRGB(220,220,220),Gradient=ColorSequence.new{ColorSequenceKeypoint.new(0,Color3.fromRGB(100,150,255)),ColorSequenceKeypoint.new(1,Color3.fromRGB(255,100,150))},Sector=Color3.fromRGB(200,200,200),Text=Color3.fromRGB(30,30,30),TabSelected=Color3.fromRGB(180,180,180),ElementBg=Color3.fromRGB(255,255,255),ElementOutline=Color3.fromRGB(180,180,180),DropdownSelected=Color3.fromRGB(0,120,215),Toggle=Color3.fromRGB(0,120,215),ToggleUnchecked=Color3.fromRGB(220,220,220),Slider=Color3.fromRGB(0,120,215),SliderBg=Color3.fromRGB(240,240,240),ButtonHover=Color3.fromRGB(230,230,230),ButtonPressed=Color3.fromRGB(200,200,200)},
["ocean"] = {Window=Color3.fromRGB(5,20,35),Tabs=Color3.fromRGB(3,15,28),Gradient=ColorSequence.new{ColorSequenceKeypoint.new(0,Color3.fromRGB(0,150,255)),ColorSequenceKeypoint.new(1,Color3.fromRGB(0,255,200))},Sector=Color3.fromRGB(10,30,50),Text=Color3.fromRGB(180,230,255),TabSelected=Color3.fromRGB(8,25,45),ElementBg=Color3.fromRGB(15,40,65),ElementOutline=Color3.fromRGB(30,70,100),DropdownSelected=Color3.fromRGB(0,220,255),Toggle=Color3.fromRGB(0,220,255),ToggleUnchecked=Color3.fromRGB(20,50,70),Slider=Color3.fromRGB(0,220,255),SliderBg=Color3.fromRGB(15,40,65),ButtonHover=Color3.fromRGB(25,60,85),ButtonPressed=Color3.fromRGB(35,80,105)},
["sunset"] = {Window=Color3.fromRGB(30,10,20),Tabs=Color3.fromRGB(25,8,18),Gradient=ColorSequence.new{ColorSequenceKeypoint.new(0,Color3.fromRGB(255,100,50)),ColorSequenceKeypoint.new(1,Color3.fromRGB(255,200,100))},Sector=Color3.fromRGB(45,20,35),Text=Color3.fromRGB(255,200,150),TabSelected=Color3.fromRGB(40,15,30),ElementBg=Color3.fromRGB(60,30,50),ElementOutline=Color3.fromRGB(90,50,70),DropdownSelected=Color3.fromRGB(255,140,0),Toggle=Color3.fromRGB(255,140,0),ToggleUnchecked=Color3.fromRGB(70,40,60),Slider=Color3.fromRGB(255,140,0),SliderBg=Color3.fromRGB(60,30,50),ButtonHover=Color3.fromRGB(80,50,70),ButtonPressed=Color3.fromRGB(100,70,90)},
["matrix"] = {Window=Color3.fromRGB(0,10,0),Tabs=Color3.fromRGB(0,8,0),Gradient=ColorSequence.new{ColorSequenceKeypoint.new(0,Color3.fromRGB(0,255,0)),ColorSequenceKeypoint.new(1,Color3.fromRGB(0,100,0))},Sector=Color3.fromRGB(0,20,0),Text=Color3.fromRGB(0,255,0),TabSelected=Color3.fromRGB(0,15,0),ElementBg=Color3.fromRGB(0,30,0),ElementOutline=Color3.fromRGB(0,80,0),DropdownSelected=Color3.fromRGB(0,255,0),Toggle=Color3.fromRGB(0,255,0),ToggleUnchecked=Color3.fromRGB(0,40,0),Slider=Color3.fromRGB(0,255,0),SliderBg=Color3.fromRGB(0,30,0),ButtonHover=Color3.fromRGB(0,50,0),ButtonPressed=Color3.fromRGB(0,70,0)}
}
local services = {uis=game:GetService("UserInputService"),run=game:GetService("RunService"),tween=game:GetService("TweenService")}
local function gethui()
local core=game:GetService("CoreGui")
if syn or getexecutorname then return core end
return game.Players.LocalPlayer:WaitForChild("PlayerGui")
end
local function protectgui(gui)
if syn and syn.protect_gui then syn.protect_gui(gui) end
gui.Parent = gethui()
end
lib.create_window = function(theme,menu_key)
local target=gethui()
if target:FindFirstChild("Mute") then target.Mute:Destroy() end
local window={}
window.dragging,window.drag_input,window.drag_start,window.start_pos=false,nil,nil,nil
local Mute=Instance.new("ScreenGui")
protectgui(Mute)
Mute.Name="Mute"
Mute.ZIndexBehavior=Enum.ZIndexBehavior.Global
Mute.ResetOnSpawn=false
Mute.DisplayOrder=999999
Mute.IgnoreGuiInset=true
local Main=Instance.new("Frame")
Main.Name="Main"
Main.Parent=Mute
Main.BackgroundColor3=themes[theme].Window
Main.BorderColor3=Color3.fromRGB(40,40,40)
Main.BorderSizePixel=3
Main.Position=UDim2.new(0.38,0,0.25,0)
Main.Size=UDim2.new(0,684,0,605)
local Tabs=Instance.new("Frame")
Tabs.Parent=Main
Tabs.BackgroundColor3=themes[theme].Tabs
Tabs.BorderColor3=Color3.fromRGB(18,18,18)
Tabs.Position=UDim2.new(0,1,0.0033,0)
Tabs.Size=UDim2.new(0,100,0,602)
local UIGridLayout=Instance.new("UIGridLayout")
UIGridLayout.Parent=Tabs
UIGridLayout.CellPadding=UDim2.new(0,15,0,0)
UIGridLayout.CellSize=UDim2.new(0,85,0,70)
local UIPadding=Instance.new("UIPadding")
UIPadding.Parent=Tabs
UIPadding.PaddingLeft=UDim.new(0,14)
UIPadding.PaddingTop=UDim.new(0,15)
local TopGradient=Instance.new("Frame")
TopGradient.Parent=Main
TopGradient.BackgroundColor3=Color3.fromRGB(255,255,255)
TopGradient.Size=UDim2.new(0,684,0,2)
local UIGradient=Instance.new("UIGradient")
UIGradient.Color=themes[theme].Gradient
UIGradient.Parent=TopGradient
local Content=Instance.new("Frame")
Content.Parent=Main
Content.BackgroundTransparency=1
Content.Position=UDim2.new(0.165,0,0.0248,0)
Content.Size=UDim2.new(0,553,0,579)
local UIListLayout=Instance.new("UIListLayout")
UIListLayout.Parent=Content
UIListLayout.FillDirection=Enum.FillDirection.Horizontal
UIListLayout.Padding=UDim.new(0,10)
window.update_window=function(input)
local delta=input.Position-window.drag_start
Main.Position=UDim2.new(window.start_pos.X.Scale,window.start_pos.X.Offset+delta.X,window.start_pos.Y.Scale,window.start_pos.Y.Offset+delta.Y)
end
window.drag_began=function(input)
if input.UserInputType==Enum.UserInputType.MouseButton1 then
window.dragging=true
window.drag_start=input.Position
window.start_pos=Main.Position
end
end
window.drag_changed=function(input)
if input.UserInputType==Enum.UserInputType.MouseMovement then window.drag_input=input end
end
Tabs.InputBegan:Connect(window.drag_began)
Tabs.InputChanged:Connect(window.drag_changed)
Main.InputBegan:Connect(window.drag_began)
Main.InputChanged:Connect(window.drag_changed)
services.uis.InputChanged:Connect(function(input)
if window.dragging and input==window.drag_input then window.update_window(input) end
end)
services.uis.InputBegan:Connect(function(input)
if input.KeyCode==menu_key then Mute.Enabled=not Mute.Enabled end
end)
window.tab_contents={}
window.selected_tab=""
window.show_tab=function(name)
for _,v in pairs(window.tab_contents) do v[2].Visible=v[1]==name end
end
window.tab_active=function(tab)
services.tween:Create(tab,TweenInfo.new(0.2,Enum.EasingStyle.Quad), {BackgroundTransparency=0}):Play()
services.tween:Create(tab.Open,TweenInfo.new(0.2,Enum.EasingStyle.Quad), {ImageColor3=Color3.fromRGB(209,210,208)}):Play()
end
window.tab_inactive=function(tab)
services.tween:Create(tab,TweenInfo.new(0.2,Enum.EasingStyle.Quad), {BackgroundTransparency=1}):Play()
services.tween:Create(tab.Open,TweenInfo.new(0.2,Enum.EasingStyle.Quad), {ImageColor3=Color3.fromRGB(90,90,90)}):Play()
end
window.tab_colors=function(ignore)
for _,tab in pairs(Tabs:GetChildren()) do
if tab:IsA("TextButton") then
if tab.Name~=ignore.Name then window.tab_inactive(tab) else window.tab_active(tab) end
end
end
end
window.create_tab=function(image)
local tab={}
tab.sectorCount=0
local Tab=Instance.new("TextButton")
Tab.Name=image:sub(14)
Tab.Parent=Tabs
Tab.BackgroundColor3=themes[theme].TabSelected
Tab.BackgroundTransparency=1
Tab.BorderSizePixel=2
Tab.BorderColor3=Color3.fromRGB(18,18,18)
Tab.Size=UDim2.new(0,108,0,70)
Tab.AutoButtonColor=false
Tab.Text=""
local Open=Instance.new("ImageButton")
Open.Name="Open"
Open.Parent=Tab
Open.BackgroundTransparency=1
Open.Position=UDim2.new(0.163,0,0.186,0)
Open.Size=UDim2.new(0,43,0,43)
Open.Image=image
Open.ImageColor3=Color3.fromRGB(90,90,90)
Open.MouseButton1Down:Connect(function()
window.selected_tab=Tab.Name
window.tab_colors(Tab)
window.show_tab(Tab.Name)
end)
tab.create_sector=function(name)
if tab.sectorCount>=2 then error("max 2 sectors") end
tab.sectorCount=tab.sectorCount+1
local sector={}
local Sector=Instance.new("Frame")
Sector.Name=name
Sector.Parent=Content
Sector.BackgroundColor3=themes[theme].Sector
Sector.BorderColor3=Color3.fromRGB(30,30,30)
Sector.Size=UDim2.new(0.5,-5,1,0)
Sector.Position=tab.sectorCount==2 and UDim2.new(0.5,5,0,0) or UDim2.new(0,0,0,0)
Sector.Visible=false
Sector.ClipsDescendants=false
local Title=Instance.new("TextLabel")
Title.Parent=Sector
Title.BackgroundTransparency=1
Title.Position=UDim2.new(0.029,0,0,0)
Title.Size=UDim2.new(0,268,0,20)
Title.Font=Enum.Font.SourceSans
Title.TextColor3=themes[theme].Text
Title.TextSize=18
Title.TextXAlignment=Enum.TextXAlignment.Left
Title.Text=name
local SectorContent=Instance.new("ScrollingFrame")
SectorContent.Parent=Sector
SectorContent.BackgroundTransparency=1
SectorContent.Position=UDim2.new(0.029,0,0.04,0)
SectorContent.Size=UDim2.new(0,259,0,540)
SectorContent.CanvasSize=UDim2.new(0,0,0,0)
SectorContent.ScrollBarThickness=3
SectorContent.Active=true
local UIList=Instance.new("UIListLayout")
UIList.Parent=SectorContent
UIList.Padding=UDim.new(0,8)
UIList.SortOrder=Enum.SortOrder.LayoutOrder
local UIPad=Instance.new("UIPadding")
UIPad.Parent=SectorContent
UIPad.PaddingLeft=UDim.new(0,5)
UIPad.PaddingTop=UDim.new(0,5)
sector.increase=function()
local h=0
for _,e in pairs(SectorContent:GetChildren()) do if e:IsA("GuiObject") then h=h+e.AbsoluteSize.Y+8 end end
SectorContent.CanvasSize=UDim2.new(0,0,0,h+10)
end
sector.text=function(t)
local o=Instance.new("TextLabel")
o.Parent=SectorContent
o.BackgroundTransparency=1
o.Size=UDim2.new(0,249,0,16)
o.Text=t
o.TextColor3=themes[theme].Text
o.Font=Enum.Font.SourceSans
o.TextSize=14
o.TextXAlignment=Enum.TextXAlignment.Left
sector.increase()
return {set=function(x) o.Text=x end,delete=function() o:Destroy() sector.increase() end}
end
sector.button=function(txt,cb)
local btn=Instance.new("TextButton")
btn.Parent=SectorContent
btn.BackgroundColor3=themes[theme].ElementBg
btn.BorderColor3=themes[theme].ElementOutline
btn.Size=UDim2.new(0,249,0,24)
btn.Text=txt
btn.TextColor3=themes[theme].Text
btn.Font=Enum.Font.SourceSans
btn.TextSize=14
btn.AutoButtonColor=false
local ti=TweenInfo.new(0.2,Enum.EasingStyle.Quad)
btn.MouseEnter:Connect(function() services.tween:Create(btn,ti,{BackgroundColor3=themes[theme].ButtonHover}):Play() end)
btn.MouseLeave:Connect(function() services.tween:Create(btn,ti,{BackgroundColor3=themes[theme].ElementBg}):Play() end)
btn.MouseButton1Down:Connect(function() services.tween:Create(btn,TweenInfo.new(0.1), {BackgroundColor3=themes[theme].ButtonPressed}):Play() cb() end)
sector.increase()
return {set=function(x) btn.Text=x end,delete=function() btn:Destroy() sector.increase() end}
end
sector.toggle=function(txt,def,cb)
local val=def
local tog=Instance.new("TextButton")
tog.Parent=SectorContent
tog.BackgroundTransparency=1
tog.Size=UDim2.new(0,249,0,20)
tog.Text=""
local label=Instance.new("TextLabel")
label.Parent=tog
label.BackgroundTransparency=1
label.Position=UDim2.new(0.09,0,0,0)
label.Size=UDim2.new(0,226,0,20)
label.Text=txt
label.TextColor3=themes[theme].Text
label.Font=Enum.Font.SourceSans
label.TextSize=14
label.TextXAlignment=Enum.TextXAlignment.Left
local bg=Instance.new("TextButton")
bg.Parent=tog
bg.BackgroundColor3=def and themes[theme].Toggle or themes[theme].ToggleUnchecked
bg.BorderColor3=themes[theme].ElementOutline
bg.Position=UDim2.new(0,5,0.25,0)
bg.Size=UDim2.new(0,12,0,12)
bg.Text=""
local ti=TweenInfo.new(0.2,Enum.EasingStyle.Quad)
local function set(v)
val=v
services.tween:Create(bg,ti,{BackgroundColor3=v and themes[theme].Toggle or themes[theme].ToggleUnchecked}):Play()
cb(v)
end
tog.MouseButton1Down:Connect(function() set(not val) end)
bg.MouseButton1Down:Connect(function() set(not val) end)
sector.increase()
return {set=set,get=function() return val end}
end
sector.slider=function(txt,ind,minv,maxv,def,cb)
local val
local s=Instance.new("TextButton")
s.Parent=SectorContent
s.BackgroundTransparency=1
s.Size=UDim2.new(0,249,0,30)
s.Text=""
local label=Instance.new("TextLabel")
label.Parent=s
label.BackgroundTransparency=1
label.Position=UDim2.new(0.02,0,0,0)
label.Size=UDim2.new(0,200,0,15)
label.Text=txt
label.TextColor3=themes[theme].Text
label.Font=Enum.Font.SourceSans
label.TextSize=14
label.TextXAlignment=Enum.TextXAlignment.Left
local bg=Instance.new("Frame")
bg.Parent=s
bg.BackgroundColor3=themes[theme].SliderBg
bg.BorderColor3=themes[theme].ElementOutline
bg.Position=UDim2.new(0.02,0,0.55,0)
bg.Size=UDim2.new(0,238,0,8)
local fill=Instance.new("Frame")
fill.Parent=bg
fill.BackgroundColor3=themes[theme].Slider
fill.Size=UDim2.new(0.5,0,1,0)
local valuel=Instance.new("TextLabel")
valuel.Parent=bg
valuel.BackgroundTransparency=1
valuel.Position=UDim2.new(0,0,1,2)
valuel.Size=UDim2.new(1,0,0,12)
valuel.TextColor3=themes[theme].Text
valuel.Font=Enum.Font.SourceSans
valuel.TextSize=11
valuel.TextXAlignment=Enum.TextXAlignment.Right
local dragging=false
local ti=TweenInfo.new(0.2,Enum.EasingStyle.Quad)
local function set(v)
v=math.clamp(v,0,1)
fill.Size=UDim2.new(v,0,1,0)
val= minv + v*(maxv-minv)
valuel.Text=math.round(val*100)/100 ..ind
cb(val)
end
bg.InputBegan:Connect(function(i) if i.UserInputType==Enum.UserInputType.MouseButton1 then dragging=true end end)
bg.InputEnded:Connect(function(i) if i.UserInputType==Enum.UserInputType.MouseButton1 then dragging=false end end)
fill.InputBegan:Connect(function(i) if i.UserInputType==Enum.UserInputType.MouseButton1 then dragging=true end end)
services.run.RenderStepped:Connect(function()
if dragging then
local mp=services.uis:GetMouseLocation().X
local ap=bg.AbsolutePosition.X
local as=bg.AbsoluteSize.X
set(math.clamp((mp-ap)/as,0,1))
end
end)
set((def-minv)/(maxv-minv))
sector.increase()
return {set=function(v) set((v-minv)/(maxv-minv)) end,get=function() return val end}
end
table.insert(window.tab_contents,{Tab.Name,Sector})
return sector
end
return tab
end
return window
end
return lib
