extends Area2D


onready var particles: Particles2D = $particles
onready var _hint_sfx: AudioStreamPlayer2D = $hint_sfx

var _space: Physics2DDirectSpaceState
var _protuberances: Array = []
var _ui: UI

func _ready():
	collision_layer = 0
	collision_mask = 0
	set_process_input(false)
	_space = get_world_2d().direct_space_state
	_ui = get_tree().get_nodes_in_group("ui")[0]

func _process(delta):
	if _protuberances.size() != 0:
		Input.vibrate_handheld(50)
	
	for p in _protuberances:
		print("Applying vapor...")
		if p.apply_vapor():
			print ("Ready!")
			_hint_sfx.play()
			_protuberances.erase(p)

func _input(event):
	if _ui.is_inside_container(event.position):
		return
	
	if event is InputEventScreenTouch:
		if event.pressed:
			particles.emitting = true
			collision_layer = 1
			collision_mask = 1
			position = event.position
		else:
			particles.emitting = false
			collision_layer = 0
			collision_mask = 0
			position = Vector2(-1000, -1000)
	if event is InputEventScreenDrag:
		position = event.position


func _on_area_entered(area):
	var bh = area
	if bh is Blackhead:
		if not bh.is_open():
			_protuberances.append(bh)

func _on_area_exited(area):
	var bh = area
	if bh is Blackhead:
		if _protuberances.has(bh):
			_protuberances.erase(bh)

func disable() -> void:
	set_process_input(false)
	visible = false

func enable() -> void:
	set_process_input(true)
	visible = true
