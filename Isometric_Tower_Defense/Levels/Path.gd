extends Node2D

func _ready():
	randomize()

func path() -> Array:
	var new_path : Array = []
	var next_points = get_children()
	while next_points.size() > 0:
		new_path.append(next_points[randi()%next_points.size()])
		next_points = new_path[new_path.size()-1].get_children(0)
	return new_path
