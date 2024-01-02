class_name Bullet
extends Node2D

@export var speed:float = 100
@export var lifetime:float = 10
@export var direction:Vector2 = Vector2.RIGHT

@onready var despawn_timer = $DespawnTimer

func _ready():
	despawn_timer.wait_time = lifetime
	despawn_timer.start()
	
	look_at(global_position+direction)

func _process(delta):
	position += delta*speed*direction

func _on_despawn_timer_timeout():
	get_parent().remove_child(self)
	queue_free()
