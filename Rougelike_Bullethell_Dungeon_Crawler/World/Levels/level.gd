extends Node2D

@export var level:int = 1

@onready var num_rooms:int = 2# min(int(3.33*level)+randi_range(5, 6), 20)
@onready var room_scene:PackedScene = preload("res://World/Rooms/room.tscn")
@onready var rooms:Node2D = $Rooms
@onready var dead_ends:Array[Room] = []

const ROOM_SIZE: Vector2i = Vector2i(4*317, 4*183)

func _ready() -> void:
	var room_positions:Array[Vector2i] = generate_room_positions()
	generate_rooms_at_positions(room_positions)
	create_final_room()

func generate_room_positions() -> Array[Vector2i]:
	var next_room:Vector2i = Vector2(0, 0)
	var room_positions:Array[Vector2i] = [next_room]
	var directions:Array[Vector2i] = [Vector2i.UP, Vector2i.LEFT, Vector2i.DOWN, Vector2i.RIGHT]
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
		print("success! ", final_room)
		final_room.set_final_room()
	else:
		print("no dead ends")

func _visited(current_room: Vector2, positions) -> bool:
	for p in positions:
		print(p, current_room)
		if p == current_room:
			return true
	return false
