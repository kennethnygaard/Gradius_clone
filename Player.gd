extends KinematicBody2D


onready var anim_tree = $AnimationTree
onready var state_machine = $AnimationTree.get("parameters/playback")
onready var main = get_tree().get_nodes_in_group("main")[0]
onready var camera = get_tree().get_nodes_in_group("camera")[0]
onready var shot = preload("res://Shot.tscn")
onready var explosion = preload("res://Player_explosion.tscn")
var cruise_speed = 100

func _ready():
	$AnimationPlayer.play("Neutral")
	$Area2D.connect("area_entered", self, "on_player_collided")
	
	pass

func _physics_process(delta):
	var velocity = Vector2.ZERO
	if(camera.scrolling):
		global_position.x += cruise_speed*delta
	
	if(Input.is_action_pressed("up")):
		velocity.y -= 1
	if(Input.is_action_pressed("down")):
		velocity.y += 1
	if(Input.is_action_pressed("left")):
		velocity.x -= 1
	if(Input.is_action_pressed("right")):
		velocity.x += 1
	
	if(Input.is_action_just_pressed("fire")):
		fire()
	
	if(velocity.y > 0):
		state_machine.travel("Down")
	if(velocity.y < 0):
		state_machine.travel("Up")
	if(velocity.y == 0):
		state_machine.travel("Neutral")

	move_and_slide(velocity*200)
	
	global_position.x = clamp(global_position.x, camera.global_position.x-480, camera.global_position.x+480)
	global_position.y = clamp(global_position.y, -260, 280)

func on_player_collided(area2d):
	var newExplosion = explosion.instance()
	newExplosion.global_position = global_position
	main.add_child(newExplosion)
	queue_free()

func fire():
	var newShot = shot.instance()
	newShot.global_position = Vector2(global_position.x + 48, global_position.y)
	main.add_child(newShot)
	$ShotAudioPlayer.play()
