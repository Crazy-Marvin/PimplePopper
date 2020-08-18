extends Node2D
class_name BodyPart

signal bodypart_cleaned

var protuberances: int = 0

func _ready():
	print("bodypart ready")
	var n: Node2D = Global.get_bodypart()
	add_child(n)
	var nodes = get_tree().get_nodes_in_group("protuberance")
	protuberances = nodes.size()
	for p in nodes:
		var error = p.connect("protuberance_cleaned", self, "_on_protuberance_cleaned")
		if error != OK:
			breakpoint

func  _on_protuberance_cleaned() -> void:
	protuberances -= 1
	if protuberances == 0:
		print("All protuberance removed")
		emit_signal("bodypart_cleaned")
