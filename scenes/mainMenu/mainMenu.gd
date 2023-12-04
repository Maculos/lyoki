extends Control

@export var mainScene = "res://scenes/mainMenu/mainMenu.tscn"
@export var optionsScene = "res://scenes/mainMenu/mainMenu.tscn"
@export var creditsScene = "res://scenes/mainMenu/mainMenu.tscn"

# Called when the node enters the scene tree for the first time.
func _ready():
	pass

func _onPlayPressed():
	get_tree().change_scene_to_file("res://scenes/lyoki.tscn")
func _onOptionsPressed():
	get_tree().change_scene_to_file("res://scenes/introLogo/intro_logo.tscn")
func _onCreditsPressed():
	get_tree().change_scene_to_file("res://scenes/introLogo/intro_logo.tscn")
func _onExitPressed():
	get_tree().quit() #change to prompt later
