extends State

@export var parent:Boss

func enter() -> void:
	var player:Player = get_tree().get_first_node_in_group("player")
	
	parent.animated_sprite_2d.flip_h = player.global_position.x < parent.global_position.x
	
	$SweepBulletSpawner.look_at(player.position)
	parent.animated_sprite_2d.play("ranged_attack")
	await parent.animated_sprite_2d.animation_finished
	
	$SweepBulletSpawner.trigger()

func _on_sweep_bullet_spawner_done() -> void:
	parent.animated_sprite_2d.play_backwards("ranged_attack")
	await parent.animated_sprite_2d.animation_finished

	if parent._dying:
		transition.emit("Death")
	else:
		transition.emit("Move")
