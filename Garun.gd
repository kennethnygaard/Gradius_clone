extends KinematicBody2D

var time_elapsed = 0
onready var camera = get_tree().get_nodes_in_group("camera")[0]
onready var main = get_tree().get_nodes_in_group("main")[0]
var active = false
onready 	var y = global_position.y
onready var puff = preload("res://Puff_explosion.tscn")

func _ready():
	$Sprite/AnimationPlayer.play("default")
	$Sprite/hit_area.connect("area_entered", self, "on_hit")
	$VisibilityNotifier2D.connect("screen_entered", self, "on_screen_entered")
	$VisibilityNotifier2D.connect("screen_exited", self, "on_screen_exited")

func _process(delta):
	if(active):
		time_elapsed += 0.05
		global_position.y = sin(time_elapsed)*50 + y
		global_position.x -= 100*delta

func on_screen_entered():
	active = true

func on_screen_exited():
	queue_free()

func on_hit(area2d):
#	$AudioStreamPlayer.play()
#	$AudioStreamPlayer.connect("finished", self, "kill_garun")
#	visible = false
#	$Sprite/hit_area.queue_free()
#	$Sprite/collide_area.queue_free()
	var newPuff = puff.instance()
	newPuff.global_position = global_position
	main.add_child(newPuff)
	queue_free()
	
func kill_garun():
	queue_free()
