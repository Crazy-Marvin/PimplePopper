extends Node


var tools: Array

func _ready():
	tools = [
		$hand,
		$handkerchief,
		$vapor,
		$comedone_extraction_tool,
		$needle,
		$cutter,
		$anaesthetic,
		$suture
	]
	disable_all()


func disable_all() -> void:
	for t in tools:
		t.disable()


func _enable_tool(t) -> void:
	t.enable()


func enable_hand() -> void:
	disable_all()
	_enable_tool($hand)


func enable_handkerchief() -> void:
	disable_all()
	_enable_tool($handkerchief)


func enable_vapor() -> void:
	disable_all()
	_enable_tool($vapor)


func enable_comedone_extraction_tool() -> void:
	disable_all()
	_enable_tool($comedone_extraction_tool)


func enable_needle() -> void:
	disable_all()
	_enable_tool($needle)


func enable_cutter() -> void:
	disable_all()
	_enable_tool($cutter) 

func enable_anesthetic() -> void:
	disable_all()
	_enable_tool($anaesthetic)

func enable_suture() -> void:
	disable_all()
	_enable_tool($suture)
