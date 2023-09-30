extends Sprite2D

func goto(pos: Vector2) -> void:
	visible = true
	var tween = get_tree().create_tween()
	tween.tween_property(self, "global_position", pos, 0.1).set_trans(Tween.TRANS_CUBIC)
	tween.connect("finished", _tween_finished)

func _tween_finished() -> void:
	position = Vector2(0, -76)
	visible = false
