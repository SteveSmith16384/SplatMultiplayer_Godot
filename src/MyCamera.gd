extends Camera2D

const SPEED = 15

var time_left:float = 60
var end_pos = Vector2(1680,2295)

var curr_move_dir = Vector2()
var time_curr_move = 0

func _process(delta):
	time_left -= delta
	
	if time_curr_move > 0:
		time_curr_move -= delta
		self.position += curr_move_dir * SPEED * delta
		return
	
	var dist = end_pos.distance_to(self.position)
	if dist > time_left * SPEED * 100:
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
	
