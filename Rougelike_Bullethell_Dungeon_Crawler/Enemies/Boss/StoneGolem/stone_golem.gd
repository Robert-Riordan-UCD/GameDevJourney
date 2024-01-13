extends Boss

const SPEED = 300.0

signal died
#
#@export var bullet_spawner:BulletSpawner = null
#
#@export var start_time_offset_min:float = 1.6
#@export var start_time_offset_max:float = 0.2
#
#@export var movement_area:SpawnArea

@onready var animated_sprite_2d: AnimatedSprite2D = $AnimatedSprite2D

var dying:bool = false
#
#func _ready() -> void:
#	randomize()
#	setup_bullet_spawner()
#	random_movement.movement_area = movement_area
#
#func _process(delta: float) -> void:
#	if dying: return
#	if random_movement and random_movement.enabled:
#		animated_sprite_2d.play("move")
#		animated_sprite_2d.flip_h = velocity.x < 0
#
#func activate() -> void:
#	await spawn_self()
#	if dying: return
#	bullet_spawner.enable()
#	random_movement.enabled = true
#
#func setup_bullet_spawner() -> void:
#	if bullet_spawner ==  null:
#		bullet_spawner = preload("res://Bullets/bullet_spawner.tscn").instantiate()
#	add_child(bullet_spawner)
#	bullet_spawner.disable()
#
#func spawn_self() -> void:
#	await get_tree().create_timer(randf_range(start_time_offset_min, start_time_offset_max)).timeout
#	animated_sprite_2d.play_backwards("death")
#	await animated_sprite_2d.animation_finished
#	animated_sprite_2d.position.y += 8
#	animated_sprite_2d.play("default")
#
#func _on_health_died() -> void:
#	if dying: return
#	dying = true
#	died.emit()
#	animated_sprite_2d.position.y -= 8
#	animated_sprite_2d.play("death")
#	$CollisionShape2D.queue_free()
#	random_movement.queue_free()
#	bullet_spawner.disable()
#	await animated_sprite_2d.animation_finished
#	get_parent().remove_child(self)
#	queue_free()
