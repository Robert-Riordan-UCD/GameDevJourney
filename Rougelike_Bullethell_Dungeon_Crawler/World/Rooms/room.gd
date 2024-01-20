class_name Room
extends Node2D

@export var num_enemies:int = 4
@export var level:int = 1 
@export_range(0, 1) var item_drop_chance:float = 0.2

var room_defeated:bool = false
var exit = null

const left_spawn_limit:float = -575
const right_spawn_limit:float = 575
const top_spawn_limit:float = -192
const bottom_spawn_limit:float = 288

@onready var enemy_scene:PackedScene = preload("res://Enemies/enemy.tscn")
@onready var boss_scene:PackedScene = preload("res://Enemies/Boss/StoneGolem/stone_golem.tscn")
@onready var enemies: Node2D = $Enemies
@onready var rect:Rect2 = $Room.get_rect()
@onready var spawn_area:SpawnArea = $SpawnArea
@onready var doors: Node2D = $Doors
@onready var walls: StaticBody2D = $Walls
@onready var items:Array[PackedScene] = [preload("res://Player/Weapons/sword.tscn"), preload("res://Player/Weapons/spear.tscn")]

func _ready() -> void:
	randomize()
	for i in range(num_enemies):
		spawn_new_enemy()

func activate() -> void:
	for door in doors.get_children():
		door.lock()

func spawn_new_enemy() -> void:
	var new_enemy:Enemy = enemy_scene.instantiate()
	new_enemy.scale /= scale
	new_enemy.connect("died", _on_enemy_died)
	new_enemy.difficulty = level
	new_enemy.movement_area = spawn_area
	await get_tree().process_frame
	enemies.add_child(new_enemy)
	new_enemy.global_position = global_position + spawn_area.get_random_point()

func remove_door(direction:Vector2i) -> void:
	match direction:
		Vector2i.UP: _remove_door($Doors/North)
		Vector2i.LEFT: _remove_door($Doors/West)
		Vector2i.DOWN: _remove_door($Doors/South)
		Vector2i.RIGHT: _remove_door($Doors/East)

func set_final_room() -> void:
	var level_exit = preload("res://World/Levels/level_exit.tscn").instantiate()
	add_child(level_exit)
	move_child(level_exit, 1)
	level_exit.position = Vector2(randf_range(-200, 200), randf_range(-50, 50))
	exit = level_exit

func add_boss() -> void:
	await get_tree().process_frame
	for enemy in enemies.get_children():
		enemies.remove_child(enemy)
		enemy.queue_free()
	num_enemies = 1
	
	var boss:Boss = boss_scene.instantiate()
	boss.movement_area = spawn_area
	enemies.add_child(boss)
	boss.died.connect(_on_enemy_died)

func _remove_door(door:Door) -> void:
	door.become_wall()

func _on_enemy_died() -> void:
	num_enemies -= 1
	if num_enemies <= 0:
		unlock()
		if randf() < item_drop_chance:
			spawn_random_item()

func unlock() -> void:
	room_defeated = true
	for door in doors.get_children():
		door.unlock()
	if exit:
		exit.unlock()
	get_tree().call_group("bullet", "early_despawn")

func spawn_random_item() -> void:
	var item = items.pick_random().instantiate()
	item.global_position = global_position + spawn_area.get_random_point()
	get_tree().root.add_child(item)

func _on_player_dection_body_entered(_body: Node2D) -> void:
	if not room_defeated:
		activate()
		for enemy in enemies.get_children():
			if enemy.has_method("activate"):
				enemy.activate()
