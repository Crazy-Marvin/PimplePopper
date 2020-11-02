extends Control

onready var _bottons_container: HBoxContainer = $bottons_container

func _ready():
	var bcsize: Vector2 = _bottons_container.rect_size
	bcsize.x = OS.window_size.x
	_bottons_container.rect_size = bcsize
