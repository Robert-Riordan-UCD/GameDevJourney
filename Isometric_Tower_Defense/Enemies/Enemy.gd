class_name Enemy
extends Area2D

signal reached_end(damage)
signal died(gold)

@export_category("Variables")
@export var speed : float = 50
@export var damage : int = 1
@export var health : int = 10
@export var gold : int = 10

@export_category("Setup")
@export var path : Array

var next_point : Vector2

var path_points : Array = []

const NEAR_TARGET_THRESHOLD = 1;

func _ready() -> void:
	for point in path:
		path_points.append(point.global_position)
	next_point = path_points[0]

func _process(delta: float) -> void:
	move(delta)
	update_path()

func move(delta: float) -> void:
	var dir_to_point = position.direction_to(next_point)
	position += delta*speed*dir_to_point

func update_path() -> void:
	if position.distance_to(next_point) <= NEAR_TARGET_THRESHOLD:
		path_points.pop_front()
		if len(path_points) > 0:
			next_point = path_points[0]
		else:
			reached_end.emit(damage)
			queue_free()

func take_damage(d: int):
	health -= d
	print("Ouch")
	if health <= 0:
		print("Ugh....")
		died.emit(gold)
		queue_free()
