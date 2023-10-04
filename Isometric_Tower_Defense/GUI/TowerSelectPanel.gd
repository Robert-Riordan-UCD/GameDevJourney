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
		texture = new_texture
		$TextureRect.texture = texture
@export var y_travel : int = 50
@export var separation : int = 20

func _ready() -> void:
	_on_mouse_exited()

func _on_mouse_entered():
	var tween = get_tree().create_tween()
	var x_offset : int = 0
	for p in get_parent().get_children():
		if p == self:
			break
		x_offset += p.custom_minimum_size.x + separation
	tween.tween_property(self, "position", Vector2(x_offset, -y_travel), 1).set_trans(Tween.TRANS_CUBIC)

func _on_mouse_exited():
	var tween = get_tree().create_tween()
	var x_offset : int = 0
	for p in get_parent().get_children():
		if p == self:
			break
		x_offset += p.custom_minimum_size.x + separation
	tween.tween_property(self, "position", Vector2(x_offset, y_travel), 1).set_trans(Tween.TRANS_CUBIC)
