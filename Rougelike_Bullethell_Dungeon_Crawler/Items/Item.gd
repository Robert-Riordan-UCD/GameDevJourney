class_name Item
extends Node2D

@export var held:bool = false

@onready var animation_player: AnimationPlayer = $AnimationPlayer
@onready var sprite_2d: Sprite2D = $AnimationOffset/Sprite2D
@onready var pickup_area: Area2D = $AnimationOffset/Sprite2D/PickupArea

func _ready() -> void:
	assert(sprite_2d, "Item sprite not set")
	animation_player.play("idle")

func _input(event: InputEvent) -> void:
	if event.is_action_pressed("player_pickup") and not held:
		for body in pickup_area.get_overlapping_bodies():
			if body is Player:
				body.pickup(self)

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

func use(user:Node) -> void:
	if get_parent(): get_parent().remove_child(self)
	queue_free()
