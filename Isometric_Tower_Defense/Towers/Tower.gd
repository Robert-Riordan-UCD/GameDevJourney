class_name Tower
extends Area2D

signal request_level_up(cost)

@export var tower_name : String
@export var price : int = 50
var range : float
var damage : int
var cooldown : float
var current_level : int = 0

@export var levels : Array = [
	{
	"next_price": 50,
	"range": 300,
	"damage": 1,
	"cooldown": 0.5,
	"sprite": "res://Towers/crossbowTowerLevel0.png"
	},
	{
	"next_price": 50,
	"range": 400,
	"damage": 1,
	"cooldown": 0.5,
	"sprite": "res://Towers/crossbowTowerLevel1.png"
	},
	{
	"next_price": 50,
	"range": 500,
	"damage": 2,
	"cooldown": 0.5,
	"sprite": "res://Towers/crossbowTowerLevel2.png"
	},
	{
	"next_price": null,
	"range": 600,
	"damage": 2,
	"cooldown": 0.3,
	"sprite": "res://Towers/crossbowTowerLevel3.png"
	}
]

@onready var range_shape = $Range
@onready var range_sprite = $RangeSprite
@onready var attack_timer = $AttackTimer
@onready var last_range : int = 32
@onready var sprite_2d = $Sprite2D
@onready var upgrade_popup : UpgradePopup = $UpgradePopup

var attack : Attack = null
var enemies : Array = []

func _ready():
	for child in get_children():
		if child is Attack:
			attack = child
			break
	if attack == null:
		push_error("Tower must have an attack as a child. ", self)
	set_level()

func _on_area_entered(area):
	if area is Enemy:
		enemies.append(area)
		print("Orcs!")

func _on_area_exited(area):
	for i in range(len(enemies)):
		if enemies[i] == area:
			enemies.remove_at(i)
			return

func _on_attack_timer_timeout():
	var enemy_to_attack = null
	for i in range(len(enemies)-1, -1, -1):
		if enemies[i] == null:
			enemies.remove_at(i)
		else:
			enemy_to_attack = enemies[i]
	if enemy_to_attack == null: return
	attack.attack(enemy_to_attack, damage)

func level_up() -> void:
	current_level = min(current_level + 1, len(levels))
	set_level()

func set_level() -> void:
	range = levels[current_level]["range"]
	damage = levels[current_level]["damage"]
	cooldown = levels[current_level]["cooldown"]
	sprite_2d.texture = load(levels[current_level]["sprite"])
	
	range_shape.scale = Vector2(range, range*0.5)
	range_sprite.scale *= range/last_range
	last_range = range
	attack_timer.wait_time = cooldown

func _on_click_area_input_event(_viewport, event: InputEvent, _shape_idx):
	if event.is_action_pressed("left_mouse") and current_level < len(levels)-1:
		upgrade_popup.display(current_level, levels[current_level], levels[current_level+1], get_global_mouse_position())

func _on_click_area_mouse_entered():
	range_sprite.visible = true

func _on_click_area_mouse_exited():
	range_sprite.visible = false

func _on_upgrade_popup_buy():
	request_level_up.emit(levels[current_level]["next_price"])
