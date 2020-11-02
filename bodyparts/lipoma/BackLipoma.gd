extends Node2D


func _ready():
	var background = $lipoma/sheet.frames.get_frame("default", 0)
	var bsize: Vector2 = background.get_size()
	
	position.x = OS.window_size.x - bsize.x
