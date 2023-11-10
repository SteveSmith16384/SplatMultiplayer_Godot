extends Camera2D

var main
var border : Node2D

func _ready():
	main = get_tree().get_root().get_node("World")
	border = self.get_parent().get_node("SplatBorder")
	pass
	
	
func _process(delta):
	if main.game_over:
		return
	
	self.position = border.position
	pass
	

