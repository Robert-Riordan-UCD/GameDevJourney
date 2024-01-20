extends Node

var bullet_spawner_scene:PackedScene = preload("res://Bullets/bullet_spawner.tscn")
var burst_bullet_spawner_scene:PackedScene = preload("res://Bullets/burst_bullet_spawner.tscn")

func _ready() -> void:
	randomize()

func new_random_bullet_spawner(difficulty:int) -> BulletSpawner:
	match randi()%2:
		0: return default_spawner(difficulty)
		1: return burst_spawner(difficulty)
		_: return null

func default_spawner(difficulty:int) -> BulletSpawner:
	var spawner:BulletSpawner = bullet_spawner_scene.instantiate()
	
	spawner.direction = -1 if randi()%2 else 1
	spawner.bullets_per_second = randf_range(sqrt(float(difficulty)), 2*sqrt(float(difficulty)))
	spawner.size = randf_range(0.8, 1.0)
	spawner.bullets_per_gap = randi_range(4, 10)
	spawner.rotation_speed = randf_range(PI/4, PI)
	spawner.bullet_speed = randf_range(50, 75)
	
	return spawner

func burst_spawner(difficulty:int) -> BurstBulletSpawner:
	var spawner:BurstBulletSpawner = burst_bullet_spawner_scene.instantiate()
	
	spawner.bullets_per_second = randf_range(8, 12)
	spawner.size = randf_range(0.6, 0.8)
	spawner.rotation_speed = randf_range(0.5*PI, 1.5*PI)
	spawner.bullet_speed = randf_range(75, 100)
	
	spawner.on_time = randf_range(0.3, 0.6)*sqrt(difficulty/4.0)
	spawner.off_time = randf_range(1.2, 2.0)*max(0.5, (100.0-difficulty)/100.0)
	
	return spawner

func get_current_camera():
	var viewport = get_viewport()
	if not viewport:
		return null
	var camerasGroupName = "__cameras_%d" % viewport.get_viewport_rid().get_id()
	var cameras = get_tree().get_nodes_in_group(camerasGroupName)
	for camera in cameras:
		if camera is Camera2D and camera.enabled:
			return camera
	return null
