@tool
extends Panel

signal tower_selected(tower)

@export var tower : PackedScene :
	set(t):
		tower = t
		var tmp : Tower = tower.instantiate()
		$VBoxContainer/Label.text = tmp.tower_name
		$VBoxContainer/HBoxContainer/Label.text = str(tmp.price)
		$TextureRect.texture = load(tmp.levels[0]["sprite"])

@export var y_travel : int = 50
@export var separation : int = 20

@onready var mouse_over : bool = false

func _ready() -> void:
	_on_mouse_exited()

func _on_mouse_entered():
	mouse_over = true
	var tween = get_tree().create_tween()
	var x_offset : int = 0
	for p in get_parent().get_children():
		if p == self:
			break
		x_offset += p.custom_minimum_size.x + separation
	tween.tween_property(self, "position", Vector2(x_offset, -y_travel), 1).set_trans(Tween.TRANS_CUBIC)

func _on_mouse_exited():
	mouse_over = false
	var tween = get_tree().create_tween()
	var x_offset : int = 0
	for p in get_parent().get_children():
		if p == self:
			break
		x_offset += p.custom_minimum_size.x + separation
	tween.tween_property(self, "position", Vector2(x_offset, y_travel), 1).set_trans(Tween.TRANS_CUBIC)

func _input(event):
	if event.is_action_pressed("left_mouse") and mouse_over:
		tower_selected.emit(tower)
		print("Tower selected")
