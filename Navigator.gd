extends Node2D

var walls : TileMap # Defined by base node on ready

var path_start_position = Vector2() setget _set_path_start_position
var path_end_position = Vector2() setget _set_path_end_position

var point_path = []

onready var astar_node = AStar2D.new()

func set_path(start, end):
	astar_node.clear()
	var walkable_cells_list = astar_add_walkable_cells(walls.walls)
	astar_connect_walkable_cells(walkable_cells_list)
	return get_astar_path(start, end)

func astar_add_walkable_cells(obstacle_list = []):
	var points_array = []
	for y in range(walls.map_size.y):
		for x in range(walls.map_size.x):
			var point = Vector2(x, y)
			if point in walls.walls:
				continue
			points_array.append(point)
			var point_index = calculate_point_index(point)
			astar_node.add_point(point_index, point)
	return points_array

func astar_connect_walkable_cells(points_array):
	for point in points_array:
		var point_index = calculate_point_index(point)
		var points_relative = PoolVector2Array([
			point + Vector2.RIGHT,
			point + Vector2.LEFT,
			point + Vector2.DOWN,
			point + Vector2.UP,
			point + Vector2(1, 1),
			point + Vector2(1, -1),
			point + Vector2(-1, 1),
			point + Vector2(-1, -1)
		])
		for point_relative in points_relative:
			var point_relative_index = calculate_point_index(point_relative)
			if is_outside_map(point_relative):
				continue
			if not astar_node.has_point(point_relative_index):
				continue
			astar_node.connect_points(point_index, point_relative_index, false)

func get_astar_path(world_start, world_end):
	self.path_start_position = walls.world_to_map(world_start)
	self.path_end_position = walls.world_to_map(world_end)
	_recalculate_path()
	var path_world = []
	for point in point_path:
		var point_world = walls.map_to_world(point) + walls._half_cell_size
		path_world.append(point_world)
	return path_world

func calculate_point_index(point):
	return point.x + walls.map_size.x * point.y

func is_outside_map(point):
	return point.x < 0 or point.y < 0 or point.x >= walls.map_size.x or point.y >= walls.map_size.y

func _recalculate_path():
	var start_point_index = calculate_point_index(path_start_position)
	var end_point_index = calculate_point_index(path_end_position)
	point_path = astar_node.get_point_path(start_point_index, end_point_index)

func _set_path_start_position(value):
	if value in walls:
		return
	if is_outside_map(value):
		return
	path_start_position = value
	if path_end_position and path_end_position != path_start_position:
		_recalculate_path()
	
func _set_path_end_position(value):
	if value in walls:
		return
	if is_outside_map(value):
		return
	path_end_position = value
	if path_start_position != value:
		_recalculate_path()



