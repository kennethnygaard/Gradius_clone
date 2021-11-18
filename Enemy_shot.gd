extends KinematicBody2D

var speed = 300
var move_vector = Vector2.ZERO
var player

func _ready():
	var player = get_tree().get_nodes_in_group("player")[0]
	var x = player.global_position.x - global_position.x
	var y = player.global_position.y - global_position.y
	move_vector = Vector2(x, y).normalized()
	$VisibilityNotifier2D.connect("screen_exited", self, "on_screen_exited")

func _process(delta):
	move_and_slide(move_vector*speed + Vector2(100, 0))

func on_screen_exited():
	queue_free()
