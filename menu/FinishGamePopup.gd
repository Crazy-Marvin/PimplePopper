extends Control

enum finish_type {
	WIN,
	LOSS, # Just in case
	NONE # Just in case
}

signal anim_finished(finish_type)

onready var _animation: AnimationPlayer = $AnimationPlayer 
onready var _texture: TextureRect = $TextureRect

export(Vector2) var initial_position: Vector2 = Vector2.ZERO

var _center_offset: Vector2
var _finish_type: int = finish_type.NONE

func _ready():
	_center_image()
	rect_position = initial_position

# Center image though the offset
func _center_image() -> void:
	var texture: Texture = _texture.texture
	var tex_size: Vector2 = texture.get_size()
	_texture.rect_pivot_offset = tex_size / 2.0
	
	var size_x: float = _texture.rect_size.x * _texture.rect_scale.x
	var size_y: float = _texture.rect_size.y * _texture.rect_scale.y
	
	_center_offset = Vector2(size_x, size_y) / 2.0
	

func start() -> void:
	rect_position = (OS.window_size / 2.0) - _center_offset
	_animation.play("win_show_up")

func _on_animation_finished(anim_name: String) -> void:
	if anim_name == "win_show_up":
		emit_signal("anim_finished", finish_type.WIN)
