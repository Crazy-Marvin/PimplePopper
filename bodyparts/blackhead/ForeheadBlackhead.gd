extends Node2D


func _ready():
	var background: Sprite = $background
	var bsize: Vector2 = background.texture.get_size()
	var new_scale: float = OS.window_size.x / bsize.x
	
	scale = Vector2(new_scale, new_scale)
	
	position.x = OS.window_size.x / 2.0
