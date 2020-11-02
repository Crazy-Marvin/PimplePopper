extends Node

# Pimple resources
const _pimple_cheek_resource = preload("res://bodyparts/pimple/cheek.tscn")
const _pimple_forehead_resource = preload("res://bodyparts/pimple/forehead.tscn")

# Blackhead resources
const _blackhead_forehead_resource = preload("res://bodyparts/blackhead/forehead.tscn")

# Cyst resources.
const _cyst_forehead_resource = preload("res://bodyparts/cyst/forehead.tscn")
const _cyst_wrist_resource = preload("res://bodyparts/cyst/wrist.tscn")
const _cyst_back_resource = preload("res://bodyparts/cyst/back.tscn")

# Lipoma resources
const _lipoma_back_resource = preload("res://bodyparts/lipoma/back.tscn")

var type: String = "pimple" 
var bodypart: String = "cheek"
var level: String = "easy"

var _scenes = {
	"pimple": {
		"cheek": _pimple_cheek_resource,
		"forehead": _pimple_forehead_resource
	},
	"blackhead": {
		"forehead": _blackhead_forehead_resource
	},
	"cyst": {
		"forehead": _cyst_forehead_resource,
		"wrist": _cyst_wrist_resource,
		"back": _cyst_back_resource
	},
	"lipoma": {
		"back": _lipoma_back_resource
	}
}

var _levels: Dictionary = {
	"pimple": [
		{
			"name": "K_CHEEK_LEVEL_BUTTON",
			"code": "cheek"
		},
		{
			"name": "K_FOREHEAD_LEVEL_BUTTON",
			"code": "forehead"
		}
	],
	"blackhead": [
		{
			"name": "K_FOREHEAD_LEVEL_BUTTON",
			"code": "forehead"
		}
	],
	"cyst": [
		{
			"name": "K_FOREHEAD_LEVEL_BUTTON",
			"code": "forehead"
		},
		{
			"name": "K_WRIST_LEVEL_BUTTON",
			"code": "wrist"
		},
		{
			"name": "K_BACK_LEVEL_BUTTON",
			"code": "back"
		}
	],
	"lipoma": [
		{
			"name": "K_BACK_LEVEL_BUTTON",
			"code": "back"
		}
	]
}

var _window_relation: Vector2
var _window_project_size: Vector2
var relative_screen_size_x: float

func _ready():
	var width: float = ProjectSettings.get_setting("display/window/size/width")
	var height: float = ProjectSettings.get_setting("display/window/size/height")
	_window_project_size = Vector2(width, height)
	_window_relation = Vector2(_window_project_size.x / OS.window_size.x,  _window_project_size.y / OS.window_size.y)
	var ry: float = OS.window_size.y / _window_project_size.y
	relative_screen_size_x = OS.window_size.x / ry


func get_relative_screen_size_x() -> float:
	return relative_screen_size_x

func get_window_relation() -> Vector2:
	return _window_relation

func get_window_project_size() -> Vector2:
	return _window_project_size

func get_level() -> Node2D:
	return _scenes[type][bodypart].instance()

func is_protuberance_type_available (t: String) -> bool:
	return _levels[t] != null

func is_level_available(bp: String) -> bool:
	var ls = _levels[type]
	for l in ls:
		if l["code"] == bp:
			return true
	return false

func get_bodypart_scale(sprite_size: Vector2) -> Vector2:
	var new_x: float = OS.window_size.x / sprite_size.x
	var new_y: float = OS.window_size.y / sprite_size.y
	var size: Vector2
	if new_y > new_x:
		size = Vector2(new_y, new_y)
	else:
		size = Vector2(new_x, new_x)
	return size

func get_bodyparts(level: String) -> Array:
	return _levels[level]
