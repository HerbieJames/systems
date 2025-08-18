extends Node3D


## Node to be the subject of camera
@export var target : Node
@export_group("Zooming", "size")
## Zoom camera resolves to
@export_range(1, 100, 1) var size_target         : float = 20
## Minimum zoom camera can possess
@export_range(0.1, 10, 0.1) var size_margin      : float = 5
@export_group("Easing", "ease")
## Distance to which the camera is able to drift away from target
@export_range(0.1, 10, 0.1) var ease_move_margin : float = 5
## rate at which camera moves in response to target movement
@export_range(0.1, 10, 0.1) var ease_move_rate   : float = 2
## rate at which camera zooms in response to target movement
@export_range(0.1, 10, 0.1) var ease_zoom_rate   : float = 2

@onready var camera : Camera3D = $Camera3D


func _ready() -> void:
	camera.size = size_target


## Interpolates the position to the target's position
func ease_position(delta: float) -> Vector3:
	position = (Vector3)(
		lerp(position.x, target.position.x, ease_move_rate * delta),
		lerp(position.y, target.position.y, ease_move_rate * delta),
		lerp(position.z, target.position.z, ease_move_rate * delta)
	)
	position = (Vector3)(
		clampf(position.x, target.position.x - ease_move_margin, target.position.x + ease_move_margin),
		clampf(position.y, target.position.y - ease_move_margin, target.position.y + ease_move_margin),
		clampf(position.z, target.position.z - ease_move_margin, target.position.z + ease_move_margin),
	)
	return target.position - position


## Adjusts the size of camera according to position from target
func ease_zoom(position_delta : Vector3, delta: float) -> void:
	var pos_dif : float = position_delta.length() / ease_move_margin
	camera.size = move_toward(camera.size, size_target + (size_margin * pos_dif), ease_zoom_rate * delta)


func _physics_process(delta: float) -> void:
	var position_delta : Vector3
	position_delta = ease_position(delta)
	ease_zoom(position_delta, delta)
