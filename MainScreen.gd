extends Control

signal bodypart_selected

onready var _main_screen: Control = $main_screen
onready var _bodypart_screen: Control = $level_screen/bodypart_level_screen
onready var _bodypart_hscroll: Control = $level_screen/bodypart_level_screen/hscroll
onready var _difficulty_screen: Control = $level_screen/difficulty_screen
onready var _difficulty_hscroll: Control = $level_screen/difficulty_screen/hscroll
onready var _animation: AnimationPlayer = $animation


var _bodypart: String
var _level: String


# Called when the node enters the scene tree for the first time.
func _ready():
	_main_screen.rect_position = Vector2(0, -OS.window_size.y - 100)
	_animation.play("intro")
#	_difficulty_hscroll.set_process_input(false)
#	_bodypart_hscroll.set_process_input(false)
	_difficulty_hscroll.set_enabled(false)
	_bodypart_hscroll.set_enabled(false)
	
	var bodypart_hscroll = _bodypart_screen.get_node("hscroll")
	bodypart_hscroll.connect("selected_level", self, "_on_bodypart_selected")
	var difficulty_hscroll = _difficulty_screen.get_node("hscroll")
	difficulty_hscroll.connect("selected_level", self, "_on_difficulty_selected")


func _on_difficulty_selected(level: String) -> void:
	if not _animation.is_playing():
		print(level)
		Global.level = level
		if Global.is_bodypart_available():
			_animation.play("fade_in")

func _on_bodypart_selected(bodypart: String) -> void:
	if not _animation.is_playing():
		print (bodypart)
		Global.bodypart = bodypart
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
