extends MarginContainer


@onready var timer_letter : Timer = $"letter-display"
@onready var timer_hold   : Timer = $"hold-display"
@onready var label        : Label = $"margin-for-text/text"


var letter_index : int    = 0
var letter_time  : float  = 0.05
var hold_time    : float  = 2.75
var text         : String = ""


signal finished_writing()
signal finished_displaying()


func hold_display() -> void:
	finished_writing.emit()
	timer_hold.start(hold_time)


func display_letter() -> void:
	label.text += text[letter_index]
	letter_index += 1
	if letter_index >= text.length():
		hold_display()
		return
	timer_letter.start(letter_time)
	
	if GlobalSound.sfx.sound_files.has("letter_typed"):
		GlobalSound.sfx.sound_files["letter_typed"].random_pitch = randf_range(0.8, 1)
	GlobalSound.sfx.create_sound("letter_typed")


func display_text(text_to_display : String) -> void:
	text = text_to_display
	label.autowrap_mode = TextServer.AUTOWRAP_WORD
	display_letter()


func _on_letterdisplay_timeout() -> void:
	display_letter()


func _on_holddisplay_timeout() -> void:
	finished_displaying.emit()
