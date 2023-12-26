extends Control

@onready var place_crossbow_tower_popup := $PlaceCrossbowTowerPopup
@onready var label = $PlaceCrossbowTowerPopup/MarginContainer/VBoxContainer/Label
@onready var button = $PlaceCrossbowTowerPopup/MarginContainer/VBoxContainer/Button

func _ready():
	advance_text("The orcs are trying to steal your crystals!")
	await button.pressed
	await Utils.tween_out(place_crossbow_tower_popup)
	
	advance_text("Protect them by building a crossbow tower.")
	await button.pressed
	await Utils.tween_out(place_crossbow_tower_popup)
	
	focus_target($"../TowerSelect/HBoxContainer/CrossbowSelect")
	await $"../TowerSelect/HBoxContainer/CrossbowSelect".tower_selected

	focus_target($TowerPlacmentSpot, 0.6, 0.05)
	await $"../../TowerManager".tower_placed
	
	focus_target($TowerPlacmentSpot, 1.0, 1.0)


func advance_text(text):
	label.text = text
	Utils.tween_in(place_crossbow_tower_popup)

func focus_target(node, duration=1.0, radius=0.15):
	var tween = create_tween()
	tween.set_parallel()
	tween.tween_method(
		_update_shader_position,
		$FocusShader.material.get_shader_parameter("target"),
		(node.global_position+node.size/2) / get_viewport_rect().size,
		duration
	).set_trans(Tween.TRANS_CUBIC).set_ease(Tween.EASE_OUT)
	tween.tween_method(
		_update_shader_radius,
		$FocusShader.material.get_shader_parameter("radius"),
		radius,
		duration
	).set_trans(Tween.TRANS_ELASTIC)

func _update_shader_position(target):
	$FocusShader.material.set_shader_parameter("target", target)

func _update_shader_radius(radius):
	$FocusShader.material.set_shader_parameter("radius", radius)
