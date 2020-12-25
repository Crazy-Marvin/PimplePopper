extends Node2D


func _ready():
	var bsize: Vector2 = $background.texture.get_size()
	var new_y: float = OS.window_size.y / bsize.y
	scale = Vector2(new_y, new_y)
