
class_name AnimaTween

func tween(target: Object, property: String, final_value: Variant, duration: float, trans: Variant = Tween.TRANS_LINEAR, easing: Variant = Tween.EASE_IN_OUT, parallel: bool = false):
  var res = target.create_tween().set_trans(trans).set_ease(easing)
  
  if parallel:
    res.parallel().tween_property(target, property, final_value, duration)
  else:
    res.tween_property(target, property, final_value, duration)
  
  return res