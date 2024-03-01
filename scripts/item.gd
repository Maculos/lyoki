extends StaticBody3D
@onready var orange = preload("res://components/items/orange.tscn")
@onready var items = [orange, orange, orange]


func _process(_delta):
	pass


func create_item(itm):
	for h in range(itm):
		var i = items.instance(items[randf_range(0, items.size())])
		i.set_pos(Vector3(randf_range(-100, 100), 0, randf_range(-100, 100))
		
)
