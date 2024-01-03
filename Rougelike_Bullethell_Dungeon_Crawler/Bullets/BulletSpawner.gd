class_name BulletSpawner
extends Node2D

@export var spawn_radius:float = 100

@export_category("Bullets")
@export var bullets_per_second:float = 1
@export var damage:float = 1

@export_category("Rotation")
#@export_range(-180, 180) var rotation_start:float = -90
#@export_range(-180, 180) var rotation_end:float = 90
@export_range(0, 2*PI) var rotation_speed:float = PI

@onready var bullet_spawn_timer:Timer = $BulletSpawnTimer

const bullet_scene:PackedScene = preload("res://Bullets/bullet.tscn")

func _ready() -> void:
	bullet_spawn_timer.wait_time = 1/bullets_per_second
	bullet_spawn_timer.start()

func _process(delta):
	rotate(delta*rotation_speed)

func _on_bullet_spawn_timer_timeout():
	var new_bullet:Bullet = bullet_scene.instantiate()
	new_bullet.global_position = global_position + spawn_radius*Vector2.RIGHT.rotated(rotation)
	new_bullet.direction = Vector2.RIGHT.rotated(rotation)
	new_bullet.damage = damage
	get_tree().root.add_child(new_bullet)
