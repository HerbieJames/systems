class_name Interactant
extends Resource

@export var state : Dictionary[String, float]

## DialogueManager can bounce off of instances of these (e.g. an NPC, Dungeon, etc.) ...
## ... as well as other game state variables, including the player's DREAM stats.
##
## Null coalescing can be employed to write conditioning into Interactions for ...
## ... Interactant keys that don't exist yet (i.e. A character with no opinion of ...
## ... something yet)
##
## https://github.com/nathanhoad/godot_dialogue_manager/blob/main/docs/Conditions_Mutations.md
