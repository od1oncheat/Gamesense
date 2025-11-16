gamesense ui library
a modern, customizable ui library for roblox scripting with a gamesense-inspired design.

Installation
```
local Gamesense = loadstring(game:HttpGet("https://raw.githubusercontent.com/od1oncheat/Gamesense/refs/heads/main/gamesense.lua"))()
```

Quick Start

```
local lib = loadstring(game:HttpGet("https://raw.githubusercontent.com/od1oncheat/Gamesense/refs/heads/main/gamesense.lua"))()

-- create a window with gamesense theme and insert toggle key
local window = lib.create_window("gamesense", Enum.KeyCode.Insert)

-- create a tab with an icon
local combat_tab = window.create_tab("rbxassetid://123456789") -- replace with actual icon id

-- create a sector (max 2 per tab)
local aimbot_sector = combat_tab.create_sector("aimbot")

-- add ui elements
aimbot_sector.toggle("enable aimbot", false, function(value)
    print("aimbot:", value)
end)

aimbot_sector.slider("fov", "°", 1, 360, 30, function(value)
    print("fov:", value)
end)
```
Complete Example
```
local lib = loadstring(game:HttpGet("https://raw.githubusercontent.com/od1oncheat/Gamesense/refs/heads/main/gamesense.lua"))()

-- initialize window
local window = lib.create_window("gamesense", Enum.KeyCode.Insert)

-- combat tab
local combat = window.create_tab("rbxassetid://7072706620") -- sword icon
local aimbot = combat.create_sector("aimbot")
local trigger = combat.create_sector("trigger bot")

-- visuals tab  
local visuals = window.create_tab("rbxassetid://7072718225") -- eye icon
local esp = visuals.create_sector("esp")
local chams = visuals.create_sector("chams")

-- aimbot section
aimbot.toggle("enabled", true, function(value)
    print("aimbot enabled:", value)
end)

aimbot.dropdown("hitbox", {"head", "torso", "random"}, "head", function(selected)
    print("selected hitbox:", selected)
end)

aimbot.slider("smoothness", "%", 1, 100, 50, function(value)
    print("smoothness:", value)
end)

aimbot.multicombobox("checks", {"visible", "team", "alive"}, {"visible", "alive"}, function(selected)
    print("active checks:")
    for check, active in pairs(selected) do
        print(check, "=", active)
    end
end)

-- trigger bot section
trigger.toggle("auto shoot", false, function(value)
    print("auto shoot:", value)
end)

trigger.textbox("delay (ms)", "100", function(value)
    print("trigger delay:", value)
end)

trigger.button("test trigger", function()
    print("trigger test executed!")
end)

-- esp section
esp.toggle("player esp", true, function(value)
    print("player esp:", value)
end)

local esp_toggle = esp.toggle("box esp", false, function(value)
    print("box esp:", value)
end)

-- add color picker to the toggle
esp_toggle.add_color(Color3.fromRGB(255, 0, 0), function(color)
    print("esp color:", color)
end)

esp.slider("max distance", " studs", 0, 1000, 500, function(value)
    print("max distance:", value)
end)

-- info elements
esp.text("esp settings")
esp.warning("esp may cause lag")
esp.error("don't use in competitive!")
esp.info("works best with 100+ fps")

-- dropdown with multiple options
local weapon_dropdown = trigger.dropdown("weapon filter", {"any", "rifle", "pistol", "sniper"}, "any", function(selected)
    print("weapon filter:", selected)
end)

-- add more options dynamically
weapon_dropdown.add("shotgun")

-- multi-combobox example
local features = esp.multicombobox("esp features", {"name", "distance", "health", "weapon"}, {"name", "distance"}, function(selected)
    print("active esp features:")
    for feature, active in pairs(selected) do
        print(feature, "=", active)
    end
end)

-- remove a feature
features.remove("weapon")

-- clear all selections
features.clear()
```

api reference
window creation
```
local window = lib.create_window(theme, toggle_key)
```
theme: currently only "gamesense"
toggle_key: enum.keycode for toggling ui visibility

tabs
```
local tab = window.create_tab(icon_image_id)
```
icon_image_id: roblox image asset id
returns: tab object

sectors
```
local sector = tab.create_sector(name)
```
name: sector title
maximum 2 sectors per tab
returns: sector object

ui elements
toggle
```
local toggle = sector.toggle(text, default, callback)
```
text: display text
default: initial state (boolean)
callback: function called when value changes

color picker (attached to toggle)
```
toggle.add_color(default_color, callback)
```
default_color: color3 initial color
callback: function called when color changes

slider
```
local slider = sector.slider(text, indicator, min, max, default, callback)
```
text: display text
indicator: unit indicator (e.g., "°", "%")
min/max: value range
default: initial value
callback: function called when value changes

dropdown
```
local dropdown = sector.dropdown(text, options, default, callback)
```
text: display text
options: table of string options
default: default selected option
callback: function called when selection changes

multi-combobox
```
local multicombobox = sector.multicombobox(text, options, defaults, callback)
```
text: display text
options: table of string options
defaults: table of default selected options
callback: function called when selections change


button
```
local button = sector.button(text, callback)
```
text: button text
callback: function called when clicked

textbox
```
local textbox = sector.textbox(placeholder, default, callback)
```
placeholder: placeholder text
default: default text
callback: function called when text changes

text elements
```
sector.text("normal text")
sector.warning("warning text")
sector.error("error text") 
sector.info("info text")
```

features
🎨 gamesense-inspired gradient design
🖱️ smooth dragging and animations
🎯 multiple element types (toggles, sliders, dropdowns, etc.)
🎪 color pickers with hsv selection
📱 responsive layout with scrolling
🔒 anti-detection gui protection
⚡ performance optimized

element methods
dropdown methods
```
dropdown.set(option_name) -- select option
dropdown.add(option_name) -- add new option
dropdown.remove(option_name) -- remove option
dropdown.get() -- get current selection
```
multi-combobox methods
```
multicombobox.set(option, value) -- set option state
multicombobox.get(option) -- get option state
multicombobox.get_all() -- get all states
multicombobox.clear() -- clear all selections
multicombobox.add(option) -- add new option
multicombobox.remove(option) -- remove option
```
slider methods
```
slider.set(value) -- set slider value
slider.get() -- get current value
```
textbox methods
```
textbox.set(text) -- set text
textbox.get() -- get current text
```
notes

the ui can be toggled with the specified key (default: insert)

supports multiple executors with gui protection

each tab can have up to 2 sectors

all elements include hover animations and visual feedback

color pickers use hsv color model for accurate color selection

security
the library includes built-in gui protection for various executors:

synapse x
script-ware

other common exploit environments

the ui automatically parents to the safest available location to prevent detection.

example menu

<img width="697" height="625" alt="image" src="https://github.com/user-attachments/assets/c5a7282d-365e-439a-9ef6-9044ff1f93e6" />
```
local lib = loadstring(game:HttpGet("https://raw.githubusercontent.com/od1oncheat/Gamesense/refs/heads/main/gamesense.lua"))()

-- initialize window
local window = lib.create_window("gamesense", Enum.KeyCode.Insert)

-- rage tab
local rage = window.create_tab("rbxassetid://18484264435") -- rage icon
local rage_aim = rage.create_sector("aimbot")
local rage_resolver = rage.create_sector("resolver")

-- legit tab
local legit = window.create_tab("rbxassetid://14695120237") -- legit icon
local legit_aim = legit.create_sector("triggerbot")
local legit_movement = legit.create_sector("movement")

-- antiaim tab
local antiaim = window.create_tab("rbxassetid://7992557358") -- antiaim icon
local antiaim_angles = antiaim.create_sector("angles")
local antiaim_fake = antiaim.create_sector("fake lag")

-- visuals tab
local visuals = window.create_tab("rbxassetid://5881046614") -- visuals icon
local visuals_esp = visuals.create_sector("esp")
local visuals_chams = visuals.create_sector("chams")

-- misc tab
local misc = window.create_tab("rbxassetid://7059346373") -- misc icon
local misc_exploits = misc.create_sector("exploits")
local misc_other = misc.create_sector("other")

-- playerlist tab
local playerlist = window.create_tab("rbxassetid://15016878198") -- playerlist icon
local playerlist_main = playerlist.create_sector("players")
local playerlist_actions = playerlist.create_sector("actions")

-- config tab
local config = window.create_tab("rbxassetid://78388764182737") -- config icon
local config_load = config.create_sector("load/save")
local config_settings = config.create_sector("settings")
```
