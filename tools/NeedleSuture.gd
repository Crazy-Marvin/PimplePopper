class_name NeedleSuture extends Node2D

onready var _line: Line2D = $Node/Line2D
onready var _hint: AudioStreamPlayer2D = $hint_sfx

var _touched: bool = false
var _ui

func _ready():
	_ui = get_tree().get_nodes_in_group("ui")[0]

func _input(event):
	if _ui.is_inside_container(event.position):
		return
	
	if event is InputEventScreenTouch:
			_line.points = []
			_touched = event.pressed
	elif event is InputEventScreenDrag:
		position = event.position
		_line.add_point(event.position)


func _on_needle_area_entered(area):
	if area is Lipoma:
		if area.suture():
			_hint.play()

func disable() -> void:
	set_process_input(false)
	visible = false

func enable() -> void:
	set_process_input(true)
	visible = true
