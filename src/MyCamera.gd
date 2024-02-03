extends Camera2D

var main
var border : Node2D
var single_screen = false

func _ready():
	main = get_tree().get_root().get_node("World")
	border = self.get_parent().get_node("SplatBorder")
	
	self.zoom = Vector2(1, 1)
	#self.position = Vector2(700, 1500)
	pass
	
	
func _process(delta):
	if main.game_over:
		return
	
	if Input.is_action_just_pressed("zoom"):
		single_screen = not single_screen
		if single_screen:
			position = Vector2(700, 1500)
			self.zoom = Vector2(8, 8)
		else:
			self.zoom = Vector2(1, 1)
			
	if single_screen == false:
		self.position = border.position
	pass
	

