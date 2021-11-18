extends KinematicBody2D

enum Direction {UP, DOWN}
var active = false
var stage = 0
var move_speed = 100
var move_speed_y = 150
var move_vector = Vector2(-move_speed, 0)
var direction = Direction.DOWN
var turn_x = 300
var players

var master_y
var target_y

onready var camera = get_tree().get_nodes_in_group("camera")[0]
onready var puff = preload("res://Puff_explosion.tscn")
onready var main = get_tree().get_nodes_in_group("main")[0]

func _ready():
	$VisibilityNotifier2D.connect("screen_entered", self, "on_screen_entered")
	$VisibilityNotifier2D.connect("screen_exited", self, "on_screen_exited")
	$Sprite/Hit_area.connect("area_entered", self, "on_hit")

func _process(delta):
	if(active):
		run_process(delta)

func run_process(delta):
	move_and_slide(move_vector)
	if(stage==0):
		if(global_position.x < camera.global_position.x - turn_x):
			move_vector.x = move_speed+camera.cruise_speed*2
			if(direction == Direction.DOWN):
				move_vector.y = move_speed_y
			if(direction == Direction.UP):
				move_vector.y = -move_speed_y
			stage = 1
			
	if(stage == 1):
		players = get_tree().get_nodes_in_group("player")
		if(players.size() > 0):
			var fan_y = global_position.y
			var player_y = players[0].global_position.y

			if(fan_y > player_y - 5 && fan_y < player_y + 5):
				stage = 2
				print("going to stage 2")
	if(stage == 2):
		move_vector.y = 0

func set_direction(dir):
	direction = dir

func on_screen_entered():
	active = true
	var children = get_parent().get_children()
	for child in children:
		child.active = true
	
func on_screen_exited():
	queue_free()

func on_hit(area2d):
	var newPuff = puff.instance()
	newPuff.global_position = global_position
	main.add_child(newPuff)
	queue_free()
