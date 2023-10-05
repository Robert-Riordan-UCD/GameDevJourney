class_name UpgradePopup
extends Popup

signal buy

@onready var level_text = $MarginContainer/VBoxContainer/Level
@onready var current_texture := $MarginContainer/VBoxContainer/GridContainer/CurrentTexture
@onready var next_texture = $MarginContainer/VBoxContainer/GridContainer/NextTexture
@onready var current_damage = $MarginContainer/VBoxContainer/GridContainer/CurrentDamage
@onready var next_damage = $MarginContainer/VBoxContainer/GridContainer/NextDamage
@onready var current_range = $MarginContainer/VBoxContainer/GridContainer/CurrentRange
@onready var next_range = $MarginContainer/VBoxContainer/GridContainer/NextRange
@onready var current_cooldown = $MarginContainer/VBoxContainer/GridContainer/CurrentCooldown
@onready var next_cooldown = $MarginContainer/VBoxContainer/GridContainer/NextCooldown
@onready var button = $MarginContainer/VBoxContainer/Button

@onready var can_display_timer = $CanDisplayTimer

func display(level: int, current_level: Dictionary, next_level: Dictionary, position: Vector2) -> void:
	if !can_display_timer.is_stopped(): return
	level_text.text = "Level " + str(level) + " -> " + str(level+1)
	current_texture.texture = load(current_level['sprite'])
	next_texture.texture = load(next_level['sprite'])
	current_damage.text = str(current_level["damage"])
	next_damage.text = str(next_level["damage"])
	current_range.text = str(current_level["range"])
	next_range.text = str(next_level["range"])
	current_cooldown.text = str(current_level["cooldown"])
	next_cooldown.text = str(next_level["cooldown"])
	button.text = str(current_level["next_price"])
	var s = get_size()
	popup(Rect2i(position.x-s.x/2,  position.y-s.y/2, 100+s.x/2, 100+s.y/2))

func _on_button_pressed():
	buy.emit()
	hide()
