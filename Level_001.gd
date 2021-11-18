extends Node

var cruise_speed = 100
export var start_pos = 0


func _ready():
	set_start_position(start_pos)

func set_start_position(x):
	$Camera2D.global_position.x = x
	$Player.global_position.x = x
