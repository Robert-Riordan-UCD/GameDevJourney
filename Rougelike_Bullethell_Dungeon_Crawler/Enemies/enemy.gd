class_name Enemy
extends CharacterBody2D

signal died

@export var bullet_spawner:BulletSpawner = null

@export var start_time_offset_min:float = 0.2
@export var start_time_offset_max:float = 1.6

@export var movement_area:SpawnArea

@export_range(0.0, 1.0) var item_drop_chance:float = 0.05
@export var difficulty:int = 1

@onready var animated_sprite_2d: AnimatedSprite2D = $AnimatedSprite2D
@onready var random_movement: Node2D = $RandomMovement
@onready var animation_player: AnimationPlayer = $AnimationPlayer
@onready var items:Array[PackedScene] = [preload("res://Items/health_potion.tscn")]


var dying:bool = false

func _ready() -> void:
	randomize()
	randomize_self()
	setup_bullet_spawner()
	random_movement.movement_area = movement_area

func randomize_self() -> void:
	random_movement.speed += randi_range(0, difficulty)
	$Health.max_health += randi_range(0, difficulty)
	$Health.current_health = $Health.max_health
	bullet_spawner = Utils.new_random_bullet_spawner(difficulty)
	start_time_offset_min *= max(0, (100.0-difficulty)/100)
	start_time_offset_max *= max(0, (100.0-difficulty)/100)

func _process(delta: float) -> void:
	if dying: return
	if random_movement and random_movement.enabled:
		animated_sprite_2d.play("move")
		animated_sprite_2d.flip_h = velocity.x < 0

func activate() -> void:
	await spawn_self()
	if dying: return
	bullet_spawner.enable()
	random_movement.enabled = true

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

func _on_health_damaged() -> void:
	animation_player.play("hit")

func _on_health_died() -> void:
	if dying: return
	_on_health_damaged()
	dying = true
	died.emit()
	if randf() < item_drop_chance:
		Utils.drop_item(items.pick_random(), global_position)
	animated_sprite_2d.stop()
	animated_sprite_2d.position.y -= 8
	animated_sprite_2d.play("death")
	$CollisionShape2D.queue_free()
	random_movement.queue_free()
	bullet_spawner.disable()
	await animated_sprite_2d.animation_finished
	get_parent().remove_child(self)
	queue_free()
