extends Node2D


var latest_ping


func _on_button_pressed() -> void:
	latest_ping = GlobalAudio.create_sound("ping", true)


func _on_button_2_pressed() -> void:
	GlobalAudio.destroy_sound("ping")


func _on_button_3_pressed() -> void:
	if latest_ping: latest_ping.queue_free()


func _on_button_4_pressed() -> void:
	GlobalDialogue.start_dialogue(["x aa..hah","be fw?ee"]) # GlobalDialogue.dialogue["greeting"])
