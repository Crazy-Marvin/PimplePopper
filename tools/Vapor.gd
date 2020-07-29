extends Area2D


onready var particles: Particles2D = $particles
var _space: Physics2DDirectSpaceState
var _protuberances: Array = []

func _ready():
	collision_layer = 0
	collision_mask = 0
	set_process_input(false)
	_space = get_world_2d().direct_space_state

func _process(delta):
	for p in _protuberances:
		p.apply_vapor()

func _input(event):
	if event is InputEventScreenTouch:
		if event.pressed:
			particles.emitting = true
			collision_layer = 1
			collision_mask = 1
		else:
			particles.emitting = false
			collision_layer = 0
			collision_mask = 0
	if event is InputEventScreenDrag:
		position = event.position


func _on_area_entered(area):
	print_debug ("Body entered")
	if area.get_parent() is Blackhead:
		print_debug ("ON blackhead")
		_protuberances.append(area.get_parent())

func _on_area_exited(area):
	if area.get_parent() is Blackhead:
		_protuberances.erase(area.get_parent())
