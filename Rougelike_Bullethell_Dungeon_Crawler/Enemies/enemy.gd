class_name Enemy
extends CharacterBody2D

signal died

@onready var animated_sprite_2d: AnimatedSprite2D = $AnimatedSprite2D

var dying:bool = false

func _ready() -> void:
	animated_sprite_2d.play("default")

func _on_health_died() -> void:
	if dying: return
	dying = true
	died.emit()
	animated_sprite_2d.position.y -= 16
	animated_sprite_2d.play("death")
	$CollisionShape2D.queue_free()
	$BulletSpawner.disable()
	await animated_sprite_2d.animation_finished
	get_parent().remove_child(self)
	queue_free()
