extends KinematicBody2D

var velocity = Vector2(700, 0)


func _ready():
	$VisibilityNotifier2D.connect("screen_exited", self, "on_screen_exited")	
	$Sprite/collision.connect("area_entered", self, "on_hit_something")
	$Sprite/kill_area.connect("area_entered", self, "on_hit_something")
	
func _process(delta):
	move_and_slide(velocity)

func on_screen_exited():
	queue_free()

func on_hit_something(area2d):
	queue_free()
