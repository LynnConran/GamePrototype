extends Node2D


# Declare member variables here. Examples:
# var a = 2
# var b = "text"

onready var player : KinematicBody2D = $Player
onready var buildable : TileMap = $Buildable
onready var buildList : ItemList = $Player/Camera2D/UI/BuildList
onready var navigator = $Navigation2D

var selected_entity
var mouse_in_ui = false
var mouse_in_entity = false

func _input(event):
	if (not mouse_in_ui and not mouse_in_entity):
		if Input.is_action_pressed("left_click") and event is InputEventMouse:
			if buildable.current_cell_type != null:
				var cell = buildable.world_to_map(get_local_mouse_position())
				if buildable.current_cell_type >= 0:
					buildable.add_placeholder(cell, buildable.current_cell_type)
				else:
					buildable.change_map(cell, buildable.current_cell_type)

# Called when the node enters the scene tree for the first time.
func _ready():
	$Minion.connect("input_event", self, "_on_Minion_input_event", [$Minion])
	$Minion.connect_signals() # Remember to add this when making more
	$Minion/Navigator.walls = buildable
	$Minion.set_destination()

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
	elif index == buildList.get_item_count() - 2:
		buildable.current_cell_type = null
	else:
		buildable.set_cell_type(index)

func _on_Minion_input_event(_viewport, event, _shape_idx, source):
	if event is InputEventMouseButton and Input.is_action_pressed("left_click"):
		selected_entity = source

func _on_Minion_mouse_entered():
	mouse_in_entity = true

func _on_Minion_mouse_exited():
	mouse_in_entity = false

func _on_OptionButton_item_selected(index):
	if selected_entity:
		if index == 1:
			selected_entity.set_goal("Player")
		elif index == 2:
			selected_entity.set_goal("Build")

func _on_OptionButton_mouse_entered():
	mouse_in_ui = true

func _on_OptionButton_mouse_exited():
	mouse_in_ui = false
