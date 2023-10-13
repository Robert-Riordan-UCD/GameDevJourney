extends Node2D

signal hit

@export var width: int = 10
@export var fade_in_time: float = 0.1
@export var hold_time: float = 0.3
@export var fade_out_time: float = 0.1


@onready var line_2d = $Line2D
@onready var casting_particles_2d = $CastingParticles2D
@onready var impact_particles_2d = $ImpactParticles2D
@onready var beam_particles_2d = $BeamParticles2D

var target : Node2D

func _physics_process(delta: float) -> void:
	if target == null: return
	var hit_point : Vector2 = 2*(target.global_position - global_position) # I have no idea why I need to double this but it works
	line_2d.points[1] = hit_point
	impact_particles_2d.position = hit_point
	beam_particles_2d.set_emission_rect_extents(Vector2(hit_point.length(), 0))
	beam_particles_2d.rotation = position.angle_to(hit_point)

func fire_laser(t: Node2D) -> void:
	target = t
	_appear()

func _appear() -> void:
	visible = true
	casting_particles_2d.emitting = true
	impact_particles_2d.emitting = true
	beam_particles_2d.emitting = true
	var tween : Tween = get_tree().create_tween()
	tween.tween_property(line_2d, "width", width, fade_in_time)
	tween.connect("finished", _appeared)

func _appeared() -> void:
	hit.emit()
	get_tree().create_timer(hold_time).connect("timeout", _disappear)

func _disappear() -> void:
	var tween : Tween = get_tree().create_tween()
	tween.tween_property(line_2d, "width", 0, fade_out_time)
	casting_particles_2d.emitting = false
	impact_particles_2d.emitting = false
	beam_particles_2d.emitting = false
