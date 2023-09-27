extends TileMap

var placeable_tile_ids : Array = [10]
var valid_tiles : Dictionary = {}

func _ready():
	for id in placeable_tile_ids:
		for tile in get_used_cells_by_id(0, id):
			valid_tiles[tile] = id

func can_place_tower(pos: Vector2) -> bool:
	var tile_pos = local_to_map(pos)
	if tile_pos in valid_tiles:
		valid_tiles.erase(tile_pos)
		return true
	return false

func snap_to_grid(pos: Vector2) -> Vector2:
	return map_to_local(local_to_map(pos))
