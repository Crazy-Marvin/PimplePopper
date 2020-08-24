extends Area2D
class_name Pimple

signal protuberance_cleaned

enum State {
	NORMAL,
	PRESSURE,
	POP,
	CLEAN
}

export(State) var state = State.NORMAL
export(float) var max_pressure: float = 100.0

func _ready():
	$normal.visible = true
	$pressure.visible = false
	$popped.visible = false

func apply_pressure(pressure: float):
	if state == State.NORMAL:
		print("Applying pressure: %d" % [pressure])
		$normal.visible = false
		$pressure.visible = true
		if pressure > max_pressure:
			state = State.POP
			$pressure.visible = false
			$popped.visible = true
			


func clean() -> void:
	if state == State.POP:
		state = State.CLEAN
		$popped.visible = false
		$shape.disabled = true
		print ("Cleaned...")
		emit_signal("protuberance_cleaned")
