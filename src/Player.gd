class_name Player
extends KinematicBody2D

const SPEED = 170

onready var main = get_tree().get_root().get_node("World")

onready var walking_left_sprite = $WalkingLeftSprites
onready var walking_right_sprite = $WalkingRightSprites

var motion = Vector2.ZERO

var alive = true
var respawning = false
var side : int
var score : int = 0

func _ready():
	main.update_score(self)
	pass
	
	
func _process(_delta):
	if main.game_over:
		return
		
	if alive == false:
		if respawning:
			if main.set_player_start_pos(self):
				$AudioStreamPlayer_Respawn.play()
				alive = true
		return
		
	motion.x = 0
	motion.y = 0
	var moving = false
	if Input.is_action_pressed("move_right" + str(side)):
		motion.x += SPEED
		$AnimatedSprite.play("default")
		moving = true
	elif Input.is_action_pressed("move_left" + str(side)):
		motion.x -= SPEED
		$AnimatedSprite.play("default")
		moving = true
	elif Input.is_action_pressed("move_up" + str(side)):
		motion.y -= SPEED
		$AnimatedSprite.play("default")
		moving = true
	elif Input.is_action_pressed("move_down" + str(side)):
		motion.y += SPEED
		$AnimatedSprite.play("default")
		moving = true
		pass
		
	if not moving:
		$AnimatedSprite.stop()
		
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
	respawning = false
	$RespawnTimer.start()
	main.update_score(self)
	inc_score(-score / 2)
	pass
	

func _on_RespawnTimer_timeout():
	respawning = true
	pass


func inc_score(amt):
	score += amt
	main.update_score(self)
	pass
	
