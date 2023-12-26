class_name TowerManager
extends Node2D

signal tower_placed
signal tower_leveled_up

@export var level_manager : LevelManager
@export var ground_tile_map : TileMap

@onready var selected_tower : PackedScene = null
@onready var tower_preview = $TowerPreview

func _ready() -> void:
	tower_preview.tile_map = ground_tile_map

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
			ground_tile_map.place_tower(get_global_mouse_position())
			tower_preview.hide()
			tower_placed.emit()
	elif event.is_action_pressed("right_mouse"):
		selected_tower = null
		tower_preview.hide()
	elif selected_tower != null and event is InputEventMouseMotion:
		tower_preview.update(selected_tower)

func _request_level_up(cost: int, tower: Tower) -> void:
	if !level_manager.spend_gold(cost):
		return
	tower.level_up()
	emit_signal("tower_leveled_up")

func _on_tower_selected(tower):
	selected_tower = tower
