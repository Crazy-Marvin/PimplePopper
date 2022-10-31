extends Control



var orig_main_panel_pos
var selection_panel_destination_pos

var is_on_second_selection: bool = false


func _ready():
	orig_main_panel_pos = $Panel.rect_global_position
	
	$LevelSelectionPanel.rect_pivot_offset = $LevelSelectionPanel.rect_size / 2
	
	load_types()


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
		b.connect('clicked', self, 'on_level_select')
		$LevelSelectionPanel/CenterContainer/LevelsList.add_child(b)


func on_type_select(level: String):
	Global.type = level
	is_on_second_selection = true
	$LevelSelectionPanel/HBoxContainer/Back.disabled = false
	load_bodyparts()


func on_level_select(string: String):
	Global.bodypart = string
	get_tree().change_scene("res://game.tscn")


func _on_Cancel_pressed():
	animate_selection(false)


func _on_Back_pressed():
	is_on_second_selection = false
	$LevelSelectionPanel/HBoxContainer/Back.disabled = true
	load_types()
