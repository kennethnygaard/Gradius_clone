extends KinematicBody2D

var x_speed = -60
onready var players = get_tree().get_nodes_in_group("player")
onready var main = get_tree().get_nodes_in_group("main")[0]
onready var cruise_speed = main.cruise_speed
var move_vector = Vector2(x_speed, 0)
onready var puff = preload("res://Puff_explosion.tscn")
var active = false

func _ready():
	$Hit_area.connect("area_entered", self, "on_hit")
	$VisibilityNotifier2D.connect("screen_entered", self, "on_screen_entered")
	$VisibilityNotifier2D.connect("screen_exited", self, "on_screen_exited")

func _physics_process(delta):
	if(active):
		players = get_tree().get_nodes_in_group("player")

		var slack = 20
		move_vector.y = 0
		$Sprite.frame = 0
		if(players.size() > 0):
			if(players[0].global_position.y < global_position.y-slack):
				move_vector.y = -100
				$Sprite.frame = 1
			if(players[0].global_position.y > global_position.y+slack):
				move_vector.y = 100
				$Sprite.frame = 2
		move_and_slide(move_vector)

func on_screen_entered():
	active = true
	
func on_screen_exited():
	queue_free()

func on_hit(area2d):
	var newPuff = puff.instance()
	newPuff.global_position = global_position
	main.add_child(newPuff)
	queue_free()
