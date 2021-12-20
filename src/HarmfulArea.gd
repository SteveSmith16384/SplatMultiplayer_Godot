extends Area2D


func _on_HarmfulArea_body_entered(body):
	if body.is_in_group("players"):
		body.die()
	pass
