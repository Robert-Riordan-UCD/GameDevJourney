@tool
extends Panel

@export var tower_name : String:
	set(new_name):
		tower_name = new_name
		$VBoxContainer/Label.text = new_name
@export var tower_price : int:
	set(price):
		tower_price = price
		$VBoxContainer/HBoxContainer/Label.text = str(tower_price)
@export var texture : Texture2D:
	set(new_texture):
		texture = texture
		$TextureRect.texture = new_texture
