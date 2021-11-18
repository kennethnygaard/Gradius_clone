extends Camera2D

onready var main = get_tree().get_nodes_in_group("main")[0]
onready var cruise_speed = main.cruise_speed
var scrolling = true

func _ready():
	pass # Replace with function body.

func _process(delta):
	if(scrolling):
		global_position.x += cruise_speed*delta
	if(Input.is_action_just_pressed("ui_cancel")):
		get_tree().quit()

func set_scrolling(is_scrolling):
	scrolling = is_scrolling
