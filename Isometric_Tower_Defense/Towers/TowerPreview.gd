extends Sprite2D

@export var tile_map: TileMap
@export var sprite_offset: Vector2 = Vector2.ZERO

@onready var last_pos: Vector2 = Vector2.ZERO
@onready var last_tower: PackedScene = null
@onready var range_preview = $RangePreview

func update(tower: PackedScene):
	visible = true
	update_sprite(tower)
	update_position()

func update_sprite(tower: PackedScene) -> void:
	if tower == last_tower: return
	last_tower = tower
	var t : Tower = tower.instantiate()
	texture = load(t.levels[0]["sprite"])
	range_preview.scale = t.levels[0]["range"]/32*Vector2(1, 0.5)
	scale = Vector2(0.5, 0.5)

func update_position() -> void:
	global_position = tile_map.map_to_local(tile_map.local_to_map(get_global_mouse_position())) + sprite_offset
