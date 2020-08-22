extends Control
class_name HScroll

const level_resource = preload("res://menu/level.tscn")

onready var main = get_parent()

signal selected_level()

export(Array) var levels: Array = []
export(float) var min_distance: float = 60.0
export(float) var time: float = 0.5
export(float) var min_diff_movement: float = 10.0 

var speed: float = 2.0
var level: int = 0
var slide: bool = false
var old_position: Vector2
var begin_position: Vector2
var direction: Vector2
var new_position: Vector2
var diff_movement: float
var slide_state: bool = false
var _enabled: bool = true


func _ready():
	set_process(false)
	for n in range(levels.size()):
		var level_instance: Level = level_resource.instance()
		level_instance.connect("button_pressed", self, "_on_selected_level", [level_instance])
		level_instance.info = levels[n]
		level_instance.set_text(levels[n])
		level_instance.number = n
		level_instance.rect_min_size = Vector2(1024, 600)
		$hbox.add_child(level_instance)

func _process(delta):
	var np: float = direction.x * delta * speed
	$hbox.rect_position.x += np
	# 20.0 is a  magic number because i need a "error margin" when
	# the levels are sliding. I do not declare it as a exportable variable
	# because i think i can find a better way to do it.
	if abs($hbox.rect_position.x - new_position.x) < 30.0:
		$hbox.rect_position = new_position
		set_process(false)
		set_process_input(true)


func _on_gui_input(event):
#	print ("On GUI")
#	if event is InputEventScreenTouch:
#		if event.pressed:
#			slide = true
#			old_position = event.position
#			begin_position = old_position
#			print ("Slide" + str(slide))
#		else:
#			slide = false
#			diff_movement = old_position.x - begin_position.x
#			if abs(diff_movement) > min_diff_movement:
#				slide_state = true
#			else:
#				slide_state = false
#			change_level(diff_movement)
#	elif slide and event is InputEventScreenDrag:
#		if event.index == 0:
#			var diff: float = event.position.x - old_position.x
#			$hbox.rect_position.x += diff
#			old_position = event.position
	pass # Replace with function body.

func set_enabled(e: bool) -> void:
	_enabled = e

func _input(event):
	if event is InputEventScreenTouch and _enabled:
		if event.pressed:
			slide = true
			old_position = event.position
			begin_position = old_position
#			print ("Slide" + str(slide))
		else:
			slide = false
			diff_movement = old_position.x - begin_position.x
			if abs(diff_movement) > min_diff_movement:
				slide_state = true
			else:
				slide_state = false
			change_level(diff_movement)
	elif slide and event is InputEventScreenDrag:
		if event.index == 0:
			var diff: float = event.position.x - old_position.x
			$hbox.rect_position.x += diff
			old_position = event.position
	pass

func change_level(distance: float) -> void:
	set_process_input(false)
	if abs(distance) > min_distance:
		if distance < 0:
			if level + 1 < levels.size():
				level += 1
		else:
			if level - 1 >= 0:
				level -= 1
	new_position.x = 1024 * -level
	speed = abs(new_position.x - $hbox.rect_position.x) / time
	direction = (new_position - $hbox.rect_position).normalized()
	set_process(true)

func _on_selected_level(level: Level) -> void:
	if not slide_state:
		emit_signal("selected_level", level.info)

func get_levels() -> Array:
	return $hbox.get_children()


