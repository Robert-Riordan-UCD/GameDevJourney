extends BulletSpawner

signal done

@export var sweep_angle:float = 90
@export var firing_time:float = 3.0
@export var sweeps:int = 4

@onready var player:Player = get_tree().get_first_node_in_group("player")

func _ready() -> void:
	pass

func _process(_delta) -> void:
	pass

func trigger() -> void:
	var tween:Tween
	rotation_degrees -= sweep_angle/2
	enable()
	for i in range(sweeps):
		tween = create_tween()
		if i%2:
			tween.tween_property(self, "rotation_degrees", rotation_degrees-sweep_angle, firing_time/sweeps)
		else:
			tween.tween_property(self, "rotation_degrees", rotation_degrees+sweep_angle, firing_time/sweeps)
		await tween.finished
	disable()
	done.emit()
	
