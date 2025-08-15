extends Node3D


## Node to be the subject of camera
@export var target : Node
@export_group("Zooming", "size")
## Zoom camera resolves to
@export_range(1, 100, 5) var size_target       : float = 20
## Minimum zoom camera can possess
@export_range(1, 100, 5) var size_max          : float = 40
@export_group("Easing", "ease")
## Distance to which the camera is able to drift away from target
# @export_range(0.2, 15, 0.2) var ease_move_margin    : float = 10
## rate at which camera moves in response to target movement
@export_range(0.2, 10, 0.2) var ease_move_rate : float = 1
## rate at which camera zooms in response to target movement
@export_range(0.2, 10, 0.2) var ease_zoom_rate : float = 1

@onready var camera : Camera3D = $Camera3D


## Interpolates the position to the target's position
func ease_position(delta: float) -> Vector3:
	position = (Vector3)(
		lerp(position.x, target.position.x, ease_move_rate * delta),
		lerp(position.y, target.position.y, ease_move_rate * delta),
		lerp(position.z, target.position.z, ease_move_rate * delta)
	)
	# position = (Vector3)(
	# 	clampf(position.x, target.position.x - move_margin, target.position.x + move_margin),
	# 	clampf(position.y, target.position.y - move_margin, target.position.y + move_margin),
	# 	clampf(position.z, target.position.z - move_margin, target.position.z + move_margin),
	# )
	return target.position - position


## Adjusts the size of camera according to position from target
func ease_zoom(position_delta : Vector3, delta: float) -> void:
	var pos_dif = position_delta.length()
	camera.size = size_target + (pos_dif * ease_zoom_rate)
	camera.size = clampf(camera.size, size_target, size_max)


func _physics_process(delta: float) -> void:
	var position_delta
	position_delta = ease_position(delta)
	ease_zoom(position_delta, delta)
