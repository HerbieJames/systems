extends ControllerShip
## Handles Inputs to control the movement behaviours of a [Ship].
class_name ControllerShipPlayer


func handle_input() -> void:
	if Input.is_action_pressed("to-port"):
		to_dir = 1
	elif Input.is_action_pressed("to-star"):
		to_dir = -1
	else:
		to_dir = 0
	
	if Input.is_action_pressed("afore"):
		if Input.is_action_pressed("sprint"):
			a_dir = 2
		else:
			a_dir = 1
	elif Input.is_action_pressed("astern"):
		a_dir = -1
	else:
		a_dir = 0
	
	# if Input.is_action_just_pressed("layer-down"):
	# 	layer_dir = -1
	# elif Input.is_action_just_pressed("layer-up"):
	# 	layer_dir = 1
	# else:
	# 	layer_dir = 0


func _process(delta: float) -> void:
	handle_input()
