extends Node


@onready var text_box_scene = preload("res://Scenes/Global Dialogue/GlobalDialogueBox.tscn")


var dialogue_lines       : Array[String] = []
var current_line_index   : int           = 0
var is_dialogue_active   : bool          = false
var text_box : MarginContainer
var canvas   : CanvasLayer

func on_text_box_finished_writing() -> void:
	pass


func on_text_box_finished_displaying() -> void:
	advance_dialogue()


func show_text_box(line_index: int) -> void:
	canvas = CanvasLayer.new()
	text_box = text_box_scene.instantiate()
	text_box.finished_writing.connect(on_text_box_finished_writing)
	text_box.finished_displaying.connect(on_text_box_finished_displaying)
	canvas.add_child(text_box)
	get_tree().root.add_child(canvas)
	text_box.display_text(dialogue_lines[line_index])


func override_text_box_to_end() -> void:
	if text_box:
		text_box.queue_free()
	if canvas:
		canvas.queue_free()
	is_dialogue_active = false
	current_line_index = 0


func start_dialogue(lines: Array[String]) -> void:
	if is_dialogue_active:
		print("overlapping dialogue")
		override_text_box_to_end()
	 
	dialogue_lines = lines
	show_text_box(current_line_index)
	is_dialogue_active = true


func advance_dialogue() -> void:
	text_box.queue_free()
	canvas.queue_free()
	current_line_index += 1
	if current_line_index < dialogue_lines.size():
		show_text_box(current_line_index)
	else:
		is_dialogue_active = false
		current_line_index = 0
