extends Control

var config = ConfigFile.new()

func _on_pressed() -> void:
  $"../LoadConfigWindow".visible = true

# iterate through all keys in the specific section
# to get the value of the key
func get_config_value(section: String):
  var data = {}
  for key in config.get_section_keys(section):
    data[key] = config.get_value(section, key)
  return data


func _on_load_config_window_file_selected(path: String) -> void:
  var err = config.load(path)
  
  if err != OK:
    print("Load config failed: something wrong inside the file")
    return
  elif path.get_extension() != "cfg":
    print("Load config failed: not a config file")
    return
  
  
  # get the value from loaded config
  # Color Correction
  var color_correction = get_config_value("Color Correction")
  var tonemap_id = color_correction.TonemapType
  var gamma_value = color_correction.Gamma
  var exposure_on = color_correction.EnableExposure
  var exposure_value = color_correction.Exposure
  var saturation_on = color_correction.EnableSaturation
  var saturation_value = color_correction.Saturation
  var tint_on = color_correction.EnableTint
  var low_tint_val = color_correction.TintLow
  var high_tint_val = color_correction.TintHigh
  
  
  # Terrain Lighting
  var terrain_lighting = get_config_value("Terrain Lighting")
  var sun_intens_val = terrain_lighting.SunIntensity
  var torch_intens_val = terrain_lighting.TorchIntensity
  var night_bright_val = terrain_lighting.NightBrightness
  var cave_bright_val = terrain_lighting.CaveBrightness
  var shadow_intens_val = terrain_lighting.ShadowIntensity
  var blinking_torch = terrain_lighting.EnableBlinkingTorch
  var cloud_shadow = terrain_lighting.EnableCloudShadow
  
  
  # terrain color
  var terrain_color : Dictionary = {}
  var terrain_col = get_config_value("Terrain Color")
  terrain_color["morning"] = terrain_col.MorningSunCol
  terrain_color["noon"] = terrain_col.NoonSunCol
  terrain_color["night"] = terrain_col.NightSunCol
  
  
  # Fog
  var fog = get_config_value("Fog Effects")
  var fog_on = fog.EnableFog
  var fog_value = fog.Fog
  var mist_dens = fog.MistDensity
  var rain_mist_on = fog.EnableRainMist
  var rain_mist_opacity = fog.RainMistOpacity
  var cloudy_fog_on = fog.EnableCloudyFog
  var cloudy_fog_val = fog.CloudyFog
  
  
  # Sky Color
  var zenith : Dictionary = {}
  var horizon : Dictionary = {}
  var sky_color = get_config_value("Sky Color")
  zenith["day"] = sky_color.DayZenith
  horizon["day"] = sky_color.DayHorizon
  zenith["night"] = sky_color.NightZenith
  horizon["night"] = sky_color.NightHorizon
  zenith["rain"] = sky_color.RainZenith
  horizon["rain"] = sky_color.RainHorizon
  zenith["end"] = sky_color.EndZenith
  horizon["end"] = sky_color.EndHorizon
  zenith["dawn"] = sky_color.DawnZenith
  horizon["dawn"] = sky_color.DawnHorizon
  var dawn_edge = sky_color.DawnEdge
  
  
  # Wave
  var wave = get_config_value("Wave")
  var plantw_on = wave.EnablePlantWave
  var plant_wave_val = wave.PlantWave
  var lanternw_on = wave.EnableLanternWave
  var lantern_wave_val = wave.LanternWave
  var wave_speed = wave.WaveSpeed
  var wave_range = wave.WaveRange
  
  
  # set the value to global uniform
  # Color Correction
  RenderingServer.global_shader_parameter_set(&"TonemapType", tonemap_id)
  RenderingServer.global_shader_parameter_set(&"Gamma", gamma_value)
  RenderingServer.global_shader_parameter_set(&"EExposure", exposure_on)
  RenderingServer.global_shader_parameter_set(&"Exposure", exposure_value)
  RenderingServer.global_shader_parameter_set(&"ESaturation", saturation_on)
  RenderingServer.global_shader_parameter_set(&"Saturation", saturation_value)
  RenderingServer.global_shader_parameter_set(&"Tint", tint_on)
  RenderingServer.global_shader_parameter_set(&"LTint", low_tint_val)
  RenderingServer.global_shader_parameter_set(&"HTint", high_tint_val)
  
  
  # Terrain Lighting
  RenderingServer.global_shader_parameter_set(&"SunIntensity", sun_intens_val)
  RenderingServer.global_shader_parameter_set(&"TorchIntensity", torch_intens_val)
  RenderingServer.global_shader_parameter_set(&"NightBrighness", night_bright_val)
  RenderingServer.global_shader_parameter_set(&"CaveBrightness", cave_bright_val)
  RenderingServer.global_shader_parameter_set(&"ShadowIntensity", shadow_intens_val)
  RenderingServer.global_shader_parameter_set(&"EnableBlinkingTorch", blinking_torch)
  RenderingServer.global_shader_parameter_set(&"EnableCloudShadow", cloud_shadow)
  
  
  # Terrain Color
  RenderingServer.global_shader_parameter_set(&"MorningSunCol", terrain_color["morning"])
  RenderingServer.global_shader_parameter_set(&"NoonSunCol", terrain_color["noon"])
  RenderingServer.global_shader_parameter_set(&"NightSunCol", terrain_color["night"])
  
  
  # Fog
  RenderingServer.global_shader_parameter_set(&"EFog", fog_on)
  RenderingServer.global_shader_parameter_set(&"Fog", fog_value)
  RenderingServer.global_shader_parameter_set(&"MistDensity", mist_dens)
  RenderingServer.global_shader_parameter_set(&"ERainMistOpacity", rain_mist_on)
  RenderingServer.global_shader_parameter_set(&"RainMistOpacity", rain_mist_opacity)
  RenderingServer.global_shader_parameter_set(&"ECloudyFog", cloudy_fog_on)
  RenderingServer.global_shader_parameter_set(&"CloudyFog", cloudy_fog_val)
  
  
  # Sky Color
  RenderingServer.global_shader_parameter_set(&"DayZenith", zenith["day"])
  RenderingServer.global_shader_parameter_set(&"DayHorizon", horizon["day"])
  RenderingServer.global_shader_parameter_set(&"NightZenith", zenith["night"])
  RenderingServer.global_shader_parameter_set(&"NightHorizon", horizon["night"])
  RenderingServer.global_shader_parameter_set(&"RainZenith", zenith["rain"])
  RenderingServer.global_shader_parameter_set(&"RainHorizon", horizon["rain"])
  RenderingServer.global_shader_parameter_set(&"EndZenith", zenith["end"])
  RenderingServer.global_shader_parameter_set(&"EndHorizon", horizon["end"])
  RenderingServer.global_shader_parameter_set(&"DawnZenith", zenith["dawn"])
  RenderingServer.global_shader_parameter_set(&"DawnEdge", dawn_edge)
  RenderingServer.global_shader_parameter_set(&"DawnHorizon", horizon["dawn"])
  
  
  # wave
  RenderingServer.global_shader_parameter_set(&"EPlantWave", plantw_on)
  RenderingServer.global_shader_parameter_set(&"PlantWave", plant_wave_val)
  RenderingServer.global_shader_parameter_set(&"ELanternWave", lanternw_on)
  RenderingServer.global_shader_parameter_set(&"LanternWave", lantern_wave_val)
  RenderingServer.global_shader_parameter_set(&"WaveSpeed", wave_speed)
  RenderingServer.global_shader_parameter_set(&"WaveRange", wave_range)
  
  
  # update the ui control appearance based on the new loaded value
  # Color Correction
  $"../../../../../Config/Container/Scroll/ConfigContainer/Config/ColorCorrection/TonemapPanel/Tonemap/TonemapType".select(tonemap_id-1)
  $"../../../../../Config/Container/Scroll/ConfigContainer/Config/ColorCorrection/GammaPanel/Gamma/Gamma".text = str(gamma_value)
  $"../../../../../Config/Container/Scroll/ConfigContainer/Config/ColorCorrection/ExposurePanel/Exposure/Mod/ExpoToggle".button_pressed = exposure_on
  $"../../../../../Config/Container/Scroll/ConfigContainer/Config/ColorCorrection/ExposurePanel/Exposure/Mod/Exposure".text = str(exposure_value)
  $"../../../../../Config/Container/Scroll/ConfigContainer/Config/ColorCorrection/SaturationPanel/Saturation/Mod/SatToggle".button_pressed = saturation_on
  $"../../../../../Config/Container/Scroll/ConfigContainer/Config/ColorCorrection/SaturationPanel/Saturation/Mod/Saturation".text = str(saturation_value)
  $"../../../../../Config/Container/Scroll/ConfigContainer/Config/ColorCorrection/TintPanel/Tint/Mod/TintToggle".button_pressed = tint_on
  $"../../../../../Config/Container/Scroll/ConfigContainer/Config/ColorCorrection/TintPanel/Tint/Mod/Low/TintLow".color = Color(low_tint_val.x, low_tint_val.y, low_tint_val.z, 1.0)
  $"../../../../../Config/Container/Scroll/ConfigContainer/Config/ColorCorrection/TintPanel/Tint/Mod/High/TintHigh".color = Color(high_tint_val.x, high_tint_val.y, high_tint_val.z, 1.0)
  
  
  # Terrain Lighting
  $"../../../../../Config/Container/Scroll/ConfigContainer/Config/TerrainLighting/SunIntensityPanel/SunIntensity/SunIntensity".text = str(sun_intens_val)
  $"../../../../../Config/Container/Scroll/ConfigContainer/Config/TerrainLighting/TorchIntensityPanel/TorchIntensity/TorchIntensity".text = str(torch_intens_val)
  $"../../../../../Config/Container/Scroll/ConfigContainer/Config/TerrainLighting/NightBrightnssPanel/NightBrightness/NightBrightness".text = str(night_bright_val)
  $"../../../../../Config/Container/Scroll/ConfigContainer/Config/TerrainLighting/CaveBrightnessPanel/CaveBrightness/CaveBrightness".text = str(cave_bright_val)
  $"../../../../../Config/Container/Scroll/ConfigContainer/Config/TerrainLighting/ShadowIntensPanel/ShadowIntensity/ShadowIntensity".text = str(shadow_intens_val)
  $"../../../../../Config/Container/Scroll/ConfigContainer/Config/TerrainLighting/BlinkingTorchPanel/BlinkingTorch/BlinkTorchToggle".button_pressed = blinking_torch
  $"../../../../../Config/Container/Scroll/ConfigContainer/Config/TerrainLighting/CloudShadowPanel/CloudShadow/CloudShadowToggle".button_pressed = cloud_shadow
  
  
  # terrain color
  $"../../../../../Config/Container/Scroll/ConfigContainer/Config/TerrainColor/TerrainColPanel/Mod/Morning/TerrColMorning".color = Color(terrain_color["morning"].x, terrain_color["morning"].y, terrain_color["morning"].z, 1.0)
  $"../../../../../Config/Container/Scroll/ConfigContainer/Config/TerrainColor/TerrainColPanel/Mod/Noon/TerrColNoon".color = Color(terrain_color["noon"].x, terrain_color["noon"].y, terrain_color["noon"].z, 1.0)
  $"../../../../../Config/Container/Scroll/ConfigContainer/Config/TerrainColor/TerrainColPanel/Mod/Night/TerrColNight".color = Color(terrain_color["night"].x, terrain_color["night"].y, terrain_color["night"].z, 1.0)
  
  
  # fog
  $"../../../../../Config/Container/Scroll/ConfigContainer/Config/Fog/FogBlendPanel/FogBlend/Mod/FogToggle".button_pressed = fog_on
  $"../../../../../Config/Container/Scroll/ConfigContainer/Config/Fog/FogBlendPanel/FogBlend/Mod/Fog".text = str(fog_value)
  $"../../../../../Config/Container/Scroll/ConfigContainer/Config/Fog/MistDensPanel/MistDensity/MistDensity".text = str(mist_dens)
  $"../../../../../Config/Container/Scroll/ConfigContainer/Config/Fog/RainMistPanel/RainMist/Mod/RainMToggle".button_pressed = rain_mist_on
  $"../../../../../Config/Container/Scroll/ConfigContainer/Config/Fog/RainMistPanel/RainMist/Mod/RainMist".text = str(rain_mist_opacity)
  $"../../../../../Config/Container/Scroll/ConfigContainer/Config/Fog/CloudyFogPanel/CloudyFog/Mod/CloudyFogToggle".button_pressed = cloudy_fog_on
  $"../../../../../Config/Container/Scroll/ConfigContainer/Config/Fog/CloudyFogPanel/CloudyFog/Mod/CloudyFog".text = str(cloudy_fog_val)
  
  
  # Sky Color
  $"../../../../../Config/Container/Scroll/ConfigContainer/Config/SkyColor/DayColorPanel/DayColor/Mod/Zenith/DayZenith".color = Color(zenith["day"].x, zenith["day"].y, zenith["day"].z, 1.0)
  $"../../../../../Config/Container/Scroll/ConfigContainer/Config/SkyColor/DayColorPanel/DayColor/Mod/Horizon/DayHorizon".color = Color(horizon["day"].x, horizon["day"].y, horizon["day"].z, 1.0)
  $"../../../../../Config/Container/Scroll/ConfigContainer/Config/SkyColor/NightColorPanel/NightColor/Mod/Zenith/NightZenith".color = Color(zenith["night"].x, zenith["night"].y, zenith["night"].z, 1.0)
  $"../../../../../Config/Container/Scroll/ConfigContainer/Config/SkyColor/NightColorPanel/NightColor/Mod/Horizon/NightHorizon".color = Color(horizon["night"].x, horizon["night"].y, horizon["night"].z, 1.0)
  $"../../../../../Config/Container/Scroll/ConfigContainer/Config/SkyColor/RainColorPanel/RainColor/Mod/Zenith/RainZenith".color = Color(zenith["rain"].x, zenith["rain"].y, zenith["rain"].z, 1.0)
  $"../../../../../Config/Container/Scroll/ConfigContainer/Config/SkyColor/RainColorPanel/RainColor/Mod/Horizon/RainHorizon".color = Color(horizon["rain"].x, horizon["rain"].y, horizon["rain"].z, 1.0)
  $"../../../../../Config/Container/Scroll/ConfigContainer/Config/SkyColor/EndColorPanel/EndColor/Mod/Zenith/EndZenith".color = Color(zenith["end"].x, zenith["end"].y, zenith["end"].z, 1.0)
  $"../../../../../Config/Container/Scroll/ConfigContainer/Config/SkyColor/EndColorPanel/EndColor/Mod/Horizon/EnHorizon".color = Color(horizon["end"].x, horizon["end"].y, horizon["end"].z, 1.0)
  $"../../../../../Config/Container/Scroll/ConfigContainer/Config/SkyColor/DawnColorPanel/DawnColor/Mod/Zenith/DawnZenith".color = Color(zenith["dawn"].x, zenith["dawn"].y, zenith["dawn"].z, 1.0)
  $"../../../../../Config/Container/Scroll/ConfigContainer/Config/SkyColor/DawnColorPanel/DawnColor/Mod/Edge/DawnEdge".color = Color(dawn_edge.x, dawn_edge.y, dawn_edge.z, 1.0)
  $"../../../../../Config/Container/Scroll/ConfigContainer/Config/SkyColor/DawnColorPanel/DawnColor/Mod/Horizon/DawnHorizon".color = Color(horizon["dawn"].x, horizon["dawn"].y, horizon["dawn"].z, 1.0)
  
  
  # wave
  $"../../../../../Config/Container/Scroll/ConfigContainer/Config/Wave/PlantWavePanel/PlantWave/Mod/PWaveToggle".button_pressed = plantw_on
  $"../../../../../Config/Container/Scroll/ConfigContainer/Config/Wave/PlantWavePanel/PlantWave/Mod/PlantWave".text = str(plant_wave_val)
  $"../../../../../Config/Container/Scroll/ConfigContainer/Config/Wave/LanternWavePanel/LanternWave/Mod/LWaveToggle".button_pressed = lanternw_on
  $"../../../../../Config/Container/Scroll/ConfigContainer/Config/Wave/LanternWavePanel/LanternWave/Mod/LanternWave".text = str(lantern_wave_val)
  $"../../../../../Config/Container/Scroll/ConfigContainer/Config/Wave/WaveSpeedPanel/WaveSpeed/WaveSpeed".text = str(wave_speed)
  $"../../../../../Config/Container/Scroll/ConfigContainer/Config/Wave/WaveRangePanel/WaveRange/WaveRange".text = str(wave_range)
