extends Node


@onready var world  : SoundChannel = $World
@onready var player : SoundChannel = $Player
@onready var ui     : SoundChannel = $UI


func destroy_sounds(sound: String, whitelist: bool = false) -> void:
	world.destroy_sounds(sound, whitelist)
	player.destroy_sounds(sound, whitelist)
	ui.destroy_sounds(sound, whitelist)
