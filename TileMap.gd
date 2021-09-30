extends TileMap


# Declare member variables here. Examples:
# var a = 2
# var b = "text"
var current_cell_type
var placeholders : Array

func set_cell_type(index : int):
	current_cell_type = get_tileset().get_tiles_ids()[index]

# Called when the node enters the scene tree for the first time.
func _ready():
	#current_cell_type = get_tileset().get_tiles_ids()[0]
	placeholders = []

func change_map(pos: Vector2, cell_type: int):
	#Logic to determine what to place
	if cell_type == -1:
		set_cellv(pos, -1)
	elif get_cellv(pos) < 0:
		if cell_type >= 0:
			var cell_id = get_tileset().get_tiles_ids()[cell_type]
			set_cellv(pos, cell_id)
		else:
			set_cellv(pos, -1)

func add_placeholder(pos: Vector2, cell_type: int):
	var scene = load("res://ToBuild.tscn")
	var node = scene.instance()
	add_child(node)
	node.instantiate(pos, cell_type)
	placeholders.append(node)

func remove_placeholder(node):
	placeholders.erase(node)

# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass
