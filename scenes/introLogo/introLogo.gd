extends Node2D

@export var nextScene = "res://scenes/mainMenu/mainMenu.tscn"

func _ready():
	$logoCover/logoFade.play("fadeIn")
	await get_tree().create_timer(3).timeout
	get_tree().change_scene_to_file(nextScene)
