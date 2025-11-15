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
			Sector.Position = UDim2.new(-0.00108384306, 0, -0.0011133909, 0)
			Sector.Size = UDim2.new(0.5, -5, 1, 0)
			Sector.Visible = false
			Sector.ClipsDescendants = true

			if tab.sectorCount == 2 then
				Sector.Position = UDim2.new(0.5, 5, -0.0011133909, 0)
			end

			Title.Name = "Title"
			Title.Parent = Sector
			Title.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
			Title.BackgroundTransparency = 1.000
			Title.BorderColor3 = Color3.fromRGB(0, 0, 0)
			Title.BorderSizePixel = 0
			Title.Position = UDim2.new(0.028933093, 0, 0.01, 0) -- Fixed: changed from -0.012 to 0.01
			Title.Size = UDim2.new(0, 268, 0, 15)
			Title.Font = Enum.Font.SourceSans
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
			SectorContent.Position = UDim2.new(0.028933093, 0, 0.04, 0) -- Adjusted to make space for title
			SectorContent.Size = UDim2.new(0, 259, 0, 550) -- Reduced height to fit title
			SectorContent.CanvasSize = UDim2.new(0, 0, 0, 0)
			SectorContent.ScrollBarThickness = 3
			SectorContent.ClipsDescendants = true

			UIListLayout.Parent = SectorContent
			UIListLayout.SortOrder = Enum.SortOrder.LayoutOrder
			UIListLayout.Padding = UDim.new(0,7)

			UIPadding.Parent = SectorContent
			UIPadding.PaddingLeft = UDim.new(0, 5)
			
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
						totalHeight = totalHeight + element.AbsoluteSize.Y + 7
					end
				end
				SectorContent.CanvasSize = UDim2.new(0, 0, 0, totalHeight + 5)
			end
			
			sector.text = function(_text)
				local text = {}
				
				local Text = Instance.new("TextLabel")
				Text.Name = _text
				Text.Parent = SectorContent
				Text.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
				Text.BackgroundTransparency = 1.000
				Text.BorderColor3 = Color3.fromRGB(0, 0, 0)
				Text.BorderSizePixel = 0
				Text.Size = UDim2.new(0, 249, 0, 13)
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
			
			sector.warning = function(_text)
				local text = {}
				
				local Text = Instance.new("TextLabel")
				Text.Name = _text
				Text.Parent = SectorContent
				Text.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
				Text.BackgroundTransparency = 1.000
				Text.BorderColor3 = Color3.fromRGB(0, 0, 0)
				Text.BorderSizePixel = 0
				Text.Size = UDim2.new(0, 249, 0, 13)
				Text.Font = Enum.Font.SourceSans
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
				Text.Name = _text
				Text.Parent = SectorContent
				Text.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
				Text.BackgroundTransparency = 1.000
				Text.BorderColor3 = Color3.fromRGB(0, 0, 0)
				Text.BorderSizePixel = 0
				Text.Size = UDim2.new(0, 249, 0, 13)
				Text.Font = Enum.Font.SourceSans
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
				Text.Name = _text
				Text.Parent = SectorContent
				Text.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
				Text.BackgroundTransparency = 1.000
				Text.BorderColor3 = Color3.fromRGB(0, 0, 0)
				Text.BorderSizePixel = 0
				Text.Size = UDim2.new(0, 249, 0, 13)
				Text.Font = Enum.Font.SourceSans
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
				TextBox.Position = UDim2.new(0, 0, 0.15053764, 0)
				TextBox.Size = UDim2.new(0, 249, 0, 21)
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
				end)
				
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
				Button.Position = UDim2.new(0.0157480314, 0, 0.254480273, 0)
				Button.Size = UDim2.new(0, 249, 0, 21)
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
				Dropdown.Position = UDim2.new(0.0157480314, 0, 0.254480273, 0)
				Dropdown.Size = UDim2.new(0, 249, 0, 21)
				Dropdown.AutoButtonColor = false
				Dropdown.Font = Enum.Font.SourceSans
				Dropdown.Text = text
				Dropdown.TextColor3 = themes[theme]["Text"]
				Dropdown.TextSize = 14.000
				Dropdown.TextXAlignment = Enum.TextXAlignment.Left
				Dropdown.ZIndex = 100

				UIPadding.Parent = Dropdown
				UIPadding.PaddingLeft = UDim.new(0, 5)
				UIPadding.PaddingRight = UDim.new(0, 20) -- Fixed: added padding for arrow

				Image.Name = "Image"
				Image.Parent = Dropdown
				Image.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
				Image.BackgroundTransparency = 1.000
				Image.BorderColor3 = Color3.fromRGB(0, 0, 0)
				Image.BorderSizePixel = 0
				Image.Position = UDim2.new(0.9, 0, 0.142857149, 0)
				Image.Size = UDim2.new(0, 15, 0, 15)
				Image.Image = "rbxassetid://74187648454886"
				Image.ImageColor3 = Color3.fromRGB(115, 115, 115)
				Image.ZIndex = 101

				DropdownContent.Name = "DropdownContent"
				DropdownContent.Parent = Dropdown
				DropdownContent.Active = true
				DropdownContent.BackgroundColor3 = themes[theme]["ElementBg"]
				DropdownContent.BorderColor3 = themes[theme]["ElementOutline"]
				DropdownContent.Position = UDim2.new(-0.004, 0, 1, 2) -- Fixed: aligned to left
				DropdownContent.Size = UDim2.new(0, 249, 0, 0)
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
						services.tween:Create(DropdownContent, tweenInfo, {Size = UDim2.new(0, 249, 0, 116)}):Play()
					else
						services.tween:Create(Image, tweenInfo, {Rotation = 0}):Play()
						services.tween:Create(DropdownContent, tweenInfo, {Size = UDim2.new(0, 249, 0, 0)}):Play()
						wait(0.2)
						DropdownContent.Visible = false
					end
				end
				
				Dropdown.MouseButton1Down:Connect(toggleDropdown)

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
					Button.Size = UDim2.new(0, 238, 0, 21)
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
						toggleDropdown()
					end)

					if name == default then
						dropdown.set(name)
					end

					DropdownContent.CanvasSize += UDim2.new(0, 0, 0, Button.AbsoluteSize.Y + 6)
				end

				dropdown.remove = function(name)
					DropdownContent.CanvasSize -= UDim2.new(0, 0, 0, DropdownContent:FindFirstChild(name).AbsoluteSize.Y + 6)
					DropdownContent:FindFirstChild(name):Destroy()
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

				Toggle.Name = text
				Toggle.Parent = SectorContent
				Toggle.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
				Toggle.BackgroundTransparency = 1.000
				Toggle.BorderColor3 = Color3.fromRGB(0, 0, 0)
				Toggle.BorderSizePixel = 0
				Toggle.Position = UDim2.new(0, 0, 0.306451619, 0)
				Toggle.Size = UDim2.new(0, 249, 0, 21)
				Toggle.Font = Enum.Font.SourceSans
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
				Text.Size = UDim2.new(0, 226, 0, 21)
				Text.Font = Enum.Font.SourceSans
				Text.TextColor3 = themes[theme]["Text"]
				Text.TextSize = 14.000
				Text.TextStrokeTransparency = 0.800
				Text.TextXAlignment = Enum.TextXAlignment.Left
				Text.Text = text

				Bg.Name = "Bg"
				Bg.Parent = Toggle
				Bg.BackgroundColor3 = themes[theme]["ToggleUnchecked"]
				Bg.BorderColor3 = themes[theme]["ElementOutline"]
				Bg.Position = UDim2.new(0, 5, 0.324999988, 0)
				Bg.Size = UDim2.new(0, 8, 0, 8)
				Bg.Font = Enum.Font.SourceSans
				Bg.Text = ""
				Bg.TextColor3 = Color3.fromRGB(0, 0, 0)
				Bg.TextSize = 14.000
				Bg.AutoButtonColor = false
				
				local tweenInfo = TweenInfo.new(0.2, Enum.EasingStyle.Quad, Enum.EasingDirection.Out)
				
				Bg.MouseEnter:Connect(function()
					services.tween:Create(Bg, tweenInfo, {Size = UDim2.new(0, 10, 0, 10)}):Play()
				end)
				
				Bg.MouseLeave:Connect(function()
					services.tween:Create(Bg, tweenInfo, {Size = UDim2.new(0, 8, 0, 8)}):Play()
				end)
				
				toggle.set = function(value)
					local targetColor = value and themes[theme]["Toggle"] or themes[theme]["ToggleUnchecked"]
					services.tween:Create(Bg, tweenInfo, {BackgroundColor3 = targetColor}):Play()
					callback(value)
				end
				
				toggle.set_text = function(_text)
					Text.Text = _text
				end
				
				toggle.add_color = function(_default, cpcallback)
					local colorpicker = {}

					local choosing_hue = false
					local choosing_color = false
					local choosing_darkness = false

					local Colorpicker = Instance.new("TextButton")

					Colorpicker.Name = "Colorpicker"
					Colorpicker.Parent = Toggle
					Colorpicker.BackgroundColor3 = _default
					Colorpicker.BorderColor3 = Color3.fromRGB(40, 40, 40)
					Colorpicker.Position = UDim2.new(0.85, 0, 0.325, 0)
					Colorpicker.Size = UDim2.new(0, 22, 0, 11)
					Colorpicker.AutoButtonColor = false
					Colorpicker.Font = Enum.Font.SourceSans
					Colorpicker.Text = ""
					Colorpicker.TextColor3 = Color3.fromRGB(0, 0, 0)
					Colorpicker.TextSize = 14.000

					local default_hue, default_saturation, default_value = _default:ToHSV()
					local hue_value = default_hue
					local sat_value = 1.0
					local val_value = 1.0
					local darkness_value = 1.0

					local ColorPicker = Instance.new("Frame")
					local Color = Instance.new("Frame")
					local WhiteToColorGradient = Instance.new("UIGradient")
					local ColorSelection = Instance.new("Frame")
					local Hue = Instance.new("Frame")
					local HueGradient = Instance.new("UIGradient")
					local HueSelection = Instance.new("Frame")
					local Darkness = Instance.new("Frame")
					local DarknessGradient = Instance.new("UIGradient")
					local DarknessSelection = Instance.new("Frame")

					ColorPicker.Name = "ColorPicker"
					ColorPicker.Parent = Sector
					ColorPicker.BackgroundColor3 = Color3.fromRGB(20, 20, 20)
					ColorPicker.BorderColor3 = Color3.fromRGB(35, 35, 35)
					ColorPicker.BorderSizePixel = 2
					ColorPicker.Size = UDim2.new(0, 150, 0, 140)
					ColorPicker.Visible = false
					ColorPicker.ZIndex = 200

					Color.Name = "Color"
					Color.Parent = ColorPicker
					Color.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
					Color.BorderColor3 = Color3.fromRGB(0, 0, 0)
					Color.BorderSizePixel = 0
					Color.Position = UDim2.new(0.05, 0, 0.05, 0)
					Color.Size = UDim2.new(0, 100, 0, 80)
					Color.ZIndex = 201

					-- Fixed: Only vertical gradient - white to color
					WhiteToColorGradient.Color = ColorSequence.new{
						ColorSequenceKeypoint.new(0, Color3.fromRGB(255, 255, 255)),
						ColorSequenceKeypoint.new(1, Color3.fromHSV(hue_value, 1, 1))
					}
					WhiteToColorGradient.Rotation = 90
					WhiteToColorGradient.Parent = Color

					ColorSelection.Name = "ColorSelection"
					ColorSelection.Parent = Color
					ColorSelection.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
					ColorSelection.BorderColor3 = Color3.fromRGB(0, 0, 0)
					ColorSelection.BorderSizePixel = 1
					ColorSelection.Size = UDim2.new(0, 3, 0, 3)
					ColorSelection.ZIndex = 202

					Hue.Name = "Hue"
					Hue.Parent = ColorPicker
					Hue.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
					Hue.BorderColor3 = Color3.fromRGB(0, 0, 0)
					Hue.BorderSizePixel = 0
					Hue.Position = UDim2.new(0.75, 0, 0.05, 0)
					Hue.Size = UDim2.new(0, 15, 0, 80)
					Hue.ZIndex = 201

					HueGradient.Color = ColorSequence.new{
						ColorSequenceKeypoint.new(0.00, Color3.fromRGB(255, 0, 4)),
						ColorSequenceKeypoint.new(0.17, Color3.fromRGB(255, 0, 251)),
						ColorSequenceKeypoint.new(0.33, Color3.fromRGB(0, 17, 255)),
						ColorSequenceKeypoint.new(0.50, Color3.fromRGB(0, 255, 255)),
						ColorSequenceKeypoint.new(0.67, Color3.fromRGB(21, 255, 0)),
						ColorSequenceKeypoint.new(0.83, Color3.fromRGB(234, 255, 0)),
						ColorSequenceKeypoint.new(1.00, Color3.fromRGB(255, 0, 4))
					}
					HueGradient.Rotation = 270
					HueGradient.Parent = Hue

					HueSelection.Name = "HueSelection"
					HueSelection.Parent = Hue
					HueSelection.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
					HueSelection.BorderColor3 = Color3.fromRGB(0, 0, 0)
					HueSelection.BorderSizePixel = 1
					HueSelection.Size = UDim2.new(1, 0, 0, 2)
					HueSelection.ZIndex = 202

					-- Fixed: Added darkness slider below color picker
					Darkness.Name = "Darkness"
					Darkness.Parent = ColorPicker
					Darkness.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
					Darkness.BorderColor3 = Color3.fromRGB(0, 0, 0)
					Darkness.BorderSizePixel = 0
					Darkness.Position = UDim2.new(0.05, 0, 0.7, 0)
					Darkness.Size = UDim2.new(0, 115, 0, 15)
					Darkness.ZIndex = 201

					DarknessGradient.Color = ColorSequence.new{
						ColorSequenceKeypoint.new(0, Color3.fromRGB(0, 0, 0)),
						ColorSequenceKeypoint.new(1, Color3.fromHSV(hue_value, sat_value, val_value))
					}
					DarknessGradient.Rotation = 0
					DarknessGradient.Parent = Darkness

					DarknessSelection.Name = "DarknessSelection"
					DarknessSelection.Parent = Darkness
					DarknessSelection.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
					DarknessSelection.BorderColor3 = Color3.fromRGB(0, 0, 0)
					DarknessSelection.BorderSizePixel = 1
					DarknessSelection.Size = UDim2.new(0, 3, 0, 15)
					DarknessSelection.ZIndex = 202

					Colorpicker.MouseButton1Down:Connect(function()
						for _, element in pairs(Sector:GetChildren()) do
							if element.Name == "ColorPicker" and element ~= ColorPicker then
								element.Visible = false
							end
						end

						local abs_pos = Colorpicker.AbsolutePosition
						ColorPicker.Position = UDim2.new(0, abs_pos.X - Sector.AbsolutePosition.X - 150, 0, abs_pos.Y - Sector.AbsolutePosition.Y + Colorpicker.Size.Y.Offset + 5)
						ColorPicker.Visible = not ColorPicker.Visible
					end)

					local function update_color_picker()
						local current_color = Color3.fromHSV(hue_value, sat_value, val_value)
						
						-- Update gradients
						WhiteToColorGradient.Color = ColorSequence.new{
							ColorSequenceKeypoint.new(0, Color3.fromRGB(255, 255, 255)),
							ColorSequenceKeypoint.new(1, current_color)
						}
						
						DarknessGradient.Color = ColorSequence.new{
							ColorSequenceKeypoint.new(0, Color3.fromRGB(0, 0, 0)),
							ColorSequenceKeypoint.new(1, current_color)
						}
						
						-- Update selection positions
						ColorSelection.Position = UDim2.new(0.5, -1.5, val_value, -1.5)
						HueSelection.Position = UDim2.new(0, 0, hue_value, -1)
						DarknessSelection.Position = UDim2.new(darkness_value, -1.5, 0, 0)
						
						-- Calculate final color with darkness
						local final_color = Color3.new(
							current_color.R * darkness_value,
							current_color.G * darkness_value,
							current_color.B * darkness_value
						)
						
						Colorpicker.BackgroundColor3 = final_color
						cpcallback(final_color)
					end

					colorpicker.set = function(hue, sat, val)
						hue_value = hue
						sat_value = sat
						val_value = val
						update_color_picker()
					end

					-- Color square input handling
					Color.InputBegan:Connect(function(input)
						if input.UserInputType == Enum.UserInputType.MouseButton1 then
							choosing_color = true
							
							local mouse_pos = services.uis:GetMouseLocation()
							local abs_pos = Color.AbsolutePosition
							local abs_size = Color.AbsoluteSize

							local x = math.clamp((mouse_pos.X - abs_pos.X) / abs_size.X, 0, 1)
							local y = math.clamp((mouse_pos.Y - abs_pos.Y) / abs_size.Y, 0, 1)

							sat_value = x
							val_value = 1 - y
							update_color_picker()
						end
					end)

					Color.InputEnded:Connect(function(input)
						if input.UserInputType == Enum.UserInputType.MouseButton1 then
							choosing_color = false
						end
					end)

					-- Hue input handling
					Hue.InputBegan:Connect(function(input)
						if input.UserInputType == Enum.UserInputType.MouseButton1 then
							choosing_hue = true
							
							local mouse_pos = services.uis:GetMouseLocation()
							local abs_pos = Hue.AbsolutePosition
							local abs_size = Hue.AbsoluteSize

							local y = math.clamp((mouse_pos.Y - abs_pos.Y) / abs_size.Y, 0, 1)

							hue_value = 1 - y
							update_color_picker()
						end
					end)

					Hue.InputEnded:Connect(function(input)
						if input.UserInputType == Enum.UserInputType.MouseButton1 then
							choosing_hue = false
						end
					end)

					-- Darkness input handling
					Darkness.InputBegan:Connect(function(input)
						if input.UserInputType == Enum.UserInputType.MouseButton1 then
							choosing_darkness = true
							
							local mouse_pos = services.uis:GetMouseLocation()
							local abs_pos = Darkness.AbsolutePosition
							local abs_size = Darkness.AbsoluteSize

							local x = math.clamp((mouse_pos.X - abs_pos.X) / abs_size.X, 0, 1)

							darkness_value = x
							update_color_picker()
						end
					end)

					Darkness.InputEnded:Connect(function(input)
						if input.UserInputType == Enum.UserInputType.MouseButton1 then
							choosing_darkness = false
						end
					end)

					services.run.RenderStepped:Connect(function()
						if choosing_color then
							local mouse_pos = services.uis:GetMouseLocation()
							local abs_pos = Color.AbsolutePosition
							local abs_size = Color.AbsoluteSize

							local x = math.clamp((mouse_pos.X - abs_pos.X) / abs_size.X, 0, 1)
							local y = math.clamp((mouse_pos.Y - abs_pos.Y) / abs_size.Y, 0, 1)

							sat_value = x
							val_value = 1 - y
							update_color_picker()
						end

						if choosing_hue then
							local mouse_pos = services.uis:GetMouseLocation()
							local abs_pos = Hue.AbsolutePosition
							local abs_size = Hue.AbsoluteSize

							local y = math.clamp((mouse_pos.Y - abs_pos.Y) / abs_size.Y, 0, 1)

							hue_value = 1 - y
							update_color_picker()
						end

						if choosing_darkness then
							local mouse_pos = services.uis:GetMouseLocation()
							local abs_pos = Darkness.AbsolutePosition
							local abs_size = Darkness.AbsoluteSize

							local x = math.clamp((mouse_pos.X - abs_pos.X) / abs_size.X, 0, 1)

							darkness_value = x
							update_color_picker()
						end
					end)

					update_color_picker()

					return colorpicker
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
				local Fill = Instance.new("TextButton")
				local ValueLabel = Instance.new("TextLabel")

				Slider.Name = "Slider"
				Slider.Parent = SectorContent
				Slider.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
				Slider.BackgroundTransparency = 1.000
				Slider.BorderColor3 = Color3.fromRGB(0, 0, 0)
				Slider.BorderSizePixel = 0
				Slider.Position = UDim2.new(0, 0, 0.306451619, 0)
				Slider.Size = UDim2.new(0, 249, 0, 35)
				Slider.Font = Enum.Font.SourceSans
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
				Text.Position = UDim2.new(0.02, 0, 0, 0)
				Text.Size = UDim2.new(0, 226, 0, 15)
				Text.Font = Enum.Font.SourceSans
				Text.TextColor3 = themes[theme]["Text"]
				Text.TextSize = 14.000
				Text.TextStrokeTransparency = 0.800
				Text.TextXAlignment = Enum.TextXAlignment.Left
				Text.Text = text

				Bg.Name = "Bg"
				Bg.Parent = Slider
				Bg.BackgroundColor3 = themes[theme]["SliderBg"]
				Bg.BorderColor3 = themes[theme]["ElementOutline"]
				Bg.Position = UDim2.new(0.02, 0, 0.6, 0)
				Bg.Size = UDim2.new(0, 238, 0, 8)
				Bg.AutoButtonColor = false
				Bg.Font = Enum.Font.SourceSans
				Bg.Text = ""
				Bg.TextColor3 = Color3.fromRGB(0, 0, 0)
				Bg.TextSize = 14.000

				Fill.Name = "Fill"
				Fill.Parent = Bg
				Fill.BackgroundColor3 = themes[theme]["Slider"]
				Fill.BorderColor3 = themes[theme]["ElementOutline"]
				Fill.Position = UDim2.new(0, 0, 0, 0)
				Fill.Size = UDim2.new(0.5, 0, 1, 0)
				Fill.AutoButtonColor = false
				Fill.Font = Enum.Font.SourceSans
				Fill.Text = ""
				Fill.TextColor3 = Color3.fromRGB(0, 0, 0)
				Fill.TextSize = 14.000

				ValueLabel.Name = "ValueLabel"
				ValueLabel.Parent = Bg
				ValueLabel.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
				ValueLabel.BackgroundTransparency = 1.000
				ValueLabel.BorderColor3 = Color3.fromRGB(0, 0, 0)
				ValueLabel.BorderSizePixel = 0
				ValueLabel.Position = UDim2.new(1, -40, 1, 2)
				ValueLabel.Size = UDim2.new(0, 40, 0, 10)
				ValueLabel.Font = Enum.Font.SourceSans
				ValueLabel.TextColor3 = themes[theme]["Text"]
				ValueLabel.TextSize = 11.000
				ValueLabel.TextXAlignment = Enum.TextXAlignment.Right
				
				local tweenInfo = TweenInfo.new(0.2, Enum.EasingStyle.Quad, Enum.EasingDirection.Out)
				
				Bg.MouseEnter:Connect(function()
					services.tween:Create(Bg, tweenInfo, {BackgroundColor3 = themes[theme]["ButtonHover"]}):Play()
				end)
				
				Bg.MouseLeave:Connect(function()
					services.tween:Create(Bg, tweenInfo, {BackgroundColor3 = themes[theme]["SliderBg"]}):Play()
				end)

				slider.set = function(percentage)
					services.tween:Create(Fill, tweenInfo, {Size = UDim2.new(percentage, 0, 1, 0)}):Play()
					
					value = (percentage / 1) * (max - min) + min
					callback(value)
					
					ValueLabel.Text = tostring(math.round(value * 100) / 100)..indicator
				end
				
				slider.get = function()
					return value
				end
				
				slider.set_text = function(_text)
					Text.Text = _text
					text = _text
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

				slider.set((default - min) / (max - min))

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
