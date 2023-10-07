extends TileMap

var placeable_tile_ids : Array = [10]
var valid_tiles : Dictionary = {}

func _ready():
	for id in placeable_tile_ids:
		for tile in get_used_cells_by_id(0, id):
			valid_tiles[tile] = id

func place_tower(pos: Vector2) -> void:
	valid_tiles.erase(local_to_map(pos))


func can_place_tower(pos: Vector2) -> bool:
	if local_to_map(pos) in valid_tiles:
		return true
	return false

func snap_to_grid(pos: Vector2) -> Vector2:
	return map_to_local(local_to_map(pos))
