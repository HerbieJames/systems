extends Node


## For assigning keys to sounds.
@export var sound_data : Dictionary[String, AudioStream]
@onready var audio_stream_players : Dictionary[String, Array]


## Remove a sound, terminating it's audio.
func remove_sound(instance: AudioStreamPlayer) -> void:
	instance.queue_free()


## Play a sound by it's key. Returns the instance node.
func create_sound(sound: String, loop : bool = false, db : float = 0) -> AudioStreamPlayer:
	var instance = AudioStreamPlayer.new()
	var i : int = 1
	if (sound_data.has(sound)): instance.stream = sound_data[sound]
	if (loop): instance.finished.connect(instance.play)
	else: instance.finished.connect(remove_sound.bind(instance))
	if (!audio_stream_players.has(sound)): audio_stream_players[sound] = [instance]
	else:
		audio_stream_players[sound].push_front(instance)
		i = audio_stream_players[sound].size()
	instance.name = sound + str(i)
	instance.volume_db = db
	add_child(instance)
	instance.play()
	return instance


## Destroy sound by some key, or all of them if no key is provided.
func destroy_sound(sound: String) -> void:
	if (!sound):
		for instance in get_children(): 
			instance.queue_free()
	else: 
		if (!audio_stream_players.has(sound)): return
		for instance in audio_stream_players[sound]: 
			if instance: instance.queue_free()
		audio_stream_players[sound].clear()
