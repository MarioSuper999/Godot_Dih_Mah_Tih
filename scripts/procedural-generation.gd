extends Node
const BOUNDARY_X := 1
const BOUNDARY_Y := 1
const BOUNDARY_Z := 1
@onready var box = preload("res://prefabs/rooms/box.tscn")
var spawned_boxes: Array = []

func _ready() -> void:
	var pos = Vector3(0, 0, 0)
	var pos_new = Vector3(0,0,0)
	var invalid = true
	for i in range(randf_range(50,75)):
		var new_box = box.instantiate()
		add_child.call_deferred(new_box)
		
		spawned_boxes.append(new_box)
		
		var collision_node = new_box.get_node("CollisionShape3D")
		collision_node.shape = collision_node.shape.duplicate()
		collision_node.shape.size = Vector3(20.0,7.5,20.0)
		new_box.position += pos
		
		if randi()%2 == 0:
			while invalid:	
				pos_new = pos + Vector3(20 *(randi_range(0,1)*2-1),randf_range(-5,1),0)
				for boxes in spawned_boxes:
					if pos_new.x == boxes.position.x and pos_new.z == boxes.position.z and abs(pos_new.y - boxes.position.y) < 10:
						invalid = true
						break
					else:
						invalid = false		
				
		else:
			while invalid:	
				pos_new = pos + Vector3(0,randf_range(-5,1),20 *(randi_range(0,1)*2-1),)
				for boxes in spawned_boxes:
					if pos_new.x == boxes.position.x and pos_new.z == boxes.position.z and abs(pos_new.y - boxes.position.y) < 10:
						invalid = true
						break
					else:
						invalid = false		
		pos = pos_new
		invalid = true
		print(spawned_boxes[i].position)
	
		
func _process(delta: float) -> void:
	pass

#pos_new = pos + Vector3(0,randf_range(-5,1),20 *(randi_range(0,1)*2-1),)
