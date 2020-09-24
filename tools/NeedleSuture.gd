class_name NeedleSuture extends Node2D

onready var _line: Line2D = $Node/Line2D
onready var _hint: AudioStreamPlayer2D = $hint_sfx

var _touched: bool = false

func _ready():
	pass # Replace with function body.

func _input(event):
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
