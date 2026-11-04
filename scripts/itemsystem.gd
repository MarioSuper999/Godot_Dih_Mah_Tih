extends Area3D

@export var floatingimage : Image

@export var mesh : Mesh

@export_group("Scaling")

@export_range (0,10) var distancetoItem : float

@export_range (0,2) var textandIconScaling : float

@export_group("Scene specific")

@export var itemtxt : Label3D

@export var textball : Sprite3D

var charnear : bool

var pbody : Node3D

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	%itemtext.visible = false
	%textballl.visible = false
	if floatingimage != null:
		%textballl.texture = ImageTexture.create_from_image(floatingimage)
	%itemtext.text = InputMap.action_get_events("pickup")[0].as_text()[0]
	charnear = true
	$ItemPickupRange.shape.radius = distancetoItem
	$MeshInstance3D.mesh = mesh
	


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta: float) -> void:
	if pbody != null:
		var distance = global_position.distance_to(pbody.global_position)
		itemtxt.pixel_size = distance * 0.008 * textandIconScaling
		textball.pixel_size = distance * 0.002 * textandIconScaling
	if charnear and Input.is_action_pressed("pickup"):
		disconnect("body_exited",_on_body_exited)
		queue_free()
		


func _on_body_entered(body: Node3D) -> void:
	if body.name == "Player":
		charnear = true
		pbody = body
		%itemtext.visible = true
		%textballl.visible = true


func _on_body_exited(_body: Node3D) -> void:
	charnear = true
	%itemtext.visible = false
	$textballl.visible = false
