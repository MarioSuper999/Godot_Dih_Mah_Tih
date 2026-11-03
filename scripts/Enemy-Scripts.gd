extends Node
var behavioral_attributes := ["normal","lurking","aggressive","semi_random"]
var actional_attributes := ["venting","checking","running","crawling","climbing"]
var scary_attributes := ["mimicry","paranoia","schizophrenia"]

var current_behavior : String


func _ready() -> void:
	current_behavior = behavioral_attributes.pick_random()


func _process(delta: float) -> void:
	pass
