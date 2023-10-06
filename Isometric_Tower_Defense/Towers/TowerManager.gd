class_name TowerManager
extends Node2D

@export var level_manager : LevelManager
@export var ground_tile_map : TileMap

@onready var selected_tower : PackedScene = null

func _input(event):
	if selected_tower != null and event.is_action_pressed("left_mouse"):
		if ground_tile_map.can_place_tower(get_global_mouse_position()):
			if selected_tower == null: return
			var new_tower : Tower = selected_tower.instantiate()
			
			if !level_manager.spend_gold(new_tower.price):
				return
			add_child(new_tower)
			new_tower.position = ground_tile_map.snap_to_grid(get_global_mouse_position())
			new_tower.request_level_up.connect(_request_level_up.bind(new_tower))
			selected_tower = null
	elif event.is_action_pressed("right_mouse"):
		selected_tower = null

func _request_level_up(cost: int, tower: Tower) -> void:
	if !level_manager.spend_gold(cost):
		return
	tower.level_up()

func _on_tower_selected(tower):
	selected_tower = tower
