extends Control
class_name HScroll

const level_resource = preload("res://menu/level.tscn")

onready var main = get_parent()
onready var _hbox = $hbox

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
	print(Global.get_relative_screen_size_x())
	_add_levels(levels)

func _get_level_size() -> Vector2:
	var relation: Vector2 = Global.get_window_relation()
	var w: float = OS.window_size.x * relation.x
	var h: float = OS.window_size.y * relation.y
	var size: Vector2 = Vector2(w, h)
	return size

func add_levels(ls: Array) -> void:
	_add_levels(ls)

func _add_levels(ls: Array) -> void:
	for l in ls:
		var li: Level = level_resource.instance()
		li.connect("button_pressed", self, "_on_selected_level", [li])
		li.code = l["code"]
		li.set_text(tr(l["name"]))
#		li.rect_min_size = _get_level_size()
		_hbox.add_child(li)
	_hbox.rect_min_size.x = _hbox.get_child_count() * Global.get_relative_screen_size_x()
	_hbox.rect_size = Vector2.ZERO

func remove_levels() -> void:
	for child in _hbox.get_children():
		_hbox.remove_child(child)
		child.queue_free()
		_reset()

func _reset() -> void:
	level = 0
	_hbox.rect_position.x = 0

func get_size() -> Vector2:
	return _hbox.rect_size

func _process(delta):
	var np: float = direction.x * delta * speed
	_hbox.rect_position.x += np
	# 30.0 is a  magic number because i need a "error margin" when
	# the levels are sliding. I do not declare it as a exportable variable
	# because i think i can find a better way to do it.
	if abs(_hbox.rect_position.x - new_position.x) < 30.0:
		_hbox.rect_position = new_position
		set_process(false)
		set_process_input(true)

func set_enabled(e: bool) -> void:
	_enabled = e

func _input(event):
	if event is InputEventScreenTouch and _enabled:
		if event.pressed:
			slide = true
			old_position = event.position
			begin_position = old_position
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
			_hbox.rect_position.x += diff
			old_position = event.position

func change_level(distance: float) -> void:
	set_process_input(false)
	if abs(distance) > min_distance:
		if distance < 0:
			if level + 1 < _hbox.get_child_count():
				level += 1
		else:
			if level - 1 >= 0:
				level -= 1
	new_position.x = Global.get_relative_screen_size_x() * -level
	speed = abs(new_position.x - _hbox.rect_position.x) / time
	direction = (new_position - _hbox.rect_position).normalized()
	set_process(true)

func _on_selected_level(level: Level) -> void:
	if not slide_state:
		emit_signal("selected_level", level.code)

func get_levels() -> Array:
	return _hbox.get_children()


