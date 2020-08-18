extends CenterContainer
class_name Level

signal button_pressed(bodypart)

var info: String
var number: int


func _on_pressed():
	emit_signal("button_pressed")

func set_text (t: String) -> void:
	$button.text = t

func get_size () -> Vector2:
	return $button.rect_size

func set_enable_level (enabled: bool) -> void:
	$button.disabled = not enabled
