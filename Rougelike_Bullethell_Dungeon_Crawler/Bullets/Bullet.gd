class_name Bullet
extends Node2D

@export var speed:float = 100
@export var lifetime:float = 10
@export var damage:float = 1
@export var team:String = "enemy"

var direction:Vector2 = Vector2.RIGHT

@onready var despawn_timer = $DespawnTimer
@onready var hit_box: HitBox = $HitBox
@onready var despawning:bool = false

func _ready():
	despawn_timer.wait_time = lifetime
	despawn_timer.start()
	
	look_at(global_position+direction)
	
	hit_box.damage = damage

func _process(delta):
	position += delta*speed*direction

func _on_despawn_timer_timeout():
	despwan()

func early_despawn():
	await get_tree().create_timer(randf_range(0, 1.0)).timeout
	despwan()

func _on_despawn_box_body_entered(_body: Node2D) -> void:
	despwan(_body is Player)

func despwan(explode:bool=false) -> void:
	if despawning: return
	despawning = true
	
	if explode:
		$Sprite2D.visible = false
		$CPUParticles2D.emitting = true
		await $CPUParticles2D.finished
	
	get_parent().call_deferred("remove_child", self)
	queue_free()
	
