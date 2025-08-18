extends CharacterBody3D
## Possesses movement behaviours and other capabilities of a space-ship, not under the effect of any gravity.
##
## Must be assigned a [ControllerShip] to exhibit movement behaviours.
class_name Ship


@export var controller : ControllerShip
@export var max_speed        : float = 7.50
@export var max_speed_sprint : float = 10.0
@export var max_speed_astern : float = 2.50
@export var deacceleration   : float = 15.0
@export var turn_speed       : float = 5.00
var layer         : int     = 0
var speed         : float   = 0.0
var accel_counter : float   = 0.0


func turn_to_port_or_star(to_dir: int, delta: float) -> void:
	rotation.y += to_dir * turn_speed * delta


func come_to_rest(delta: float) -> void:
	speed = move_toward(speed, 0, deacceleration*delta)


func move_afore() -> void:
	speed = max_speed


func move_afore_sprint() -> void:
	speed = max_speed_sprint


func move_astern() -> void:
	speed = -max_speed_astern


func move_layer_up_or_down(layer_dir: int) -> void:
	var a : int = - layer_dir
	match layer:
		0: layer = layer_dir
		a: layer = 0


func adjust_by_instruction(delta: float) -> void:
	move_layer_up_or_down(controller.layer_dir)
	turn_to_port_or_star(controller.to_dir, delta)
	match controller.a_dir:
		2 : move_afore_sprint()
		1 : move_afore()
		0 : come_to_rest(delta)
		-1: move_astern()


func _physics_process(delta: float) -> void:
	if controller:
		adjust_by_instruction(delta)
	position.y = 0
	velocity.x = sin(rotation.y) * speed
	velocity.z = cos(rotation.y) * speed
	move_and_slide()
