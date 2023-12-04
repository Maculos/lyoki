extends Control

func _process(_delta):
	$leftText.text = "
	State:\n
	FPS: " + str(Engine.get_frames_per_second()) + "\n
	Player Coords:\n	" + str(get_parent().get_parent().get_node("player").position) + "\n
	meow\n
	meow\n
	meow\n
	meow
	"
	
	$rightText.text = "
	Variables:\n
	Walk Speed: " + str(get_parent().get_parent().get_node("player").walk_speed) + "\n
	Run Speed: " + str(get_parent().get_parent().get_node("player").run_speed) + "\n
	Sensitivity: " + str(get_parent().get_parent().get_node("player").sensitivity) + "\n
	Jump Velocity: " + str(get_parent().get_parent().get_node("player").jump_velocity) + "\n
	meow\n
	meow
	"
