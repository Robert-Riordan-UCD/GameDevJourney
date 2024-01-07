class_name Player
extends CharacterBody2D

@export var player_speed:float = 450.0

var dying:bool = false

@onready var animated_sprite_2d = $AnimatedSprite2D
@onready var weapon: Sprite2D = $Weapon

func _physics_process(_delta):
	if dying: return
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
	pass # Replace with function body.

func _on_health_died() -> void:
	dying = true
	animated_sprite_2d.play("death")
	
