extends Node

const _cheek_easy_resource = preload("res://bodyparts/easy/cheek.tscn")
const _wrist_hard_resource = preload("res://bodyparts/hard/wrist.tscn")

var bodypart: String = "cheek"
var level: String = "easy"

var _scenes: Dictionary = {
	"forehead": {
		"easy": load("res://bodyparts/easy/forehead.tscn"),
		"normal": load("res://bodyparts/normal/forehead.tscn"),
		"hard": null,
		"super-hard": null
	},
	"cheek": {
		"easy": _cheek_easy_resource,
		"normal": null,
		"hard": null,
		"super-hard": null
	},
	"wrist": {
		"easy": null,
		"normal": null,
		"hard": load("res://bodyparts/hard/wrist.tscn"),
		"super-hard": null,
	},
	"back": {
		"easy": null,
		"normal": null,
		"hard": null,
		"super-hard": load("res://bodyparts/super-hard/back.tscn")
	}
}

# Returns a scene depending on the configuration of bodypart and level variables
func get_bodypart() -> Node2D:
	return _scenes[bodypart][level].instance()

func is_bodypart_available() -> bool:
	return _scenes[bodypart][level] != null
