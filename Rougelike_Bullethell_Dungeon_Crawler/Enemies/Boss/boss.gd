class_name Boss
extends CharacterBody2D

signal died

@export var movement_area:SpawnArea

@onready var _dying:bool = false
