extends Node2D


func _ready():
	var background = $background
	var bsize: Vector2 = background.texture.get_size()
#	scale = Global.get_bodypart_scale(bsize)
