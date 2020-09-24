class_name Lipoma extends Area2D

signal protuberance_cleaned

enum State {
	NORMAL,
	ANAESTHETIC,
	OPEN,
	CUT,
	REMOVED,
	SUTURED,
	CLEANED
}

onready var rect_shape: RectangleShape2D = $CollisionShape2D.shape
onready var _sheet: AnimatedSprite = $sheet
onready var _circle_hint = $CollisionShape2D/circle_hint

export(State) var state = State.NORMAL
export(int, 1, 100) var suture_points: int = 5
export(float, 20, 100) var open_distance: float = 20
export(int) var cut_frames: int = 5
export(int, 10, 20) var anaesthetic_amount: int = 10
export(float, 10, 200) var max_pressure: float = 190
export(int) var pressure_frames: int = 4
export(int) var suture_frames: int = 5

var _cut_distance: float = 0
var _distance: float = 0
var _sutures: int = 0
var _anaesthetic: int = 0
var _cdistance: float = 0
var _frames: int = 0

func _ready():
	_cut_distance = rect_shape.extents.y
	_circle_hint.set_color(_circle_hint.white)


func apply_anaesthetic() -> bool:
	if state == State.NORMAL:
		_anaesthetic += 1
		Input.vibrate_handheld(100)
		if _anaesthetic >= anaesthetic_amount:
			_circle_hint.set_color(_circle_hint.blue)
			state = State.ANAESTHETIC
			return true
	return false

func open():
	if state == State.ANAESTHETIC:
		pass

func cut() -> bool:
	if state == State.ANAESTHETIC:
		_cdistance += 1
		var current_frame = (_cdistance / _cut_distance) * cut_frames
		_sheet.frame = _frames + current_frame
		if _cdistance >= _cut_distance:
			_circle_hint.set_color(_circle_hint.red)
			_frames += cut_frames
			state = State.CUT
			return true
	return false

func apply_pressure(pressure: float) -> bool:
	if state == State.CUT:
		var current_frame: int = (pressure / max_pressure) * pressure_frames
		_sheet.frame = _frames + current_frame
		if pressure > max_pressure:
			_circle_hint.set_color(_circle_hint.purple)
			_frames = _sheet.frame
			state = State.REMOVED
			return true
	return false

func suture() -> bool:
	if state == State.REMOVED:
		_sutures += 1
		_sheet.frame = _frames + _sutures
		if _sutures == suture_points:
			_circle_hint.set_color(_circle_hint.green)
			Input.vibrate_handheld()
			state = State.SUTURED
			emit_signal("protuberance_cleaned")
			return true
	return false

func clean() -> void:
	if state == State.SUTURED:
		return
		state == State.CLEANED
		emit_signal("protuberance_cleaned")

func _draw():
	var shape: RectangleShape2D = $CollisionShape2D.shape
	var initial_position: Vector2 = Vector2(0, -shape.extents.y + 5.0)
	var y_steps: float = shape.extents.y / 5.0
	var pos: Vector2 = initial_position
	for s in 10:
		draw_circle(pos, 5, Color(1, 0, 0, 0.5))
		pos.y += y_steps
