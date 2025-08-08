extends SpringArm3D


@export var LOOK_RATE  : int             = 180
@export var MOUSE_RATE : float           = .25
@onready var camera    : Camera3D        = $"Camera3D"
@onready var player    : CharacterBody3D = get_parent()
@onready var diff      : Vector3         = position 
var mouse_input        : Vector2         = Vector2()


func _ready() -> void:
	spring_length = camera.position.z
	Input.mouse_mode = Input.MOUSE_MODE_CAPTURED


func _physics_process(delta: float) -> void:
	position = player.position + diff


func _process(delta: float) -> void:
	var look_input := Input.get_vector( "view_left", "view_right", "view_up", "view_down")
	rotation_degrees.x += (look_input.y * LOOK_RATE * delta) + (mouse_input.y * MOUSE_RATE)
	rotation_degrees.x = clampf(rotation_degrees.x, -54.7, 35.3) # Magic angles
	rotation_degrees.y += (look_input.x * LOOK_RATE * delta) + (mouse_input.x * MOUSE_RATE)
	mouse_input = Vector2()


func _input(event: InputEvent) ->void:
	if event is InputEventMouseMotion:
		mouse_input = -event.relative
