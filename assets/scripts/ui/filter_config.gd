extends Button

@export var cf : Control

func tween(target: Object, property: String, final_value: Variant, duration: float, trans: Variant, easing: Variant, parallel: bool = false):
  var res = target.create_tween().set_trans(trans).set_ease(easing)
  
  if parallel:
    res.parallel().tween_property(target, property, final_value, duration)
  else:
    res.tween_property(target, property, final_value, duration)
  
  return res

func _on_pressed() -> void:
  tween(cf.get_node("BGBlurr"), "visible", true, 0., Tween.TRANS_SINE, Tween.EASE_IN, true)
  tween(cf.get_node("CFContent"), "position", Vector2(0, 0), 0.7, Tween.TRANS_EXPO, Tween.EASE_OUT)
  tween(cf.get_node("BGBlurr/BlurrXY"), "color", Color(0, 0, 0, 0.35), 0.3, Tween.TRANS_SINE, Tween.EASE_IN, true)
