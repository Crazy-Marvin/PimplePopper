class_name Cutter extends Node2D

onready var _hint_sfx: AudioStreamPlayer2D = $hint_sfx

var _touched
var _space: Physics2DDirectSpaceState
var _lipoma
var _ui: UI

func _ready():
	_space = get_world_2d().direct_space_state
	_ui = get_tree().get_nodes_in_group("ui")[0]

func _input(event):
	if _ui.is_inside_container(event.position):
		return
	
	if event is InputEventScreenTouch:
		_touched = event.pressed
		if event.pressed:
			var points: Array = _space.intersect_point(event.position, 1, [], 0 | 1, false, true)
			if points.size() != 0:
				_lipoma = points[0].collider
		else:
			_lipoma = null
	elif event is InputEventScreenDrag:
		if _lipoma != null:
			if _lipoma.cut():
				_hint_sfx.play()

func disable() -> void:
	set_process_input(false)
	visible = false

func enable() -> void:
	set_process_input(true)
	visible = true

