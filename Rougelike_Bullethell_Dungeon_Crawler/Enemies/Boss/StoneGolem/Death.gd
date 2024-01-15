extends State

@export var parent:Boss

func enter() -> void:
	final = true
	parent.animated_sprite_2d.play("death")
	await parent.animated_sprite_2d.animation_finished
