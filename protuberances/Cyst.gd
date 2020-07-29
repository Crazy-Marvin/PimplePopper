extends Node2D
class_name Cyst

signal protuberance_cleaned

enum State {
	NORMAL,
	EMPTY,
	CLEAN
}

onready var _sprites: AnimatedSprite = get_parent().get_node("background")

export(int, 20, 100) var amount: int = 30

var _initial_amount: int
var _fs: int

var _state = State.NORMAL

func _ready():
	_initial_amount = amount
	_fs = _sprites.frames.get_frame_count("default")

# Returns true if the cyst is empty, false otherwise
func extract() -> int:
	if _state == State.NORMAL:
		amount -= 1
		var value: float = (1.0 - (float(amount) / float(_initial_amount))) * float(_fs)
		print (value)
		_sprites.frame = clamp(value, 1, _fs - 2)
		if amount <= 0:
			print_debug("Empty!")
			_state = State.EMPTY
	return _sprites.frame

func clean() -> void:
	if _state == State.EMPTY:
		_sprites.frame = _fs - 1
		emit_signal("protuberance_cleaned")
		_state = State.CLEAN
