class_name BossIdle
extends State

@export var parent:Boss
@export var speed:float = 10

func enter() -> void:
	parent.animated_sprite_2d.play("idle")
