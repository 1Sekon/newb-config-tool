extends Node

@export_category("Menu")
@export var menu_content : PanelContainer
@export var button_strip : TextureButton
@export var menu_panel : PanelContainer
@export_category("Config")
@export var config_main : Control



func tween(target: Object, property: String, final_value: Variant, duration: float, trans: Variant, easing: Variant, parallel: bool = false):
  var res = target.create_tween().set_trans(trans).set_ease(easing)
  
  if parallel:
    res.parallel().tween_property(target, property, final_value, duration)
  else:
    res.tween_property(target, property, final_value, duration)
  
  return res


func _ready() -> void:
  menu_content.position.x = 1000
  menu_panel.position.x = 1000
  config_main.position.x = -1000
  
  $Content/Settings.visible = true
  $Content/Settings/SettingsContent.position.y = 10000
  
  $Content/ConfigFilter.visible = true
  $Content/ConfigFilter/CFContent.position.y = 10000

# open and close menu
# open
func _on_stripe_menu_pressed() -> void:
  tween(button_strip, "position", Vector2.RIGHT*1000, 1, Tween.TRANS_EXPO, Tween.EASE_OUT)
  tween(menu_content, "position", Vector2(-155.0, 47.0), 0.8, Tween.TRANS_EXPO, Tween.EASE_OUT)
  tween(menu_panel, "position", Vector2(-158.0, 0.0), 0.8, Tween.TRANS_EXPO, Tween.EASE_OUT)


# close
func _on_cross_menu_pressed() -> void:
  tween(button_strip, "position", Vector2.LEFT*4, 1, Tween.TRANS_EXPO, Tween.EASE_OUT)
  tween(menu_content, "position", Vector2(1000.0, 47.0), 0.3, Tween.TRANS_EXPO, Tween.EASE_IN)
  tween(menu_panel, "position", Vector2(1000.0, 0.0), 0.3, Tween.TRANS_EXPO, Tween.EASE_IN)


# Open and close config
# open
func _on_open_config_pressed() -> void:
  tween(config_main, "position", Vector2.RIGHT*0, 1, Tween.TRANS_EXPO, Tween.EASE_OUT)
  tween(config_main.get_node(^"../OpenConfig"), "position", Vector2(-1000, 292), 0.8, Tween.TRANS_EXPO, Tween.EASE_OUT)


# close
func _on_close_config_pressed() -> void:
  tween(config_main, "position", Vector2.LEFT*1000, 0.3, Tween.TRANS_EXPO, Tween.EASE_IN)
  tween(config_main.get_node(^"../OpenConfig"), "position", Vector2(0, 292), 1, Tween.TRANS_EXPO, Tween.EASE_OUT)


func _on_visibility_toggled(toggled_on: bool) -> void:
  var node : Array[Node] = [get_node(^"Content/Config"), get_node(^"Content/Menu"), get_node(^"Content/OpenConfig")]
  for n in node:
    n.visible = not(toggled_on)


func _on_settings_pressed() -> void:
  tween($Content/Settings/BGBlurr, "visible", true, 0., Tween.TRANS_SINE, Tween.EASE_IN, true)
  tween($Content/Settings/SettingsContent, "position", Vector2(0, 0), 0.7, Tween.TRANS_EXPO, Tween.EASE_OUT)
  tween($Content/Settings/BGBlurr/BlurrXY, "color", Color(0, 0, 0, 0.35), 0.3, Tween.TRANS_SINE, Tween.EASE_IN, true)
