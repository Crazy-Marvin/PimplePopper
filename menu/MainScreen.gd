extends Control

signal bodypart_selected

onready var _main_screen: Control = $main_screen
onready var _bodypart_screen: Control = $level_screen/bodypart_level_screen
onready var _bodypart_hscroll: Control = $level_screen/bodypart_level_screen/hscroll
onready var _difficulty_screen: Control = $level_screen/difficulty_screen
onready var _difficulty_hscroll: Control = $level_screen/difficulty_screen/hscroll
onready var _animation: AnimationPlayer = $animation
onready var _popup: PopupDialog = $popup
onready var _no_game_popup: PopupPanel = $no_game_popup


var _bodypart: String
var _level: String


func _ready():
	_config_menu()

func _config_menu() -> void:
	_main_screen.rect_position = Vector2(0, -OS.window_size.y - 100)
	_animation.play("intro")
	_difficulty_hscroll.set_enabled(false)
	_bodypart_hscroll.set_enabled(false)
	
	var bodypart_hscroll = _bodypart_screen.get_node("hscroll")
	bodypart_hscroll.connect("selected_level", self, "_on_bodypart_selected")
	var difficulty_hscroll = _difficulty_screen.get_node("hscroll")
	difficulty_hscroll.connect("selected_level", self, "_on_difficulty_selected")

func _cast_string(s: String) -> String:
	return s.replace(" ", "-")

func _on_difficulty_selected(level: String) -> void:
	if not _animation.is_playing():
		print(level)
		Global.level = _cast_string(level)
		if Global.is_bodypart_available():
			_animation.play("fade_in")
		else:
			_no_game_popup.popup_centered()

func _on_bodypart_selected(bodypart: String) -> void:
	if not _animation.is_playing():
		print (bodypart)
		Global.bodypart = _cast_string(bodypart)
		_animation.play("to_difficulty")
		_bodypart_hscroll.set_enabled(false)
		_difficulty_hscroll.set_enabled(true)

func _on_play_pressed() -> void:
	if not _animation.is_playing():
		_animation.play("to_bodypart")
#		_bodypart_hscroll.set_process_input(true)
		_bodypart_hscroll.set_enabled(true)

func _on_animation_finished(anim_name):
	if anim_name == "fade_in":
		get_tree().change_scene("res://game.tscn")


func _on_back_to_main_pressed():
	if not _animation.is_playing():
		_bodypart_hscroll.set_enabled(false)
		_animation.play("back_to_main")


func _on_back_to_bodypart_pressed():
	if not _animation.is_playing():
		_bodypart_hscroll.set_enabled(true)
		_difficulty_hscroll.set_enabled(false)
		_animation.play("back_to_bodypart")


func _on_about_back_pressed():
	if not _animation.is_playing():
		_animation.play("about_to_main")


func _on_about_pressed():
	print ("About pressed")
	if not _animation.is_playing():
		_animation.play("to_about")


func _on_mailto_pressed():
	print("Open mail")
	OS.shell_open("mailto:marvin@poopjournal.rocks")


func _on_issue_pressed():
	OS.shell_open("https://github.com/Crazy-Marvin/PimplePopper/issues")
	pass # Replace with function body.


func _on_tutorial_pressed():
	_popup.popup()


func _on_link_pressed(link):
	OS.shell_open(link)
	pass # Replace with function body.


func _on_options_pressed():
	Input.vibrate_handheld(50)
