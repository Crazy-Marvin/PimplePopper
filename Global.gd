extends Node

const SAVE_PATH = 'user://player_data.json'

var type: String = "pimple" 
var bodypart: String = "cheek"
var level: String = "easy"

var _scenes = {
	"pimple": {
		"cheek": "res://bodyparts/pimple/cheek.tscn",
		"forehead": "res://bodyparts/pimple/forehead.tscn",
		"back": "res://bodyparts/pimple/back.tscn",
		"chest": "res://bodyparts/pimple/chest.tscn",
		"buttocks": "res://bodyparts/pimple/butt.tscn",
		"nose": "res://bodyparts/pimple/nose.tscn"
	},
	"blackhead": {
		"cheek": "res://bodyparts/blackhead/cheek.tscn",
		"forehead": "res://bodyparts/blackhead/forehead.tscn",
		"nose": "res://bodyparts/blackhead/nose.tscn",
		"shoulder": "res://bodyparts/blackhead/shoulder.tscn",
		"back": "res://bodyparts/blackhead/back.tscn",
		"ear": "res://bodyparts/blackhead/ear.tscn",
	},
	"cyst": {
		"forehead": "res://bodyparts/cyst/forehead.tscn",
		"wrist": "res://bodyparts/cyst/wrist.tscn",
		"back": "res://bodyparts/cyst/back.tscn",
		"shin": "res://bodyparts/cyst/shin.tscn"
	},
	"lipoma": {
		"back": "res://bodyparts/lipoma/back.tscn",
		"nose": "res://bodyparts/lipoma/nose.tscn"
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
		},
		{
			"name": "K_BACK_LEVEL_BUTTON",
			"code": "back"
		},
		{
			"name": "K_CHEST_LEVEL_BUTTON",
			"code": "chest"
		},
		{
			"name": "K_BUTTOCKS_BUTTON",
			"code": "buttocks"
		},
		{
			"name": "K_NOSE_BUTTON",
			"code": "nose"
		}
	],
	"blackhead": [
		{
			"name": "K_CHEEK_LEVEL_BUTTON",
			"code": "cheek"
		},
		{
			"name": "K_FOREHEAD_LEVEL_BUTTON",
			"code": "forehead"
		},
		{
			"name": "K_NOSE_BUTTON",
			"code": "nose"
		},
		{
			"name": "K_SHOULDER_BUTTON",
			"code": "shoulder"
		},
		{
			"name": "K_BACK_LEVEL_BUTTON",
			"code": "back"
		},
		{
			"name": "K_EAR_LEVEL_BUTTON",
			"code": "ear"
		},
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
		},
		{
			"name": "K_SHIN_BUTTON",
			"code": "shin"
		}
	],
	"lipoma": [
		{
			"name": "K_BACK_LEVEL_BUTTON",
			"code": "back"
		},
		{
			"name": "K_ARM_LEVEL_BUTTON",
			"code": "arm"
		}
	]
}

var _window_relation: Vector2
var _window_project_size: Vector2
var relative_screen_size_x: float

var player_data_orig = {}
var player_data: Dictionary = {
	'is_ad_active': false,
	'levels_completion': {
		'pimple':{
			'cheek': false,
			'back': false,
			'butt': false,
			'chest': false,
			'forehead': false,
			'nose': false,
		},
		'cyst':{
			'back': false,
			'forehead': false,
			'wrist': false,
			'shin': false,
		},
		'lipoma':{
			'back': false,
			'arm': false,
		},
		'blackhead':{
			'back': false,
			'cheek': false,
			'ear': false,
			'forehead': false,
			'nose': false,
			'shoulder': false,
		}
	},
	'day': 0,
	'month': 0,
	'day_streak':0,
	'month_streak':0
}

func _ready():
	player_data_orig = player_data.duplicate(true)
	
	var width: float = ProjectSettings.get_setting("display/window/size/width")
	var height: float = ProjectSettings.get_setting("display/window/size/height")
	_window_project_size = Vector2(width, height)
	_window_relation = Vector2(_window_project_size.x / OS.window_size.x,  _window_project_size.y / OS.window_size.y)
	var ry: float = OS.window_size.y / _window_project_size.y
	relative_screen_size_x = OS.window_size.x / ry
	
	var f = File.new()
	if f.file_exists(SAVE_PATH):
		load_game()
	else:
		save_game()
	
	f.close()
	
	check_time_achievements()


func get_relative_screen_size_x() -> float:
	return relative_screen_size_x

func get_window_relation() -> Vector2:
	return _window_relation

func get_window_project_size() -> Vector2:
	return _window_project_size

func get_level() -> Node2D:
	return load(_scenes[type][bodypart]).instance()

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
	if new_y < new_x:
		size = Vector2(new_y, new_y)
	else:
		size = Vector2(new_x, new_x)
	return size

func get_bodyparts(plevel: String) -> Array:
	return _levels[plevel]


func load_game():
	var f = File.new()
	f.open(SAVE_PATH, f.READ)
	player_data = parse_json(f.get_as_text())
	player_data.merge(player_data_orig)
	f.close()


func save_game():
	var f = File.new()
	f.open(SAVE_PATH, f.WRITE)
	f.store_string(JSON.print(player_data))
	f.close()


func _notification(what):
	if what == NOTIFICATION_WM_FOCUS_OUT or what == NOTIFICATION_APP_PAUSED:
		save_game()


func check_time_achievements():
	var time = Time.get_datetime_dict_from_system()
	
	var current_total_days = (time['month'] * 30) + time['day']
	
	if player_data['day'] == 0 and player_data['month'] == 0:
		player_data['day'] = current_total_days
	else:
		pass
	
	if player_data['day'] == player_data['day'] - 1:
		player_data['day_streak'] += 1
		
		if player_data['day_streak'] == 14:
			ManagerPlayGames.playgames.achievementsUnlock('CgkI5ILm9-4PEAIQBg', true)
		if player_data['day_streak'] == 30:
			ManagerPlayGames.playgames.achievementsUnlock('CgkI5ILm9-4PEAIQBw', true)
	else:
		player_data['day_streak'] = 0
	
	player_data['day'] = current_total_days
