extends MarginContainer


@onready var label        : Label = $"margin-for-text/text"
@onready var timer_letter : Timer = $"letter-display"
@onready var timer_hold   : Timer = $"hold-display"


var text         : String = ""
var letter_index : int    = 0
var letter_time  : float  = 0.03
var space_time   : float  = 0.06
var punct_time   : float  = 0.20
var hold_time    : float  = 1.75


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
	
	match text[letter_index]:
		".", ",", "?", "!", ":", "-":
			timer_letter.start(punct_time)
		" ":
			timer_letter.start(space_time)
		_:
			timer_letter.start(letter_time)
			GlobalAudio.sound_data["letter"].random_pitch = randf_range(1, 1.2)
			if text[letter_index] in ["a","e","i","o","u"]:
				GlobalAudio.sound_data["letter"].random_pitch = randf_range(1.2, 1.4)
			GlobalAudio.create_sound("letter")


func display_text(text_to_display : String) -> void:
	text = text_to_display
	label.autowrap_mode = TextServer.AUTOWRAP_WORD
	
	display_letter()
	


func _on_letterdisplay_timeout() -> void:
	display_letter()


func _on_holddisplay_timeout() -> void:
	finished_displaying.emit()
