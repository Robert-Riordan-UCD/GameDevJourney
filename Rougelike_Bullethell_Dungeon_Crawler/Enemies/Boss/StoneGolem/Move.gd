extends State

@export var speed:float = 30
@export var parent:Boss
@export var exit_states:Array = ["MeleeAttack", "RangeAttack"]

var target:Vector2

func enter() -> void:
	target = parent.movement_area.get_random_point()
	parent.animated_sprite_2d.play("idle")
	parent.animated_sprite_2d.flip_h = target.x < parent.position.x

func physics_update(delta:float) -> void:
	parent.position += speed*delta*parent.position.direction_to(target)
	if parent.position.distance_to(target) < 10:
		transition.emit(exit_states.pick_random())
