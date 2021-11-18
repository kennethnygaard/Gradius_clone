extends KinematicBody2D

onready var camera = get_tree().get_nodes_in_group("camera")[0]

func _ready():
	$AudioStreamPlayer.play()
	$AudioStreamPlayer.connect("finished", self, "on_finished")

func _process(delta):

	var move_vector = Vector2(100, 0) if camera.scrolling else Vector2(0, 0)
	move_and_slide(move_vector)

func on_finished():
	queue_free()	

func set_invisible():
	visible = false
