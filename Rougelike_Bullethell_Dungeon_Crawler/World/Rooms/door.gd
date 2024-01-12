class_name Door
extends StaticBody2D

var is_wall:bool = false

func _ready() -> void:
	for child in get_children():
		if child is AnimatedSprite2D:
			child.frame = child.sprite_frames.get_frame_count("unlock")-1

func become_wall() -> void:
	is_wall = true
	for child in get_children():
		if child is CollisionShape2D:
			child.set_deferred("disabled", false)
	for child in get_children():
		if child is AnimatedSprite2D:
			remove_child(child)
			child.queue_free()

func unlock() -> void:
	if is_wall: return
	animate()
	
	for child in get_children():
		if child is CollisionShape2D:
			child.set_deferred("disabled", true)

func lock() -> void:
	if is_wall: return
	animate(true)

	for child in get_children():
		if child is CollisionShape2D:
			child.set_deferred("disabled", false)

func animate(lock:bool=false) -> void:
	for child in get_children():
		if child is AnimatedSprite2D:
			if lock:
				child.play_backwards("unlock")
			else:
				child.play("unlock")
	
