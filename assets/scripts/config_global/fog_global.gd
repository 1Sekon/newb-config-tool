extends VBoxContainer

var fog_on : bool = true
var fog_value : float = 1.0
var mist_dens : float = 0.18
var rain_mist_on : bool = true
var rain_mist_opacity : float = 0.12
var cloudy_fog_on : bool = true
var cloudy_fog_value : float = 0.1


func _on_fog_toggle_toggled(toggled_on: bool) -> void:
  fog_on = toggled_on
  RenderingServer.global_shader_parameter_set(&"EFog", toggled_on)


func _on_fog_text_changed(new_text: String) -> void:
 fog_value = type_convert(new_text, TYPE_FLOAT)
 RenderingServer.global_shader_parameter_set(&"Fog", type_convert(new_text, TYPE_FLOAT))


func _on_mist_density_text_changed(new_text: String) -> void:
 mist_dens = type_convert(new_text, TYPE_FLOAT)
 RenderingServer.global_shader_parameter_set(&"MistDensity", type_convert(new_text, TYPE_FLOAT))


func _on_rain_m_toggle_toggled(toggled_on: bool) -> void:
 rain_mist_on = toggled_on
 RenderingServer.global_shader_parameter_set(&"ERainMistOpacity", toggled_on)


func _on_rain_mist_text_changed(new_text: String) -> void:
 rain_mist_opacity = type_convert(new_text, TYPE_FLOAT)
 RenderingServer.global_shader_parameter_set(&"RainMistOpacity", type_convert(new_text, TYPE_FLOAT))


func _on_cloudy_fog_toggle_toggled(toggled_on: bool) -> void:
 cloudy_fog_on = toggled_on
 RenderingServer.global_shader_parameter_set(&"ECloudyFog", toggled_on)


func _on_cloudy_fog_text_changed(new_text: String) -> void:
  cloudy_fog_value = type_convert(new_text, TYPE_FLOAT)
  RenderingServer.global_shader_parameter_set(&"CloudyFog", type_convert(new_text, TYPE_FLOAT))
