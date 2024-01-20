class_name Player
extends CharacterBody2D

signal health_changed(health:int, max_health:int)

@export var player_speed:float = 450.0

var dying:bool = false
var movement_blocked:bool = false
var main_hand_weapon:Weapon = null

@onready var animated_sprite_2d = $AnimatedSprite2D
@onready var main_hand: Node2D = $MainHand
@onready var health:Health = $Health
const SWORD = preload("res://Player/Weapons/sword.tscn")

func _ready() -> void:
	pickup(SWORD.instantiate())

func _physics_process(_delta):
	if dying or movement_blocked: return
	var speed_left = player_speed * Input.get_axis("player_left", "player_right")
	var speed_up = player_speed * Input.get_axis("player_up", "player_down")
	velocity = Vector2(speed_left, speed_up)

	move_and_slide()

	if speed_left:
		if main_hand_weapon: main_hand_weapon.flipped = speed_left < 0
		animated_sprite_2d.flip_h = speed_left < 0
	
	if velocity:
		animated_sprite_2d.play("run")
	else:
		animated_sprite_2d.play("default")

func pickup(item) -> void:
	if item is Weapon:
		if main_hand_weapon:
			main_hand.remove_child(main_hand_weapon)
			main_hand_weapon.drop()
		
		item.pickup(main_hand)
		main_hand_weapon = item

func _on_health_damaged() -> void:
	health_changed.emit(health.current_health, health.max_health)
	ScreenShake.screen_shake(40, 75, 6)
	$AnimationPlayer.play("hit")

func _on_health_died() -> void:
	if dying: return
	dying = true
	_on_health_damaged()
	animated_sprite_2d.play("death")
	health_changed.emit(health.current_health, health.max_health)
