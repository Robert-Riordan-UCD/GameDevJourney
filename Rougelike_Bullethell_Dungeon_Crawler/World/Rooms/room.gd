class_name Room
extends Node2D

@export var num_enemies:int = 4

var room_defeated:bool = false

const left_spawn_limit:float = -575
const right_spawn_limit:float = 575
const top_spawn_limit:float = -192
const bottom_spawn_limit:float = 288

@onready var enemy_scene:PackedScene = preload("res://Enemies/enemy.tscn")
@onready var enemies: Node2D = $Enemies
@onready var rect:Rect2 = $Room.get_rect()

func activate() -> void:
	for i in range(num_enemies):
		var new_enemy:Enemy = enemy_scene.instantiate()
		new_enemy.scale /= scale
		new_enemy.connect("died", _on_enemy_died)
		enemies.add_child(new_enemy)
		new_enemy.global_position = Vector2(randf_range(left_spawn_limit, right_spawn_limit), randf_range(top_spawn_limit, bottom_spawn_limit))

func _on_enemy_died() -> void:
	num_enemies -= 1
	if num_enemies <= 0:
		room_defeated = true
		$Doors/NorthDoor.queue_free()
