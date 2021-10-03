extends Navigation2D


# Declare member variables here. Examples:
# var a = 2
# var b = "text"
var mesh_list = {}
#onready var polygon = $NavigationPolygonInstance.get_navigation_polygon()

#func add_mesh(pos):
#	var outline = PoolVector2Array([pos, pos + Vector2(64, 0), pos + Vector2(0, 64), pos + Vector2(64, 64)])
#	polygon.add_outline(outline)
#	polygon.make_polygons_from_outlines()
#	var my_transform
#	#navpoly_add(polygon, Transform2D.IDENTITY)
#	mesh_list[pos] = polygon
	
#func remove_mesh(pos):
#	navpoly_remove(mesh_list[pos].id)
#	mesh_list.erase(pos)

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass
