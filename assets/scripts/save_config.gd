extends Control

var save_path : String = "res://saved_config/%s.cfg"
var tree_node_name : String = "res://assets/ui/hud.tscn".get_basename().get_file()
var config = ConfigFile.new()

@export var cc : Control
@export var tl : Control
@export var fog : Control
@export var sc : Control
@export var wave : Control


func save_config(dir: String):
  # Color Correction
  config.set_value("Color Correction", "TonemapType", cc.tonemap_id)
  config.set_value("Color Correction", "Gamma", cc.gamma_value)
  config.set_value("Color Correction", "EnableExposure", cc.exposure_on)
  config.set_value("Color Correction", "Exposure", cc.exposure_value)
  config.set_value("Color Correction", "EnableSaturation", cc.saturation_on)
  config.set_value("Color Correction", "Saturation", cc.saturation_value)
  config.set_value("Color Correction", "EnableTint", cc.tint_on)
  config.set_value("Color Correction", "TintLow", cc.low_tint_val)
  config.set_value("Color Correction", "TintHigh", cc.high_tint_val)
  
  # Terrain Color
  config.set_value("Terrain Lighting", "SunIntensity", tl.sun_intens_val)
  config.set_value("Terrain Lighting", "TorchIntensity", tl.torch_intens_val)
  config.set_value("Terrain Lighting", "NightBrightness", tl.night_bright_val)
  config.set_value("Terrain Lighting", "CaveBrightness", tl.cave_bright_val)
  config.set_value("Terrain Lighting", "ShadowIntensity", tl.shadow_intens_val)
  config.set_value("Terrain Lighting", "EnableBlinkingTorch", tl.blinking_torch)
  config.set_value("Terrain Lighting", "EnableCloudShadow", tl.cloud_shadow)
  
  # Terrain Color
  config.set_value("Terrain Color", "MorningSunCol", tl.terrain_col["morning"])
  config.set_value("Terrain Color", "NoonSunCol", tl.terrain_col["noon"])
  config.set_value("Terrain Color", "NightSunCol", tl.terrain_col["night"])
  
  # fog
  config.set_value("Fog Effects", "EnableFog", fog.fog_on)
  config.set_value("Fog Effects", "Fog", fog.fog_value)
  config.set_value("Fog Effects", "MistDensity", fog.mist_dens)
  config.set_value("Fog Effects", "EnableRainMist", fog.rain_mist_on)
  config.set_value("Fog Effects", "RainMistOpacity", fog.rain_mist_opacity)
  config.set_value("Fog Effects", "EnableCloudyFog", fog.cloudy_fog_on)
  config.set_value("Fog Effects", "CloudyFog", fog.cloudy_fog_value)
  
  # Sky Color
  config.set_value("Sky Color", "DayZenith", sc.zenith["day"])
  config.set_value("Sky Color", "DayHorizon", sc.horizon["day"])
  config.set_value("Sky Color", "NightZenith", sc.zenith["night"])
  config.set_value("Sky Color", "NightHorizon", sc.horizon["night"])
  config.set_value("Sky Color", "RainZenith", sc.zenith["rain"])
  config.set_value("Sky Color", "RainHorizon", sc.horizon["rain"])
  config.set_value("Sky Color", "EndZenith", sc.zenith["end"])
  config.set_value("Sky Color", "EndHorizon", sc.horizon["end"])
  config.set_value("Sky Color", "DawnZenith", sc.zenith["dawn"])
  config.set_value("Sky Color", "DawnEdge", sc.dawn_edge)
  config.set_value("Sky Color", "DawnHorizon", sc.horizon["dawn"])
  
  # wave
  config.set_value("Wave", "EnablePlantWave", wave.plantw_on)
  config.set_value("Wave", "PlantWave", wave.plant_wave_val)
  config.set_value("Wave", "EnableLanternWave", wave.lanternw_on)
  config.set_value("Wave", "LanternWave", wave.lantern_wave_val)
  config.set_value("Wave", "WaveSpeed", wave.wave_speed)
  
  config.save(dir)

func _on_pressed() -> void:
  save_config(save_path % [tree_node_name])
