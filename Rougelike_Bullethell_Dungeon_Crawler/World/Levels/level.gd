extends Node2D

@export var level:int = 1
@export var level_transtion_time:float = 1.0
@export var boss_level:int = 5

@onready var room_scene:PackedScene = preload("res://World/Rooms/room.tscn")
@onready var rooms:Node2D = $Rooms
@onready var player: CharacterBody2D = $Player

const ROOM_SIZE: Vector2i = Vector2i(4*317, 4*183)

func _ready() -> void:
	generate_level()

func generate_level() -> void:
	$GUI/MarginContainer/LevelNumber.text = "Level " + str(level)
	var room_positions:Array[Vector2i] = generate_room_positions()
	generate_rooms_at_positions(room_positions)
	var final_room:Room = create_final_room()
	if level%boss_level == 0:
		final_room.add_boss()

func generate_room_positions() -> Array[Vector2i]:
	var next_room:Vector2i = Vector2(0, 0)
	var room_positions:Array[Vector2i] = [next_room]
	var directions:Array[Vector2i] = [Vector2i.UP, Vector2i.LEFT, Vector2i.DOWN, Vector2i.RIGHT]
	var num_rooms:int = min(int(3.33*level)+randi_range(5, 6), 20)
	print("Generating ", num_rooms, " rooms")
	while true:
		if room_positions.size() >= num_rooms: break
		next_room = room_positions.pick_random() + directions.pick_random()
		if next_room in room_positions: continue
		room_positions.append(next_room)
	print(room_positions)
	return room_positions

func generate_rooms_at_positions(room_positions:Array[Vector2i]) -> void:
	var directions:Array[Vector2i] = [Vector2i.UP, Vector2i.LEFT, Vector2i.DOWN, Vector2i.RIGHT]
	for pos in room_positions:
		var new_room:Room = room_scene.instantiate()
		new_room.level = level
		if pos == Vector2i.ZERO: new_room.num_enemies = 0
		rooms.add_child(new_room)
		if pos == Vector2i.ZERO: new_room.unlock()
		new_room.global_position = pos*ROOM_SIZE
		for d in directions:
			if not pos + d in room_positions:
				new_room.remove_door(d)

func create_final_room() -> Room:
	var final_room:Room = null
	var greatest_distance:float = 0
	for room in rooms.get_children():
		var d:float = room.global_position.length()
		if d >= greatest_distance:
			greatest_distance = d
			final_room = room

	assert(final_room != null, "Failed to generate final room")
	final_room.set_final_room()
	final_room.exit.level_exited.connect(_next_level)
	return final_room

func screen_off() -> void:
	var tween:Tween = create_tween()
	tween.tween_property($GUI/LevelTransiton, "color:a", 1, level_transtion_time/2)
	await tween.finished

func screen_on() -> void:
	var tween:Tween = create_tween()
	tween.tween_property($GUI/LevelTransiton, "color:a", 0, level_transtion_time/2)
	await tween.finished

func clear_level() -> void:
	for room in rooms.get_children():
		rooms.remove_child(room)
		room.queue_free()
	
	for item in get_tree().get_nodes_in_group("item"):
		if not item.held:
			item.get_parent().remove_child(item)
			item.queue_free()

func _next_level():
	player.movement_blocked = true
	await screen_off()
	clear_level()
	level += 1
	player.global_position = Vector2.ZERO
	await get_tree().process_frame
	generate_level()
	await screen_on()
	player.movement_blocked = false

func _visited(current_room: Vector2, positions) -> bool:
	for p in positions:
		print(p, current_room)
		if p == current_room:
			return true
	return false
