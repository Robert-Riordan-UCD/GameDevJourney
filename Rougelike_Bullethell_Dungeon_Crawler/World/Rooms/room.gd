class_name Room
extends Node2D

@export var num_enemies:int = 4

var room_defeated:bool = false
var exit = null

const left_spawn_limit:float = -575
const right_spawn_limit:float = 575
const top_spawn_limit:float = -192
const bottom_spawn_limit:float = 288

@onready var enemy_scene:PackedScene = preload("res://Enemies/enemy.tscn")
@onready var enemies: Node2D = $Enemies
@onready var rect:Rect2 = $Room.get_rect()
@onready var doors: StaticBody2D = $Doors
@onready var walls: StaticBody2D = $Walls

func activate() -> void:
	for i in range(num_enemies):
		var new_enemy:Enemy = enemy_scene.instantiate()
		new_enemy.scale /= scale
		new_enemy.connect("died", _on_enemy_died)
		enemies.add_child(new_enemy)
		new_enemy.global_position = global_position + Vector2(randf_range(left_spawn_limit, right_spawn_limit), randf_range(top_spawn_limit, bottom_spawn_limit))
	
	for door in doors.get_children():
		door.set_deferred("disabled", false)

func remove_door(direction:Vector2i) -> void:
	match direction:
		Vector2i.UP: _remove_door($Doors/North)
		Vector2i.LEFT: _remove_door($Doors/West)
		Vector2i.DOWN: _remove_door($Doors/South)
		Vector2i.RIGHT: _remove_door($Doors/East)

func set_final_room() -> void:
	var level_exit = preload("res://World/Levels/level_exit.tscn").instantiate()
	add_child(level_exit)
	level_exit.position =  Vector2(randf_range(-200, 200), randf_range(-50, 50))
	exit = level_exit

func _remove_door(door:CollisionShape2D) -> void:
	doors.remove_child(door)
	walls.add_child(door)
	door.disabled = false

func _on_enemy_died() -> void:
	num_enemies -= 1
	if num_enemies <= 0:
		room_defeated = true
		for door in doors.get_children():
			door.set_deferred("disabled", true)
		if exit:
			exit.unlock()

func _on_player_dection_body_entered(body: Node2D) -> void:
	if not room_defeated:
		activate()
