local EnableCayoMiniMap = false

CreateThread(function()
    SetMapZoomDataLevel(0, 2.75, 0.9, 0.08, 0.0, 0.0) -- Level 0
    SetMapZoomDataLevel(1, 2.8, 0.9, 0.08, 0.0, 0.0) -- Level 1
    SetMapZoomDataLevel(2, 8.0, 0.9, 0.08, 0.0, 0.0) -- Level 2
    SetMapZoomDataLevel(3, 20.0, 0.9, 0.08, 0.0, 0.0) -- Level 3
    SetMapZoomDataLevel(4, 35.0, 0.9, 0.08, 0.0, 0.0) -- Level 4
    SetMapZoomDataLevel(5, 55.0, 0.0, 0.1, 2.0, 1.0) -- ZOOM_LEVEL_GOLF_COURSE
    SetMapZoomDataLevel(6, 450.0, 0.0, 0.1, 1.0, 1.0) -- ZOOM_LEVEL_INTERIOR
    SetMapZoomDataLevel(7, 4.5, 0.0, 0.0, 0.0, 0.0) -- ZOOM_LEVEL_GALLERY
    SetMapZoomDataLevel(8, 11.0, 0.0, 0.0, 2.0, 3.0) -- ZOOM_LEVEL_GALLERY_MAXIMIZE
    SetRadarZoom(1200) -- Radar zoom one time on resource start
end)

local function UpdateRadarZoom() -- Some people have reported that the minimap is buggy...
    SetRadarZoom(1100)
    SetTimeout(10000, UpdateRadarZoom)
end

UpdateRadarZoom()

if EnableCayoMiniMap then
    local function CreateBlip()
        local BlipCoords = {
            vec3(4800.85, -6159.22, 0.0),
            vec3(6420.60, -5169.87, 37.43),
        }
        for coords=1, #BlipCoords do
            local coords = BlipCoords[coords]
            local blip = AddBlipForCoord(coords.x, coords.y, coords.z)
            SetBlipSprite(blip, 1)
            SetBlipAlpha(blip, 0)
            SetBlipScale(blip, 0.1)
            SetBlipAsShortRange(blip, true)
        end
    end
    CreateThread(function()
        CreateBlip()
        while true do
            SetRadarAsExteriorThisFrame()
            local coords = vec(4700.0, -5145.0)
            SetRadarAsInteriorThisFrame(`h4_fake_islandx`, coords.x, coords.y, 0, 0)
            Wait(0)
        end
    end)
end

-- Disabling HUD

SatNav = {
  ["NONE"] = {icon = 0},
  ["UP"] = {icon = 1},
  ["DOWN"] = {icon = 2},
  ["LEFT"] = {icon = 3},
  ["RIGHT"] = {icon = 4},
  ["EXIT_LEFT"] = {icon = 5},
  ["EXIT_RIGHT"] = {icon = 6},
  ["UP_LEFT"] = {icon = 7},
  ["UP_RIGHT"] = {icon = 8},
  ["MERGE_RIGHT"] = {icon = 9},
  ["MERGE_LEFT"] = {icon = 10},
  ["UTURN"] = {icon = 11},
}

MinimapScaleform = {
  scaleform = nil,
}

local function getMinimap()
  return MinimapScaleform.scaleform
end

function SetSatNavDirection(direction)
  local dir = SatNav[direction]
  if type(direction) == 'number' then
      dir = direction
  end
  if dir then
      BeginScaleformMovieMethod(getMinimap(), "SET_SATNAV_DIRECTION")
      ScaleformMovieMethodAddParamInt(dir.icon)
      EndScaleformMovieMethod()
  end
end

function SetSatNavDistance(distance)
  BeginScaleformMovieMethod(getMinimap(), "SET_SATNAV_DISTANCE")
  ScaleformMovieMethodAddParamInt(distance)
  EndScaleformMovieMethod()
end

function SetSatNavState(show)
  BeginScaleformMovieMethod(getMinimap(), (show and "SHOW_SATNAV" or "HIDE_SATNAV"))
  EndScaleformMovieMethod()
end

function SetStallWarningState(show)
  BeginScaleformMovieMethod(getMinimap(), "SHOW_STALL_WARNING")
  ScaleformMovieMethodAddParamBool(show)
  EndScaleformMovieMethod()
end

function SetAbilityGlow(show)
  BeginScaleformMovieMethod(getMinimap(), "SET_ABILITY_BAR_GLOW")
  ScaleformMovieMethodAddParamBool(show)
  EndScaleformMovieMethod()
end

function SetAbilityVisible(show)
  BeginScaleformMovieMethod(getMinimap(), "SET_ABILITY_BAR_VISIBILITY_IN_MULTIPLAYER")
  ScaleformMovieMethodAddParamBool(show)
  EndScaleformMovieMethod()
end

function ShowYoke(x, y, vis, alpha)
  BeginScaleformMovieMethod(getMinimap(), "SHOW_YOKE")
  ScaleformMovieMethodAddParamFloat(show)
  ScaleformMovieMethodAddParamFloat(show)
  ScaleformMovieMethodAddParamBool(show)
  ScaleformMovieMethodAddParamInt(alpha)
  EndScaleformMovieMethod()
end

function SetHealthArmorType(type)
  BeginScaleformMovieMethod(getMinimap(), "SETUP_HEALTH_ARMOUR")
  ScaleformMovieMethodAddParamInt(type)
  EndScaleformMovieMethod()
end

function SetHealthAmount(amount)
  BeginScaleformMovieMethod(getMinimap(), "SET_PLAYER_HEALTH")
  ScaleformMovieMethodAddParamInt(amount)
  ScaleformMovieMethodAddParamFloat(0)
  ScaleformMovieMethodAddParamFloat(2000)
  ScaleformMovieMethodAddParamBool(false)
  EndScaleformMovieMethod()
end

function SetArmorAmount(amount)
  BeginScaleformMovieMethod(getMinimap(), "SET_PLAYER_ARMOUR")
  ScaleformMovieMethodAddParamInt(amount)
  ScaleformMovieMethodAddParamFloat(0)
  ScaleformMovieMethodAddParamFloat(2000)
  EndScaleformMovieMethod()
end

function SetAbilityAmount(amount)
  BeginScaleformMovieMethod(getMinimap(), "SET_ABILITY_BAR")
  ScaleformMovieMethodAddParamInt(amount)
  ScaleformMovieMethodAddParamInt(0)
  ScaleformMovieMethodAddParamFloat(100)
  EndScaleformMovieMethod()
end

function SetAirAmount(amount)
  BeginScaleformMovieMethod(getMinimap(), "SET_AIR_BAR")
  ScaleformMovieMethodAddParamFloat(amount)
  EndScaleformMovieMethod()
end