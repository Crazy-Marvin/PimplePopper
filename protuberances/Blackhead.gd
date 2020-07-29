extends Node2D
class_name Blackhead

signal protuberance_cleaned

enum State {
	CLOSED,
	OPEN,
	REMOVED,
	CLEAN,
}

export(float) var vapor_tolerance_time: float = 5.0

var _time: float = 0.0
var _state = State.CLOSED
var _fs: int

# Called when the node enters the scene tree for the first time.
func _ready():
	_fs = $sprites.frames.get_frame_count("default")
	print (name, _fs)
	pass # Replace with function body.

func apply_vapor() -> void:
	if _state == State.CLOSED:
		_time += get_process_delta_time()
		if _time >= vapor_tolerance_time:
			$sprites.frame = 1
			print_debug("Ready to remove")
			_state = State.OPEN

func remove(delta: float) -> void:
	if _state == State.OPEN:
		var f: int = clamp(delta * _fs, 1, _fs - 1)
		$sprites.frame = f
		if _state == State.OPEN and f == _fs - 1:
			print ("Ready to clean")
			_state = State.REMOVED

func clean() -> void:
	if _state == State.REMOVED:
		$sprites.visible = false
		print ("Blackhead removed")
		emit_signal("protuberance_cleaned")
		_state = State.CLEAN
