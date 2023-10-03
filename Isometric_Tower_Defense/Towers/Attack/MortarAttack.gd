extends Attack

@export var splash_range : float = 150

@onready var collision_shape_2d = $Area2D/CollisionShape2D
@onready var area_2d = $Area2D

func _ready() -> void:
	collision_shape_2d.shape.radius = splash_range

func attack(enemy: Enemy, damage: int) -> void:
	print("Attacking!!!")
	collision_shape_2d.global_position = enemy.global_position
	for area in area_2d.get_overlapping_areas():
		if area is Enemy:
			area.take_damage(damage)
