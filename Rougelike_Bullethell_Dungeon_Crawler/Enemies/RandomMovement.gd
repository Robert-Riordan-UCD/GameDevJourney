extends Node2D

@export var parent:CharacterBody2D
@export var speed:float = 100
@export var enabled:bool = false
@export var movement_area:SpawnArea
@export_range(0.0, 1.0) var friction:float = 0.5
var target:Vector2

func _ready() -> void:
	await get_tree().process_frame # wait for parent to ready to set movement area
	new_target()

func _process(delta: float) -> void:
	if not enabled: return
	parent.velocity += position.direction_to(target)*speed*delta
	parent.velocity = lerp(parent.velocity, Vector2.ZERO, friction*delta)
	parent.move_and_slide()

func new_target() -> void:
	target = movement_area.get_random_point()
	await get_tree().create_timer(randf_range(5, 15)).timeout
	print(target)
	new_target()
