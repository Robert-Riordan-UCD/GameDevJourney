class_name PrePlayerEnter
extends State

@export var parent:Boss

func enter() -> void:
	parent.animated_sprite_2d.play("death")
	parent.movement_area.body_entered.connect(_on_body_entered)

func exit() -> void:
	parent.animated_sprite_2d.play_backwards("death")
	await parent.animated_sprite_2d.animation_finished
	print("Exit PrePlayerEnter")

func _on_body_entered(body: Node2D) -> void:
	if body is Player:
		transition.emit("RangeAttack")
