extends Node2D


onready var _space: Physics2DDirectSpaceState = get_world_2d().direct_space_state
onready var _sfx: AudioStreamPlayer2D = $hint_sfx


func _ready():
	pass # Replace with function body.


func _input(event):
	if event is InputEventScreenTouch:
		pass
	elif event is InputEventScreenDrag:
		var collisions: Array = _space.intersect_point(event.position, 1, [], 3, false, true)
		if collisions.size() != 0:
			var collider = collisions[0]["collider"]
			if collider is Lipoma:
				if collider.apply_anaesthetic():
					_sfx.play()

func disable() -> void:
	set_process_input(false)
	visible = false

func enable() -> void:
	set_process_input(true)
	visible = true
