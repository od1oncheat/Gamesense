local lib = {}
local themes = {
	["gamesense"] = {
		["Window"] = Color3.fromRGB(16, 16, 16),
		["Tabs"] = Color3.fromRGB(12, 12, 12),
		["Gradient"] = ColorSequence.new{ColorSequenceKeypoint.new(0.00, Color3.fromRGB(61, 130, 162)), ColorSequenceKeypoint.new(0.50, Color3.fromRGB(156, 59, 145)), ColorSequenceKeypoint.new(1.00, Color3.fromRGB(155, 161, 48))},
		["Sector"] = Color3.fromRGB(23, 23, 23),
		["Text"] = Color3.fromRGB(161, 161, 161),
		["TabSelected"] = Color3.fromRGB(17, 17, 17),
		["ElementBg"] = Color3.fromRGB(27, 27, 27),
		["ElementOutline"] = Color3.fromRGB(40,40,40),
		["DropdownSelected"] = Color3.fromRGB(135, 176, 27),
		["Toggle"] = Color3.fromRGB(135, 176, 27),
		["ToggleUnchecked"] = Color3.fromRGB(30,30,30),
		["Slider"] = Color3.fromRGB(135, 176, 27),
		["SliderBg"] = Color3.fromRGB(27, 27, 27)
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
	local UIListLayout = Instance.new("UIListLayout")
	local TopGradient = Instance.new("Frame")
	local UIGradient = Instance.new("UIGradient")
	local Content = Instance.new("Frame")
	local ContentListLayout = Instance.new("UIListLayout")
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
	Main.BorderSizePixel = 3
	Main.Position = UDim2.new(0.38166827, 0, 0.249408439, 0)
	Main.Size = UDim2.new(0, 684, 0, 605)
	Tabs.Name = "Tabs"
	Tabs.Parent = Main
	Tabs.BackgroundColor3 = themes[theme]["Tabs"]
	Tabs.BorderColor3 = Color3.fromRGB(21, 21, 21)
	Tabs.Position = UDim2.new(0, 1, 0.00330578513, 0)
	Tabs.Size = UDim2.new(0, 120, 0, 602)
	UIListLayout.Parent = Tabs
	UIListLayout.SortOrder = Enum.SortOrder.LayoutOrder
	UIListLayout.FillDirection = Enum.FillDirection.Vertical
	UIListLayout.Padding = UDim.new(0, 0)
	TopGradient.Name = "TopGradient"
	TopGradient.Parent = Main
	TopGradient.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
	TopGradient.BorderColor3 = Color3.fromRGB(0, 0, 0)
	TopGradient.BorderSizePixel = 0
	TopGradient.Size = UDim2.new(0, 684, 0, 1)
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
	ContentListLayout.Parent = Content
	ContentListLayout.FillDirection = Enum.FillDirection.Horizontal
	ContentListLayout.SortOrder = Enum.SortOrder.LayoutOrder
	ContentListLayout.Padding = UDim.new(0, 10)
	window.tab_contents = {}
	window.selected_tab = ""
	local tweenInfo = TweenInfo.new(0.3, Enum.EasingStyle.Sine, Enum.EasingDirection.InOut)
	window.show_tab = function(name)
		if window.selected_tab == name then return end
		local old_name = window.selected_tab
		window.selected_tab = name
		if old_name ~= "" then
			for _, content in pairs(window.tab_contents) do
				if content[1] == old_name then
					local old_frame = content[2]
					local tweenOut = services.tween:Create(old_frame, tweenInfo, {BackgroundTransparency = 1})
					tweenOut:Play()
					tweenOut.Completed:Connect(function()
						old_frame.Visible = false
					end)
					break
				end
			end
		end
		for _, content in pairs(window.tab_contents) do
			if content[1] == name then
				local new_frame = content[2]
				new_frame.Visible = true
				if old_name == "" then
					new_frame.BackgroundTransparency = 0
				else
					new_frame.BackgroundTransparency = 1
					local tweenIn = services.tween:Create(new_frame, tweenInfo, {BackgroundTransparency = 0})
					tweenIn:Play()
				end
				break
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
			if not tab:IsA("UIListLayout") then
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
		local Tab = Instance.new("TextButton")
		local Open = Instance.new("ImageButton")
		Tab.Name = image:sub(14)
		Tab.Parent = Tabs
		Tab.BackgroundColor3 = themes[theme]["TabSelected"]
		Tab.BorderColor3 = Color3.fromRGB(20, 20, 20)
		Tab.BackgroundTransparency = 1
		Tab.BorderSizePixel = 2
		Tab.Size = UDim2.new(1, 0, 0, 80)
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
		Open.Position = UDim2.new(0.25, 0, 0.2, 0)
		Open.Size = UDim2.new(0, 50, 0, 50)
		Open.Image = image
		Open.ImageColor3 = Color3.fromRGB(90,90,90)
		Open.MouseButton1Down:Connect(function()
			window.selected_tab = Tab.Name
			window.tab_colors(Tab)
			window.show_tab(Tab.Name)
		end)
		tab.create_sector = function(name)
			local sector = {}
			local Sector = Instance.new("Frame")
			local Title = Instance.new("TextLabel")
			local SectorContent = Instance.new("ScrollingFrame")
			local listLayout = Instance.new("UIListLayout")
			local UIPadding = Instance.new("UIPadding")
			Sector.Name = name
			Sector.Parent = Content
			Sector.BackgroundColor3 = themes[theme]["Sector"]
			Sector.BorderColor3 = Color3.fromRGB(34, 34, 34)
			Sector.Position = UDim2.new(0, 0, 0, 0)
			Sector.Size = UDim2.new(1, 0, 1, 0)
			Sector.BackgroundTransparency = 0
			Sector.Visible = false
			Title.Name = "Title"
			Title.Parent = Sector
			Title.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
			Title.BackgroundTransparency = 1.000
			Title.BorderColor3 = Color3.fromRGB(0, 0, 0)
			Title.BorderSizePixel = 0
			Title.Position = UDim2.new(0, 0, 0, 0)
			Title.Size = UDim2.new(1, 0, 0, 20)
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
			SectorContent.Position = UDim2.new(0, 0, 0, 25)
			SectorContent.Size = UDim2.new(1, 0, 1, -25)
			SectorContent.CanvasSize = UDim2.new(0, 0, 0, 0)
			SectorContent.ScrollBarThickness = 3
			listLayout.Parent = SectorContent
			listLayout.SortOrder = Enum.SortOrder.LayoutOrder
			listLayout.Padding = UDim.new(0,7)
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
				SectorContent.CanvasSize = UDim2.new(0, 0, 0, listLayout.AbsoluteContentSize.Y)
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
				Text.Size = UDim2.new(1, 0, 0, 13)
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
				Text.Size = UDim2.new(1, 0, 0, 13)
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
				Text.Size = UDim2.new(1, 0, 0, 13)
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
				Text.Size = UDim2.new(1, 0, 0, 13)
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
				TextBox.Size = UDim2.new(1, 0, 0, 21)
				TextBox.ClearTextOnFocus = false
				TextBox.Font = Enum.Font.SourceSans
				TextBox.PlaceholderColor3 = Color3.fromRGB(72, 72, 72)
				TextBox.PlaceholderText = placeholder
				TextBox.Text = default
				TextBox.TextColor3 = themes[theme]["Text"]
				TextBox.TextSize = 14.000
				TextBox.TextStrokeTransparency = 0.800
				TextBox.TextXAlignment = Enum.TextXAlignment.Left
				UIPadding.Parent = TextBox
				UIPadding.PaddingLeft = UDim.new(0, 5)
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
				Button.Size = UDim2.new(1, 0, 0, 21)
				Button.AutoButtonColor = false
				Button.Font = Enum.Font.SourceSans
				Button.TextColor3 = themes[theme]["Text"]
				Button.TextSize = 14.000
				Button.Text = text
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
				local label = text
				dropdown.selected = default
				local up_id = "rbxassetid://74187648454886"
				local down_id = "rbxassetid://97940921082727"
				local Dropdown = Instance.new("TextButton")
				local UIPadding = Instance.new("UIPadding")
				local Image = Instance.new("ImageLabel")
				local DropdownContent = Instance.new("ScrollingFrame")
				local UIPadding_2 = Instance.new("UIPadding")
				local listLayoutDrop = Instance.new("UIListLayout")
				Dropdown.Name = "Dropdown"
				Dropdown.Parent = SectorContent
				Dropdown.BackgroundColor3 = themes[theme]["ElementBg"]
				Dropdown.BorderColor3 = themes[theme]["ElementOutline"]
				Dropdown.Size = UDim2.new(1, 0, 0, 21)
				Dropdown.AutoButtonColor = false
				Dropdown.Font = Enum.Font.SourceSans
				Dropdown.Text = label .. (default and ": " .. default or "")
				Dropdown.TextColor3 = themes[theme]["Text"]
				Dropdown.TextSize = 14.000
				Dropdown.TextXAlignment = Enum.TextXAlignment.Left
				Dropdown.ZIndex = 100
				UIPadding.Parent = Dropdown
				UIPadding.PaddingLeft = UDim.new(0, 5)
				Image.Name = "Image"
				Image.Parent = Dropdown
				Image.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
				Image.BackgroundTransparency = 1.000
				Image.BorderColor3 = Color3.fromRGB(0, 0, 0)
				Image.BorderSizePixel = 0
				Image.Position = UDim2.new(1, -20, 0.14, 0)
				Image.Size = UDim2.new(0, 15, 0, 15)
				Image.Image = down_id
				Image.ImageColor3 = Color3.fromRGB(115, 115, 115)
				Image.ZIndex = 101
				DropdownContent.Name = "DropdownContent"
				DropdownContent.Parent = Dropdown
				DropdownContent.Active = true
				DropdownContent.BackgroundColor3 = themes[theme]["ElementBg"]
				DropdownContent.BorderColor3 = themes[theme]["ElementOutline"]
				DropdownContent.Position = UDim2.new(0, 0, 1, 0)
				DropdownContent.Size = UDim2.new(1, 0, 0, 116)
				DropdownContent.CanvasSize = UDim2.new(0, 0, 0, 0)
				DropdownContent.ScrollBarThickness = 3
				DropdownContent.ScrollBarImageColor3 = Color3.fromRGB(50, 50, 50)
				DropdownContent.Visible = false
				DropdownContent.ZIndex = 102
				UIPadding_2.Parent = DropdownContent
				UIPadding_2.PaddingLeft = UDim.new(0, 5)
				UIPadding_2.PaddingTop = UDim.new(0, 5)
				listLayoutDrop.Parent = DropdownContent
				listLayoutDrop.SortOrder = Enum.SortOrder.LayoutOrder
				listLayoutDrop.Padding = UDim.new(0, 5)
				Dropdown.MouseButton1Down:Connect(function()
					DropdownContent.Visible = not DropdownContent.Visible
					Image.Image = DropdownContent.Visible and up_id or down_id
				end)
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
					Dropdown.Text = label .. ": " .. name
					callback(name)
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
					Button.Size = UDim2.new(1, 0, 0, 21)
					Button.Font = Enum.Font.SourceSans
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
						DropdownContent.Visible = false
						Image.Image = down_id
					end)
					if name == default then
						dropdown.set(name)
					end
				end
				dropdown.remove = function(name)
					local btn = DropdownContent:FindFirstChild(name)
					if btn then
						btn:Destroy()
					end
					if dropdown.selected == name then
						dropdown.selected = ""
						Dropdown.Text = label
					end
				end
				dropdown.delete = function()
					Dropdown:Destroy()
				end
				for _, option in pairs(options) do
					dropdown.add(option)
				end
				DropdownContent.CanvasSize = UDim2.new(0, 0, 0, listLayoutDrop.AbsoluteContentSize.Y)
				sector.increase_scrollbar_size()
				return dropdown
			end
			sector.multidropdown = function(text, options, defaults, callback)
				local dropdown = {}
				local label = text
				dropdown.selected = defaults or {}
				local up_id = "rbxassetid://74187648454886"
				local down_id = "rbxassetid://97940921082727"
				local Dropdown = Instance.new("TextButton")
				local UIPadding = Instance.new("UIPadding")
				local Image = Instance.new("ImageLabel")
				local DropdownContent = Instance.new("ScrollingFrame")
				local UIPadding_2 = Instance.new("UIPadding")
				local listLayoutMulti = Instance.new("UIListLayout")
				Dropdown.Name = "Multidropdown"
				Dropdown.Parent = SectorContent
				Dropdown.BackgroundColor3 = themes[theme]["ElementBg"]
				Dropdown.BorderColor3 = themes[theme]["ElementOutline"]
				Dropdown.Size = UDim2.new(1, 0, 0, 21)
				Dropdown.AutoButtonColor = false
				Dropdown.Font = Enum.Font.SourceSans
				local selected_count = #dropdown.selected
				Dropdown.Text = label .. ": " .. selected_count .. " selected"
				Dropdown.TextColor3 = themes[theme]["Text"]
				Dropdown.TextSize = 14.000
				Dropdown.TextXAlignment = Enum.TextXAlignment.Left
				Dropdown.ZIndex = 100
				UIPadding.Parent = Dropdown
				UIPadding.PaddingLeft = UDim.new(0, 5)
				Image.Name = "Image"
				Image.Parent = Dropdown
				Image.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
				Image.BackgroundTransparency = 1.000
				Image.BorderColor3 = Color3.fromRGB(0, 0, 0)
				Image.BorderSizePixel = 0
				Image.Position = UDim2.new(1, -20, 0.14, 0)
				Image.Size = UDim2.new(0, 15, 0, 15)
				Image.Image = down_id
				Image.ImageColor3 = Color3.fromRGB(115, 115, 115)
				Image.ZIndex = 101
				DropdownContent.Name = "DropdownContent"
				DropdownContent.Parent = Dropdown
				DropdownContent.Active = true
				DropdownContent.BackgroundColor3 = themes[theme]["ElementBg"]
				DropdownContent.BorderColor3 = themes[theme]["ElementOutline"]
				DropdownContent.Position = UDim2.new(0, 0, 1, 0)
				DropdownContent.Size = UDim2.new(1, 0, 0, 116)
				DropdownContent.CanvasSize = UDim2.new(0, 0, 0, 0)
				DropdownContent.ScrollBarThickness = 3
				DropdownContent.ScrollBarImageColor3 = Color3.fromRGB(50, 50, 50)
				DropdownContent.Visible = false
				DropdownContent.ZIndex = 102
				UIPadding_2.Parent = DropdownContent
				UIPadding_2.PaddingLeft = UDim.new(0, 5)
				UIPadding_2.PaddingTop = UDim.new(0, 5)
				listLayoutMulti.Parent = DropdownContent
				listLayoutMulti.SortOrder = Enum.SortOrder.LayoutOrder
				listLayoutMulti.Padding = UDim.new(0, 5)
				Dropdown.MouseButton1Down:Connect(function()
					DropdownContent.Visible = not DropdownContent.Visible
					Image.Image = DropdownContent.Visible and up_id or down_id
				end)
				dropdown.toggle = function(name)
					local index = table.find(dropdown.selected, name)
					if index then
						table.remove(dropdown.selected, index)
					else
						table.insert(dropdown.selected, name)
					end
					local btn = DropdownContent:FindFirstChild(name)
					if btn then
						btn.BorderColor3 = table.find(dropdown.selected, name) and themes[theme]["DropdownSelected"] or themes[theme]["ElementOutline"]
					end
					local count = #dropdown.selected
					Dropdown.Text = label .. ": " .. count .. " selected"
					callback(dropdown.selected)
				end
				dropdown.add = function(name)
					local Button = Instance.new("TextButton")
					Button.Name = name
					Button.Parent = DropdownContent
					Button.BackgroundColor3 = themes[theme]["ElementBg"]
					Button.BorderColor3 = themes[theme]["ElementOutline"]
					Button.Size = UDim2.new(1, 0, 0, 21)
					Button.Font = Enum.Font.SourceSans
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
						dropdown.toggle(name)
					end)
					if table.find(defaults, name) then
						dropdown.toggle(name)
					end
				end
				dropdown.remove = function(name)
					local btn = DropdownContent:FindFirstChild(name)
					if btn then
						btn:Destroy()
					end
					local index = table.find(dropdown.selected, name)
					if index then
						table.remove(dropdown.selected, index)
						local count = #dropdown.selected
						Dropdown.Text = label .. ": " .. count .. " selected"
						callback(dropdown.selected)
					end
				end
				dropdown.delete = function()
					Dropdown:Destroy()
				end
				dropdown.get = function()
					return dropdown.selected
				end
				for _, option in pairs(options) do
					dropdown.add(option)
				end
				DropdownContent.CanvasSize = UDim2.new(0, 0, 0, listLayoutMulti.AbsoluteContentSize.Y)
				sector.increase_scrollbar_size()
				return dropdown
			end
			sector.keybind = function(text, default_key, callback)
				local keybind = {}
				local label = text
				local current_key = default_key or Enum.KeyCode.Unknown
				local capturing = false
				local Keybind = Instance.new("TextButton")
				local Text = Instance.new("TextLabel")
				local UIPadding = Instance.new("UIPadding")
				Keybind.Name = "Keybind"
				Keybind.Parent = SectorContent
				Keybind.BackgroundColor3 = themes[theme]["ElementBg"]
				Keybind.BorderColor3 = themes[theme]["ElementOutline"]
				Keybind.Size = UDim2.new(1, 0, 0, 21)
				Keybind.AutoButtonColor = false
				Keybind.Font = Enum.Font.SourceSans
				Keybind.Text = ""
				Keybind.TextColor3 = themes[theme]["Text"]
				Keybind.TextSize = 14.000
				Keybind.TextXAlignment = Enum.TextXAlignment.Left
				Text.Name = "Text"
				Text.Parent = Keybind
				Text.BackgroundTransparency = 1
				Text.Size = UDim2.new(1, 0, 1, 0)
				Text.Font = Enum.Font.SourceSans
				Text.Text = label .. ": " .. (current_key.Name or "None")
				Text.TextColor3 = themes[theme]["Text"]
				Text.TextSize = 14.000
				Text.TextXAlignment = Enum.TextXAlignment.Left
				UIPadding.Parent = Keybind
				UIPadding.PaddingLeft = UDim.new(0, 5)
				Keybind.MouseButton1Down:Connect(function()
					capturing = true
					Text.Text = label .. ": ... "
				end)
				local connection
				connection = services.uis.InputBegan:Connect(function(input)
					if capturing and input.KeyCode ~= Enum.KeyCode.Unknown then
						capturing = false
						current_key = input.KeyCode
						Text.Text = label .. ": " .. current_key.Name
						callback(current_key)
						connection:Disconnect()
					elseif capturing and input.KeyCode == Enum.KeyCode.Escape then
						capturing = false
						Text.Text = label .. ": " .. (current_key.Name or "None")
						connection:Disconnect()
					end
				end)
				keybind.set = function(key)
					current_key = key
					Text.Text = label .. ": " .. key.Name
					callback(key)
				end
				keybind.get = function()
					return current_key
				end
				keybind.delete = function()
					Keybind:Destroy()
				end
				if default_key then
					keybind.set(default_key)
				end
				sector.increase_scrollbar_size()
				return keybind
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
				Toggle.Size = UDim2.new(1, 0, 0, 21)
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
				Text.Position = UDim2.new(0, 0, 0, 0)
				Text.Size = UDim2.new(1, -30, 1, 0)
				Text.Font = Enum.Font.SourceSans
				Text.TextColor3 = themes[theme]["Text"]
				Text.TextSize = 14.000
				Text.TextStrokeTransparency = 0.800
				Text.TextXAlignment = Enum.TextXAlignment.Left
				Text.Text = text
				Bg.Name = "Bg"
				Bg.Parent = Toggle
				Bg.BorderColor3 = themes[theme]["ElementOutline"]
				Bg.Position = UDim2.new(1, -18, 0.325, 0)
				Bg.Size = UDim2.new(0, 8, 0, 8)
				Bg.Font = Enum.Font.SourceSans
				Bg.Text = ""
				Bg.TextColor3 = Color3.fromRGB(0, 0, 0)
				Bg.TextSize = 14.000
				Bg.AutoButtonColor = false
				UIGradient.Color = ColorSequence.new{ColorSequenceKeypoint.new(0.00, Color3.fromRGB(255, 255, 255)), ColorSequenceKeypoint.new(1.00, Color3.fromRGB(175, 175, 175))}
				UIGradient.Rotation = 90
				UIGradient.Parent = Bg
				toggle.set = function(value)
					if value then
						Bg.BackgroundColor3 = themes[theme]["Toggle"]
					else
						Bg.BackgroundColor3 = themes[theme]["ToggleUnchecked"]
					end
					callback(value)
				end
				toggle.set_text = function(_text)
					Text.Text = _text
				end
				toggle.add_color = function(_default, cpcallback)
					local colorpicker = {}
					local choosing_hue = false
					local choosing_saturation = false
					local sat_conn, hue_conn
					local Colorpicker = Instance.new("TextButton")
					Colorpicker.Name = "Colorpicker"
					Colorpicker.Parent = Toggle
					Colorpicker.BackgroundColor3 = _default
					Colorpicker.BorderColor3 = Color3.fromRGB(40, 40, 40)
					Colorpicker.Position = UDim2.new(1, -30, 0.325, 0)
					Colorpicker.Size = UDim2.new(0, 11, 0, 11)
					Colorpicker.AutoButtonColor = false
					Colorpicker.Font = Enum.Font.SourceSans
					Colorpicker.Text = ""
					Colorpicker.TextColor3 = Color3.fromRGB(0, 0, 0)
					Colorpicker.TextSize = 14.000
					local default_hue, default_saturation, default_value = _default:ToHSV()
					local hue_value = default_hue
					local sat_value = default_saturation
					local value_value = default_value
					local ColorPicker = Instance.new("Frame")
					local Saturation = Instance.new("TextButton")
					local satGradient = Instance.new("UIGradient")
					local valGradient = Instance.new("UIGradient")
					local SaturationDrag = Instance.new("Frame")
					local Hue = Instance.new("ImageButton")
					local SaturationDrag_2 = Instance.new("Frame")
					ColorPicker.Name = "ColorPicker"
					ColorPicker.Parent = Sector
					ColorPicker.BackgroundColor3 = Color3.fromRGB(27, 27, 27)
					ColorPicker.BorderColor3 = Color3.fromRGB(40, 40, 40)
					ColorPicker.BorderSizePixel = 2
					ColorPicker.Size = UDim2.new(0, 125, 0, 100)
					ColorPicker.Visible = false
					Saturation.Name = "Saturation"
					Saturation.Parent = ColorPicker
					Saturation.BackgroundColor3 = Color3.fromHSV(hue_value, 1, 1)
					Saturation.BorderColor3 = Color3.fromRGB(0, 0, 0)
					Saturation.BorderSizePixel = 0
					Saturation.Position = UDim2.new(0.288, 0, 0.13, 0)
					Saturation.Size = UDim2.new(0, 76, 0, 76)
					Saturation.Font = Enum.Font.SourceSans
					Saturation.Text = ""
					Saturation.TextColor3 = Color3.fromRGB(0, 0, 0)
					Saturation.TextSize = 14.000
					Saturation.AutoButtonColor = false
					satGradient.Color = ColorSequence.new{
						ColorSequenceKeypoint.new(0, Color3.fromHSV(hue_value, 0, 1)),
						ColorSequenceKeypoint.new(1, Color3.fromHSV(hue_value, 1, 1))
					}
					satGradient.Rotation = 0
					satGradient.Parent = Saturation
					valGradient.Color = ColorSequence.new{
						ColorSequenceKeypoint.new(0, Color3.new(0,0,0)),
						ColorSequenceKeypoint.new(1, Color3.new(1,1,1))
					}
					valGradient.Rotation = -90
					valGradient.Parent = Saturation
					SaturationDrag.Name = "SaturationDrag"
					SaturationDrag.Parent = Saturation
					SaturationDrag.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
					SaturationDrag.BorderColor3 = Color3.fromRGB(0, 0, 0)
					SaturationDrag.BorderSizePixel = 0
					SaturationDrag.Size = UDim2.new(0, 4, 0, 4)
					SaturationDrag.Position = UDim2.new(sat_value, -2, 1 - value_value, -2)
					Hue.Name = "Hue"
					Hue.Parent = ColorPicker
					Hue.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
					Hue.BorderColor3 = Color3.fromRGB(0, 0, 0)
					Hue.BorderSizePixel = 0
					Hue.Position = UDim2.new(0.112, 0, 0.13, 0)
					Hue.Size = UDim2.new(0, 13, 0, 76)
					Hue.Image = "rbxassetid://129669031573073"
					Hue.AutoButtonColor = false
					SaturationDrag_2.Name = "SaturationDrag_2"
					SaturationDrag_2.Parent = Hue
					SaturationDrag_2.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
					SaturationDrag_2.BorderColor3 = Color3.fromRGB(0, 0, 0)
					SaturationDrag_2.BorderSizePixel = 1
					SaturationDrag_2.Size = UDim2.new(1, 0, 0, 3)
					SaturationDrag_2.Position = UDim2.new(0, 0, 1 - hue_value, 0)
					local function updateColor()
						local mouse = services.uis:GetMouseLocation()
						if choosing_saturation then
							local abs_pos = Saturation.AbsolutePosition
							local abs_size = Saturation.AbsoluteSize
							local rel_x = math.clamp((mouse.X - abs_pos.X) / abs_size.X, 0, 1)
							local rel_y = math.clamp((mouse.Y - abs_pos.Y) / abs_size.Y, 0, 1)
							colorpicker.set(hue_value, rel_x, 1 - rel_y)
						elseif choosing_hue then
							local abs_pos = Hue.AbsolutePosition
							local abs_size = Hue.AbsoluteSize
							local rel_y = math.clamp((mouse.Y - abs_pos.Y) / abs_size.Y, 0, 1)
							colorpicker.set(1 - rel_y, sat_value, value_value)
						end
					end
					Colorpicker.MouseButton1Down:Connect(function()
						for _, element in pairs(Sector:GetChildren()) do
							if element.Name == "ColorPicker" and element ~= ColorPicker then
								element.Visible = false
							end
						end
						local abs_pos = Colorpicker.AbsolutePosition
						ColorPicker.Position = UDim2.new(0, abs_pos.X - Sector.AbsolutePosition.X - 120, 0, abs_pos.Y - Sector.AbsolutePosition.Y + Colorpicker.AbsoluteSize.Y + 5)
						ColorPicker.Visible = not ColorPicker.Visible
					end)
					colorpicker.set = function(h, s, v)
						hue_value = h
						sat_value = s
						value_value = v
						SaturationDrag.Position = UDim2.new(s, -2, 1 - v, -2)
						SaturationDrag_2.Position = UDim2.new(0, 0, 1 - h, 0)
						Saturation.BackgroundColor3 = Color3.fromHSV(h, 1, 1)
						satGradient.Color = ColorSequence.new{
							ColorSequenceKeypoint.new(0, Color3.fromHSV(h, 0, 1)),
							ColorSequenceKeypoint.new(1, Color3.fromHSV(h, 1, 1))
						}
						local color = Color3.fromHSV(h, s, v)
						Colorpicker.BackgroundColor3 = color
						cpcallback(color)
					end
					Saturation.InputBegan:Connect(function(input)
						if input.UserInputType == Enum.UserInputType.MouseButton1 then
							choosing_saturation = true
							sat_conn = services.run.RenderStepped:Connect(updateColor)
						end
					end)
					Saturation.InputEnded:Connect(function(input)
						if input.UserInputType == Enum.UserInputType.MouseButton1 then
							choosing_saturation = false
							if sat_conn then
								sat_conn:Disconnect()
								sat_conn = nil
							end
						end
					end)
					Hue.InputBegan:Connect(function(input)
						if input.UserInputType == Enum.UserInputType.MouseButton1 then
							choosing_hue = true
							hue_conn = services.run.RenderStepped:Connect(updateColor)
						end
					end)
					Hue.InputEnded:Connect(function(input)
						if input.UserInputType == Enum.UserInputType.MouseButton1 then
							choosing_hue = false
							if hue_conn then
								hue_conn:Disconnect()
								hue_conn = nil
							end
						end
					end)
					colorpicker.set(default_hue, default_saturation, default_value)
					return colorpicker
				end
				toggle.get = function()
					return value
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
				local value = default
				local Slider = Instance.new("TextButton")
				local Text = Instance.new("TextLabel")
				local Bg = Instance.new("TextButton")
				local UIGradient = Instance.new("UIGradient")
				local Fill = Instance.new("TextButton")
				local UIGradient_2 = Instance.new("UIGradient")
				Slider.Name = "Slider"
				Slider.Parent = SectorContent
				Slider.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
				Slider.BackgroundTransparency = 1.000
				Slider.BorderColor3 = Color3.fromRGB(0, 0, 0)
				Slider.BorderSizePixel = 0
				Slider.Size = UDim2.new(1, 0, 0, 21)
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
				Text.Position = UDim2.new(0, 0, 0, 0)
				Text.Size = UDim2.new(1, 0, 0.6, 0)
				Text.Font = Enum.Font.SourceSans
				Text.TextColor3 = themes[theme]["Text"]
				Text.TextSize = 14.000
				Text.TextStrokeTransparency = 0.800
				Text.TextXAlignment = Enum.TextXAlignment.Left
				Bg.Name = "Bg"
				Bg.Parent = Slider
				Bg.BackgroundColor3 = themes[theme]["SliderBg"]
				Bg.BorderColor3 = themes[theme]["ElementOutline"]
				Bg.Position = UDim2.new(0, 0, 0.7, 0)
				Bg.Size = UDim2.new(1, 0, 0.3, 0)
				Bg.AutoButtonColor = false
				Bg.Font = Enum.Font.SourceSans
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
				Fill.Size = UDim2.new((default - min) / (max - min), 0, 1, 0)
				Fill.AutoButtonColor = false
				Fill.Font = Enum.Font.SourceSans
				Fill.Text = ""
				Fill.TextColor3 = Color3.fromRGB(0, 0, 0)
				Fill.TextSize = 14.000
				UIGradient_2.Color = ColorSequence.new{
					ColorSequenceKeypoint.new(0.00, Color3.fromRGB(255, 255, 255)),
					ColorSequenceKeypoint.new(1.00, Color3.fromRGB(175, 175, 175))
				}
				UIGradient_2.Rotation = 90
				UIGradient_2.Parent = Fill
				slider.set = function(val)
					value = val
					local percentage = ((val - min) / (max - min))
					Fill.Size = UDim2.new(percentage, 0, 1, 0)
					Text.Text = text .. " " .. string.format("%.2f", val) .. indicator
					callback(val)
				end
				slider.get = function()
					return value
				end
				slider.set_text = function(_text)
					text = _text
					Text.Text = text .. " " .. string.format("%.2f", value) .. indicator
				end
				local function onInputBegan(input)
					if input.UserInputType == Enum.UserInputType.MouseButton1 then
						dragging = true
					end
				end
				local function onInputEnded(input)
					if input.UserInputType == Enum.UserInputType.MouseButton1 then
						dragging = false
					end
				end
				Bg.InputBegan:Connect(onInputBegan)
				Bg.InputEnded:Connect(onInputEnded)
				Fill.InputBegan:Connect(onInputBegan)
				Fill.InputEnded:Connect(onInputEnded)
				local drag_conn = services.run.RenderStepped:Connect(function()
					if dragging then
						local mouse_pos = services.uis:GetMouseLocation()
						local abs_pos = Bg.AbsolutePosition
						local abs_size = Bg.AbsoluteSize
						local rel_x = math.clamp((mouse_pos.X - abs_pos.X) / abs_size.X, 0, 1)
						local new_val = min + rel_x * (max - min)
						slider.set(new_val)
					end
				end)
				slider.delete = function()
					if drag_conn then
						drag_conn:Disconnect()
					end
					Slider:Destroy()
				end
				slider.set(default)
				sector.increase_scrollbar_size()
				return slider
			end
			table.insert(window.tab_contents, {Tab.Name, Sector})
			if #window.tab_contents == 1 then
				window.selected_tab = Tab.Name
				window.tab_colors(Tab)
				window.show_tab(Tab.Name)
			end
			return sector
		end
		return tab
	end
	return window
end
return lib
