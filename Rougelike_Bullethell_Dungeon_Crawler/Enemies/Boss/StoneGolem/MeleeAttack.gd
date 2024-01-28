extends State

@export var parent:Boss
@export var slam_dist:float = 10
@export var slam_time:float = 0.2
@export var floor_time:float = 0.2
@export var rise_time:float = 0.8

@onready var tween:Tween

func enter() -> void:
	parent.animated_sprite_2d.play("slam")
	await parent.animated_sprite_2d.animation_finished
	
	tween = create_tween()
	tween.tween_property(parent.animated_sprite_2d, "position", position+Vector2(0, slam_dist), slam_time).set_trans(Tween.TRANS_EXPO)
	await tween.finished
	
	$CircleBulletSpawner.trigger(Vector2(0, slam_dist))
	
	tween = create_tween()
	tween.tween_property(parent.animated_sprite_2d, "position", position-Vector2(0, slam_dist), rise_time).set_delay(floor_time)
	await tween.finished
	
	parent.animated_sprite_2d.play_backwards("slam")
	parent.animated_sprite_2d.animation_finished.connect(done)

func exit() -> void:
	tween.stop()
	print("Exit Melee")

func done() -> void:
	transition.emit("Move")
