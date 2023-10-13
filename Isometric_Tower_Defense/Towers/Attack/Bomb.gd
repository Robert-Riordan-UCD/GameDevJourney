class_name Bomb
extends Area2D

signal hit(hits)

@export var splash_range : float = 150
@export var rotation_speed : float = 10
@export var attack_duration : float = 1.0

@onready var collision_shape_2d = $CollisionShape2D
@onready var sprite_2d = $Sprite2D

func _ready() -> void:
	collision_shape_2d.shape.radius = splash_range

func _process(delta) -> void:
	sprite_2d.rotate(delta*rotation_speed)

func goto(pos: Vector2) -> void:
	var tween : Tween = get_tree().create_tween()
	tween.set_parallel()
	tween.tween_property(self, "global_position:x", pos.x, attack_duration)
	tween.tween_property(self, "global_position:y", pos.y, attack_duration).set_trans(Tween.TRANS_CUBIC).set_ease(Tween.EASE_IN)
	tween.connect("finished", _bomb_landed)

func _bomb_landed() -> void:
	var hits := []
	for area in get_overlapping_areas():
		hits.append(area)
	hit.emit(hits)
	queue_free()
