--[[
    Quantum Helper:
    - Visual Customizer
    - FPS Booster
    - Hit Logs
    - Auto Console Cleaner
]]

-- ===== ГЛОБАЛЬНЫЕ НАСТРОЙКИ ===== --
local quantum_enabled = ui.new_checkbox("LUA", "A", "Enable Quantum Helper")
local section = ui.new_combobox("LUA", "A", "Section", {"Visual", "Misc"})

-- ===== ВИЗУАЛЬНЫЕ НАСТРОЙКИ ===== --
local visual = {
    fov = ui.new_slider("LUA", "A", "Weapon FOV", 54, 150, 90, true, "°", 1),
    view_x = ui.new_slider("LUA", "A", "Viewmodel X", -300, 300, 200, true, "", 1),
    view_y = ui.new_slider("LUA", "A", "Viewmodel Y", -300, 300, 0, true, "", 1),
    view_z = ui.new_slider("LUA", "A", "Viewmodel Z", -300, 300, -200, true, "", 1),
    aspect = ui.new_slider("LUA", "A", "Aspect Ratio", 50, 200, 177, true, "%", 1),
    hud = ui.new_slider("LUA", "A", "Interface", 0, 1, 1, true, "", 1),
    kill_list = ui.new_checkbox("LUA", "A", "Custom Kill List"),
    kill_x = ui.new_slider("LUA", "A", "Kill List X", 0, 1920, 1500, true, "px", 1),
    kill_y = ui.new_slider("LUA", "A", "Kill List Y", 0, 1080, 50, true, "px", 1)
}

-- ===== MISC НАСТРОЙКИ ===== --
local misc = {
    fps_boost = ui.new_checkbox("LUA", "A", "FPS Boost"),
    clear_console = ui.new_checkbox("LUA", "A", "Auto Clear Console"),
    clear_timer = ui.new_slider("LUA", "A", "Clear Interval", 0, 120, 60, true, "s", 1),
    hit_logs = ui.new_checkbox("LUA", "A", "Hit Logs")
}

-- ===== СИСТЕМА ВИДИМОСТИ ===== --
local function update_ui()
    local enabled = ui.get(quantum_enabled)
    local current_section = ui.get(section)
    
    -- Visual
    ui.set_visible(visual.fov, enabled and current_section == "Visual")
    ui.set_visible(visual.view_x, enabled and current_section == "Visual")
    ui.set_visible(visual.view_y, enabled and current_section == "Visual")
    ui.set_visible(visual.view_z, enabled and current_section == "Visual")
    ui.set_visible(visual.aspect, enabled and current_section == "Visual")
    ui.set_visible(visual.hud, enabled and current_section == "Visual")
    ui.set_visible(visual.kill_list, enabled and current_section == "Visual")
    ui.set_visible(visual.kill_x, enabled and current_section == "Visual" and ui.get(visual.kill_list))
    ui.set_visible(visual.kill_y, enabled and current_section == "Visual" and ui.get(visual.kill_list))
    
    -- Misc
    ui.set_visible(misc.fps_boost, enabled and current_section == "Misc")
    ui.set_visible(misc.clear_console, enabled and current_section == "Misc")
    ui.set_visible(misc.clear_timer, enabled and current_section == "Misc" and ui.get(misc.clear_console))
    ui.set_visible(misc.hit_logs, enabled and current_section == "Misc")
    ui.set_visible(section, enabled)
end

-- ===== FPS BOOST ===== --
local function fps_optimize()
    client.set_cvar("r_drawtracers", 0)
    client.set_cvar("r_drawparticles", 0)
    client.set_cvar("mat_postprocess_enable", 0)
    client.set_cvar("cl_forcepreload", 1)
    client.set_cvar("r_dynamic", 0)
end

-- ===== HIT LOGS ===== --
client.set_event_callback("player_hurt", function(e)
    if ui.get(misc.hit_logs) then
        local hitgroups = {"Body", "Head", "Chest", "Stomach", "Left Arm", "Right Arm", "Left Leg", "Right Leg", "Neck", "?", "Gear"}
        local dmg = e.dmg_health
        local name = entity.get_player_name(e.userid)
        local group = hitgroups[e.hitgroup + 1] or "Unknown"
        client.color_log(255, 165, 0, string.format("[HIT] %s | %d dmg | %s", name, dmg, group))
    end
end)

-- ===== MAIN LOOP ===== --
local last_clear = 0
client.set_event_callback("paint", function()
    if not ui.get(quantum_enabled) then return end

    -- Visuals
    if ui.get(section) == "Visual" then
        client.set_cvar("viewmodel_fov", ui.get(visual.fov))
        client.set_cvar("viewmodel_offset_x", ui.get(visual.view_x)/100)
        client.set_cvar("viewmodel_offset_y", ui.get(visual.view_y)/100)
        client.set_cvar("viewmodel_offset_z", ui.get(visual.view_z)/100)
        client.set_cvar("r_aspectratio", ui.get(visual.aspect)/100)
        client.set_cvar("cl_drawhud", ui.get(visual.hud))
    end

    -- Misc
    if ui.get(misc.fps_boost) then fps_optimize() end
    
    if ui.get(misc.clear_console) and (globals.realtime() - last_clear) > ui.get(misc.clear_timer) then
        client.exec("clear")
        last_clear = globals.realtime()
    end
end)

-- ===== ИНИЦИАЛИЗАЦИЯ ===== --
for _, v in pairs(visual) do ui.set_visible(v, false) end
for _, v in pairs(misc) do ui.set_visible(v, false) end
ui.set_visible(section, false)

ui.set_callback(quantum_enabled, update_ui)
ui.set_callback(section, update_ui)
ui.set_callback(visual.kill_list, update_ui)
ui.set_callback(misc.clear_console, update_ui)
