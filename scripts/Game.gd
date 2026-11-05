extends Node
@onready var player = $Player
@onready var da_monsta = $Da_Monsta

func _physics_process(delta: float):
	da_monsta.update_target_location(player.global_transform.origin)
