class_name PrePlayerEnter
extends State

@export var parent:Boss

func enter() -> void:
	parent.animated_sprite_2d.play("death")

func exit() -> void:
	parent.animated_sprite_2d.play_backwards("death")
	await parent.animated_sprite_2d.animation_finished

func _on_player_dection_body_entered(body: Node2D) -> void:
	if body is Player:
		transition.emit("BossIdle")
