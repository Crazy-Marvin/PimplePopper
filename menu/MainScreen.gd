extends Control

signal bodypart_selected

onready var _main_screen: Control = $main_screen
onready var _bodypart_screen: Control = $bodypart_level_screen
onready var _bodypart_hscroll: Control = $bodypart_level_screen/hscroll
onready var _protuberance_type_screen: Control = $protuberance_type_screen
onready var _protuberance_type_hscroll: Control = $protuberance_type_screen/hscroll
onready var _animation: AnimationPlayer = $animation
onready var _popup: PopupDialog = $popup
onready var _no_game_popup: PopupPanel = $no_game_popup
onready var _about_text = $about_screen/center_content/scroll/content/RichTextLabel
onready var _protuberance_tutorial = $tutorial_screen/protuberance_explanation
onready var _background: TextureRect = $background


var _bodypart: String
var _level: String


func _ready():
	_config_menu()

func _config_menu() -> void:
	_main_screen.rect_position = Vector2(0, -OS.window_size.y - 100)
	_protuberance_type_hscroll.set_enabled(false)
	_bodypart_hscroll.set_enabled(false)
	_about_text.bbcode_text = tr("K_ABOUT_TEXT")
	
	var bodypart_hscroll = _bodypart_screen.get_node("hscroll")
	bodypart_hscroll.connect("selected_level", self, "_on_bodypart_selected")
	var protuberance_type_hscroll = _protuberance_type_screen.get_node("hscroll")
	protuberance_type_hscroll.connect("selected_level", self, "_on_protuberance_type_selected")

func _fit_sizes() -> void:
	_background.rect_position = Vector2.ZERO
	var bsize: Vector2 = _background.texture.get_size()
	var ssize: Vector2 = OS.window_size
	_background.rect_size = bsize
	
	var x: float = bsize.x / ssize.x
	var y: float = bsize.y / ssize.y
	var new_scale: Vector2 = Vector2(1, 1)
	if x < y:
		new_scale.x = 1.0 / x
		new_scale.y = 1.0 / x
	else:
		new_scale.x = 1.0 / y
		new_scale.y = 1.0 / y
	_background.rect_scale = new_scale
	
	# Aligning title
	var game_title = $main_screen/title_container
	game_title.rect_min_size.x = OS.window_size.x / game_title.rect_scale.x
	
	# Aligning menu bottons
	var menu_bottons = $main_screen/CenterContainer
	var menu_bottoms_position: Vector2 = menu_bottons.rect_position
	menu_bottoms_position.x = 0
	menu_bottoms_position.y = OS.window_size.y - menu_bottons.rect_size.y
	menu_bottons.rect_min_size.x = OS.window_size.x
	
	var _bodypart_title = $level_screen/bodypart_level_screen/title
	_bodypart_title.rect_min_size.x = OS.window_size.x
	
	var protuberance_type_title = $level_screen/protuberance_type_screen/title
	protuberance_type_title.rect_min_size.x = OS.window_size.x
	
	var about_title = $about_screen/title
	about_title.rect_min_size.x = OS.window_size.x
	
	var about_center = $about_screen/center_content
	about_center.rect_min_size.x = OS.window_size.x
	
	var about_text_background = $about_screen/CenterContainer/content_background
	about_text_background.rect_min_size.x = OS.window_size.x
	
	var about_text_content = $about_screen/center_content
	about_text_content.rect_min_size.x = OS.window_size.x


func _on_protuberance_type_selected(level: String) -> void:
	if not _animation.is_playing():
		_generate_bodyparts(level)
#		print ("protuberance_type: ", level)
		Global.type = level
		_animation.play("protuberance_type_to_bodypart")
		_protuberance_type_hscroll.set_enabled(false)
		_bodypart_hscroll.set_enabled(true)
		

#
# Clean the hbox in bodyparts screen and generate a new set of levels
#
func _generate_bodyparts(level: String) -> void:
	_bodypart_hscroll.remove_levels()
	
	var levels = Global.get_bodyparts(level)
	_bodypart_hscroll.add_levels(levels)
	

func _on_bodypart_selected(bp: String) -> void:
	if not _animation.is_playing():
		print ("bodypart selected: ", bp)
		Global.bodypart = bp
		_animation.play("fade_in")

func _on_play_pressed() -> void:
	if not _animation.is_playing():
		_animation.play("intro_to_protuberance_type")
		_protuberance_type_hscroll.set_enabled(true)

func _on_animation_finished(anim_name):
	if anim_name == "fade_in":
		get_tree().change_scene("res://game.tscn")


func _on_back_to_main_pressed():
	if not _animation.is_playing():
		_bodypart_hscroll.set_enabled(false)
		_animation.play("protuberance_type_to_main")


func _on_back_to_protuberance_type_pressed():
	if not _animation.is_playing():
		_bodypart_hscroll.set_enabled(false)
		_protuberance_type_hscroll.set_enabled(true)
		_animation.play("bodypart_to_protuberance_type")


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


func _on_tutorial_pressed():
	if not _animation.is_playing():
		_animation.play("intro_to_tutorial")


func _on_link_pressed(link):
	OS.shell_open(link)

func _on_options_pressed():
	Input.vibrate_handheld(50)

func _on_meta_clicked(meta):
	OS.shell_open(meta)

func _on_pimple_tutorial_pressed():
	_protuberance_tutorial.set_pimple_tutorial()
	_animation.play("to_tutorial")


func _on_blackhead_tutorial_pressed():
	_protuberance_tutorial.set_blackhead_tutorial()
	_animation.play("to_tutorial")


func _on_cyst_tutorial_pressed():
	_protuberance_tutorial.set_cyst_tutorial()
	_animation.play("to_tutorial")


func _on_lipoma_tutorial_pressed():
	_protuberance_tutorial.set_lipoma_tutorial()
	_animation.play("to_tutorial")


func _on_back_protuberance_tutorial_pressed():
	if not _animation.is_playing():
		_animation.play("tutorial_to_protuberances")


func _on_back_to_intro_pressed():
	if not _animation.is_playing():
		_animation.play("tutorial_screen_to_intro")
