extends Node

var bullet_spawner_scene:PackedScene = preload("res://Bullets/bullet_spawner.tscn")

func _ready() -> void:
	randomize()

func new_random_bullet_spawner() -> BulletSpawner:
	var spawner:BulletSpawner = bullet_spawner_scene.instantiate()
	
	spawner.bullets_per_second = randf_range(2, 4)
	spawner.size = randf_range(0.8, 1.0)
	spawner.bullets_per_gap = randi_range(4, 10)
	spawner.rotation_speed = randf_range(PI/4, PI)
	spawner.bullet_speed = randf_range(50, 75)
	
	return spawner
