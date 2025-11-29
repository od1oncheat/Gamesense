local lib = {}
local themes = {
["gamesense"] = {
["Window"] = Color3.fromRGB(8,8,8),
["Tabs"] = Color3.fromRGB(6,6,6),
["Gradient"] = ColorSequence.new{ColorSequenceKeypoint.new(0,Color3.fromRGB(61,130,162)),ColorSequenceKeypoint.new(0.5,Color3.fromRGB(156,59,145)),ColorSequenceKeypoint.new(1,Color3.fromRGB(155,161,48))},
["Sector"] = Color3.fromRGB(15,15,15),
["Text"] = Color3.fromRGB(180,180,180),
["TabSelected"] = Color3.fromRGB(10,10,10),
["ElementBg"] = Color3.fromRGB(20,20,20),
["ElementOutline"] = Color3.fromRGB(35,35,35),
["DropdownSelected"] = Color3.fromRGB(135,176,27),
["Toggle"] = Color3.fromRGB(135,176,27),
["ToggleUnchecked"] = Color3.fromRGB(25,25,25),
["Slider"] = Color3.fromRGB(135,176,27),
["SliderBg"] = Color3.fromRGB(20,20,20),
["ButtonHover"] = Color3.fromRGB(30,30,30),
["ButtonPressed"] = Color3.fromRGB(35,35,35)
}
}
local svc = {uis=game:GetService("UserInputService"),run=game:GetService("RunService"),tween=game:GetService("TweenService")}

local function gethui()
    local cg = game:GetService("CoreGui")
    local pg = game.Players.LocalPlayer:FindFirstChild("PlayerGui")
    if cg and (syn or getexecutorname) then return cg end
    return pg or game.Players.LocalPlayer:WaitForChild("PlayerGui")
end

local function protectgui(g)
    if syn and syn.protect_gui then syn.protect_gui(g)
    elseif get_hui_gui and type(get_hui_gui)=="function" then get_hui_gui(g)
    elseif gethui then g.Parent = gethui() end
    if identifyexecutor and string.find(string.lower(identifyexecutor()),"scriptware") then g.Parent = gethui() end
end

lib.create_window = function(theme,menu_key)
    local par = gethui()
    if par:FindFirstChild("Mute") then par.Mute:Destroy() end

    local win = {}
    win.dragging,win.drag_input,win.drag_start,win.start_pos = false,nil,nil,nil

    local scr = Instance.new("ScreenGui")
    protectgui(scr)
    scr.Name,scr.ZIndexBehavior,scr.ResetOnSpawn,scr.DisplayOrder,scr.IgnoreGuiInset = "Mute",Enum.ZIndexBehavior.Global,false,999999,true

    local main = Instance.new("Frame")
    local tabs = Instance.new("Frame")
    local tabgrid = Instance.new("UIGridLayout")
    local tabpad = Instance.new("UIPadding")
    local topgrad = Instance.new("Frame")
    local tg = Instance.new("UIGradient")
    local tgo = Instance.new("Frame")
    local cont = Instance.new("Frame")
    local contlist = Instance.new("UIListLayout")

    local wm = Instance.new("Frame")
    local wmg = Instance.new("Frame")
    local wmgd = Instance.new("UIGradient")
    local wmt = Instance.new("TextLabel")
    local wmp = Instance.new("ImageLabel")
    local wmo = Instance.new("Frame")

    local fps = 0
    svc.run.RenderStepped:Connect(function(d) fps = fps*0.9 + d*0.1 end)
    task.spawn(function()
        while task.wait(0.5) do
            wmt.Text = "gamesense | "..math.floor(1/fps+0.5).." fps"
        end
    end)

    wm.Name = "Watermark" wm.Parent = scr wm.BackgroundColor3 = Color3.fromRGB(62,62,62) wm.Position = UDim2.new(1,-200,0,15) wm.Size = UDim2.new(0,150,0,24)
    wmp.Parent = wm wmp.BackgroundTransparency = 1 wmp.Position = UDim2.new(0,4,0,4) wmp.Size = UDim2.new(1,-8,1,-8) wmp.TileSize = UDim2.new(0,4,0,4) wmp.Image = "rbxassetid://0" wmp.ImageColor3 = Color3.new(1,1,1) wmp.ScaleType = Enum.ScaleType.Tile
    wmg.Parent = wm wmg.Position = UDim2.new(0,5,0,4) wmg.Size = UDim2.new(1,-10,0,1) wmg.BackgroundColor3 = Color3.new(1,1,1)
    wmgd.Color = themes[theme].Gradient wmgd.Parent = wmg
    wmo.Parent = wmg wmo.Position = UDim2.new(0,-1,0,-1) wmo.Size = UDim2.new(1,2,0,3) wmo.BackgroundColor3 = Color3.new(0,0,0)
    wmt.Parent = wm wmt.BackgroundTransparency = 1 wmt.Position = UDim2.new(0,8,0,5) wmt.Size = UDim2.new(1,0,1,0) wmt.Font = Enum.Font.SourceSans wmt.TextColor3 = Color3.new(1,1,1) wmt.TextSize = 14 wmt.TextXAlignment = Enum.TextXAlignment.Left

    local function drag_begin(i)
        if i.UserInputType ~= Enum.UserInputType.MouseButton1 and i.UserInputType ~= Enum.UserInputType.Touch then return end
        win.dragging = true win.drag_start = i.Position win.start_pos = main.Position
        i.Changed:Connect(function() if i.UserInputState == Enum.UserInputState.End then win.dragging = false end end)
    end
    local function drag_change(i)
        if i.UserInputType == Enum.UserInputType.MouseMovement or i.UserInputType == Enum.UserInputType.Touch then win.drag_input = i end
    end
    local function drag_update(i)
        if not win.dragging then return end
        local d = i.Position - win.drag_start
        main.Position = UDim2.new(win.start_pos.X.Scale,win.start_pos.X.Offset+d.X,win.start_pos.Y.Scale,win.start_pos.Y.Offset+d.Y)
    end

    tabs.InputBegan:Connect(drag_begin) tabs.InputChanged:Connect(drag_change)
    main.InputBegan:Connect(drag_begin) main.InputChanged:Connect(drag_change)
    svc.uis.InputChanged:Connect(drag_update)

    svc.uis.InputBegan:Connect(function(i)
        if i.KeyCode == menu_key then scr.Enabled = not scr.Enabled end
    end)

    math.randomseed(os.time())
    scr.Name = tostring(math.random(1e6,1e7-1))
    scr.Parent = par

    main.Name = "Main" main.Parent = scr main.BackgroundColor3 = themes[theme].Window main.Position = UDim2.new(0.38,0,0.25,0) main.Size = UDim2.new(0,684,0,605) main.BorderSizePixel = 0

    tabs.Name = "Tabs" tabs.Parent = main tabs.BackgroundColor3 = themes[theme].Tabs tabs.Position = UDim2.new(0,0,0,0) tabs.Size = UDim2.new(0,102,0,602)
    tabgrid.Parent = tabs tabgrid.CellSize = UDim2.new(0,85,0,70) tabgrid.CellPadding = UDim2.new(0,15,0,0) tabgrid.SortOrder = Enum.SortOrder.LayoutOrder
    tabpad.Parent = tabs tabpad.PaddingLeft = UDim.new(0,13) tabpad.PaddingTop = UDim.new(0,15)

    topgrad.Parent = main topgrad.Size = UDim2.new(0,684,0,2) topgrad.BackgroundColor3 = Color3.new(1,1,1)
    tg.Color = themes[theme].Gradient tg.Parent = topgrad
    tgo.Parent = topgrad tgo.Position = UDim2.new(0,-1,0,-1) tgo.Size = UDim2.new(1,2,1,2) tgo.BackgroundColor3 = Color3.new(0,0,0)

    cont.Name = "Content" cont.Parent = main cont.BackgroundTransparency = 1 cont.Position = UDim2.new(0.165,0,0.0248,0) cont.Size = UDim2.new(0,553,0,579)
    contlist.Parent = cont contlist.FillDirection = Enum.FillDirection.Horizontal contlist.Padding = UDim.new(0,10) contlist.SortOrder = Enum.SortOrder.LayoutOrder

    win.tab_contents = {}
    win.selected_tab = ""

    win.show_tab = function(name)
        for _,v in win.tab_contents do v[2].Visible = v[1]==name end
    end

    win.create_tab = function(img)
        local tab = {}
        tab.sectors = 0

        local btn = Instance.new("TextButton")
        local open = Instance.new("ImageButton")
        btn.Name = img:sub(14) btn.Parent = tabs btn.BackgroundTransparency = 1 btn.Size = UDim2.new(0,108,0,70) btn.Text = "" btn.AutoButtonColor = false
        open.Parent = btn open.BackgroundTransparency = 1 open.Position = UDim2.new(0.163,0,0.186,0) open.Size = UDim2.new(0,43,0,43) open.Image = img open.ImageColor3 = Color3.fromRGB(90,90,90)

        open.MouseButton1Click:Connect(function()
            win.selected_tab = btn.Name
            for _,t in tabs:GetChildren() do
                if t:IsA("TextButton") then
                    svc.tween:Create(t,TweenInfo.new(0.2),{BackgroundTransparency = t==btn and 0 or 1}):Play()
                    svc.tween:Create(t.Open,TweenInfo.new(0.2),{ImageColor3 = t==btn and Color3.fromRGB(209,210,208) or Color3.fromRGB(90,90,90)}):Play()
                end
            end
            win.show_tab(btn.Name)
        end)

        tab.create_sector = function(name)
            if tab.sectors >= 2 then error("max 2 sectors") end
            tab.sectors += 1

            local sec = Instance.new("Frame")
            local title = Instance.new("TextLabel")
            local scroll = Instance.new("ScrollingFrame")
            local slist = Instance.new("UIListLayout")
            local spad = Instance.new("UIPadding")

            sec.Name = name sec.Parent = cont sec.BackgroundColor3 = themes[theme].Sector sec.Size = UDim2.new(0.5,-5,1,0) sec.Visible = false sec.ClipsDescendants = false
            if tab.sectors == 2 then sec.Position = UDim2.new(0.5,5,0,0) end

            title.Parent = sec title.BackgroundTransparency = 1 title.Position = UDim2.new(0.03,0,0,0) title.Size = UDim2.new(0,268,0,20) title.Font = Enum.Font.SourceSans title.TextColor3 = themes[theme].Text title.TextSize = 18 title.TextXAlignment = Enum.TextXAlignment.Left title.Text = name

            scroll.Parent = sec scroll.BackgroundTransparency = 1 scroll.Position = UDim2.new(0,0,0,25) scroll.Size = UDim2.new(1,0,1,-25) scroll.CanvasSize = UDim2.new(0,0,0,0) scroll.ScrollBarThickness = 3 scroll.ClipsDescendants = true scroll.Active = true
            slist.Parent = scroll slist.Padding = UDim.new(0,8) slist.SortOrder = Enum.SortOrder.LayoutOrder
            spad.Parent = scroll spad.PaddingLeft = UDim.new(0,10) spad.PaddingTop = UDim.new(0,8)

            local function upd()
                local h = 0
                for _,c in scroll:GetChildren() do if c:IsA("GuiObject") then h += c.AbsoluteSize.Y + 8 end end
                scroll.CanvasSize = UDim2.new(0,0,0,h+16)
            end

            local sector = {}

            sector.text = function(txt)
                local l = Instance.new("TextLabel")
                l.Parent = scroll l.BackgroundTransparency = 1 l.Size = UDim2.new(1,-20,0,13) l.Font = Enum.Font.SourceSans l.TextColor3 = themes[theme].Text l.TextSize = 14 l.TextXAlignment = Enum.TextXAlignment.Left l.Text = txt
                upd() return {set=function(t) l.Text=t end,delete=function() l:Destroy() upd() end}
            end

            sector.warning = function(txt)
                local l = sector.text(txt) l.TextColor3 = Color3.fromRGB(142,127,74) return l
            end
            sector.error = function(txt)
                local l = sector.text(txt) l.TextColor3 = Color3.fromRGB(142,74,65) return l
            end
            sector.info = function(txt)
                local l = sector.text(txt) l.TextColor3 = Color3.fromRGB(63,110,152) return l
            end

            sector.textbox = function(ph,default,cb)
                local box = Instance.new("TextBox")
                local pad = Instance.new("UIPadding")
                box.Parent = scroll box.BackgroundColor3 = themes[theme].ElementBg box.BorderColor3 = themes[theme].ElementOutline box.Size = UDim2.new(1,-20,0,21) box.ClearTextOnFocus = false box.Font = Enum.Font.SourceSans box.PlaceholderText = ph box.Text = default or "" box.TextColor3 = themes[theme].Text box.TextSize = 14 box.TextXAlignment = Enum.TextXAlignment.Left
                pad.Parent = box pad.PaddingLeft = UDim.new(0,5)

                local ti = TweenInfo.new(0.2)
                box.MouseEnter:Connect(function() svc.tween:Create(box,ti,{BackgroundColor3=themes[theme].ButtonHover}):Play() end)
                box.MouseLeave:Connect(function() svc.tween:Create(box,ti,{BackgroundColor3=themes[theme].ElementBg}):Play() end)
                box:GetPropertyChangedSignal("Text"):Connect(function() cb(box.Text) end)
                cb(default or "")
                upd()
                return {set=function(t) box.Text=t end,get=function() return box.Text end,delete=function() box:Destroy() upd() end}
            end

            sector.button = function(txt,cb)
                local btn = Instance.new("TextButton")
                btn.Parent = scroll btn.BackgroundColor3 = themes[theme].ElementBg btn.BorderColor3 = themes[theme].ElementOutline btn.Size = UDim2.new(1,-20,0,21) btn.AutoButtonColor = false btn.Font = Enum.Font.SourceSans btn.TextColor3 = themes[theme].Text btn.TextSize = 14 btn.Text = txt

                local ti = TweenInfo.new(0.2)
                btn.MouseEnter:Connect(function() svc.tween:Create(btn,ti,{BackgroundColor3=themes[theme].ButtonHover}):Play() end)
                btn.MouseLeave:Connect(function() svc.tween:Create(btn,ti,{BackgroundColor3=themes[theme].ElementBg}):Play() end)
                btn.MouseButton1Down:Connect(function() svc.tween:Create(btn,TweenInfo.new(0.1),{BackgroundColor3=themes[theme].ButtonPressed}):Play() end)
                btn.MouseButton1Up:Connect(function() svc.tween:Create(btn,ti,{BackgroundColor3=themes[theme].ButtonHover}):Play() end)
                btn.MouseButton1Click:Connect(cb)
                upd()
                return {set=function(t) btn.Text=t end,delete=function() btn:Destroy() upd() end}
            end

            sector.dropdown = function(txt,opts,default,cb)
                local dd = {}
                dd.sel = default or opts[1]

                local con = Instance.new("Frame")
                local lab = Instance.new("TextLabel")
                local btn = Instance.new("TextButton")
                local pad = Instance.new("UIPadding")
                local arrow = Instance.new("ImageLabel")
                local list = Instance.new("ScrollingFrame")
                local lpad = Instance.new("UIPadding")
                local llist = Instance.new("UIListLayout")

                con.Parent = scroll con.BackgroundTransparency = 1 con.Size = UDim2.new(1,-20,0,35)
                lab.Parent = con lab.BackgroundTransparency = 1 lab.Size = UDim2.new(1,0,0,14) lab.Font = Enum.Font.SourceSans lab.TextColor3 = themes[theme].Text lab.TextSize = 14 lab.TextXAlignment = Enum.TextXAlignment.Left lab.Text = txt
                btn.Parent = con btn.Position = UDim2.new(0,0,0,14) btn.Size = UDim2.new(1,0,0,21) btn.BackgroundColor3 = themes[theme].ElementBg btn.BorderColor3 = themes[theme].ElementOutline btn.AutoButtonColor = false btn.Font = Enum.Font.SourceSans btn.TextColor3 = themes[theme].Text btn.TextSize = 14 btn.TextXAlignment = Enum.TextXAlignment.Left btn.Text = dd.sel
                pad.Parent = btn pad.PaddingLeft = UDim.new(0,30)
                arrow.Parent = btn arrow.BackgroundTransparency = 1 arrow.Position = UDim2.new(1,-20,0.14,0) arrow.Size = UDim2.new(0,15,0,15) arrow.Image = "rbxassetid://74187648454886" arrow.ImageColor3 = Color3.fromRGB(115,115,115)
                list.Parent = btn list.Position = UDim2.new(0,0,1,0) list.Size = UDim2.new(1,0,0,0) list.BackgroundColor3 = themes[theme].ElementBg list.BorderColor3 = themes[theme].ElementOutline list.ScrollBarThickness = 3 list.Visible = false list.ClipsDescendants = true
                lpad.Parent = list lpad.PaddingLeft = UDim.new(0,5) lpad.PaddingTop = UDim.new(0,5)
                llist.Parent = list llist.Padding = UDim.new(0,5)

                local ti = TweenInfo.new(0.2)
                local open = false
                local function tog()
                    open = not open
                    list.Visible = true
                    svc.tween:Create(arrow,ti,{Rotation=open and 180 or 0}):Play()
                    svc.tween:Create(list,ti,{Size=open and UDim2.new(1,0,0,116) or UDim2.new(1,0,0,0)}):Play()
                    if not open then task.wait(0.2) list.Visible = false end
                end
                btn.MouseButton1Click:Connect(tog)

                dd.set = function(v,skip)
                    for _,b in list:GetChildren() do if b:IsA("TextButton") then b.BorderColor3 = themes[theme].ElementOutline end end
                    local b = list:FindFirstChild(v)
                    if b then b.BorderColor3 = themes[theme].DropdownSelected end
                    dd.sel = v btn.Text = v
                    if not skip then cb(v) tog() end
                end
                dd.add = function(v)
                    local b = Instance.new("TextButton")
                    b.Name = v b.Parent = list b.BackgroundColor3 = themes[theme].ElementBg b.BorderColor3 = themes[theme].ElementOutline b.Size = UDim2.new(1,-10,0,21) b.AutoButtonColor = false b.Font = Enum.Font.SourceSans b.TextColor3 = themes[theme].Text b.TextSize = 14 b.Text = v
                    b.MouseEnter:Connect(function() svc.tween:Create(b,ti,{BackgroundColor3=themes[theme].ButtonHover}):Play() end)
                    b.MouseLeave:Connect(function() if b.BorderColor3~=themes[theme].DropdownSelected then svc.tween:Create(b,ti,{BackgroundColor3=themes[theme].ElementBg}):Play() end end)
                    b.MouseButton1Click:Connect(function() dd.set(v) end)
                    list.CanvasSize = list.CanvasSize + UDim2.new(0,0,0,b.AbsoluteSize.Y+6)
                end
                for _,o in opts do dd.add(o) end
                if default then dd.set(default,true) end
                upd()
                return dd
            end

            sector.multicombobox = function(txt,opts,defs,cb)
                local mc = {sel={},open=false}
                for _,o in opts do mc.sel[o] = table.find(defs or {},o) and true or false end

                local con = Instance.new("Frame")
                local lab = Instance.new("TextLabel")
                local btn = Instance.new("TextButton")
                local pad = Instance.new("UIPadding")
                local arrow = Instance.new("ImageLabel")
                local list = Instance.new("ScrollingFrame")
                local lpad = Instance.new("UIPadding")
                local llist = Instance.new("UIListLayout")

                con.Parent = scroll con.BackgroundTransparency = 1 con.Size = UDim2.new(1,-20,0,35)
                lab.Parent = con lab.BackgroundTransparency = 1 lab.Size = UDim2.new(1,0,0,14) lab.Font = Enum.Font.SourceSans lab.TextColor3 = themes[theme].Text lab.TextSize = 14 lab.TextXAlignment = Enum.TextXAlignment.Left lab.Text = txt
                btn.Parent = con btn.Position = UDim2.new(0,0,0,14) btn.Size = UDim2.new(1,0,0,21) btn.BackgroundColor3 = themes[theme].ElementBg btn.BorderColor3 = themes[theme].ElementOutline btn.AutoButtonColor = false btn.Font = Enum.Font.SourceSans btn.TextColor3 = themes[theme].Text btn.TextSize = 14 btn.TextXAlignment = Enum.TextXAlignment.Left btn.Text = "None"
                pad.Parent = btn pad.PaddingLeft = UDim.new(0,30)
                arrow.Parent = btn arrow.BackgroundTransparency = 1 arrow.Position = UDim2.new(1,-20,0.14,0) arrow.Size = UDim2.new(0,15,0,15) arrow.Image = "rbxassetid://74187648454886" arrow.ImageColor3 = Color3.fromRGB(115,115,115)
                list.Parent = btn list.Position = UDim2.new(0,0,1,0) list.Size = UDim2.new(1,0,0,0) list.BackgroundColor3 = themes[theme].ElementBg list.BorderColor3 = themes[theme].ElementOutline list.ScrollBarThickness = 3 list.Visible = false list.ClipsDescendants = true
                lpad.Parent = list lpad.PaddingLeft = UDim.new(0,5) lpad.PaddingTop = UDim.new(0,5)
                llist.Parent = list llist.Padding = UDim.new(0,5)

                local ti = TweenInfo.new(0.2)
                local function update_text()
                    local c = 0 for _,v in mc.sel do if v then c+=1 end end
                    if c==0 then btn.Text="None"
                    elseif c==1 then for k,v in mc.sel do if v then btn.Text=k break end end
                    else btn.Text="("..c.." selected)" end
                end
                local function tog()
                    mc.open = not mc.open
                    list.Visible = true
                    svc.tween:Create(arrow,ti,{Rotation=mc.open and 180 or 0}):Play()
                    svc.tween:Create(list,ti,{Size=mc.open and UDim2.new(1,0,0,116) or UDim2.new(1,0,0,0)}):Play()
                    if not mc.open then task.wait(0.2) list.Visible=false end
                end
                btn.MouseButton1Click:Connect(tog)
                update_text()

                mc.toggle = function(v)
                    mc.sel[v] = not mc.sel[v]
                    local b = list:FindFirstChild(v)
                    if b then b.BorderColor3 = mc.sel[v] and themes[theme].DropdownSelected or themes[theme].ElementOutline b.BackgroundColor3 = mc.sel[v] and themes[theme].ButtonHover or themes[theme].ElementBg end
                    update_text() cb(mc.sel)
                end
                mc.add = function(v)
                    local b = Instance.new("TextButton")
                    b.Name = v b.Parent = list b.BackgroundColor3 = themes[theme].ElementBg b.BorderColor3 = mc.sel[v] and themes[theme].DropdownSelected or themes[theme].ElementOutline b.Size = UDim2.new(1,-10,0,21) b.AutoButtonColor = false b.Font = Enum.Font.SourceSans b.TextColor3 = themes[theme].Text b.TextSize = 14 b.Text = v
                    if mc.sel[v] then b.BackgroundColor3 = themes[theme].ButtonHover end
                    b.MouseButton1Click:Connect(function() mc.toggle(v) end)
                    list.CanvasSize += UDim2.new(0,0,0,b.AbsoluteSize.Y+6)
                end
                for _,o in opts do mc.add(o) end
                upd()
                return mc
            end

            sector.toggle = function(txt,default,cb)
                local val = default
                local con = Instance.new("TextButton")
                local lab = Instance.new("TextLabel")
                local box = Instance.new("TextButton")

                con.Parent = scroll con.BackgroundTransparency = 1 con.Size = UDim2.new(1,-20,0,18) con.Text = ""
                lab.Parent = con lab.BackgroundTransparency = 1 lab.Position = UDim2.new(0.09,0,0,0) lab.Size = UDim2.new(0,226,0,18) lab.Font = Enum.Font.SourceSans lab.TextColor3 = themes[theme].Text lab.TextSize = 14 lab.TextXAlignment = Enum.TextXAlignment.Left lab.Text = txt
                box.Name = "Box" box.Parent = con box.BackgroundColor3 = default and themes[theme].Toggle or themes[theme].ToggleUnchecked box.BorderColor3 = themes[theme].ElementOutline box.Position = UDim2.new(0,5,0.2,0) box.Size = UDim2.new(0,8,0,8) box.Text = ""

                local ti = TweenInfo.new(0.2)
                local function set(v)
                    val = v
                    svc.tween:Create(box,ti,{BackgroundColor3=v and themes[theme].Toggle or themes[theme].ToggleUnchecked}):Play()
                    cb(v)
                end
                con.MouseButton1Click:Connect(function() set(not val) end)
                box.MouseButton1Click:Connect(function() set(not val) end)

                local cp = nil
                local function addcp(def,cp_cb)
                    local picker = Instance.new("TextButton")
                    picker.Parent = con picker.BackgroundColor3 = def picker.Position = UDim2.new(0.85,0,0.32,0) picker.Size = UDim2.new(0,22,0,11) picker.Text = ""

                    local frame = Instance.new("Frame")
                    frame.Parent = sec frame.BackgroundColor3 = Color3.fromRGB(20,20,20) frame.BorderColor3 = Color3.fromRGB(35,35,35) frame.BorderSizePixel = 2 frame.Size = UDim2.new(0,180,0,100) frame.Visible = false frame.ZIndex = 200

                    local h,s,v = def:ToHSV()
                    local hue,sat,val = h,s,v

                    local function upd()
                        local col = Color3.fromHSV(hue,sat,val)
                        picker.BackgroundColor3 = col
                        cp_cb(col)
                    end

                    local function mk_slider(name,pos,grad,drag_col)
                        local s = Instance.new("TextButton")
                        s.Parent = frame s.Position = pos s.Size = UDim2.new(0,20,0,80) s.BackgroundColor3 = Color3.new(1,1,1) s.Text = ""
                        local g = Instance.new("UIGradient") g.Parent = s g.Color = grad g.Rotation = 90
                        local d = Instance.new("Frame") d.Parent = s d.BackgroundColor3 = drag_col d.BorderSizePixel = 1 d.Size = UDim2.new(1,0,0,2)
                        s.InputBegan:Connect(function(i)
                            if i.UserInputType==Enum.UserInputType.MouseButton1 then
                                local conn
                                conn = svc.run.RenderStepped:Connect(function()
                                    local m = svc.uis:GetMouseLocation()
                                    local rel = math.clamp((m.Y-s.AbsolutePosition.Y)/s.AbsoluteSize.Y,0,1)
                                    if name=="hue" then hue=rel elseif name=="sat" then sat=rel else val=rel end
                                    d.Position = UDim2.new(0,0,rel,-1) upd()
                                end)
                                svc.uis.InputEnded:Connect(function(e) if e.UserInputType==Enum.UserInputType.MouseButton1 then conn:Disconnect() end end)
                            end
                        end)
                        return s
                    end

                    mk_slider("hue",UDim2.new(0.05,0,0.1,0),ColorSequence.new{ColorSequenceKeypoint.new(0,Color3.new(1,0,0)),ColorSequenceKeypoint.new(1/6,Color3.new(1,1,0)),ColorSequenceKeypoint.new(1/3,Color3.new(0,1,0)),ColorSequenceKeypoint.new(0.5,Color3.new(0,1,1)),ColorSequenceKeypoint.new(2/3,Color3.new(0,0,1)),ColorSequenceKeypoint.new(5/6,Color3.new(1,0,1)),ColorSequenceKeypoint.new(1,Color3.new(1,0,0))},Color3.new(1,1,1))
                    mk_slider("sat",UDim2.new(0.25,0,0.1,0),ColorSequence.new{ColorSequenceKeypoint.new(0,Color3.new(1,1,1)),ColorSequenceKeypoint.new(1,Color3.fromHSV(hue,1,1))},Color3.new(1,1,1))
                    mk_slider("val",UDim2.new(0.45,0,0.1,0),ColorSequence.new{ColorSequenceKeypoint.new(0,Color3.new(0,0,0)),ColorSequenceKeypoint.new(1,Color3.fromHSV(hue,sat,1))},Color3.new(1,1,1))

                    local prev = Instance.new("Frame")
                    prev.Parent = frame prev.Position = UDim2.new(0.7,0,0.1,0) prev.Size = UDim2.new(0,40,0,40) prev.BackgroundColor3 = def

                    picker.MouseButton1Click:Connect(function()
                        for _,f in sec:GetChildren() do if f.Name=="ColorPicker" and f~=frame then f.Visible=false end end
                        local ap = picker.AbsolutePosition
                        frame.Position = UDim2.new(0,ap.X-sec.AbsolutePosition.X-180,0,ap.Y-sec.AbsolutePosition.Y+picker.Size.Y.Offset+5)
                        frame.Visible = not frame.Visible
                    end)

                    upd()
                    cp = {set=function(hh,ss,vv) hue,sat,val=hh,ss,vv upd() end}
                    return cp
                end

                local t = {set=function(v) set(v) end,get=function() return val end,add_color=function(def,cb) return addcp(def,cb) end}
                upd()
                return t
            end

            sector.slider = function(txt,ind,min,max,def,cb)
                local val = def
                local con = Instance.new("TextButton")
                local lab = Instance.new("TextLabel")
                local bg = Instance.new("TextButton")
                local fill = Instance.new("TextButton")
                local num = Instance.new("TextLabel")

                con.Parent = scroll con.BackgroundTransparency = 1 con.Size = UDim2.new(1,-20,0,25) con.Text = ""
                lab.Parent = con lab.BackgroundTransparency = 1 lab.Position = UDim2.new(0.02,0,0,0) lab.Size = UDim2.new(0,226,0,12) lab.Font = Enum.Font.SourceSans lab.TextColor3 = themes[theme].Text lab.TextSize = 14 lab.TextXAlignment = Enum.TextXAlignment.Left lab.Text = txt
                bg.Parent = con bg.Position = UDim2.new(0.02,0,0.6,0) bg.Size = UDim2.new(0,238,0,6) bg.BackgroundColor3 = themes[theme].SliderBg bg.BorderColor3 = themes[theme].ElementOutline bg.Text = ""
                fill.Parent = bg fill.Size = UDim2.new((def-min)/(max-min),0,1,0) fill.BackgroundColor3 = themes[theme].Slider fill.Text = ""
                num.Parent = fill num.BackgroundTransparency = 1 num.Position = UDim2.new(1,-40,1,2) num.Size = UDim2.new(0,40,0,8) num.Font = Enum.Font.SourceSans num.TextColor3 = themes[theme].Text num.TextSize = 11 num.TextXAlignment = Enum.TextXAlignment.Right

                local dragging = false
                local ti = TweenInfo.new(0.2)

                local function set(p)
                    svc.tween:Create(fill,ti,{Size=UDim2.new(p,0,1,0)}):Play()
                    val = min + p*(max-min)
                    num.Text = tostring(math.round(val*100)/100)..ind
                    cb(val)
                end

                bg.InputBegan:Connect(function(i) if i.UserInputType==Enum.UserInputType.MouseButton1 then dragging=true end end)
                bg.InputEnded:Connect(function(i) if i.UserInputType==Enum.UserInputType.MouseButton1 then dragging=false end end)
                fill.InputBegan:Connect(function(i) if i.UserInputType==Enum.UserInputType.MouseButton1 then dragging=true end end)
                fill.InputEnded:Connect(function(i) if i.UserInputType==Enum.UserInputType.MouseButton1 then dragging=false end end)

                svc.run.RenderStepped:Connect(function()
                    if dragging then
                        local m = svc.uis:GetMouseLocation().X
                        local p = math.clamp((m-bg.AbsolutePosition.X)/bg.AbsoluteSize.X,0,1)
                        set(p)
                    end
                end)

                set((def-min)/(max-min))
                upd()
                return {set=function(v) set((v-min)/(max-min)) end,get=function() return val end}
            end

            table.insert(win.tab_contents,{btn.Name,sec})
            return sector
        end
        return tab
    end
    return win
end
return lib
