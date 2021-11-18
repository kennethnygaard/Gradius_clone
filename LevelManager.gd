extends Node

export(Array, PackedScene) var levelScenes

var currentLevelIndex = 0

func _ready():
	changeLevel(currentLevelIndex)
	
func changeLevel(levelIndex):
	currentLevelIndex = levelIndex
	get_tree().change_scene(levelScenes[levelIndex].resource_path)
