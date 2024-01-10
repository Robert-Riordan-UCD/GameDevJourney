class_name BurstBulletSpawner
extends BulletSpawner

@export var on_time:float = 0.5
@export var off_time:float = 1.5
@export var target:Node2D = null

@onready var burst_on_timer: Timer = $BurstOnTimer
@onready var burst_off_timer: Timer = $BurstOffTimer

func _ready() -> void:
	burst_on_timer.wait_time = on_time
	burst_off_timer.wait_time = off_time
	
	if target == null:
		target = get_tree().get_nodes_in_group("player")[0]

func enable():
	burst_on_timer.start()
	bullet_spawn_timer.wait_time = 1/bullets_per_second
	bullet_spawn_timer.start()

func disable():
	burst_on_timer.stop()
	burst_off_timer.stop()
	bullet_spawn_timer.stop()

func _on_burst_on_timer_timeout() -> void:
	burst_off_timer.start()
	bullet_spawn_timer.stop()

func _on_burst_off_timer_timeout() -> void:
	burst_on_timer.start()
	bullet_spawn_timer.start()
	if target:
		look_at(target.global_position)
		rotation -= on_time*rotation_speed/2
