extends Node2D

func _ready():
	$Sfx/Select.play()
	$Music.play()
	Globals.player_nums.clear()

	for i in 4:
		var human = find_node("SinglePlayerSprite_" + str(i))
		human.visible = false
	pass
	
	
func _process(_delta):
	if Input.is_action_just_pressed("ui_cancel"):
		get_tree().change_scene("res://SelectGameMode.tscn")
	if Input.is_action_just_pressed("full_screen"):
		OS.window_fullscreen = !OS.window_fullscreen
		
	for i in range(0,4):
		if Input.is_action_just_pressed("primary_fire" + str(i)) or Input.is_action_just_pressed("jump" + str(i)):
			if Globals.player_nums.has(i) == false:
				Globals.player_nums.push_back(i)
				var human = find_node("SinglePlayerSprite_" + str(i))
				human.visible = true
				$AudioStreamPlayer_Joined.play()
				pass
			pass
		pass
		
	if Input.is_action_just_pressed("start_game"):
		if Globals.player_nums.size() > 0:
			var _unused = get_tree().change_scene("res://World.tscn")
	pass
	

func _on_Timer_Flash_timeout():
	var label = find_node("Label")
	label.visible = not label.visible
	pass
