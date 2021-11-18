extends KinematicBody2D

var gravity = 1200
var velocity = Vector2.ZERO
onready var puff = preload("res://Puff_explosion.tscn")
onready var main = get_tree().get_nodes_in_group("main")[0]

func _ready():
	velocity.y = rand_range(-1060, -800)
	var direction_random = rand_range(0, 1)
	var direction = 0
	if(direction_random > 0.5):
		direction = -1
	else:
		direction = 1
	velocity.x = rand_range(200, 360)* direction
	$hit_area.connect("area_entered", self, "on_hit")


func _process(delta):
	velocity.y += gravity*delta
	move_and_slide(velocity)

func on_hit(area2d):
	var newPuff = puff.instance()
	newPuff.global_position = global_position
	main.add_child(newPuff)
	queue_free()
