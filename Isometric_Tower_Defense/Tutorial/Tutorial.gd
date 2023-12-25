extends Control

var popup_text : Array = [
	"The orcs are trying to steal your crystals!",
	"Protect them by building a crossbow tower."
]

@onready var place_crossbow_tower_popup := $PlaceCrossbowTowerPopup
@onready var label = $PlaceCrossbowTowerPopup/MarginContainer/VBoxContainer/Label

func _ready():
	advance()

func advance():
	if popup_text.is_empty(): return
	label.text = popup_text.pop_front()
	print(label.text)
	Utils.tween_in(place_crossbow_tower_popup)

func _on_button_pressed():
	await Utils.tween_out(place_crossbow_tower_popup)
	print("Finished waiting")
	advance()
