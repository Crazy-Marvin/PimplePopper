extends Node2D
class_name FingerPointer


# Declare member variables here. Examples:
# var a = 2
# var b = "text"


# Called when the node enters the scene tree for the first time.
func _ready():
	hide_pointer()
	pass # Replace with function body.

func draw_pointer() -> void:
	visible = true

func hide_pointer() -> void:
	visible = false

func _draw():
	draw_circle(Vector2(), 30, Color(1, 1, 1))
