extends Node

signal pause
var isPaused = false

func _ready():
	#Needs to be run at start or mouse is visible by default
	Input.set_mouse_mode(Input.MOUSE_MODE_CAPTURED)

func _process(_delta):
	#Handle changes between fullscreen and windowed, pause on ESC
	if Input.is_action_just_pressed("ui_cancel"):
		_pause()
	if Input.is_action_just_pressed("fullscreen"):
		if DisplayServer.window_get_mode() == DisplayServer.WINDOW_MODE_FULLSCREEN:
			DisplayServer.window_set_mode(DisplayServer.WINDOW_MODE_WINDOWED)
		else:
			DisplayServer.window_set_mode(DisplayServer.WINDOW_MODE_FULLSCREEN)

func saveSettings():
	var settings: Dictionary = {
		"egg" = "salad"
		#"key" = value
	}
	var json: String = JSON.stringify(settings)
	var save: FileAccess = FileAccess.open("user://settings.json", FileAccess.WRITE)
	save.store_line(json)

func loadSettings():
	pass

#If paused recapture mouse, if not make visible
func _pause():
	if(isPaused):
		Input.set_mouse_mode(Input.MOUSE_MODE_CAPTURED)
		isPaused = false
		emit_signal("pause")
		saveSettings()
	else:
		Input.set_mouse_mode(Input.MOUSE_MODE_VISIBLE)
		isPaused = true
		emit_signal("pause")
