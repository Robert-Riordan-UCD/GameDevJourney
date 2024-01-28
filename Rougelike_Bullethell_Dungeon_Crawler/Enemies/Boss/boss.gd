class_name Boss
extends CharacterBody2D

signal died

@export var movement_area:SpawnArea

@onready var _dying:bool = false
@onready var animated_sprite_2d: AnimatedSprite2D = $AnimatedSprite2D
@onready var state_machine: Node2D = $StateMachine
@onready var animation_player: AnimationPlayer = $AnimationPlayer

func _on_health_damaged() -> void:
	animation_player.play("hit")

func _on_health_died() -> void:
	if _dying:return
	_on_health_damaged()
	_dying = true
	died.emit()
	await state_machine.change_state("Death")
	MusicBus.set_intensity(1)

func activate() -> void:
	MusicBus.set_intensity(3)
