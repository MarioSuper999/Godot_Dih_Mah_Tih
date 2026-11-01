extends Node
const BOUNDARY_X := 100
const BOUNDARY_Y := 75
const BOUNDARY_Z := 100
@onready var box = preload("res://prefabs/rooms/box.tscn")

func _ready() -> void:
	for i in range(randf_range(50,75)):
		
		var new_box = box.instantiate()
		add_child.call_deferred(new_box)
		
		var collision_node = new_box.get_node("CollisionShape3D")
		collision_node.shape = collision_node.shape.duplicate()
		collision_node.shape.size = Vector3(20.0,7.5,20.0)
		new_box.position += Vector3(randf_range(-BOUNDARY_X,BOUNDARY_X),randf_range(-BOUNDARY_Y,BOUNDARY_Y-50),randf_range(-BOUNDARY_Z,BOUNDARY_Z))
		
func _process(delta: float) -> void:
	pass
