extends Camera2D

signal player_hit_edge
signal end_of_level

var SPEED = 35
var MAX_SPEED = 65

var time_left : float = 50 # Time left on level
var end_pos = Vector2(1680,2295)
var main

var curr_move_dir = Vector2()
var time_curr_move = 0
var left_right = false


func _ready():
	main = get_tree().get_root().get_node("World")
	get_end_pos()
	pass
	
	
func _process(delta):
	if main.game_over:
		return
		
	var dist = end_pos.distance_to(self.position)
	if dist < 70:
		end_of_level_reached()
		return

	time_left -= delta
	
	if time_curr_move > 0 and curr_move_dir.length() > 0:
		time_curr_move -= delta
		self.position += curr_move_dir * SPEED * delta
		
		# Ensure within map
		if self.position.x < 214:
			self.position.x = 214
			time_curr_move = 0
		elif self.position.x > 1680:
			self.position.x = 1680
			time_curr_move = 0
		if self.position.y < 142:
			self.position.y = 142
			time_curr_move = 0
		elif self.position.y > 2718:
			self.position.y = 2718
			time_curr_move = 0
			
		return
	
	left_right = not left_right
	if dist > time_left * SPEED * 100:
		curr_move_dir = end_pos - position # Move to end
		pass
	else:
		curr_move_dir = Vector2(Globals.rnd.randi_range(-10, 10), Globals.rnd.randi_range(-10, 10))
		pass

	if left_right:
		curr_move_dir.y = 0
	else:
		curr_move_dir.x = 0
		
	curr_move_dir = curr_move_dir.normalized()
	time_curr_move = Globals.rnd.randi_range(2, 7)
	pass
	

func _on_Area2D_body_exited(body):
	if body.is_in_group("players"):
		emit_signal("player_hit_edge", body)
	pass


func end_of_level_reached():
	emit_signal("end_of_level")
	$AudioStreamPlayer_NextLevel.play()
	Globals.level += 1
	time_left = 45
	if Globals.level >= 8:
		main.select_winner();
		return

	$Label_Level.text = "LEVEL:" + str(Globals.level)
	if Globals.game_mode == Globals.GameMode.Original:
		SPEED += 5
	else:
		SPEED += 8
	if SPEED > MAX_SPEED:
		SPEED = MAX_SPEED
	get_end_pos()
	pass
	

func get_end_pos():
	if Globals.level % 2 != 0:
		end_pos.x = 1680
	else:
		end_pos.x = 214
	
	var section = (2550 / 7)
	end_pos.y = 2718 - (section * Globals.level)
	pass
	
