extends Node2D


func _on_button_pressed() -> void:
	AudioManager.create_sound("ping")
