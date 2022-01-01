extends Node

export(NodePath) var background_path: NodePath

# Declare member variables here. Examples:
# var a = 2
# var b = "text"


# Called when the node enters the scene tree for the first time.
func _ready():
	var bsize: Vector2 = get_node(background_path).texture.get_size()
	var scale_x: float = OS.window_size.x / bsize.x
	var scale_y: float = OS.window_size.y / bsize.y
	var new_scale = scale_x
	if scale_x < scale_y:
		new_scale = scale_y
	get_parent().scale = Vector2(new_scale, new_scale)
