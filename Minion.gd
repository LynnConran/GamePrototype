extends KinematicBody2D


# Declare member variables here. Examples:
# var a = 2
# var b = "text"
const MOVE_SPEED = 100

onready var line = $Line2D
onready var nav = $Navigation2D
onready var nav_poly = $Navigation2D/NavigationPolygonInstance
onready var parent = get_parent()

var goal : String 
var destination : Vector2

# Called when the node enters the scene tree for the first time.
func _ready():
	goal = "Player"
	# parent.get_child(2)

func find_closest_building_block():
	var list = parent.buildable.placeholders
	if list.size() == 0:
		return parent.player.position
	else:
		var closest = list[0]
		var closest_val = to_global(closest.coordinates).distance_to(to_global(position))
		for i in list:
			if to_global(i.coordinates).distance_to(to_global(position)) < closest_val:
				closest = i
				closest_val = to_global(i.coordinates).distance_to(to_global(position))
		return closest.coordinates
		
	

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta):
	if goal == "Player":
		destination = to_global(parent.player.position)
	
	elif goal == "Build":
		destination = to_global(find_closest_building_block())
		#Checking all the placeholders
		for i in parent.buildable.placeholders:
			#print(to_global(i.coordinates).distance_to(to_global(position)))
			if to_global(i.coordinates).distance_to(to_global(position)) < 100:
				i.build()
		
	
	var direction = (destination - to_global(position)).normalized()
	var movement = direction * MOVE_SPEED
	move_and_slide(movement)

func set_goal(new_goal : String):
	goal = new_goal
