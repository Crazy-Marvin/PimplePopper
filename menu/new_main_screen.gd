extends Control


onready var yodo1mas = $Yodo1Mas
onready var debug_out = $CanvasLayer/Orange/DebugOut
var orig_main_panel_pos
var selection_panel_destination_pos

var is_on_second_selection: bool = false

var langs = [
	['es', 'K_SPANISH_SELECTION'],
	['en', 'K_ENGLISH_SELECTION'],
	['de', 'K_GERMAN_SELECTION'],
	['zh_CN', 'K_CN_SIMPLIFIED_SELECTION'],
	['zh_TW', 'K_CN_TRAD_SELECTION'],
	['ru', 'K_RUSSIAN_SELECTION'],
	['sr', 'K_SERBIAN_SELECTION'],
	['it', 'K_ITALIAN_SELECTION'],
	['pt_BR', 'K_PR_SELECTION'],
	['fr', 'K_FRENCH_SELECTION'],
]


onready var tutorial = $protuberance_explanation
onready var lang_options = $SettingsPanel/VBoxContainer/LangOptions


func _ready():
	yodo1mas.init()
	#yodo1mas.connect("banner_ad_loaded", self, 'on_banner_ad_loaded')
	
	if Global.player_data['is_add_active'] == false:
		yodo1mas.load_banner_ad("Banner","RIGHT","TOP")
		yodo1mas.load_interstitial_ads()
		#yodo1mas.show_banner_ad()
	
	orig_main_panel_pos = $Panel.rect_global_position
	
	$LevelSelectionPanel.rect_pivot_offset = $LevelSelectionPanel.rect_size / 2
	$TutorialPanel.rect_pivot_offset = $TutorialPanel.rect_size / 2
	$SettingsPanel.rect_pivot_offset = $SettingsPanel.rect_size / 2
	
	load_types()
	load_languages()


func on_banner_ad_loaded():
	yodo1mas.show_banner_ad()

func _on_Play_pressed():
#	get_tree().change_scene("res://game.tscn")
	
	animate_main_panel()


func animate_main_panel(forward: bool = true):
	var tween = get_tree().create_tween()
	
	if forward:
		tween.tween_property($Panel, 'rect_position:x', -700.0, .6).set_trans(Tween.TRANS_BACK).set_ease(Tween.EASE_IN)
		yield(tween, "finished")
		animate_selection()
	else:
		tween.tween_property($Panel, 'rect_position:x', orig_main_panel_pos.x, .6).set_trans(Tween.TRANS_BACK).set_ease(Tween.EASE_OUT)


func animate_selection(forward: bool = true):
	var tween = get_tree().create_tween()
	
	if forward:
		$LevelSelectionPanel.rect_scale = Vector2.ZERO
		$LevelSelectionPanel.show()
		tween.tween_property($LevelSelectionPanel, 'rect_scale', Vector2.ONE, 0.4).set_trans(Tween.TRANS_BOUNCE).set_ease(Tween.EASE_OUT)
	else:
		tween.tween_property($LevelSelectionPanel, 'rect_scale', Vector2.ZERO, 0.4).set_trans(Tween.TRANS_BOUNCE).set_ease(Tween.EASE_OUT)
		yield(tween, "finished")
		animate_main_panel(false)


func animate_tut(forward):
	var tween = get_tree().create_tween()
	
	
	if forward:
		$Panel.hide()
		$TutorialPanel.rect_scale = Vector2.ZERO
		$TutorialPanel.show()
		tween.tween_property($TutorialPanel, 'rect_scale', Vector2.ONE, 0.4).set_trans(Tween.TRANS_BOUNCE).set_ease(Tween.EASE_OUT)
	else:
		tween.tween_property($TutorialPanel, 'rect_scale', Vector2.ZERO, 0.4).set_trans(Tween.TRANS_BOUNCE).set_ease(Tween.EASE_OUT)
		yield(tween, "finished")
		$Panel.show()


func animate_settings(forward: bool):
	var tween = get_tree().create_tween()
	
	
	if forward:
		$Panel.hide()
		$SettingsPanel.rect_scale = Vector2.ZERO
		$SettingsPanel.show()
		tween.tween_property($SettingsPanel, 'rect_scale', Vector2.ONE, 0.4).set_trans(Tween.TRANS_BOUNCE).set_ease(Tween.EASE_OUT)
	else:
		tween.tween_property($SettingsPanel, 'rect_scale', Vector2.ZERO, 0.4).set_trans(Tween.TRANS_BOUNCE).set_ease(Tween.EASE_OUT)
		yield(tween, "finished")
		$SettingsPanel.hide()
		$Panel.show()


func load_types():
	for child in $LevelSelectionPanel/CenterContainer/LevelsList.get_children():
		child.queue_free()
	
	for l in Global._levels:
		var li = load("res://menu/LevelButton.tscn").instance()
		li.level_type = l
		li.text = l.to_upper()
		li.connect('clicked', self, 'on_type_select')
		$LevelSelectionPanel/CenterContainer/LevelsList.add_child(li)


func load_bodyparts():
	for child in $LevelSelectionPanel/CenterContainer/LevelsList.get_children():
		child.queue_free()
	
	for l in Global._levels[Global.type]:
		var b = load("res://menu/LevelButton.tscn").instance()
		b.level_type = l['code']
		b.text = l['name'].to_upper()
#		b.text = 'K_CHEEK_LEVEL_BUTTON'
		b.connect('clicked', self, 'on_level_select')
		$LevelSelectionPanel/CenterContainer/LevelsList.add_child(b)


func on_type_select(level: String):
	Global.type = level
	is_on_second_selection = true
	$LevelSelectionPanel/HBoxContainer/Back.disabled = false
	load_bodyparts()


func _on_tutorial_pressed(string: String):
	tutorial.show()
	$TutorialPanel.hide()
	$TutBackButton.show()
	
	match string:
		'pimple':
			tutorial.set_pimple_tutorial()
		'blackhead':
			tutorial.set_blackhead_tutorial()
		'cyst':
			tutorial.set_cyst_tutorial()
		'lipoma':
			tutorial.set_lipoma_tutorial()
	


func on_level_select(string: String):
	Global.bodypart = string
	yodo1mas.show_interstitial_ad()
	get_tree().change_scene("res://game.tscn")


func load_languages():
	for l in langs:
		lang_options.add_item(l[1])


func _on_Cancel_pressed():
	animate_selection(false)


func _on_Back_pressed():
	is_on_second_selection = false
	$LevelSelectionPanel/HBoxContainer/Back.disabled = true
	load_types()


func _on_TextureRect2_gui_input(event):
	if event is InputEventScreenTouch and !event.pressed:
		animate_tut(true)


func _on_TutPanelBack_pressed():
	animate_tut(false)


func _on_TutBackButton_pressed():
	tutorial.hide()
	$TutBackButton.hide()
	animate_tut(true)


func on_language_selected(index):
	var l: String = langs[index][0]
	Save.save_language(l)
	TranslationServer.set_locale(l)


func _on_SettingsBack_pressed():
	animate_settings(false)


func _on_Options_pressed():
	animate_settings(true)


func _on_DisableAdsButton_pressed():
	get_node('%DisableAdsPopup').popup_centered_ratio(0.3)


func _on_DisableAdsPopup_confirmed():
	ManagerBilling.payment.purchase('remove_ads') # add this sku to your google play settings
	
# callbacks	from signals

func _on_Yodo1Mas_banner_ad_loaded():
	debug_out.text = debug_out.text + "Banner loaded\n"
	
func _on_Yodo1Mas_banner_failed_ad_loaded():
	debug_out.text = debug_out.text + "Banner not loaded\n"
func _on_Yodo1Mas_banner_ad_opened():
	#add_coins(5)
	debug_out.text = debug_out.text + "Banner opened\n"

func _on_Yodo1Mas_banner_ad_failed_opened():
	#add_coins(5)
	debug_out.text = debug_out.text + "Banner not opened\n"

func _on_Yodo1Mas_banner_ad_closed():
	debug_out.text = debug_out.text + "Banner closed\n"




func _on_Yodo1Mas_interstitial_ad_loaded():
	debug_out.text = debug_out.text + "Interstitial  loaded\n"
	
func _on_Yodo1Mas_interstitial_ad_not_loaded():
	yodo1mas.load_interstitial_ads()
	debug_out.text = debug_out.text + "Interstitial not loaded\n"

func _on_Yodo1Mas_interstitial_ad_opened():
	debug_out.text = debug_out.text + "Interstitial opened\n"
	
func _on_Yodo1Mas_interstitial_ad_failed_to_opened():
	yodo1mas.load_interstitial_ads()
	debug_out.text = debug_out.text + "Interstitial not opened\n"

func _on_Yodo1Mas_interstitial_ad_closed():
	yodo1mas.load_interstitial_ads()
	#add_coins(10)
	debug_out.text = debug_out.text + "Interstitial closed\n"



func _on_Yodo1Mas_rewarded_ad_loaded():
	debug_out.text = debug_out.text + "Rewarded video  loaded\n"
	
func _on_Yodo1Mas_rewarded_ad_not_loaded():
	yodo1mas.load_rewarded_ad()
	debug_out.text = debug_out.text + "Rewarded video not loaded\n"
	
func _on_Yodo1Mas_rewarded_ad_opened():
	debug_out.text = debug_out.text + "Rewarded video opened\n"
	
func _on_Yodo1Mas_rewarded_ad_failed_opened():
	yodo1mas.load_rewarded_ad()
	debug_out.text = debug_out.text + "Rewarded video not opened\n"
func _on_Yodo1Mas_rewarded_ad_closed():
	yodo1mas.load_rewarded_ad()
	debug_out.text = debug_out.text + "Rewarded video closed\n"

func _on_Yodo1Mas_rewarded_ad_earned():
	#add_coins(15)
	debug_out.text = debug_out.text + "Rewarded video earned\n"
