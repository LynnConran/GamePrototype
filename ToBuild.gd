extends Node2D


# Declare member variables here. Examples:
# var a = 2
# var b = "text"
var placement : Vector2
var coordinates : Vector2
var block_type : int

# Called when the node enters the scene tree for the first time.
func _ready():
	placement = Vector2(-100, -100)

func instantiate(place, type):
	coordinates = get_parent().map_to_world(place)
	placement = place
	block_type = type

func build():
	var parent = get_parent()
	parent.change_map(placement, block_type)
	parent.remove_placeholder(self)
	queue_free()
# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass
