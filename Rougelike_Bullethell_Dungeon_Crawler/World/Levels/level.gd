extends Node2D

@export var level:int = 1
@export var level_transtion_time:float = 1.0

@onready var room_scene:PackedScene = preload("res://World/Rooms/room.tscn")
@onready var rooms:Node2D = $Rooms
@onready var dead_ends:Array[Room] = []
@onready var player: CharacterBody2D = $Player

const ROOM_SIZE: Vector2i = Vector2i(4*317, 4*183)

func _ready() -> void:
	generate_level()

func generate_level() -> void:
	var room_positions:Array[Vector2i] = generate_room_positions()
	generate_rooms_at_positions(room_positions)
	create_final_room()

func generate_room_positions() -> Array[Vector2i]:
	var next_room:Vector2i = Vector2(0, 0)
	var room_positions:Array[Vector2i] = [next_room]
	var directions:Array[Vector2i] = [Vector2i.UP, Vector2i.LEFT, Vector2i.DOWN, Vector2i.RIGHT]
	var num_rooms:int = min(int(3.33*level)+randi_range(5, 6), 20)
	print("Generating ", num_rooms, " rooms")
	while true:
		next_room = room_positions.pick_random() + directions.pick_random()
		if next_room in room_positions: continue
		room_positions.append(next_room)
		if room_positions.size() >= num_rooms:
			break
	return room_positions

func generate_rooms_at_positions(room_positions:Array[Vector2i]) -> void:
	var directions:Array[Vector2i] = [Vector2i.UP, Vector2i.LEFT, Vector2i.DOWN, Vector2i.RIGHT]
	for pos in room_positions:
		var new_room:Room = room_scene.instantiate()
		rooms.add_child(new_room)
		new_room.global_position = pos*ROOM_SIZE
		var doors:int = 4
		for d in directions:
			if not pos + d in room_positions:
				new_room.remove_door(d)
				doors -= 1
		if doors == 1:
			dead_ends.append(new_room)

func create_final_room():
	var final_room:Room = dead_ends.pick_random()
	if final_room:
		print("generated exit")
		final_room.set_final_room()
		final_room.exit.level_exited.connect(_next_level)
	else:
		print("no dead ends")

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
		room.remove_child(room)
		room.queue_free()

func _next_level():
	player.movement_blocked = true
	await screen_off()
	clear_level()
	level += 1
	player.global_position = Vector2.ZERO
	generate_level()
	await screen_on()
	player.movement_blocked = false

func _visited(current_room: Vector2, positions) -> bool:
	for p in positions:
		print(p, current_room)
		if p == current_room:
			return true
	return false
