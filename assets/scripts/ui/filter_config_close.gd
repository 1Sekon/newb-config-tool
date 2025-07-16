extends Control

func tween(target: Object, property: String, final_value: Variant, duration: float, trans: Variant, easing: Variant, parallel: bool = false):
  var res = target.create_tween().set_trans(trans).set_ease(easing)
  
  if parallel:
    res.parallel().tween_property(target, property, final_value, duration)
  else:
    res.tween_property(target, property, final_value, duration)
  
  return res

func _on_close_button_pressed() -> void:
  tween(self, "position", Vector2.DOWN*1000, 0.3, Tween.TRANS_SINE, Tween.EASE_IN)
  tween(get_node(^"../BGBlurr/BlurrXY"), "color", Color(0, 0, 0, 0), 0.3, Tween.TRANS_SINE, Tween.EASE_IN, true)
