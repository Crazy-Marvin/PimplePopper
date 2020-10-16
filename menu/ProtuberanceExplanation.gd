extends Control

enum VideoType {
	PIMPLE,
	BLACKHEAD,
	CYST,
	LIPOMA
}

onready var pimple_video_resource = load("res://assets/videos/pimple-pop-sample.ogv")
onready var blackhead_video_resource = load("res://assets/videos/blackhead-sample.ogv")
onready var cyst_video_resource = load("res://assets/videos/cyst-sample.ogv")
onready var lipoma_video_resource = load("res://assets/videos/lipoma-sample.ogv")

onready var videos = {
	"pimple": pimple_video_resource,
	"blackhead": blackhead_video_resource,
	"cyst": cyst_video_resource,
	"lipoma": lipoma_video_resource
}

onready var _video_player: VideoPlayer = $HBoxContainer/CenterContainer/VideoPlayer
onready var _text: Label = $HBoxContainer/CenterContainer2/ScrollContainer/Label

export(VideoType) var tutorial_type
export(bool) var debug = false

func _ready():
	if debug:
		_set_debug_tutorial()

func _set_debug_tutorial() -> void:
	match tutorial_type:
		VideoType.PIMPLE:
			set_pimple_tutorial()
		VideoType.BLACKHEAD:
			set_blackhead_tutorial()
		VideoType.CYST:
			set_cyst_tutorial()
		VideoType.LIPOMA:
			set_lipoma_tutorial()

func set_pimple_tutorial() -> void:
	_set_video(videos["pimple"])
	_set_text("K_PIMPLE_TUTORIAL_TEXT")

func set_blackhead_tutorial() -> void:
	_set_video(videos["blackhead"])
	_set_text("K_BLACKHEAD_TUTORIAL_TEXT")

func set_cyst_tutorial() -> void:
	_set_video(videos["cyst"])
	_set_text("K_CYST_TUTORIAL_TEXT")

func set_lipoma_tutorial() -> void:
	_set_video(videos["lipoma"])
	_set_text("K_LIPOMA_TUTORIAL_TEXT")

func _set_video(video: VideoStream) -> void:
	if _video_player.stream != null:
		_video_player.stop()
	_video_player.stream = video
	_video_player.play()

func _set_text(tx: String) -> void:
	_text.text = tr(tx)


func _on_VideoPlayer_finished():
	_video_player.play()
