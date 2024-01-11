extends Node2D

@export var player:Player = null

@export_group("Dash", "dash_")
@export var dash_distance:float = 250
@export var dash_time:float = 0.3

@onready var ray_cast_2d: RayCast2D = $RayCast2D

var dir:Vector2

func _ready() -> void:
	ray_cast_2d.target_position = Vector2(dash_distance, 0)

func _physics_process(_delta: float) -> void:
	var speed_left:float = Input.get_axis("player_left", "player_right")
	var speed_up:float = Input.get_axis("player_up", "player_down")
	dir = Vector2(speed_left, speed_up).normalized()
	ray_cast_2d.look_at(global_position+dir)

func _input(event: InputEvent) -> void:
	if event.is_action_pressed("player_dash"):
		player.movement_blocked = true
		var tween:Tween = create_tween()
		if ray_cast_2d.is_colliding():
			tween.tween_property(player, "global_position", ray_cast_2d.get_collision_point(), dash_time).set_trans(Tween.TRANS_EXPO).set_ease(Tween.EASE_IN)
		else:
			tween.tween_property(player, "global_position", global_position+ray_cast_2d.target_position.rotated(ray_cast_2d.rotation), dash_time).set_trans(Tween.TRANS_EXPO).set_ease(Tween.EASE_IN)
		await tween.finished
		player.movement_blocked = false
		
