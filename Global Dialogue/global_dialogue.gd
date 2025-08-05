extends Node


## For displaying dialogue.
@onready var dialogue_box_scene = preload("res://Global Dialogue/GlobalDialogueBox.tscn")


var dialogue_lines     : Array[String] = []
var current_line_index : int           = 0
var is_dialogue_active : bool          = false
var dialogue_box : MarginContainer


func dialogue_box_finished() -> void:
	advance_dialogue()


func show_dialogue_box(line_index: int) -> void:
	dialogue_box = dialogue_box_scene.instantiate()
	dialogue_box.finished_displaying.connect(dialogue_box_finished)
	GlobalUI.add_child(dialogue_box)
	dialogue_box.display_text(dialogue_lines[line_index])


func override_text_box_to_end() -> void:
	if dialogue_box:
		dialogue_box.queue_free()
	is_dialogue_active = false
	current_line_index = 0


func start_dialogue(current_lines :Array[String]) -> void:
	if is_dialogue_active:
		print("overlapping dialogue")
		override_text_box_to_end()
	 
	dialogue_lines = current_lines
	show_dialogue_box(current_line_index)
	is_dialogue_active = true


func advance_dialogue() -> void:
	dialogue_box.queue_free()
	current_line_index += 1
	if current_line_index < dialogue_lines.size():
		show_dialogue_box(current_line_index)
	else:
		is_dialogue_active = false
		current_line_index = 0
