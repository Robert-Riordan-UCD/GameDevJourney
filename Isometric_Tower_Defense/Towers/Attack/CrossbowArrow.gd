class_name CrossBowArrow
extends Sprite2D

signal hit

@export var attack_duration : float = 0.15

func goto(pos: Vector2) -> void:
	rotate((pos-global_position).angle())
	var tween = get_tree().create_tween()
	tween.tween_property(self, "global_position", pos, attack_duration).set_trans(Tween.TRANS_CUBIC)
	tween.connect("finished", _tween_finished)

func _tween_finished() -> void:
	hit.emit()
	queue_free()
