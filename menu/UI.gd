class_name UI extends Control

onready var _bottons_container: HBoxContainer = $bottons_container
onready var _scroll: ScrollContainer = $scroll

func _ready():
	pass

func is_inside_container(v: Vector2) -> bool:
	if _bottons_container.get_rect().has_point(v) or _scroll.get_rect().has_point(v):
		return true
	return false
