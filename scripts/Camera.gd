extends CharacterBody3D

@export var can_move : bool = true
@export var can_jump : bool = true
@export var flashlight_on : bool = true
@export var can_lerp : bool = true
@export_group("Speeds")
@export var mouse_sensitivity := 0.002
@export var smooth_speed := 17.5
@export var base_speed : float = 7.0
@export var jump_velocity : float = 4.5
@export var sprint_speed : float = 10.0
@export_group("Input Actions")
@export var input_left : String = "input_left"
@export var input_right : String = "input_right"
@export var input_forward : String = "input_forward"
@export var input_back : String = "input_backward"
@export var input_jump : String = "input_jump"
@export var input_sprint : String = "input_sprint"

var mouse_captured : bool = true
var look_rotation : Vector2
var target_rotation := Vector2.ZERO
var smooth_rotation := Vector2.ZERO
var weight : float = 1

@onready var head: Node3D = $Head
@onready var collider: CollisionShape3D = $Collider


func _ready() -> void:
	look_rotation.y = rotation.y
	look_rotation.x = head.rotation.x

func _unhandled_input(event: InputEvent) -> void:
	if Input.is_mouse_button_pressed(MOUSE_BUTTON_LEFT):
		capture_mouse()
	if Input.is_key_pressed(KEY_ESCAPE):
		release_mouse()
	if event is InputEventMouseMotion and mouse_captured:
		target_rotation.y -= event.relative.x * mouse_sensitivity
		target_rotation.x -= event.relative.y * mouse_sensitivity
		target_rotation.x = clamp(target_rotation.x,deg_to_rad(-85),deg_to_rad(85))
	
func _physics_process(delta: float) -> void:
	if not is_on_floor():
		velocity += get_gravity() * delta

func _process(delta: float) -> void:
	if can_lerp:
		weight = 1 - exp(-smooth_speed * delta)
	smooth_rotation.x = lerp_angle(smooth_rotation.x,target_rotation.x,weight)
	smooth_rotation.y = lerp_angle(smooth_rotation.y,target_rotation.y,weight)
	transform.basis = Basis()
	rotate_y(smooth_rotation.y)
	head.transform.basis = Basis()
	head.rotate_x(smooth_rotation.x)
	
func capture_mouse():
	Input.set_mouse_mode(Input.MOUSE_MODE_CAPTURED)
	mouse_captured = true
func release_mouse():
	Input.set_mouse_mode(Input.MOUSE_MODE_VISIBLE)
	mouse_captured = false
