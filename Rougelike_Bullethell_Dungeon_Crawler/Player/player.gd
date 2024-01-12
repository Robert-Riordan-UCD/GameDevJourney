class_name Player
extends CharacterBody2D

signal health_changed(health:int, max_health:int)

@export var player_speed:float = 450.0

var dying:bool = false
var movement_blocked:bool = false

@onready var animated_sprite_2d = $AnimatedSprite2D
@onready var weapon:Sprite2D = $Weapon
@onready var health:Health = $Health

func _physics_process(_delta):
	if dying or movement_blocked: return
	var speed_left = player_speed * Input.get_axis("player_left", "player_right")
	var speed_up = player_speed * Input.get_axis("player_up", "player_down")
	velocity = Vector2(speed_left, speed_up)

	move_and_slide()

	if speed_left:
		if speed_left < 0:
				weapon.position.x = -abs(weapon.position.x)
		else:
				weapon.position.x = abs(weapon.position.x)
		weapon.flipped = speed_left < 0
		animated_sprite_2d.flip_h = speed_left < 0
	
	if velocity:
		animated_sprite_2d.play("run")
	else:
		animated_sprite_2d.play("default")

func _on_health_damaged() -> void:
	health_changed.emit(health.current_health, health.max_health)
	ScreenShake.screen_shake(50, 25, 5)

func _on_health_died() -> void:
	dying = true
	animated_sprite_2d.play("death")
	health_changed.emit(health.current_health, health.max_health)
