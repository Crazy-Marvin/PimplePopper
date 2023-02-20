extends Button


signal clicked

var level_type: String = ''


func _ready():
	text = tr(text)


func _on_LevelButton_pressed():
	emit_signal("clicked", level_type)
