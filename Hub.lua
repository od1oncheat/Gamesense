local lib = loadstring(game:HttpGet("https://raw.githubusercontent.com/od1oncheat/Gamesense/refs/heads/main/Hub.lua"))()

local window = lib.create_window("gamesense", Enum.KeyCode.RightShift)

local rage_tab = window.create_tab("rbxassetid://10464044451")
local legit_tab = window.create_tab("rbxassetid://4483345998") 
local misc_tab = window.create_tab("rbxassetid://10464234466")

-- Rage Tab
local rage_sector1 = rage_tab.create_sector("Aimbot")
local rage_sector2 = rage_tab.create_sector("Other")

rage_sector1.toggle("Enabled", false, function(value)
    print("Aimbot:", value)
end)

rage_sector1.slider("Field of View", "°", 1, 180, 90, function(value)
    print("FOV:", value)
end)

rage_sector1.dropdown("Hitbox", {"Head", "Torso", "Arms", "Legs"}, "Head", function(value)
    print("Hitbox:", value)
end)

rage_sector2.button("Rage Mode", function()
    print("Rage mode activated!")
end)

-- Legit Tab  
local legit_sector1 = legit_tab.create_sector("Aimbot")
local legit_sector2 = legit_tab.create_sector("Triggerbot")

legit_sector1.toggle("Legit Aimbot", true, function(value)
    print("Legit Aimbot:", value)
end)

legit_sector1.slider("Smoothness", "%", 1, 100, 50, function(value)
    print("Smoothness:", value)
end)

legit_sector2.toggle("Triggerbot", false, function(value)
    print("Triggerbot:", value)
end)

-- Misc Tab
local misc_sector1 = misc_tab.create_sector("Visuals")
local misc_sector2 = misc_tab.create_sector("Settings")

misc_sector1.toggle("ESP", true, function(value)
    print("ESP:", value)
end)

local color_toggle = misc_sector1.toggle("Custom Color", false, function(value)
    print("Custom Color:", value)
end)

local colorpicker = color_toggle.add_color(Color3.fromRGB(255, 0, 0), function(color)
    print("Selected color:", color)
end)

misc_sector2.textbox("Config Name", "default", function(value)
    print("Config:", value)
end)

misc_sector2.dropdown("Theme", {"Dark", "Light", "Blue"}, "Dark", function(value)
    print("Theme:", value)
end)

-- Показать первую вкладку по умолчанию
window.show_tab(rage_tab.Name)
window.tab_colors(rage_tab)
