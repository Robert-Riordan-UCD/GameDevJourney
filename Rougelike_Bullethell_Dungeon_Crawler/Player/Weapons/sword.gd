extends Weapon

func play_attack() -> void:
	var tween:Tween = create_tween()
	if flipped:
		tween.tween_property(sprite_2d, "rotation_degrees", -180, 0.2).set_ease(Tween.EASE_IN_OUT).set_trans(Tween.TRANS_QUAD)
		tween.tween_property(sprite_2d, "rotation_degrees", 0, 0.2).set_ease(Tween.EASE_IN_OUT).set_trans(Tween.TRANS_QUAD)
	else:
		tween.tween_property(sprite_2d, "rotation_degrees", 180, 0.2).set_ease(Tween.EASE_IN_OUT).set_trans(Tween.TRANS_QUAD)
		tween.tween_property(sprite_2d, "rotation_degrees", 0, 0.2).set_ease(Tween.EASE_IN_OUT).set_trans(Tween.TRANS_QUAD)
	await tween.finished
