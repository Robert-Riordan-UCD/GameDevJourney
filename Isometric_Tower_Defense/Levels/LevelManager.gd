class_name LevelManager
extends Node2D

@export var health : int = 10
@export var gold : int = 500

@onready var gui : GUI = $CanvasLayer/GUI
@onready var tower_manager : TowerManager = $TowerManager
@onready var ground_tile_map = $GroundTileMap
@onready var level_started : bool = false
@onready var spawn_point = $SpawnPoint
@onready var next_wave_button = $CanvasLayer/NextWaveButton

var game_speed := [1, 2, 4]

func _ready():
	gui.set_gold_amount(gold)
	gui.set_health(health)
	var num_waves : int = 0
	for child in spawn_point.get_children():
		if child is Wave:
			num_waves += 1
	gui.set_total_waves(num_waves)
	gui.set_current_wave(1)
	set_game_speed()

func spend_gold(amount: int) -> bool:
	if amount > gold or amount < 0:
		return false
	gold -= amount
	gui.set_gold_amount(gold)
	return true

func _on_enemies_enemy_reached_end(damage: int) -> void:
	health -= damage
	gui.set_health(health)
	if health <= 0:
		game_over()

func _on_enemies_enemy_died(g: int) -> void:
	gold += g
	gui.set_gold_amount(gold)

func game_over() -> void:
	$CanvasLayer/GameOverPopup.display()

func _on_enemies_all_enemies_defeated():
	if health <= 0: return
	$CanvasLayer/LevelWonPopup.display()

func _on_spawn_point_new_wave(wave_number):
	if gui == null: return
	gui.set_current_wave(wave_number)
	next_wave_button.hide_next_wave_button()

func _on_button_pressed():
	set_game_speed()

func set_game_speed() -> void:
	var new_speed = game_speed.pop_front()
	game_speed.append(new_speed)
	Engine.time_scale = new_speed
	$CanvasLayer/SpeedButton/Button.text = str(new_speed) + 'x'

func _on_tower_manager_tower_placed():
	if level_started: return
	level_started = true
	spawn_point.start()

func _on_spawn_point_wave_finished():
	await get_tree().create_timer(1).timeout
	next_wave_button.show_next_wave_button()
