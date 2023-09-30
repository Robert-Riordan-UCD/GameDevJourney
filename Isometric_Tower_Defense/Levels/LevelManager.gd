class_name LevelManager
extends Node2D

@export var health : int = 10
@export var gold : int = 500

@onready var gui : GUI = $CanvasLayer/GUI
@onready var tower_manager : TowerManager = $TowerManager
@onready var ground_tile_map = $GroundTileMap

func _ready():
	gui.set_gold_amount(gold)
	gui.set_health(health)

func spend_gold(amount: int) -> bool:
	if amount > gold or amount < 0:
		return false
	gold -= amount
	gui.set_gold_amount(gold)
	return true

func _on_enemies_enemy_reached_end(damage):
	health -= damage
	gui.set_health(health)
