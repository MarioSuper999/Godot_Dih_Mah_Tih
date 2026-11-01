extends Node
const BOUNDARY_X := 1
const BOUNDARY_Y := 1
const BOUNDARY_Z := 1
@onready var box = preload("res://prefabs/rooms/box.tscn")

func _ready() -> void:
	var pos = Vector3(10, 0, 10)
	var pos_new = Vector3(0,0,0)
	var pos_old = Vector3(10,0,10)
	var attempts = 0
	for i in range(randf_range(50,75)):
		if randi()%2 == 0:
			while pos_new.x == pos_old.x and pos_new.z == pos_old.z:
				pos_new = pos + Vector3(20 *(randi_range(0,1)*2-1),randf_range(-5,1),0)
		else:
			while pos_new.x == pos_old.x and pos_new.z == pos_old.z:
				pos_new = pos + Vector3(0,randf_range(-5,1),20 *(randi_range(0,1)*2-1))
		var new_box = box.instantiate()
		add_child.call_deferred(new_box)
		
		var collision_node = new_box.get_node("CollisionShape3D")
		collision_node.shape = collision_node.shape.duplicate()
		collision_node.shape.size = Vector3(20.0,7.5,20.0)
		new_box.position += pos_new
		pos_old = pos	
		pos = pos_new
		
		
func _process(delta: float) -> void:
	pass
#for i in range(randf_range(50,75)):
		#while pos_new.x == pos_old.x or pos_new.z == pos_old.z:
			#while not((pos_new.x == pos.x and pos_new.z != pos.z) or (pos_new.x != pos.x and pos_new.z == pos.z)):
				#pos_new = pos + Vector3(20 *(randi_range(0,1)*2-1),randf_range(-5,1), 20 *(randi_range(0,1)*2-1))
				#attempts += 1
				#if attempts > 5:
					#print(i)
					#attempts = 0
					#break
