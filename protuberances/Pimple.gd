class_name Pimple extends Area2D

signal protuberance_cleaned

enum State {
	NORMAL,
	PRESSURE,
	POP,
	CLEAN
}

onready var _hint = $circle_hint

export(State) var state = State.NORMAL
export(float) var max_pressure: float = 100.0



func _ready():
	_hint.set_color(_hint.white)
	$normal.visible = true
	$pressure.visible = false
	$popped.visible = false



func apply_pressure(pressure: float) -> bool:
	if state == State.NORMAL:
		$normal.visible = false
		$pressure.visible = true
		if pressure > max_pressure:
			_hint.set_color(_hint.red)
			state = State.POP
			$pressure.visible = false
			$popped.visible = true
			return true
	return false



func clean() -> void:
	if state == State.POP:
		state = State.CLEAN
		_hint.set_color(_hint.green)
		$popped.visible = false
		$shape.disabled = true
		collision_layer = 0
		emit_signal("protuberance_cleaned")


func is_clean() -> bool:
	return state == State.CLEAN


