extends Node2D

func _process(_delta):
	if Input.is_action_just_pressed("full_screen"):
		OS.window_fullscreen = !OS.window_fullscreen

	if Input.is_key_pressed(KEY_1):
		Globals.game_mode = Globals.GameMode.ToTheDeath
		var _unused = get_tree().change_scene("res://SelectPlayersScene.tscn")
	elif Input.is_key_pressed(KEY_2):
		Globals.game_mode = Globals.GameMode.LongPlay
		var _unused = get_tree().change_scene("res://SelectPlayersScene.tscn")
	elif Input.is_key_pressed(KEY_3):
		Globals.game_mode = Globals.GameMode.Original
		var _unused = get_tree().change_scene("res://SelectPlayersScene.tscn")

	if Input.is_action_just_pressed("ui_cancel"):
		get_tree().change_scene("res://IntroScene.tscn")
	pass
	
