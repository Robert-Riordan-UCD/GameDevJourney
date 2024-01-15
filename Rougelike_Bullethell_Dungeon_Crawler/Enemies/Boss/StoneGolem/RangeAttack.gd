extends State

@export var parent:Boss

func enter() -> void:
	var player:Player = get_tree().get_first_node_in_group("player")
	
	parent.animated_sprite_2d.flip_h = player.global_position.x < parent.global_position.x
	
	parent.animated_sprite_2d.play("ranged_attack")
	await parent.animated_sprite_2d.animation_finished
	
	await $SweepBulletSpawner.trigger()
	
	parent.animated_sprite_2d.play_backwards("ranged_attack")
	parent.animated_sprite_2d.animation_finished.connect(done)

func done() -> void:
	transition.emit("Move")
	
