extends Node2D

enum Direction {UP, DOWN}

export(Direction) var direction = Direction.DOWN

func _ready():
	var children = get_children()
	for child in children:
		child.set_direction(direction)

#func _process(delta):
#	pass
