extends Node2D

func _process(delta):
	if Input.is_key_pressed(KEY_1):
		Globals.game_mode = Globals.GameMode.ToTheDeath
		get_tree().change_scene("res://SelectPlayersScene.tscn")
	elif Input.is_key_pressed(KEY_2):
		Globals.game_mode = Globals.GameMode.LongPlay
		get_tree().change_scene("res://SelectPlayersScene.tscn")
	elif Input.is_key_pressed(KEY_3):
		Globals.game_mode = Globals.GameMode.Original
		get_tree().change_scene("res://SelectPlayersScene.tscn")

	if Input.is_action_just_pressed("ui_cancel"):
		get_tree().change_scene("res://IntroScene.tscn")
	pass
	
