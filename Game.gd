extends Node

onready var _animation = $AnimationPlayer
onready var _finish_popup = $CanvasLayer/finish_game_popup

export(bool) var hint_hided: bool = true
var _hints: Array

# Called when the node enters the scene tree for the first time.
func _ready():
	var nodes = get_tree().get_nodes_in_group("bodypart")
	for bp in nodes:
		bp.connect("bodypart_cleaned", self, "_on_bodypart_cleaned")
	_animation.play("fade_out")
	
	_hints = get_tree().get_nodes_in_group("hint")
	hide_hints(hint_hided)

func hide_hints(hided: bool) -> void:
	for h in _hints:
		h.visible = not hided

func _on_bodypart_cleaned() -> void:
#	$timer.start()
	_finish_popup.start()


func _on_hand_pressed():
	$tools.enable_hand()


func _on_handkerchief_pressed():
	$tools.enable_handkerchief()


func _on_timeout() -> void:
	get_tree().change_scene("res://menu/main_screen.tscn")


func _on_vapor_pressed():
	$tools.enable_vapor()


func _on_comedone_extraction_tool_pressed():
	$tools.enable_comedone_extraction_tool()


func _on_needle_pressed():
	$tools.enable_needle()


func _on_anesthetic_pressed():
	$tools.enable_anesthetic()


func _on_suture_pressed():
	$tools.enable_suture()


func _on_cutter_pressed():
	$tools.enable_cutter()


func _on_back_pressed():
	_animation.play("fade_in")


func _on_animation_finished(anim: String) -> void:
	if anim == "fade_in":
		var error: int = get_tree().change_scene("res://menu/main_screen.tscn")
		if error != OK:
			print_debug("Error loading main screen. Code: ", error)


func _on_hint_pressed():
	hint_hided = not hint_hided
	hide_hints(hint_hided)


func _on_anim_finished(finish_type):
	if finish_type == _finish_popup.finish_type.WIN:
		get_tree().change_scene("res://menu/main_screen.tscn")
