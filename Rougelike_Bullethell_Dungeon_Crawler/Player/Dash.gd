extends Node2D

@export var player:Player = null

@export_group("Dash", "dash_")
@export var dash_distance:float = 250
@export var dash_time:float = 0.3

@onready var ray_cast_2d: RayCast2D = $RayCast2D

func _input(event: InputEvent) -> void:
	if event.is_action_pressed("player_dash"):
		var speed_left:float = Input.get_axis("player_left", "player_right")
		var speed_up:float = Input.get_axis("player_up", "player_down")
		var dir:Vector2 = Vector2(speed_left, speed_up).normalized()
		
		var target_position: Vector2 = player.global_position+dash_distance*dir
		ray_cast_2d.target_position = dir*dash_distance
		if ray_cast_2d.is_colliding():
			target_position = ray_cast_2d.get_collision_point()
		
		player.movement_blocked = true
		var tween:Tween = create_tween()
		tween.tween_property(player, "global_position", target_position, dash_time).set_trans(Tween.TRANS_EXPO).set_ease(Tween.EASE_IN)
		await tween.finished
		player.movement_blocked = false
		
