extends Node

func tween_in(node: Node2D, duration : float = 1.0) -> void:
	var tween: Tween = create_tween()
	var initial_scale := node.scale
	node.scale = Vector2.ZERO
	tween.tween_property(node, "scale", initial_scale, duration).set_trans(Tween.TRANS_ELASTIC)

func tween_out(node: Node2D, duration : float = 1.0) -> void:
	var tween: Tween = create_tween()
	tween.tween_property(node, "scale", Vector2.ZERO, duration).set_trans(Tween.TRANS_CIRC)
	await tween.finished
