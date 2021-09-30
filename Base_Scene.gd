extends Node2D


# Declare member variables here. Examples:
# var a = 2
# var b = "text"

onready var player = $Player
onready var buildable = $Buildable
onready var buildList = $Player/Camera2D/UI/BuildList

var selected_entity
var mouse_in_ui = false

func _input(event):
	if (not mouse_in_ui):
		if Input.is_action_pressed("left_click") and event is InputEventMouse:
			var cell = buildable.world_to_map(get_local_mouse_position())
			if buildable.current_cell_type >= 0:
				buildable.add_placeholder(cell, buildable.current_cell_type)
			else:
				buildable.change_map(cell, buildable.current_cell_type)

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass


func _on_ItemList_mouse_entered():
	mouse_in_ui = true
	
func _on_ItemList_mouse_exited():
	mouse_in_ui = false

func _on_ItemList_item_selected(index):
	if index == buildList.get_item_count() - 1:
		buildable.current_cell_type = -1
	else:
		buildable.set_cell_type(index)
