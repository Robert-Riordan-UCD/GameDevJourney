extends Weapon

@export var stab_distance:float = 50

func play_attack() -> void:
	var tween:Tween = create_tween()
	var x_start:float = position.x
	if flipped:
		tween.tween_property(sprite2d, "position:x", x_start-stab_distance, 0.2).set_ease(Tween.EASE_IN_OUT).set_trans(Tween.TRANS_QUAD)
		tween.tween_property(sprite2d, "position:x", x_start, 0.2).set_ease(Tween.EASE_IN_OUT).set_trans(Tween.TRANS_QUAD)
	else:
		tween.tween_property(sprite2d, "position:x", x_start+stab_distance, 0.2).set_ease(Tween.EASE_IN).set_trans(Tween.TRANS_EXPO)
		tween.tween_property(sprite2d, "position:x", x_start, 0.2).set_ease(Tween.EASE_IN_OUT).set_trans(Tween.TRANS_QUAD)
	await tween.finished

func _set_flipped(f:bool) -> void:
	if sprite2d:
		sprite2d.flip_v = f
	flipped = f
