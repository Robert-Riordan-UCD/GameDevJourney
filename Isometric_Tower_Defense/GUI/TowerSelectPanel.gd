@tool
extends Panel

@export var tower : PackedScene :
	set(t):
		tower = t
		var tmp : Tower = tower.instantiate()
		$VBoxContainer/Label.text = tmp.tower_name
		$VBoxContainer/HBoxContainer/Label.text = str(tmp.price)
		$TextureRect.texture = load(tmp.levels[0]["sprite"])

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
