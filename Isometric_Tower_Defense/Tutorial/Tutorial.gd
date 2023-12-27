extends Control

@onready var place_crossbow_tower_popup := $PlaceCrossbowTowerPopup
@onready var label = $PlaceCrossbowTowerPopup/MarginContainer/VBoxContainer/Label
@onready var button = $PlaceCrossbowTowerPopup/MarginContainer/VBoxContainer/Button

func _ready():
	await advance_text("The orcs are trying to steal your crystals!")
	
	# Tower placement
	await advance_text("Protect them by building a crossbow tower.")
	mouse_filter = Control.MOUSE_FILTER_IGNORE
	focus_target($"../TowerSelect/HBoxContainer/CrossbowSelect")
	await $"../TowerSelect/HBoxContainer/CrossbowSelect".tower_selected
	focus_target($TowerPlacmentSpot, 0.6, 0.05)
	await $"../../TowerManager".tower_placed
	mouse_filter = Control.MOUSE_FILTER_STOP
	defocus()
	
	# Start button
	await advance_text("It looks like your prepared. Call the first wave now.")
	mouse_filter = Control.MOUSE_FILTER_IGNORE
	$"../NextWaveButton".visible = true
	focus_target($"../NextWaveButton", 0.6, 0.1)
	await $"../NextWaveButton".next_wave_button_pressed
	mouse_filter = Control.MOUSE_FILTER_STOP
	defocus()
	
	# Upgrade tower
	await $"../../Enemies".enemy_died
	$"../../SpawnPoint/WaveTimer".paused = true
	await advance_text("That orc dropped some gold! You can upgrade your crossbow now!")
	mouse_filter = Control.MOUSE_FILTER_IGNORE
	focus_target($TowerPlacmentSpot, 0.6, 0.1)
	await $"../../TowerManager".tower_leveled_up
	mouse_filter = Control.MOUSE_FILTER_STOP
	defocus()
	
	# Next wave button
	await advance_text("The next wave will be coming soon, but if you call them early you'll get some extra gold!")
	mouse_filter = Control.MOUSE_FILTER_IGNORE
	$"../../SpawnPoint/WaveTimer".paused = false
	
	# Place mage tower
	while $"../..".gold < 25:
		await $"../../Enemies".enemy_died
	$"../TowerSelect/HBoxContainer/MageSelect".visible = true
	$"../../SpawnPoint/WaveTimer".paused = true
	await advance_text("You have enough gold for a mage now! They're slower than a crossbow but stronger.")
	focus_target($"../TowerSelect/HBoxContainer/MageSelect")
	await $"../TowerSelect/HBoxContainer/MageSelect".tower_selected
	focus_target($TowerPlacmentSpot2, 0.6, 0.05)
	await $"../../TowerManager".tower_placed
	$"../../SpawnPoint/WaveTimer".paused = false
	defocus()
	
	# Final message
	await advance_text("You should be able to handle it from here. Good luck!")

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

func _on_skip_button_pressed():
	SceneTransition.change_scene("res://Levels/Level1.tscn")
