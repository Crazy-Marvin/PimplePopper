extends Node2D

# Called when the node enters the scene tree for the first time.
func _ready():
	var nodes = get_tree().get_nodes_in_group("bodypart")
	for bp in nodes:
		bp.connect("bodypart_cleaned", self, "_on_bodypart_cleaned")


func _on_bodypart_cleaned() -> void:
	$timer.start()


func _on_hand_pressed():
	$tools.enable_hand()


func _on_handkerchief_pressed():
	$tools.enable_handkerchief()


func _on_timeout() -> void:
	get_tree().change_scene("res://main_screen.tscn")


func _on_vapor_pressed():
	$tools.enable_vapor()


func _on_comedone_extraction_tool_pressed():
	$tools.enable_comedone_extraction_tool()


func _on_needle_pressed():
	$tools.enable_needle()
