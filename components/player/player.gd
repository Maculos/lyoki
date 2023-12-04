extends CharacterBody3D

#Allow changes in main scene by exporting
@export var walk_speed = 5
@export var run_speed = 8
@export var jump_velocity = 4
@export var sensitivity = 0.1
@export var accel = 10
@export var default_fov = 110.0
@export var run_fov = 130.0

#WE USE METERS IN THIS HOUSE AND THATS FINAL
var gravity = ProjectSettings.get_setting("physics/3d/default_gravity")

var speed = walk_speed
var running = false

#no clue if this will cause conflicts long term having an array
#with the same name as the script but thats a problem for future me
@onready var player = {
	"head": $head,
	"camera": $head/camera,
	"cameraBobbing": $head/camera/cameraBobbing
}

func _process(delta):
	if Input.is_action_pressed("input_run"):
		running = true
		speed = run_speed
		player.camera.fov = lerp(player.camera.fov, run_fov, 10*delta)
	else:
		running = false
		speed = walk_speed
		player.camera.fov = lerp(player.camera.fov, default_fov, 10*delta)


func _physics_process(delta):
	#send back to origin if you fall off, to be removed later
	if(position.y <= -3):
		position = Vector3(0,2,0)
	#merge binary inputs into a single vector for NotJankyMovement
	var input_dir = Input.get_vector("input_left", "input_right", "input_fwd", "input_bkwd")
	#direction is relative to camera direction
	var dir = input_dir.normalized().rotated(-player.head.rotation.y)
	dir = Vector3(dir.x, 0, dir.y) #final direction

	if not is_on_floor():
		velocity.y -= gravity * delta

	#(1) lerp is a very funny name
	#(2) god im glad tutorials exist, very confusing
	if is_on_floor():
		velocity.x = lerp(velocity.x, dir.x * speed, accel * delta)
		velocity.z = lerp(velocity.z, dir.z * speed, accel * delta)

	if Input.is_action_pressed("input_jump") and is_on_floor():
		velocity.y += jump_velocity

	#up and down bobbing animation
	if input_dir and is_on_floor():
		player.cameraBobbing.play("bobbing", 0.5)
	else:
		player.cameraBobbing.play("rest", 0.5)

	move_and_slide() #the magic of characterbody3d making my life easier


func _input(event):
	if event is InputEventMouseMotion:
		player.head.rotation_degrees.x -= event.relative.y * sensitivity
		player.head.rotation_degrees.y -= event.relative.x * sensitivity
		player.head.rotation.x = clamp(player.head.rotation.x, deg_to_rad(-90), deg_to_rad(90))
