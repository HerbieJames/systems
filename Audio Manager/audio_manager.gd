extends Node


## For assigning keys to sounds meant to be played only once.
@export var sounds : Dictionary[String, AudioStream]
## For assigning keys to sounds that are intended to loop.
@export var drones : Dictionary[String, AudioStream]


## Remove a sound, terminating it's audio.
func remove_sound(instance: AudioStreamPlayer) -> void:
	instance.queue_free()


## Play a sound by it's key. Returns the instance node.
func create_sound(sound: String, loops : bool = false, db : float = 0) -> AudioStreamPlayer:
	var instance = AudioStreamPlayer.new()
	if loops:
		instance.stream = drones[sound]
		instance.finished.connect(instance.play)
	else:
		instance.stream = sounds[sound]
		instance.finished.connect(remove_sound.bind(instance))
	instance.volume_db = db
	add_child(instance)
	instance.play()
	print(sound)
	return instance


## Return a sound from the AudioManager by it's name.
func get_sound_by_name(sound_name : String) -> Node:
	return self.get_tree().get_node(sound_name)


## Return all sounds in the AudioManager by a group name, or just all of them.
func get_sounds(group_name : String = "") -> Array[Node]:
	if !group_name:
		return self.get_tree().get_nodes_in_group("audio")
	else:
		return self.get_tree().get_nodes_in_group(group_name)


## Remove a sound from the AudioManager by it's name, terminating it.
func remove_sound_by_name(sound : String) -> void:
	var instance = get_sound_by_name(sound)
	remove_sound(instance)


## Remove all sounds in the AudioManager by a group name, or just all of them.
func remove_sounds(group_name : String = "") -> void:
	var children = get_sounds(group_name)
	for instance in children:
		remove_sound(instance)
