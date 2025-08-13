extends Node


@onready var music    = $Music
@onready var sfx      = $SFX
@onready var dialogue = $Dialogue


## For assigning keys to sounds.
@export var sound_data : Dictionary[String, AudioStream]
## For accessing all sounds of the same key by said key.
@onready var audio_stream_players : Dictionary[String, Array]


## Remove a sound, terminating it's audio.
func remove_sound(instance: AudioStreamPlayer) -> void:
	instance.queue_free()


## Destroy sound by some key, or all of them if no key is provided.
func destroy_sounds(sound: String) -> void:
	if (!sound):
		for instance in get_children(): 
			instance.queue_free()
	else: 
		if (!audio_stream_players.has(sound)): return
		for instance in audio_stream_players[sound]: 
			if instance: instance.queue_free()
		audio_stream_players[sound].clear()
