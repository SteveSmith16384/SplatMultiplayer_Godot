extends Node2D

const player_class = preload("res://Player.tscn")
const collectable_class = preload("res://Collectable.tscn")
const flying_key_class = preload("res://FlyingKey.tscn")

var game_over = false
var winner : int
var total_keys = 0

func _ready():
	for side in range(0, 4):
		var score = find_node("Score_" + str(side))
		score.visible = false
		pass
		
	for side in Globals.player_nums: # range(0, 4):# todo - re-add 
		var player = player_class.instance()
		player.side = side
		#player.set_collision_mask_bit(side, 1)
		player.name = "Player_" + str(side)
		set_player_start_pos(player)
		add_child(player)
		var score = find_node("Score_" + str(side))
		score.visible = true
		pass
		
	print("Num keys:" + str(self.total_keys))
	pass


func set_player_start_pos(player):
	var pos: Vector2 = get_node("StartPositions/StartPosition_" + str(player.side)).position
	player.position = pos
	pass
	
	
func _process(delta):
	if Input.is_action_just_pressed("ui_cancel"):
		get_tree().change_scene("res://SelectPlayersScene.tscn")
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
	node.text = "SCORE:" + str(player.score)
	pass
	

func key_collected(player : Player, key : Collectable):
	$AudioStreamPlayer_Collected.play()
	if player.keys_collected >= total_keys:
		$CentralCavern.show_toaster()
	
	var fly = self.flying_key_class.instance()
	fly.start_pos = key.global_position
	#fly.end_pos = Vector2()
	self.add_child(fly)	
	pass
	
