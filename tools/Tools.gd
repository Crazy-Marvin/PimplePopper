extends Node


var tools: Array

func _ready():
	tools = [
		$hand,
		$handkerchief,
		$vapor,
		$comedone_extraction_tool,
		$needle
	]
	disable_all()

func disable_all() -> void:
	for t in tools:
		t.set_process_input(false)
		t.visible = false

func _enable_tool(t: Node2D) -> void:
	t.set_process_input(true)
	t.visible = true

func enable_hand() -> void:
	print ("Enabling hand...")
	disable_all()
	_enable_tool($hand)

func enable_handkerchief() -> void:
	print ("Enabling handkerchief...")
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
