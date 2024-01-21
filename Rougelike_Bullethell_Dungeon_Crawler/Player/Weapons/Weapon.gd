class_name Weapon
extends Item

@export var flipped:bool = false: set = _set_flipped

@onready var attacking:bool = false
@onready var hit_box_collision:CollisionShape2D = $AnimationOffset/Sprite2D/HitBox/CollisionShape2D

func _input(event: InputEvent) -> void:
	if held and event.is_action_pressed("player_main_hand"):
		attack()
	super._input(event)

func attack() -> void:
	if attacking: return
	attacking = true
	hit_box_collision.disabled = false
	await play_attack()
	attacking = false
	hit_box_collision.disabled = true

func play_attack() -> void:
	pass

func _set_flipped(f:bool) -> void:
	if sprite_2d:
		sprite_2d.position.x = -abs(sprite_2d.position.x) if f else abs(sprite_2d.position.x)
		sprite_2d.flip_h = f
	flipped = f
