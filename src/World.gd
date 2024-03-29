extends Node2D

const player_class = preload("res://Player.tscn")

var game_over = false
var winner : int

func _ready():
	$Music.play()
	
	if Globals.RELEASE_MODE == false and Globals.SHOW_FPS:
		$Timer_FPS.start()
	else:
		$MyCamera/Label_FPS.visible = false
		
	Globals.level = 1
	
	for side in range(0, 4):
		var score = find_node("Score_" + str(side))
		score.visible = false
		pass
		
	for side in Globals.player_nums: # range(0, 4):# todo - re-add 
		var player = player_class.instance()
		player.side = side
		player.name = "Player_" + str(side)
		set_player_start_pos(player)
		add_child(player)
		var score = find_node("Score_" + str(side))
		score.visible = true
		pass
	pass


func set_player_start_pos(player) -> bool:
	if $SplatBorder/CheckAreaEmpty.get_overlapping_bodies().size() == 0:
		if $SplatBorder/CheckAreaEmpty.get_overlapping_areas().size() <= 1:
			var pos: Vector2 = $SplatBorder.position
			player.position = pos
			return true;

	return false
	pass
	
	
func _process(_delta):
	if Input.is_action_just_pressed("ui_cancel"):
		game_over = true # Prevent firing any events
		get_tree().change_scene("res://SelectPlayersScene.tscn")
	if Input.is_action_just_pressed("full_screen"):
		OS.window_fullscreen = !OS.window_fullscreen
	pass


func select_winner():
	if game_over:
		return
		
	if Globals.game_mode == Globals.GameMode.ToTheDeath:
		# Check players left alive
		var num_alive = 0
		for side in Globals.player_nums: 
			var player = get_node("Player_" + str(side))
			if player and player.alive:
				num_alive += 1
		if num_alive > 1:
			return
	elif Globals.game_mode == Globals.GameMode.Original:
		# Check players left alive
		var num_alive = 0
		for side in Globals.player_nums: 
			var player = get_node("Player_" + str(side))
			if player and player.alive:
				num_alive += 1
		if num_alive > 0:
			return
			
	var winner = null
	for side in Globals.player_nums: 
		var player = get_node("Player_" + str(side))
		if player:
			if winner == null:
				winner = player
			elif player.score > winner.score:
				winner = player
	
	show_winner(winner.side)
	pass
	
	
func show_winner(side):
	if game_over:
		return
		
	game_over = true
	winner = side
	var label = self.find_node("WinnerLabel")
	label.text = "PLAYER " + str(side+1) + " IS THE WINNER!"
	
	var sprite = find_node("WinnerSprite")
	sprite.set_side(side)
	
	var anim = find_node("AnimationPlayer_WinnerSprite")
	anim.play("Pulsate")

	var node = find_node("WinnerNode")
	node.visible = true
	pass
	

func update_score(player):
	var node = find_node("Score_" + str(player.side))
	if node:
		if Globals.game_mode == Globals.GameMode.Original:
			node.text = "SCORE:" + str(player.score) + "\nLIVES:" + str(player.lives)
		else:
			node.text = "SCORE:" + str(player.score)
	pass
	

func key_collected(_player : Player, _key : Collectable):
	$AudioStreamPlayer_Collected.play()
	pass
	

func _on_Timer_FPS_timeout():
	$MyCamera/Label_FPS.set_text("FPS: " + str(Engine.get_frames_per_second()))
	pass


func _on_SplatBorder_player_hit_edge(player):
	player.die()
	pass


func _on_SplatBorder_end_of_level():
	# Do anything?
	pass
