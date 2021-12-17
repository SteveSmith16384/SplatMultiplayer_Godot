extends Node2D

func _ready():
	$CanvasLayer/Label_Version.text = "VERSION " + Globals.VERSION
	pass
	
	
func _process(delta):
	if Input.is_action_just_pressed("ui_cancel"):
		get_tree().quit()
		
	for i in range(0,4):
		if Input.is_action_just_pressed("primary_fire" + str(i)) or Input.is_action_just_pressed("jump" + str(i)):
			get_tree().change_scene("res://SelectPlayersScene.tscn")
		pass
		
	pass

func _on_Timer_Flash_timeout():
	#var label = find_node("Label")
	#label.visible = not label.visible
	pass


func _on_Timer_Logo_timeout():
	var logo1 = find_node("Sprite_Logo1")
	logo1.visible = not logo1.visible
	var logo2 = find_node("Sprite_Logo2")
	logo2.visible = not logo2.visible
	pass # Replace with function body.
