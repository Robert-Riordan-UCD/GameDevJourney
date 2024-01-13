class_name HitBox
extends Area2D

@export var damage:float = 10
@export var crit_chance:float = 0.1
@export var crit_damage:float = 15
@export var team:String = 'enemy'

func _init():
	collision_layer = 2
	collision_mask = 0
