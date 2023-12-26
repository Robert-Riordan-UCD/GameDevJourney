extends Node

func tween_in(node, duration : float = 1.0) -> void:
	var tween: Tween = create_tween()
	var initial_scale : Vector2 = node.scale
	node.scale = Vector2.ZERO
	if node is Control:
		node.pivot_offset = node.size/2
	node.visible = true
	tween.tween_property(node, "scale", initial_scale, duration).set_trans(Tween.TRANS_ELASTIC)

func tween_out(node, duration : float = 1.0) -> void:
	var tween: Tween = create_tween()
	var initial_scale : Vector2 = node.scale
	if node is Control:
		node.pivot_offset = node.size/2
	tween.tween_property(node, "scale", Vector2.ZERO, duration).set_trans(Tween.TRANS_CIRC)
	await tween.finished
	node.visible = false
	node.scale = initial_scale
