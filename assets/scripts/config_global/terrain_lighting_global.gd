extends Node

var sun_intens_val : float = 2.95
var torch_intens_val : float = 1.0
var night_bright_val : float = 0.1
var cave_bright_val : float = 0.1
var shadow_intens_val : float = 0.7
var blinking_torch : bool = false
var cloud_shadow : bool = false
var terrain_col : Dictionary = {
  "morning": Vector3(1.0, 0.45, 0.14),
  "noon": Vector3(1.0, 0.75, 0.57),
  "night": Vector3(0.5, 0.64, 1.00),
}


func _on_sun_intensity_text_changed(new_text: String) -> void:
  sun_intens_val = type_convert(new_text, TYPE_FLOAT)
  RenderingServer.global_shader_parameter_set(&"SunIntensity", type_convert(new_text, TYPE_FLOAT))


func _on_torch_intensity_text_changed(new_text: String) -> void:
  torch_intens_val = type_convert(new_text, TYPE_FLOAT)
  RenderingServer.global_shader_parameter_set(&"TorchIntensity", type_convert(new_text, TYPE_FLOAT))


func _on_night_brightness_text_changed(new_text: String) -> void:
  night_bright_val = type_convert(new_text, TYPE_FLOAT)
  RenderingServer.global_shader_parameter_set(&"NightBrightness", type_convert(new_text, TYPE_FLOAT))


func _on_cave_brightness_text_changed(new_text: String) -> void:
  cave_bright_val = type_convert(new_text, TYPE_FLOAT)
  RenderingServer.global_shader_parameter_set(&"CaveBrightness", type_convert(new_text, TYPE_FLOAT))


func _on_shadow_intensity_text_changed(new_text: String) -> void:
  shadow_intens_val = type_convert(new_text, TYPE_FLOAT)
  RenderingServer.global_shader_parameter_set(&"ShadowIntensity", type_convert(new_text, TYPE_FLOAT))


func _on_blink_torch_toggle_toggled(toggled_on: bool) -> void:
  blinking_torch = toggled_on
  RenderingServer.global_shader_parameter_set(&"BlinkingTorch", toggled_on)


func _on_cloud_shadow_toggle_toggled(toggled_on: bool) -> void:
  cloud_shadow = toggled_on
  RenderingServer.global_shader_parameter_set(&"CloudShadow", toggled_on)


func _on_terr_col_morning_color_changed(color: Color) -> void:
  terrain_col["morning"] = Vector3(color.r, color.g, color.b)
  RenderingServer.global_shader_parameter_set(&"MorningSunCol", Color(terrain_col["morning"].x, terrain_col["morning"].y, terrain_col["morning"].z))


func _on_terr_col_noon_color_changed(color: Color) -> void:
  terrain_col["noon"] = Vector3(color.r, color.g, color.b)
  RenderingServer.global_shader_parameter_set(&"NoonSunCol", Color(terrain_col["noon"].x, terrain_col["noon"].y, terrain_col["noon"].z))


func _on_terr_col_night_color_changed(color: Color) -> void:
  terrain_col["night"] = Vector3(color.r, color.g, color.b)
  RenderingServer.global_shader_parameter_set(&"NightSunCol", Color(terrain_col["night"].x, terrain_col["night"].y, terrain_col["night"].z))
