class_name HurtBox
extends Area2D

@export var parent:Node

func _init() -> void:
	collision_layer = 0
	collision_mask = 2

func _ready() -> void:
	area_entered.connect(_on_area_entered)

func _on_area_entered(hitbox:HitBox) -> void:
	if not hitbox: return
	if parent.has_method("take_damage"):
		parent.take_damage(hitbox.damage)
