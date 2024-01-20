class_name Weapon
extends Node2D

@export var flipped:bool = false: set = _set_flipped
@export var held:bool = false

@onready var attacking:bool = false
@onready var hit_box:HitBox = $Node2D/Sprite2D/HitBox
@onready var collision_shape_2d: CollisionShape2D = $Node2D/Sprite2D/HitBox/CollisionShape2D
@onready var pickup_area:Area2D = $Node2D/Sprite2D/HitBox/PickupArea
@onready var sprite2d:Sprite2D = $Node2D/Sprite2D
@onready var animation_player: AnimationPlayer = $AnimationPlayer

func _ready() -> void:
	animation_player.play("idle")

func _input(event: InputEvent) -> void:
	if held and event.is_action_pressed("player_main_hand"):
		attack()
	
	if event.is_action_pressed("player_pickup") and not held:
		for body in pickup_area.get_overlapping_bodies():
			if body is Player:
				body.pickup(self)

func attack() -> void:
	if attacking: return
	attacking = true
	collision_shape_2d.disabled = false
	await play_attack()
	attacking = false
	collision_shape_2d.disabled = true

func play_attack() -> void:
	var tween:Tween = create_tween()
	if flipped:
		tween.tween_property(sprite2d, "rotation_degrees", -180, 0.2).set_ease(Tween.EASE_IN_OUT).set_trans(Tween.TRANS_QUAD)
		tween.tween_property(sprite2d, "rotation_degrees", 0, 0.2).set_ease(Tween.EASE_IN_OUT).set_trans(Tween.TRANS_QUAD)
	else:
		tween.tween_property(sprite2d, "rotation_degrees", 180, 0.2).set_ease(Tween.EASE_IN_OUT).set_trans(Tween.TRANS_QUAD)
		tween.tween_property(sprite2d, "rotation_degrees", 0, 0.2).set_ease(Tween.EASE_IN_OUT).set_trans(Tween.TRANS_QUAD)
	await tween.finished

func pickup(new_parent:Node) -> void:
	if held: return
	if get_parent(): get_parent().remove_child(self)
	new_parent.add_child(self)
	animation_player.stop()
	transform.origin = Vector2.ZERO
	scale /= 2 
	held = true

func drop() -> void:
	if not held: return
	Utils.drop_item(load(scene_file_path), global_position)
	if get_parent(): get_parent().remove_child(self)
	queue_free()

func _set_flipped(f:bool) -> void:
	sprite2d.position.x = -abs(sprite2d.position.x) if f else abs(sprite2d.position.x)
	sprite2d.flip_h = f
	flipped = f
