extends Node

onready var _animation = $AnimationPlayer
onready var _finish_popup = $finish_game_popup

# shows what tools can be used with each body part.
export(Dictionary) var tools_per_type:Dictionary

export(bool) var hint_hided: bool = true
export(ButtonGroup) var _buttons: ButtonGroup
var _hints: Array

# Called when the node enters the scene tree for the first time.
func _ready():
	var nodes = get_tree().get_nodes_in_group("bodypart")
	for bp in nodes:
		bp.connect("bodypart_cleaned", self, "_on_bodypart_cleaned")
	_animation.play("fade_out")
	
	_hints = get_tree().get_nodes_in_group("hint")
	hide_hints(hint_hided)
#	yield(get_tree(), "idle_frame")
	_disable_buttons(true)
	
	for b in _buttons.get_buttons():
		if b.get_parent()!=$UI/scroll/tools:
			continue
		b.visible = tools_per_type[Global.type].has(b.name)
	
	Yodo.load_interstitial_ads()

func hide_hints(hided: bool) -> void:
	for h in _hints:
		h.visible = not hided

func _on_bodypart_cleaned() -> void:
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


func _disable_buttons(b: bool) -> void:
	for bt in _buttons.get_buttons():
		bt.disabled = b


func _on_back_pressed():
	_disable_buttons(true)
	_animation.play("fade_in")


func _on_animation_finished(anim: String) -> void:
	if anim == "fade_in":
		var error: int = get_tree().change_scene("res://menu/new_main_screen.tscn")
		if error != OK:
			print_debug("Error loading main screen. Code: ", error)
	elif anim == "fade_out":
		_disable_buttons(false)


func _on_hint_pressed():
	hint_hided = not hint_hided
	hide_hints(hint_hided)


func _on_anim_finished(finish_type):
	if finish_type == _finish_popup.finish_type.WIN:
		Yodo.show_interstitial_ad()
		yield(Yodo, "interstitial_ad_closed")
		get_tree().change_scene("res://menu/main_screen.tscn")

func _input(event):
	if event is InputEventScreenTouch:
		print ("_input game")

func _on_scroll_gui_input(event):
	if event is InputEventScreenTouch:
		print ("_gui_event scroll...")
	pass # Replace with function body.
