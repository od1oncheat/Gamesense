local lib = {}
local themes = {
["gamesense"] = {Window=Color3.fromRGB(8,8,8),Tabs=Color3.fromRGB(6,6,6),Gradient=ColorSequence.new{ColorSequenceKeypoint.new(0,Color3.fromRGB(61,130,162)),ColorSequenceKeypoint.new(0.5,Color3.fromRGB(156,59,145)),ColorSequenceKeypoint.new(1,Color3.fromRGB(155,161,48))},Sector=Color3.fromRGB(15,15,15),Text=Color3.fromRGB(180,180,180),TabSelected=Color3.fromRGB(10,10,10),ElementBg=Color3.fromRGB(20,20,20),ElementOutline=Color3.fromRGB(35,35,35),DropdownSelected=Color3.fromRGB(135,176,27),Toggle=Color3.fromRGB(135,176,27),ToggleUnchecked=Color3.fromRGB(25,25,25),Slider=Color3.fromRGB(135,176,27),SliderBg=Color3.fromRGB(20,20,20),ButtonHover=Color3.fromRGB(30,30,30),ButtonPressed=Color3.fromRGB(35,35,35)},
["dark"] = {Window=Color3.fromRGB(10,10,10),Tabs=Color3.fromRGB(8,8,8),Gradient=ColorSequence.new{ColorSequenceKeypoint.new(0,Color3.fromRGB(30,30,30)),ColorSequenceKeypoint.new(1,Color3.fromRGB(60,60,60))},Sector=Color3.fromRGB(18,18,18),Text=Color3.fromRGB(220,220,220),TabSelected=Color3.fromRGB(15,15,15),ElementBg=Color3.fromRGB(25,25,25),ElementOutline=Color3.fromRGB(40,40,40),DropdownSelected=Color3.fromRGB(80,180,255),Toggle=Color3.fromRGB(80,180,255),ToggleUnchecked=Color3.fromRGB(30,30,30),Slider=Color3.fromRGB(80,180,255),SliderBg=Color3.fromRGB(25,25,25),ButtonHover=Color3.fromRGB(35,35,35),ButtonPressed=Color3.fromRGB(45,45,45)},
["light"] = {Window=Color3.fromRGB(240,240,240),Tabs=Color3.fromRGB(220,220,220),Gradient=ColorSequence.new{ColorSequenceKeypoint.new(0,Color3.fromRGB(100,180,255)),ColorSequenceKeypoint.new(1,Color3.fromRGB(255,100,180))},Sector=Color3.fromRGB(230,230,230),Text=Color3.fromRGB(40,40,40),TabSelected=Color3.fromRGB(210,210,210),ElementBg=Color3.fromRGB(245,245,245),ElementOutline=Color3.fromRGB(200,200,200),DropdownSelected=Color3.fromRGB(0,120,215),Toggle=Color3.fromRGB(0,120,215),ToggleUnchecked=Color3.fromRGB(220,220,220),Slider=Color3.fromRGB(0,120,215),SliderBg=Color3.fromRGB(240,240,240),ButtonHover=Color3.fromRGB(230,230,230),ButtonPressed=Color3.fromRGB(210,210,210)},
["purple"] = {Window=Color3.fromRGB(15,10,20),Tabs=Color3.fromRGB(12,8,16),Gradient=ColorSequence.new{ColorSequenceKeypoint.new(0,Color3.fromRGB(130,60,180)),ColorSequenceKeypoint.new(1,Color3.fromRGB(200,80,255))},Sector=Color3.fromRGB(22,18,28),Text=Color3.fromRGB(220,200,255),TabSelected=Color3.fromRGB(30,20,40),ElementBg=Color3.fromRGB(35,25,50),ElementOutline=Color3.fromRGB(60,40,80),DropdownSelected=Color3.fromRGB(180,80,255),Toggle=Color3.fromRGB(180,80,255),ToggleUnchecked=Color3.fromRGB(40,30,55),Slider=Color3.fromRGB(180,80,255),SliderBg=Color3.fromRGB(35,25,50),ButtonHover=Color3.fromRGB(50,35,70),ButtonPressed=Color3.fromRGB(70,50,90)},
["ocean"] = {Window=Color3.fromRGB(5,15,25),Tabs=Color3.fromRGB(3,12,22),Gradient=ColorSequence.new{ColorSequenceKeypoint.new(0,Color3.fromRGB(0,150,200)),ColorSequenceKeypoint.new(1,Color3.fromRGB(0,220,255))},Sector=Color3.fromRGB(10,25,40),Text=Color3.fromRGB(180,240,255),TabSelected=Color3.fromRGB(15,35,55),ElementBg=Color3.fromRGB(20,40,60),ElementOutline=Color3.fromRGB(40,70,100),DropdownSelected=Color3.fromRGB(0,200,255),Toggle=Color3.fromRGB(0,200,255),ToggleUnchecked=Color3.fromRGB(25,45,65),Slider=Color3.fromRGB(0,200,255),SliderBg=Color3.fromRGB(20,40,60),ButtonHover=Color3.fromRGB(30,60,90),ButtonPressed=Color3.fromRGB(40,80,110)},
["blood"] = {Window=Color3.fromRGB(20,5,5),Tabs=Color3.fromRGB(18,3,3),Gradient=ColorSequence.new{ColorSequenceKeypoint.new(0,Color3.fromRGB(180,20,20)),ColorSequenceKeypoint.new(1,Color3.fromRGB(255,60,60))},Sector=Color3.fromRGB(30,10,10),Text=Color3.fromRGB(255,180,180),TabSelected=Color3.fromRGB(40,15,15),ElementBg=Color3.fromRGB(45,15,15),ElementOutline=Color3.fromRGB(80,30,30),DropdownSelected=Color3.fromRGB(255,80,80),Toggle=Color3.fromRGB(255,80,80),ToggleUnchecked=Color3.fromRGB(50,20,20),Slider=Color3.fromRGB(255,80,80),SliderBg=Color3.fromRGB(45,15,15),ButtonHover=Color3.fromRGB(70,25,25),ButtonPressed=Color3.fromRGB(90,35,35)}
}
local services={uis=game:GetService("UserInputService"),run=game:GetService("RunService"),tween=game:GetService("TweenService")}
local function gethui()local c=game:GetService("CoreGui")local p=game.Players.LocalPlayer:FindFirstChild("PlayerGui")if c and (syn or getexecutorname)then return c else return p or game.Players.LocalPlayer:WaitForChild("PlayerGui")end end
local function protectgui(g)if syn and syn.protect_gui then syn.protect_gui(g)elseif get_hui_gui then get_hui_gui(g)elseif gethui then g.Parent=gethui()end end
lib.create_window=function(theme,menu_key)
local target=gethui()if target:FindFirstChild("Mute")then target:FindFirstChild("Mute"):Destroy()end
local window={}
window.dragging=false window.drag_input=nil window.drag_start=nil window.start_pos=nil
local Mute=Instance.new("ScreenGui")protectgui(Mute)
local Main=Instance.new("Frame")
local Tabs=Instance.new("Frame")
local UIGrid=Instance.new("UIGridLayout")
local UIPad=Instance.new("UIPadding")
local TopGrad=Instance.new("Frame")
local Grad=Instance.new("UIGradient")
local Content=Instance.new("Frame")
Mute.Name="Mute"Mute.Parent=target Mute.ZIndexBehavior=Enum.ZIndexBehavior.Global Mute.ResetOnSpawn=false Mute.DisplayOrder=999999 Mute.IgnoreGuiInset=true
Main.Parent=Mute Main.BackgroundColor3=themes[theme].Window Main.BorderSizePixel=3 Main.BorderColor3=Color3.fromRGB(40,40,40) Main.Position=UDim2.new(0.38,0,0.25,0) Main.Size=UDim2.new(0,684,0,605)
Tabs.Parent=Main Tabs.BackgroundColor3=themes[theme].Tabs Tabs.BorderColor3=Color3.fromRGB(18,18,18) Tabs.Position=UDim2.new(0,1,0.003,0) Tabs.Size=UDim2.new(0,100,0,602)
UIGrid.Parent=Tabs UIGrid.CellPadding=UDim2.new(0,15,0,0) UIGrid.CellSize=UDim2.new(0,85,0,70) UIGrid.SortOrder=Enum.SortOrder.LayoutOrder
UIPad.Parent=Tabs UIPad.PaddingLeft=UDim.new(0,14) UIPad.PaddingTop=UDim.new(0,15)
TopGrad.Parent=Main TopGrad.BackgroundColor3=Color3.new(1,1,1) TopGrad.Size=UDim2.new(1,0,0,2)
Grad.Color=themes[theme].Gradient Grad.Parent=TopGrad
Content.Parent=Main Content.BackgroundTransparency=1 Content.Position=UDim2.new(0.165,0,0.025,0) Content.Size=UDim2.new(0,553,0,579)
local function drag(input)
if input.UserInputType==Enum.UserInputType.MouseButton1 then
window.dragging=true window.drag_start=input.Position window.start_pos=Main.Position
local c;c=services.uis.InputChanged:Connect(function(i)if i==window.drag_input and window.dragging then local d=i.Position-window.drag_start Main.Position=UDim2.new(window.start_pos.X.Scale,window.start_pos.X.Offset+d.X,window.start_pos.Y.Scale,window.start_pos.Y.Offset+d.Y)end end)
input.Changed:Connect(function()if input.UserInputState==Enum.UserInputState.End then window.dragging=false if c then c:Disconnect()end end end)
end
if input.UserInputType==Enum.UserInputType.MouseMovement then window.drag_input=input end
end
Tabs.InputBegan:Connect(drag)Tabs.InputChanged:Connect(drag)Main.InputBegan:Connect(drag)Main.InputChanged:Connect(drag)
services.uis.InputBegan:Connect(function(i)if i.KeyCode==menu_key then Mute.Enabled=not Mute.Enabled end end)
window.tab_contents={} window.selected_tab=""
window.show_tab=function(name)for _,v in window.tab_contents do if v[1]==name then v[2].Visible=true else v[2].Visible=false end end end
window.create_tab=function(img)
local tab={}tab.sectorCount=0
local Tab=Instance.new("TextButton")local Open=Instance.new("ImageButton")
Tab.Name=img:sub(14)Tab.Parent=Tabs Tab.BackgroundTransparency=1 Tab.BackgroundColor3=themes[theme].TabSelected Tab.Size=UDim2.new(0,108,0,70) Tab.Text="" Tab.AutoButtonColor=false
Open.Parent=Tab Open.BackgroundTransparency=1 Open.Position=UDim2.new(0.163,0,0.186,0) Open.Size=UDim2.new(0,43,0,43) Open.Image=img Open.ImageColor3=Color3.fromRGB(90,90,90)
Open.MouseButton1Down:Connect(function()window.selected_tab=Tab.Name for _,t in Tabs:GetChildren()do if t:IsA("TextButton")then t.BackgroundTransparency=t==Tab and 0 or 1 t.Open.ImageColor3=t==Tab and Color3.fromRGB(209,210,208)or Color3.fromRGB(90,90,90)end end window.show_tab(Tab.Name)end)
tab.create_sector=function(name)
if tab.sectorCount>=2 then error("max 2 sectors")return end
tab.sectorCount=tab.sectorCount+1
local sector={}
local Sector=Instance.new("Frame")
local Title=Instance.new("TextLabel")
local Scroll=Instance.new("ScrollingFrame")
local List=Instance.new("UIListLayout")
local Pad=Instance.new("UIPadding")
Sector.Name=name Sector.Parent=Content Sector.BackgroundColor3=themes[theme].Sector Sector.BorderColor3=Color3.fromRGB(30,30,30) Sector.Size=UDim2.new(0.5,-5,1,0) Sector.Position=tab.sectorCount==2 and UDim2.new(0.5,5,0,0)or UDim2.new(0,0,0,0) Sector.Visible=false Sector.ClipsDescendants=false
Title.Parent=Sector Title.BackgroundTransparency=1 Title.Position=UDim2.new(0.03,0,0,5) Title.Size=UDim2.new(1,-10,0,20) Title.Text=name Title.TextColor3=themes[theme].Text Title.Font=Enum.Font.SourceSans Title.TextSize=18 Title.TextXAlignment=Enum.TextXAlignment.Left
Scroll.Parent=Sector Scroll.BackgroundTransparency=1 Scroll.Position=UDim2.new(0,0,0,30) Scroll.Size=UDim2.new(1,0,1,-30) Scroll.CanvasSize=UDim2.new(0,0,0,0) Scroll.ScrollBarThickness=3 Scroll.ClipsDescendants=true
List.Parent=Scroll List.Padding=UDim.new(0,6) List.SortOrder=Enum.SortOrder.LayoutOrder
Pad.Parent=Scroll Pad.PaddingLeft=UDim.new(0,8) Pad.PaddingTop=UDim.new(0,4)
local function update()local h=0 for _,v in Scroll:GetChildren()do if v:IsA("GuiObject")then h=h+v.AbsoluteSize.Y+6 end end Scroll.CanvasSize=UDim2.new(0,0,0,h+10)end
sector.text=function(t)local obj=Instance.new("TextLabel")obj.Parent=Scroll obj.BackgroundTransparency=1 obj.Size=UDim2.new(1,-16,0,18) obj.Text=t obj.TextColor3=themes[theme].Text obj.TextSize=14 obj.TextXAlignment="Left" update()return{set=function(x)obj.Text=x end,delete=function()obj:Destroy()update()end}end
sector.button=function(txt,cb)local btn=Instance.new("TextButton")btn.Parent=Scroll btn.Size=UDim2.new(1,-16,0,26) btn.BackgroundColor3=themes[theme].ElementBg btn.BorderColor3=themes[theme].ElementOutline btn.Text=txt btn.TextColor3=themes[theme].Text btn.TextSize=14 btn.AutoButtonColor=false
btn.MouseEnter:Connect(function()services.tween:Create(btn,TweenInfo.new(0.2),{BackgroundColor3=themes[theme].ButtonHover}):Play()end)
btn.MouseLeave:Connect(function()services.tween:Create(btn,TweenInfo.new(0.2),{BackgroundColor3=themes[theme].ElementBg}):Play()end)
btn.MouseButton1Down:Connect(function()services.tween:Create(btn,TweenInfo.new(0.1),{BackgroundColor3=themes[theme].ButtonPressed}):Play()cb()end)
update()return{set=function(t)btn.Text=t end,delete=function()btn:Destroy()update()end}end
sector.textbox=function(ph,default,cb)local tb=Instance.new("TextBox")tb.Parent=Scroll tb.Size=UDim2.new(1,-16,0,26) tb.BackgroundColor3=themes[theme].ElementBg tb.BorderColor3=themes[theme].ElementOutline tb.PlaceholderText=ph tb.Text=default or"" tb.TextColor3=themes[theme].Text tb.TextSize=14 local pad=Instance.new("UIPadding",tb)pad.PaddingLeft=UDim.new(0,5)
tb.FocusLost:Connect(function()cb(tb.Text)end)cb(default or"")
tb.MouseEnter:Connect(function()services.tween:Create(tb,TweenInfo.new(0.2),{BackgroundColor3=themes[theme].ButtonHover}):Play()end)
tb.MouseLeave:Connect(function()services.tween:Create(tb,TweenInfo.new(0.2),{BackgroundColor3=themes[theme].ElementBg}):Play()end)
update()return{set=function(t)tb.Text=t end,get=function()return tb.Text end,delete=function()tb:Destroy()update()end}end
sector.toggle=function(txt,default,cb)local val=default or false
local frame=Instance.new("TextButton")frame.Parent=Scroll frame.BackgroundTransparency=1 frame.Size=UDim2.new(1,-16,0,26) frame.Text=""
local label=Instance.new("TextLabel",frame)label.BackgroundTransparency=1 label.Size=UDim2.new(1,-40,1,0) label.Position=UDim2.new(0,30,0,0) label.Text=txt label.TextColor3=themes[theme].Text label.TextSize=14 label.TextXAlignment="Left"
local check=Instance.new("Frame",frame)check.BackgroundColor3=val and themes[theme].Toggle or themes[theme].ToggleUnchecked check.BorderColor3=themes[theme].ElementOutline check.Position=UDim2.new(0,5,0.5,-6) check.Size=UDim2.new(0,12,0,12)
frame.MouseButton1Down:Connect(function()val=not val services.tween:Create(check,TweenInfo.new(0.2),{BackgroundColor3=val and themes[theme].Toggle or themes[theme].ToggleUnchecked}):Play()cb(val)end)
update()return{set=function(v)val=v services.tween:Create(check,TweenInfo.new(0.2),{BackgroundColor3=v and themes[theme].Toggle or themes[theme].ToggleUnchecked}):Play()cb(v)end,get=function()return val end}end
sector.slider=function(txt,min,max,default,cb,ind)ind=ind or""
local val=default or min
local frame=Instance.new("Frame")frame.Parent=Scroll frame.BackgroundTransparency=1 frame.Size=UDim2.new(1,-16,0,40)
local label=Instance.new("TextLabel",frame)label.BackgroundTransparency=1 label.Size=UDim2.new(1,0,0,16) label.Text=txt label.TextColor3=themes[theme].Text label.TextSize=14 label.TextXAlignment="Left"
local bar=Instance.new("Frame",frame)bar.BackgroundColor3=themes[theme].SliderBg bar.BorderColor3=themes[theme].ElementOutline bar.Position=UDim2.new(0,0,0,20) bar.Size=UDim2.new(1,0,0,8)
local fill=Instance.new("Frame",bar)fill.BackgroundColor3=themes[theme].Slider fill.Size=UDim2.new((val-min)/(max-min),0,1,0)
local valtxt=Instance.new("TextLabel",bar)valtxt.BackgroundTransparency=1 valtxt.Position=UDim2.new(1,-45,0,-2) valtxt.Size=UDim2.new(0,40,0,12) valtxt.TextColor3=themes[theme].Text valtxt.TextSize=12 valtxt.Text=tostring(math.round(val*100)/100)..ind
local dragging=false
local function upd(v)val=v fill.Size=UDim2.new((v-min)/(max-min),0,1,0) valtxt.Text=tostring(math.round(v*100)/100)..ind cb(v)end
bar.InputBegan:Connect(function(i)if i.UserInputType==Enum.UserInputType.MouseButton1 then dragging=true end end)
bar.InputEnded:Connect(function(i)if i.UserInputType==Enum.UserInputType.MouseButton1 then dragging=false end end)
fill.InputBegan:Connect(function(i)if i.UserInputType==Enum.UserInputType.MouseButton1 then dragging=true end end)
services.run.RenderStepped:Connect(function()if dragging then local m=services.uis:GetMouseLocation() local p=math.clamp((m.X-bar.AbsolutePosition.X)/bar.AbsoluteSize.X,0,1) upd(min+p*(max-min))end end)
upd(val)
update()
return{set=function(v)upd(math.clamp(v,min,max))end,get=function()return val end}
end
table.insert(window.tab_contents,{Tab.Name,Sector})
return sector
end
return tab
end
return window
end
return lib
