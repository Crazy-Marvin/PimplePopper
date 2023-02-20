extends Node

const DEBUG_LANGUAGE_PATH: String = "res://data/language.txt"
const RELEASE_LANGUAGE_PATH: String = "user://language.txt"

var _data: Dictionary
var _language_path: String

func _ready():
	if OS.has_feature("editor"):
		print("Running on editor")
		_language_path = RELEASE_LANGUAGE_PATH
	else:
		_language_path = RELEASE_LANGUAGE_PATH
	load_data()


func load_data() -> void:
	TranslationServer.set_locale(get_language())


func save_language(lang: String) -> void:
	var f: File = File.new()
	if f.open(_language_path, File.WRITE) == OK:
		f.store_string(lang)
		f.close()

func get_language() -> String:
	var f: File = File.new()
	if f.open(_language_path, File.READ) == OK:
		var t: String = f.get_as_text()
		f.close()
		return t
	
	return "de"
