extends Node2D

var finger_position: Vector2
var space_state: Physics2DDirectSpaceState
var _ui

# Called when the node enters the scene tree for the first time.
func _ready():
	visible = false
	space_state = get_world_2d().direct_space_state
	_ui = get_tree().get_nodes_in_group("ui")[0]

func _input(event):
	if _ui.is_inside_container(event.position):
		return
	if event is InputEventScreenTouch:
		if event.pressed:
			visible = true
			finger_position = event.position
		else:
			visible = false
	if event is InputEventScreenDrag:
		finger_position = event.position
		var points: Array = space_state.intersect_point(event.position, 1, [], 0x7FFFFFFF, false, true)
		for point in points:
			var collider = point.collider
#			print (collider)
			# IMPORTANT: Simplify this.
			if collider is Pimple: 
				collider.clean()
			elif collider is Blackhead:
				collider.clean()
			elif collider is Cyst:
				collider.clean()
			elif collider is Lipoma:
				collider.clean()
			elif collider is PimpleNew:
				collider.clean()
	update()

func _draw():
	draw_circle(finger_position, 5, Color(1, 1, 1, 1))

func disable() -> void:
	set_process_input(false)
	visible = false

func enable() -> void:
	set_process_input(true)
	visible = true
