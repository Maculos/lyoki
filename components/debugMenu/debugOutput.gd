extends Control

func _process(_delta):
	$leftText.text = "
	State:\n
	FPS: " + str(Engine.get_frames_per_second()) + "\n
	Player Coords:\n	" + str(get_parent().get_parent().get_parent().get_node("player").position) + "\n
	GPU Driver:	" + OS.get_video_adapter_driver_info()[0] + "\n
	RAM:	" + str(OS.get_memory_info()["free"]/100000000) + "GB free of " + str(OS.get_memory_info()["physical"]/1000000000) + "GB total\n
	meow
	"
	
	$rightText.text = "
	Variables:\n
	Walk Speed: " + str(get_parent().get_parent().get_parent().get_node("player").walk_speed) + "\n
	Run Speed: " + str(get_parent().get_parent().get_parent().get_node("player").run_speed) + "\n
	Sensitivity: " + str(get_parent().get_parent().get_parent().get_node("player").sensitivity) + "\n
	Jump Velocity: " + str(get_parent().get_parent().get_parent().get_node("player").jump_velocity) + "\n
	meow\n
	meow
	"
