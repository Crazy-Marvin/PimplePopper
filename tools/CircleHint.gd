tool
extends Node2D

const alpha: float = 0.025

const white: Color = Color(1, 1, 1, alpha)
const red: Color = Color(1, 0, 0, alpha)
const green: Color = Color(0, 1, 0, alpha)
const blue: Color = Color(0, 0, 1, alpha)
const purple: Color = Color(1, 0, 1, alpha)

export(float, 1, 100) var radius: float = 1 setget set_radius

var _color: Color = Color(1, 0, 0, 0.025)


# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.

func set_radius(value) -> void:
	radius = value
	update()

func set_color(c: Color) -> void:
	_color = c
	update()

func _draw():
	draw_arc(Vector2.ZERO, radius, 0, 180, 360, _color, 4)

