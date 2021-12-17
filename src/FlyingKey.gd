extends Sprite

var start_pos : Vector2
var end_pos = Vector2(255, 0)
var pcent : float = 0

func _ready():
	pass


func _process(delta):
	pcent += delta
	self.position.x = lerp(start_pos.x, end_pos.x, pcent)
	self.position.y = lerp(start_pos.y, end_pos.y, pcent)
	
	if pcent > 1:
		self.queue_free()
	pass
