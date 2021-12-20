class_name Player
extends KinematicBody2D

const SPEED = 80

onready var main = get_tree().get_root().get_node("World")

onready var walking_left_sprite = $WalkingLeftSprites
onready var walking_right_sprite = $WalkingRightSprites
onready var animationPlayer = $AnimationPlayer

var motion = Vector2.ZERO
var alive = true
var side : int
var score : int = 0


func _ready():
	main.update_score(self)
	pass
	
	
func _process(_delta):
	pass
	
	
func _physics_process(_delta):
	if alive == false:
		return
		
	if main.game_over:
		return
		
	motion.x = 0
	motion.y = 0
	if Input.is_action_pressed("move_right" + str(side)):
		motion.x += SPEED
		animationPlayer.play("Run_Left")
	elif Input.is_action_pressed("move_left" + str(side)):
		motion.x -= SPEED
		animationPlayer.play("Run_Left")
	else:
		animationPlayer.stop(false)

	if Input.is_action_pressed("move_up" + str(side)):
		motion.y -= SPEED
		animationPlayer.play("Run_Left")
	elif Input.is_action_pressed("move_down" + str(side)):
		motion.y += SPEED
		animationPlayer.play("Run_Left")
	else:
		animationPlayer.stop(false)
	
	motion = move_and_slide(motion, Vector2.UP)
	
	var c = get_slide_count()
	for i in range (c):
		var coll = get_slide_collision(i)
		if coll.collider.is_in_group("kills_player"):
			self.die()
	pass


func die():
	$AudioStreamPlayer_Died.play()
	self.position = Vector2(-1000, -1000)
	alive = false
	$RespawnTimer.start()
	main.update_score(self)
	pass
	

func _on_RespawnTimer_timeout():
	if main.set_player_start_pos(self):
		alive = true
	else:
		$RespawnTimer.start() # Try again
	pass


func inc_score(amt):
	score += amt
	main.update_score(self)
	pass
	
