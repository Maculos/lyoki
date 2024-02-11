extends CharacterBody3D

#Allow changes in main scene by exporting
@export var walk_speed = 5
@export var run_speed = 8
@export var jump_velocity = 4
@export var sensitivity = 1
@export var accel = 10
@export var default_fov = 110.0
@export var run_fov = 130.0

#WE USE METERS IN THIS HOUSE AND THATS FINAL
var gravity = ProjectSettings.get_setting("physics/3d/default_gravity")
var speed = walk_speed

var debugEnabled = false

@onready var player = {
	"head": $head,
	"camera": $head/camera,
	"cameraBobbing": $head/camera/cameraBobbing
}

func _process(delta):
	if Input.is_action_pressed("input_run"):
		speed = run_speed
		player.camera.fov = lerp(player.camera.fov, run_fov, 10*delta)
	else:
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

	#Normalize gravity against lag
	if not is_on_floor():
		velocity.y -= gravity * delta

	#will need to retool this but i think its
	#better to allow mid-air movment than not
	velocity.x = lerp(velocity.x, dir.x * speed, accel * delta)
	velocity.z = lerp(velocity.z, dir.z * speed, accel * delta)

	if Input.is_action_pressed("input_jump") and is_on_floor():
		velocity.y += jump_velocity

	#up and down bobbing animation
	if input_dir and is_on_floor():
		player.cameraBobbing.play("bobbing", 0.5)
	else:
		player.cameraBobbing.play("rest", 0.5)

	move_and_slide()

var isPaused = false
func _pause():
	if(isPaused):
		isPaused = false
	else:
		isPaused = true


func _input(event):
	if (event is InputEventMouseMotion) && !isPaused:
		player.head.rotation_degrees.x -= event.relative.y * (sensitivity/10.0)
		player.head.rotation_degrees.y -= event.relative.x * (sensitivity/10.0)
		player.head.rotation.x = clamp(player.head.rotation.x, deg_to_rad(-90), deg_to_rad(90))

signal depositResource
signal deleteResource
@export var hasResource = false
func _on_resource_holder_contact(body):
	if(hasResource && body.is_in_group(player)):
		emit_signal("depositResource")
		hasResource = false
	if(!hasResource && body.is_in_group(player)):
		emit_signal("deleteResource")
		hasResource = true
