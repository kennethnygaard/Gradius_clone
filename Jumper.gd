extends KinematicBody2D

var jumpspeed = 400
var gravity = 400
var vel_x = 0
var active = false
var move_vector = Vector2(-100, 0)
onready var main = get_tree().get_nodes_in_group("main")[0]
onready var camera = get_tree().get_nodes_in_group("camera")[0]
onready var puff = preload("res://Puff_explosion.tscn")
onready var shot = preload("res://Enemy_shot.tscn")
var turns = 2

export var shooting = false
export var first_shot_delay = 2
export var fire_delay = 2

func _ready():
	$VisibilityNotifier2D.connect("screen_entered", self, "on_screen_entered")
	$VisibilityNotifier2D.connect("screen_exited", self, "on_screen_exited")
	$Hit_ground_area.connect("area_entered", self, "on_hit_ground")
	$Hit_area.connect("area_entered", self, "on_hit")
	$Shoot_timer.connect("timeout", self, "on_shooter_timeout")

func _process(delta):
	if(active):
		move_vector.y += gravity*delta
		move_and_slide(move_vector)

		
func on_screen_entered():
	active = true
	$Shoot_timer.start(first_shot_delay)

func on_hit_ground(area2d):
	move_vector.y = -jumpspeed
	if(turns<1):
		pass	
	else:		
		if(global_position.x < camera.global_position.x-350 && turns%2==0):
			move_vector.x = -move_vector.x + camera.cruise_speed
			turns-=1
		if(global_position.x > camera.global_position.x+350 && turns%2==1):
			move_vector.x = -move_vector.x + camera.cruise_speed
			turns-=1

func on_hit(area2d):
	var newPuff = puff.instance()
	newPuff.global_position = global_position
	main.add_child(newPuff)
	queue_free()

func on_screen_exited():
	queue_free()

func start_timer():
	$Shoot_timer.start(fire_delay)

func on_shooter_timeout():
	if(visible && get_tree().get_nodes_in_group("player").size() > 0):
		if(shooting):
			shoot()
	
func shoot():
	var newShot = shot.instance()
	newShot.global_position = global_position
	main.add_child(newShot)

	print("jumper fires shot")
	$Shoot_timer.start(fire_delay)
