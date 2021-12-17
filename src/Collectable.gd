class_name Collectable
extends Area2D

var collected_by = []

func _ready():
	if self.visible:
		var main = get_tree().get_root().get_node("World")
		main.total_keys += 1
	pass
	
	
func _on_Collectable_body_entered(body):
	if self.visible == false:
		return
		
	if body.is_in_group("players"):
		if collected_by.find(body) >= 0:
			return # Already collected
			
		collected_by.push_back(body)
		body.keys_collected += 1
		body.inc_score(Globals.PTS_FOR_DIAMOND)

		var main = get_tree().get_root().get_node("World")
		main.key_collected(body, self)
		
		if collected_by.size() >= Globals.player_nums.size():
			self.queue_free()
	pass
