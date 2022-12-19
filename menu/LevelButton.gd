extends Button


signal clicked

var level_type: String = ''


func _ready():
	pass


func _on_LevelButton_pressed():
	emit_signal("clicked", level_type)
