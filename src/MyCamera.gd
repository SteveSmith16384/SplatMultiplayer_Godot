extends Camera2D

signal player_hit_edge
signal end_of_level

const SPEED = 20

var time_left:float = 60
var end_pos = Vector2(1680,2295)

var curr_move_dir = Vector2()
var time_curr_move = 0

func _process(delta):
	time_left -= delta
	
	if time_curr_move > 0:
		time_curr_move -= delta
		self.position += curr_move_dir * SPEED * delta
		
		# Ensure within map
		if self.position.x < 214:
			self.position.x = 214
		elif self.position.x > 1680:
			self.position.x = 1680
		if self.position.y < 142:
			self.position.y = 142
		elif self.position.y > 2718:
			self.position.y = 2718
			
		return
	
	var dist = end_pos.distance_to(self.position)
	if dist < 70:
		emit_signal("end_of_level")
		# todo - set new map params, and inc speed
	elif dist > time_left * SPEED * 100:
		move_towards_end()
		pass
	else:
		move_in_random_dir()
		pass
	pass
	

func move_towards_end():
	curr_move_dir = end_pos - position
	curr_move_dir = curr_move_dir.normalized()
	time_curr_move = 5
	pass
	
	
func move_in_random_dir():
	curr_move_dir = Vector2(Globals.rnd.randi_range(-10, 10), Globals.rnd.randi_range(-10, 10))
	curr_move_dir = curr_move_dir.normalized()
	
	time_curr_move = 5
	pass


func _on_Area2D_body_exited(body):
	if body.is_in_group("players"):
		emit_signal("player_hit_edge", body)
	pass
