extends Node
signal generation_finished
const BOUNDARY_X := 1
const BOUNDARY_Y := 1
const BOUNDARY_Z := 1
@onready var box = preload("res://prefabs/rooms/box.tscn")
var spawned_boxes: Array = []
@export var pathlen :int
@onready var pposition = $"../Player".global_position

func _ready() -> void:
	var pos = Vector3(0,0,0)
	genPath(pos, pathlen)
	emit_signal("generation_finished")


func genPath(pos, length):
	for i in range(length):
		var new_box = box.instantiate()
		add_child(new_box)
		
		spawned_boxes.append(new_box)
		
		var collision_node = new_box.get_node("CollisionShape3D")
		collision_node.shape = collision_node.shape.duplicate()
		collision_node.shape.size = Vector3(20.0,7.5,20.0)
		new_box.position += pos
		pos = get_new_pos(pos, 20)
	print(len(spawned_boxes))


func get_new_pos(pos, size):
	var pos_new = Vector3(0,0,0)
	var attempts = 0
	if randi()%2 == 0:
		while not check_colision(pos_new):
			pos_new = pos + Vector3(size *(randi_range(0,1)*2-1),0,0)
			attempts +=1
			if attempts == 10:
				break			
	else:
		while not check_colision(pos_new):
			pos_new = pos + Vector3(0,0,size *(randi_range(0,1)*2-1))
			attempts +=1
			if attempts == 10:
				break
	return pos_new


func check_colision(pos):
	for boxes in spawned_boxes:
		if pos == boxes.position:
			return false
	return true

func _process(_delta: float) -> void:
	pass
