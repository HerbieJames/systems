extends Node3D


@export var target_path : Node
@onready var camera : Camera3D = $Camera3D
var target : Node


func _ready() -> void:
	pass


func _physics_process(delta: float) -> void:
	position = target.position
