extends Node
const BOUNDARY_X := 1
const BOUNDARY_Y := 3
const BOUNDARY_Z := 1
@onready var box = preload("res://prefabs/rooms/box.tscn")

func _ready() -> void:
	var pos = Vector3(10, 0, 10)
	for i in range(randf_range(50,75)): #
		pos +=Vector3(20 *randi_range(-BOUNDARY_X,BOUNDARY_X),randf_range(-BOUNDARY_Y,BOUNDARY_Y-1), 20 *randi_range(-BOUNDARY_Z,BOUNDARY_Z))
		var new_box = box.instantiate()
		add_child.call_deferred(new_box)
		
		var collision_node = new_box.get_node("CollisionShape3D")
		collision_node.shape = collision_node.shape.duplicate()
		collision_node.shape.size = Vector3(20.0,7.5,20.0)
		new_box.position += pos
		
func _process(delta: float) -> void:
	pass
