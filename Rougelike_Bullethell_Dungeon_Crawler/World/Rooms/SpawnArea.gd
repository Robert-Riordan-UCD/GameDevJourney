class_name SpawnArea
extends Area2D

func _ready() -> void:
	randomize()

func get_random_point() -> Vector2:
	var size:Vector2 = $CollisionShape2D.shape.size
	return $CollisionShape2D.position + Vector2(randi_range(-size.x/2, size.x/2), randi_range(-size.y/2, size.y/2))
