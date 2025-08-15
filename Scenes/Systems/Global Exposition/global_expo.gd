extends Node


@onready var dialogue = $Dialogue
@onready var location = $Location


func _ready() -> void:
	dialogue.text_box_scene = preload("res://Scenes/Systems/Global Exposition/Screen Spaces/DialogueBox.tscn")
	location.text_box_scene = preload("res://Scenes/Systems/Global Exposition/Screen Spaces/LocationBox.tscn")
