extends Control

@onready var place_crossbow_tower_popup := $PlaceCrossbowTowerPopup
@onready var label = $PlaceCrossbowTowerPopup/MarginContainer/VBoxContainer/Label
@onready var button = $PlaceCrossbowTowerPopup/MarginContainer/VBoxContainer/Button

func _ready():
	await advance_text("The orcs are trying to steal your crystals!")
	
	# Tower placement
	await advance_text("Protect them by building a crossbow tower.")
	focus_target($"../TowerSelect/HBoxContainer/CrossbowSelect")
	await $"../TowerSelect/HBoxContainer/CrossbowSelect".tower_selected
	focus_target($TowerPlacmentSpot, 0.6, 0.05)
	await $"../../TowerManager".tower_placed
	defocus()
	
	# Start button
	await advance_text("It looks like your prepared. Call the first wave now.")
	$"../NextWaveButton".visible = true
	focus_target($"../NextWaveButton", 0.6, 0.1)
	await $"../NextWaveButton".next_wave_button_pressed
	defocus()
	
	# Upgrade tower
	await $"../../Enemies".enemy_died
	$"../../SpawnPoint/WaveTimer".paused = true
	await advance_text("That orc dropped some gold! You can upgrade your crossbow now!")
	focus_target($TowerPlacmentSpot, 0.6, 0.1)
	await $"../../TowerManager".tower_leveled_up
	defocus()
	
	# Next wave button
	await advance_text("The next wave will be coming soon, but if you call them early you'll get some extra gold!")
	$"../../SpawnPoint/WaveTimer".paused = false

func advance_text(text):
	label.text = text
	Utils.tween_in(place_crossbow_tower_popup, 0.5)
	await button.pressed
	await Utils.tween_out(place_crossbow_tower_popup, 0.5)

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

func defocus(duration=1.0):
	var tween = create_tween()
	tween.tween_method(
		_update_shader_radius,
		$FocusShader.material.get_shader_parameter("radius"),
		1.0,
		duration
	).set_trans(Tween.TRANS_ELASTIC)

func _update_shader_position(target):
	$FocusShader.material.set_shader_parameter("target", target)

func _update_shader_radius(radius):
	$FocusShader.material.set_shader_parameter("radius", radius)
