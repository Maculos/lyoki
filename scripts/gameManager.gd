extends Node3D

# this will eventually be a demon script that handles a lot of background processes
#rn its mouse thing

func _ready():
	Input.set_mouse_mode(Input.MOUSE_MODE_CAPTURED) #confines mouse to game window, use alt+f4 to exit

func _process(_delta):
	if Input.is_action_just_pressed("ui_cancel"):
		get_tree().quit()
	if Input.is_action_just_pressed("fullscreen"):
		if DisplayServer.window_get_mode() == DisplayServer.WINDOW_MODE_FULLSCREEN:
			DisplayServer.window_set_mode(DisplayServer.WINDOW_MODE_WINDOWED)
		else:
			DisplayServer.window_set_mode(DisplayServer.WINDOW_MODE_FULLSCREEN)
