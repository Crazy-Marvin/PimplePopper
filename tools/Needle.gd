extends Node2D
class_name Neddle

export(float) var needle_extraction_distance: float = 50

onready var _tween: Tween = $tween
onready var _sprites: AnimatedSprite = $tool/sprites
var _initial_tool_position: Vector2 
var _second_finger_position: Vector2
var _protuberance
var _space: Physics2DDirectSpaceState

# Called when the node enters the scene tree for the first time.
func _ready():
	_initial_tool_position = _sprites.position
	_space = get_world_2d().direct_space_state


func _input(event):
	if event is InputEventScreenTouch:
		if event.index == 0:
			if event.pressed:
				bring_tool(event.position)
			else:
				hide_tool()
		elif event.index == 1:
			_second_finger_position = event.position
	elif event is InputEventScreenDrag:
		if event.index == 1 and _protuberance != null:
			_sprites.frame = _protuberance.extract()

func bring_tool(event_position: Vector2) -> void:
	_tween.remove_all()
	_tween.interpolate_property(_sprites, "position", _sprites.position, event_position, 1, Tween.TRANS_LINEAR)
	_tween.start()

func hide_tool() -> void:
	_tween.remove_all()
	_tween.interpolate_property(_sprites, "position", _sprites.position, _initial_tool_position, 1, Tween.TRANS_LINEAR)
	_tween.start()
	_protuberance = null


func _on_tween_completed(object, key):
	print_debug(key)
	if object == _sprites and key == ":position":
		var collisions: Array = _space.intersect_point(_sprites.position, 1, [], 1, false, true)
		print_debug("Tween completed")
		if collisions.size() != 0:
			print_debug("On Protuberance")
			_protuberance = collisions[0].collider
