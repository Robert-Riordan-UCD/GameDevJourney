extends State

@export var parent:Boss
@onready var sweep_bullet_spawner: Node2D = $SweepBulletSpawner

func enter() -> void:
	var player:Player = get_tree().get_first_node_in_group("player")
	
	parent.animated_sprite_2d.flip_h = player.global_position.x < parent.global_position.x
	
	sweep_bullet_spawner.look_at(player.position)
	parent.animated_sprite_2d.play("ranged_attack")
	await parent.animated_sprite_2d.animation_finished
	
	if sweep_bullet_spawner:
		sweep_bullet_spawner.trigger()

func exit() -> void:
	parent.animated_sprite_2d.stop()
	sweep_bullet_spawner.queue_free()
	print("Exit Range")

func _on_sweep_bullet_spawner_done() -> void:
	parent.animated_sprite_2d.play_backwards("ranged_attack")
	await parent.animated_sprite_2d.animation_finished

	if parent._dying:
		transition.emit("Death")
	else:
		transition.emit("Move")
