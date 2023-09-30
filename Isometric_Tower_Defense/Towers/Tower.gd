class_name Tower
extends Area2D

signal request_level_up(cost)

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
	"cooldown": 0.5
	},
	{
	"next_price": 50,
	"range": 400,
	"damage": 1,
	"cooldown": 0.5
	},
	{
	"next_price": 50,
	"range": 500,
	"damage": 2,
	"cooldown": 0.5
	},
	{
	"next_price": null,
	"range": 600,
	"damage": 2,
	"cooldown": 0.3
	}
]

@onready var range_shape = $Range
@onready var attack_timer = $AttackTimer
@onready var bullet = $Bullet

var enemies : Array = []

func _ready():
	set_level(current_level)

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
	attack(enemy_to_attack)

func attack(enemy: Enemy) -> void:
	print("Attacking!!!")
	enemy.take_damage(damage)
	bullet.goto(enemy.global_position)

func level_up() -> void:
	current_level = min(current_level + 1, len(levels))
	set_level(current_level)

func set_level(level: int) -> void:
	range = levels[current_level]["range"]
	damage = levels[current_level]["damage"]
	cooldown = levels[current_level]["cooldown"]
	
	range_shape.scale = Vector2(range, range*0.5)
	attack_timer.wait_time = cooldown

func _on_click_area_input_event(_viewport, event, _shape_idx):
	if event.is_action_pressed("right_mouse") and current_level < len(levels)-1:
		request_level_up.emit(levels[current_level]["next_price"])



