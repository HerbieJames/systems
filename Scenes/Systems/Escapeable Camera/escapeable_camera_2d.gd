extends Camera2D


var mouse_input : Vector2  = Vector2()


func _ready() -> void:
	# Input.mouse_mode = Input.MOUSE_MODE_CAPTURED
	pass


func toggle() -> void:
	if enabled:
		enabled = false
		Input.mouse_mode = Input.MOUSE_MODE_VISIBLE
	else:
		enabled = true
		Input.mouse_mode = Input.MOUSE_MODE_CAPTURED


func _input(event: InputEvent) ->void:
	if (event is InputEventMouseMotion and
	Input.mouse_mode == Input.MOUSE_MODE_CAPTURED and
	enabled):
		mouse_input = -event.relative
		print(mouse_input) # CURSOR SPEED
	elif (event is InputEventKey and
	event.pressed):
		if event.keycode == KEY_ESCAPE:
			Input.mouse_mode = Input.MOUSE_MODE_VISIBLE
	elif (event is InputEventMouseButton):
		if (event.button_index == MOUSE_BUTTON_LEFT and
		Input.mouse_mode == Input.MOUSE_MODE_VISIBLE and
		enabled):
			Input.mouse_mode = Input.MOUSE_MODE_CAPTURED
