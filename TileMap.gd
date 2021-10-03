extends TileMap


# Declare member variables here. Examples:
export (Vector2) var map_size

var current_cell_type
var placeholders : Array
var walls : Array = []
onready var _half_cell_size = cell_size / 2

signal map_changed

const impassable_list = [0, 1, 2] # List of impassable values

func set_cell_type(index : int):
	current_cell_type = get_tileset().get_tiles_ids()[index]

# Called when the node enters the scene tree for the first time.
func _ready():
	#current_cell_type = get_tileset().get_tiles_ids()[0]
	placeholders = []
	define_walls()

func define_walls():
	walls = []
	for i in impassable_list:
		walls.append_array(get_used_cells_by_id(i))

func change_map(pos: Vector2, cell_type: int):
	#Logic to determine what to place
	if cell_type == -1:
		set_cellv(pos, -1)
	elif get_cellv(pos) < 0:
		var cell_id = get_tileset().get_tiles_ids()[cell_type]
		set_cellv(pos, cell_id)
		get_parent().navigator.add_mesh(pos)

func add_placeholder(pos: Vector2, cell_type: int):
	var scene = load("res://ToBuild.tscn")
	var node = scene.instance()
	add_child(node)
	node.instantiate(pos, cell_type)
	placeholders.append(node)
	emit_signal("map_changed")

func remove_placeholder(node):
	placeholders.erase(node)

# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass
