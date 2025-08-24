class_name ScreenSpace
extends Node
## Stores the states of certain texts displayed to the screen
##
## [param expo_lines] is the array of lines being work through.
## [current_line_index] is the index of the curren line being displayed.
## [param is_expo_active] is whether any lines are being displayed
## [param text_box_scene] is the design of text displayed.
## [param text_box] is the current instance of the design, if any.


var expo_lines         : Array[String] = []
var current_line_index : int           = 0
var is_expo_active     : bool          = false
var text_box_scene     : PackedScene
var text_box           : MarginContainer
var canvas             : CanvasLayer


func on_text_box_finished_writing() -> void:
	print("finished_writing")


func on_text_box_finished_displaying() -> void:
	advance_expo()


func show_text_box(line_index : int) -> void:
	canvas = CanvasLayer.new()
	text_box = text_box_scene.instantiate()
	text_box.finished_writing.connect(on_text_box_finished_writing)
	text_box.finished_displaying.connect(on_text_box_finished_displaying)
	canvas.add_child(text_box)
	get_tree().root.add_child(canvas)
	text_box.display_text(expo_lines[line_index])


func override_text_box_to_end() -> void:
	if text_box:
		text_box.queue_free()
	if canvas:
		canvas.queue_free()
	is_expo_active = false
	current_line_index = 0

## *Note:* Issue with scoping have meant that [param lines] cannot be strongly typed to Array[String]
func start_expo(lines : Array) -> void:
	if is_expo_active:
		print("overlapping expo")
		override_text_box_to_end()
	 
	expo_lines = lines
	show_text_box(current_line_index)
	is_expo_active = true


func advance_expo() -> void:
	text_box.queue_free()
	canvas.queue_free()
	current_line_index += 1
	if current_line_index < expo_lines.size():
		show_text_box(current_line_index)
	else:
		is_expo_active = false
		current_line_index = 0
