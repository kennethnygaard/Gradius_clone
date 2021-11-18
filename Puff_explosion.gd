extends Node2D


func _ready():
	$AudioStreamPlayer.connect("finished", self, "on_finished")
	$AudioStreamPlayer.play()

func on_finished():
	get_parent().queue_free()
