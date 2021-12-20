class_name Collectable
extends Area2D

enum Type {Grass, Plum}

var type
var pts = 20

func set_type(t):
	type = t
	if type == Type.Grass:
		pts = 20
	else:
		pts = 50
	pass
	
	
func _on_Collectable_body_entered(body):
	if body.is_in_group("players"):
		body.inc_score(pts)

		var main = get_tree().get_root().get_node("World")
		main.key_collected(body, self)
		
		self.queue_free()
	pass
