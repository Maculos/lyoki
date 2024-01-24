extends RigidBody3D

@export var hasResource = false
var scene = preload("res://components/resourceHolder/resource.tscn")
var instance = scene.instantiate()

func _ready():
	if(hasResource):
		_createResource()

func _createResource():
	instance.position = Vector3(0, 1, 0)
	add_child(instance)

func _depositResource():
	if(!hasResource):
		_createResource()

func _deleteResource():
	instance.queue_free()
