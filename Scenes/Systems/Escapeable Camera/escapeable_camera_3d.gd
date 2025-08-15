extends Camera3D


var mouse_input : Vector2  = Vector2()


func _ready() -> void:
	# Input.mouse_mode = Input.MOUSE_MODE_CAPTURED
	pass


func _input(event: InputEvent) ->void:
	if (event is InputEventMouseMotion and
	Input.mouse_mode == Input.MOUSE_MODE_CAPTURED and
	current):
		mouse_input = -event.relative
		print(mouse_input) # CURSOR SPEED
	elif (event is InputEventKey and
	event.pressed):
		if event.keycode == KEY_ESCAPE:
			Input.mouse_mode = Input.MOUSE_MODE_VISIBLE
	elif (event is InputEventMouseButton):
		if (event.button_index == MOUSE_BUTTON_LEFT and
		Input.mouse_mode == Input.MOUSE_MODE_VISIBLE and
		current):
			Input.mouse_mode = Input.MOUSE_MODE_CAPTURED
