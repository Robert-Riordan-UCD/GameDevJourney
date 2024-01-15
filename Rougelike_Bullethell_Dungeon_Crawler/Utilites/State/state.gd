class_name State
extends Node2D

signal transition(next_state)

@export var final:bool = false

func enter() -> void:
	pass

func exit() -> void:
	pass

func update(_delta:float) -> void:
	pass

func physics_update(_delta:float) -> void:
	pass
