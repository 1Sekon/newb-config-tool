extends Node

var tonemap_id : int = 3
var gamma_value : float = 1.33
var exposure_on : bool = false
var exposure_value : float = 1.3
var saturation_on : bool = false
var saturation_value : float = 1.4
var tint_on : bool = false
var low_tint_val : Vector3 = Vector3(0.3, 0.5, 1.4)
var high_tint_val : Vector3 = Vector3(1.4, 0.7, 0.3)


func _on_tonemap_type_item_selected(index: int) -> void:
  tonemap_id = index+1
  RenderingServer.global_shader_parameter_set(&"TonemapType", tonemap_id)

func _on_gamma_text_changed(new_text: String) -> void:
  gamma_value = type_convert(new_text, TYPE_FLOAT)
  RenderingServer.global_shader_parameter_set(&"Gamma", type_convert(new_text, TYPE_FLOAT))

func _on_expo_toggle_toggled(toggled_on: bool) -> void:
  exposure_on = toggled_on
  RenderingServer.global_shader_parameter_set(&"EExposure", toggled_on)

func _on_exposure_text_changed(new_text: String) -> void:
  exposure_value = type_convert(new_text, TYPE_FLOAT)
  RenderingServer.global_shader_parameter_set(&"Exposure", type_convert(new_text, TYPE_FLOAT))

func _on_sat_toggle_toggled(toggled_on: bool) -> void:
  saturation_on = toggled_on
  RenderingServer.global_shader_parameter_set(&"ESaturation", toggled_on)

func _on_saturation_text_changed(new_text: String) -> void:
  saturation_value = type_convert(new_text, TYPE_FLOAT)
  RenderingServer.global_shader_parameter_set(&"Saturation", type_convert(new_text, TYPE_FLOAT))

func _on_tint_toggle_toggled(toggled_on: bool) -> void:
  tint_on = toggled_on
  RenderingServer.global_shader_parameter_set(&"Tint", toggled_on)

func _on_tint_low_color_changed(color: Color) -> void:
  low_tint_val = Vector3(color.r, color.g, color.b)
  RenderingServer.global_shader_parameter_set(&"LTint", Vector3(color.r, color.g, color.b))

func _on_tint_high_color_changed(color: Color) -> void:
  high_tint_val = Vector3(color.r, color.g, color.b)
  RenderingServer.global_shader_parameter_set(&"HTint", Vector3(color.r, color.g, color.b))
