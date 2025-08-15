@icon("res://Scenes/Systems/Custom Transform/custom_transform.svg")
extends Node3D
## Allows for target node to only inheret particular properties of it's parent's transform
##
## [b]Note:[/b] "top_level" must be set to [param True] for this to work. Allows for select inheretance of position, rotation, and scale in each axis.
class_name AdvancedTransform3D


@export var remote_path : NodePath
@export_group("Position", "position")
@export var position_x  : bool = false
@export var position_y  : bool = false
@export var position_z  : bool = false
@export_group("Rotation", "rotation")
@export var rotation_x  : bool = false
@export var rotation_y  : bool = false
@export var rotation_z  : bool = false
@export_group("Scale", "scale")
@export var scale_x     : bool = false
@export var scale_y     : bool = false
@export var scale_z     : bool = false

@onready var target     : Node3D = get_node(remote_path)
@onready var parent     : Node3D = target.get_parent()


func _ready() -> void:
	target.top_level = true


func _physics_process(delta: float) -> void:
	if position_x: target.position.x = parent.position.x
	if position_y: target.position.y = parent.position.y
	if position_x: target.position.z = parent.position.z
	if rotation_x: target.rotation.x = parent.rotation.x
	if rotation_y: target.rotation.y = parent.rotation.y
	if rotation_x: target.rotation.z = parent.rotation.z
	if scale_x: target.scale.x = parent.scale.x
	if scale_y: target.scale.y = parent.scale.y
	if scale_x: target.scale.z = parent.scale.z
