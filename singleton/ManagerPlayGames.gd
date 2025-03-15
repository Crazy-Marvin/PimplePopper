extends Node


var playgames: JNISingleton


func _ready() -> void:
	if OS.get_name() == 'Android':
		playgames = Engine.get_singleton("GodotGooglePlayGameServices")
		
		playgames.connect("leaderboardsAllLoaded", self, "_on_allLeaderboardsLoaded")
		playgames.connect("signInUserAuthenticated", self, "_on_signInUserAuthenticated")


func _on_allLeaderboardsLoaded(leaderboards: String) -> void:
	var parsed_leaderboards: Dictionary = JSON.parse(leaderboards).result
	prints(parsed_leaderboards)


func _on_signInUserAuthenticated():
	print('login sucessful!')
