extends Control

signal bodypart_selected
var _bodypart: String
var _level: String

# Called when the node enters the scene tree for the first time.
func _ready():
	$bodypart_level_screen/hscroll.connect("selected_level", self, "_on_bodypart_selected")
	$level_screen2/hscroll.connect("selected_level", self, "_on_difficulty_selected")


func _on_difficulty_selected(level: String) -> void:
	print(level)
	Global.level = level
	get_tree().change_scene("res://game.tscn")

func _on_bodypart_selected(bodypart: String) -> void:
	print (bodypart)
	Global.bodypart = bodypart
	_to_screen($bodypart_level_screen, $level_screen2)

func _on_play_pressed() -> void:
	_to_screen($main_screen, $bodypart_level_screen)

func _to_screen(from: Control, to: Control) -> void:
	from.rect_position = Vector2(-10000, -10000)
	to.rect_position = Vector2.ZERO
