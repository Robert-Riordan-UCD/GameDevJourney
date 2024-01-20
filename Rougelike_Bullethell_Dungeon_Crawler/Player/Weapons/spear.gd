extends Weapon

@export var stab_distance:float = 50

func play_attack() -> void:
	var tween:Tween = create_tween()
	var y:float = position.y
	if flipped:
		tween.tween_property(self, "position", Vector2(-stab_distance, y), 0.2).set_ease(Tween.EASE_IN_OUT).set_trans(Tween.TRANS_QUAD)
		tween.tween_property(self, "position", Vector2(0, y), 0.2).set_ease(Tween.EASE_IN_OUT).set_trans(Tween.TRANS_QUAD)
	else:
		tween.tween_property(self, "position", Vector2(stab_distance, y), 0.2).set_ease(Tween.EASE_IN).set_trans(Tween.TRANS_EXPO)
		tween.tween_property(self, "position", Vector2(0, y), 0.2).set_ease(Tween.EASE_IN_OUT).set_trans(Tween.TRANS_QUAD)
	await tween.finished

func _set_flipped(f:bool) -> void:
	position.x = -abs(position.x) if f else abs(position.x)
	flip_v = f
	flipped = f
