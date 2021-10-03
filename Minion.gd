extends KinematicBody2D


const MOVE_SPEED = 100

onready var parent = get_parent()
onready var nav = $Navigator

var goal : String 
var destination : Vector2
var path : PoolVector2Array


# Called when the node enters the scene tree for the first time.
func _ready():
	goal = "Player"

func connect_signals():
	parent.buildable.connect("map_changed", self, "_on_map_change")
	
func _on_map_change():
	set_destination()

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

func set_destination():
	if goal == "Player":
		destination = to_global(parent.player.position)
	elif goal == "Build":
		destination = to_global(find_closest_building_block())
	set_path()

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if goal == "Build":
		for i in parent.buildable.placeholders:
			#print(to_global(i.coordinates).distance_to(to_global(position)))
			if to_global(i.coordinates).distance_to(to_global(position)) < 100:
				i.build()
				set_destination()
	if goal == "Player":
		if destination.distance_to(to_global(parent.player.position)) > 150:
			set_destination()
	if path.size() > 0:
		if position.distance_to(path[0]) < MOVE_SPEED * delta:
			position = path[0]
			path.remove(0)
			if path.size() == 0:
				set_destination()
		var direction = to_global(position).direction_to(to_global(path[0]))
		var movement = direction * MOVE_SPEED * delta
		position += movement
	

func set_goal(new_goal : String):
	goal = new_goal
	set_destination()

func set_path():
	path = nav.set_path(position, to_local(destination))
	get_parent().line.points = path
