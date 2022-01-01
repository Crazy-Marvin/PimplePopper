extends Node2D


func _ready():
	var background = $lipoma/sheet.frames.get_frame("default", 0)
	var bsize: Vector2 = background.get_size()
	var new_scale: float = OS.window_size.x / bsize.x
	scale = Vector2(new_scale, new_scale)
