extends BulletSpawner

@export var num_bullets:int = 30

func _ready() -> void:
	pass

func _process(_delta) -> void:
	pass

func trigger(offset:Vector2=Vector2.ZERO) -> void:
	for b in range(num_bullets):
		var angle:float = b*180/PI
		var new_bullet:Bullet = bullet_scene.instantiate()
		new_bullet.global_position = global_position + offset + spawn_radius*Vector2.RIGHT.rotated(angle)
		new_bullet.direction = Vector2.RIGHT.rotated(angle)
		new_bullet.speed = bullet_speed
		new_bullet.damage = damage
		new_bullet.scale *= size
		get_tree().root.add_child(new_bullet)
