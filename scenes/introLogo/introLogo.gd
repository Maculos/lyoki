extends Node2D

func _ready():
	$logoCover/logoFade.play("fadeIn")
	await get_tree().create_timer(3).timeout
	get_tree().change_scene_to_file("res://scenes/mainMenu/mainMenu.tscn")
