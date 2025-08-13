extends Node2D


var latest_ping


# GLOBAL AUDIO
func _on_button_pressed() -> void:
	latest_ping = GlobalSound.sfx.create_sound("ping")


func _on_button_2_pressed() -> void:
	GlobalSound.sfx.destroy_sounds("ping")


func _on_button_3_pressed() -> void:
	if latest_ping: latest_ping.queue_free()


# ESCAPEABLE CAMERA
func _on_button_4_pressed() -> void:
	if $EscapeableCamera.enabled: $EscapeableCamera.enabled = false
	else                        : $EscapeableCamera.enabled = true


# GLOBAL EXPOSITION
func _on_button_5_pressed() -> void:
	GlobalExpo.dialogue.start_expo(["x aa..hah","be fw?ee"])


func _on_button_6_pressed() -> void:
	GlobalExpo.location.start_expo(["The Menu Screen"])
