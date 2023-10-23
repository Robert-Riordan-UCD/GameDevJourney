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

const NEAR_TARGET_THRESHOLD = 5;

@onready var spawn_audio = $SpawnAudio
@onready var hurt_audio = $HurtAudio
@onready var death_audio = $DeathAudio
@onready var animated_sprite_2d = $AnimatedSprite2D
@onready var dead : bool = false

func _ready() -> void:
	for point in path:
		path_points.append(point.global_position)
	next_point = path_points[0]
	AudioManager.request_sound(spawn_audio)
	animated_sprite_2d.play("default")

func _process(delta: float) -> void:
	if dead: return
	move(delta)
	update_path()

func move(delta: float) -> void:
	var dir_to_point = position.direction_to(next_point)
	animated_sprite_2d.flip_h = dir_to_point.x < 0
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
	if dead: return
	health -= d
	AudioManager.request_sound(hurt_audio)
	if health <= 0:
		died.emit(gold)
		animated_sprite_2d.play("death")
		dead = true
		death_audio.play()

func distance_to_goal() -> float:
	var dist : float = position.distance_to(next_point)
	for i in range(path_points.size()-1):
		dist += path_points[i].distance_to(path_points[i+1])
	return dist

func _on_animated_sprite_2d_animation_finished():
	if dead:
		if death_audio.playing:
			await death_audio.finished
		await Utils.tween_out(self)
		queue_free()
