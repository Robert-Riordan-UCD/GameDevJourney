class_name Enemy
extends CharacterBody2D

signal died

@export var bullet_spawner:BulletSpawner = null

@export var start_time_offset_min:float = 1.6
@export var start_time_offset_max:float = 0.2

@onready var animated_sprite_2d: AnimatedSprite2D = $AnimatedSprite2D

var dying:bool = false

func _ready() -> void:
	randomize()
	setup_bullet_spawner()

func activate() -> void:
	await spawn_self()
	bullet_spawner.enable()

func setup_bullet_spawner() -> void:
	if bullet_spawner ==  null:
		bullet_spawner = preload("res://Bullets/bullet_spawner.tscn").instantiate()
	add_child(bullet_spawner)
	bullet_spawner.disable()

func spawn_self() -> void:
	await get_tree().create_timer(randf_range(start_time_offset_min, start_time_offset_max)).timeout
	animated_sprite_2d.play_backwards("death")
	await animated_sprite_2d.animation_finished
	animated_sprite_2d.position.y += 8
	animated_sprite_2d.play("default")

func _on_health_died() -> void:
	if dying: return
	dying = true
	died.emit()
	animated_sprite_2d.position.y -= 8
	animated_sprite_2d.play("death")
	$CollisionShape2D.queue_free()
	bullet_spawner.disable()
	await animated_sprite_2d.animation_finished
	get_parent().remove_child(self)
	queue_free()
