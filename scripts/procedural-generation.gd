extends Node
const BOUNDARY_X := 500
const BOUNDARY_Y := 250
const BOUNDARY_Z := 500

func _ready() -> void:
	for i in range(randf_range(50,100)):
		$box.position += Vector3(randf_range(-BOUNDARY_X,BOUNDARY_X),randf_range(-BOUNDARY_Y,BOUNDARY_Y),randf_range(-BOUNDARY_Z,BOUNDARY_Z))

func _process(delta: float) -> void:
	pass
