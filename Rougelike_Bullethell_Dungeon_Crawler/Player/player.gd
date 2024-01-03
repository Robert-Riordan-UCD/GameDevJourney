extends CharacterBody2D

@export var player_speed:float = 450.0

@onready var animated_sprite_2d = $AnimatedSprite2D

func _physics_process(delta):
	var speed_left = player_speed * Input.get_axis("player_left", "player_right")
	var speed_up = player_speed * Input.get_axis("player_up", "player_down")
	velocity = Vector2(speed_left, speed_up)

	move_and_slide()

	if speed_left:
		animated_sprite_2d.flip_h = speed_left < 0
	
	if velocity:
		animated_sprite_2d.play("run")
	else:
		animated_sprite_2d.play("default")

func take_damage(damage:float) -> void:
	print("Tha's a lot of damage! ", damage)
