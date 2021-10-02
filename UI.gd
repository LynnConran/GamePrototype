extends Control


# Declare member variables here. Examples:
# var a = 2
# var b = "text"
onready var list = $BuildList

# Called when the node enters the scene tree for the first time.
func _ready():
	list.add_item("green")
	list.add_item("red")
	list.add_item("blue")
	list.add_item("none")
	list.add_item("remove")


# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass
