extends Node3D


@onready var star  : MeshInstance3D     = $MeshInstance3D

@export var target : Node3D
@export var height : int = 10


func _ready() -> void:
	position.y = height

func _physics_process(delta: float) -> void:
	look_at(target.position, Vector3(0,1,0))
