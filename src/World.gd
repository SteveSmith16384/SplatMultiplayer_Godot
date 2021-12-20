extends Node2D

const player_class = preload("res://Player.tscn")
const collectable_class = preload("res://Collectable.tscn")
const flying_key_class = preload("res://FlyingKey.tscn")

var game_over = false
var winner : int
var total_keys = 0

func _ready():
	if Globals.SHOW_FPS:
		$Timer_FPS.start()
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
		
	print("Num keys:" + str(self.total_keys))
	pass


func set_player_start_pos(player) -> bool:
	if $MyCamera/CheckAreaEmpty.get_overlapping_bodies().size() == 0:
		var pos: Vector2 = $MyCamera.position
		player.position = pos
		return true;
	
	return false
	pass
	
	
func _process(delta):
	if Input.is_action_just_pressed("ui_cancel"):
		get_tree().change_scene("res://SelectPlayersScene.tscn")

	#todo	
#	$Camera2D.position.x += delta * 10
#	$Camera2D.position.y += delta * 10
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
		node.text = "SCORE:" + str(player.score)
	pass
	

func key_collected(player : Player, key : Collectable):
	$AudioStreamPlayer_Collected.play()
	
	var fly = self.flying_key_class.instance()
	fly.start_pos = key.global_position
	self.add_child(fly)	
	pass
	

func _on_Timer_FPS_timeout():
	$Label_FPS.set_text("FPS: " + str(Engine.get_frames_per_second()))
	pass


func _on_MyCamera_player_hit_edge(player):
	player.die()
	pass


func _on_MyCamera_end_of_level():
	# todo
	pass
