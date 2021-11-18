extends Node2D

onready var camera = get_tree().get_nodes_in_group("camera")[0]
onready var Lava_rock = preload("res://Lava_rock.tscn")
onready var main = get_tree().get_nodes_in_group("main")[0]


func _ready():
	$VisibilityNotifier2D.connect("screen_entered", self, "on_screen_entered")
	$StartTimer.connect("timeout", self, "on_start_timeout")
	$Left_Spew_Timer.connect("timeout", self, "on_left_spew_timeout")
	$Right_Spew_Timer.connect("timeout", self, "on_right_spew_timeout")
	$End_Timer.connect("timeout", self, "on_end_timeout")
	$Outro_Timer.connect("timeout", self, "on_outro_timeout")
	
#func _process(delta):
#	pass

func on_screen_entered(): 
	camera.set_scrolling(false)
	$StartTimer.start(2)
	
func on_start_timeout():
	$Left_Spew_Timer.start(0.02)
	$Right_Spew_Timer.start(0.034)
	$End_Timer.start(10)


func on_left_spew_timeout():
	spew(0)
	var new_time = rand_range(0.1, 0.2)
	$Left_Spew_Timer.start(new_time)

func on_right_spew_timeout():
	spew(400)
	var new_time = rand_range(0.08, 0.2)
	$Right_Spew_Timer.start(new_time)
	
func spew(x):
	var newRock = Lava_rock.instance()
	newRock.global_position = global_position
	newRock.global_position.x += x
	newRock.global_position.y -= 20
	main.add_child(newRock)	
	
func on_end_timeout():
	$Left_Spew_Timer.stop()
	$Right_Spew_Timer.stop()
	$Outro_Timer.start(2)

func on_outro_timeout():
	camera.set_scrolling(true)
	
	
