@icon("res://Scenes/Systems/Controller/controller.svg")
extends Node
## Is a base class for [ControllerShipPlayer] and [ControllerShipAI] and should not be used on it's own.
class_name ControllerShip


var to_dir    : int  = 0
var a_dir     : int  = 0
var layer_dir : int = 0
