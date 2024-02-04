extends Node2D

func _ready():
	$Sprite.visible = true
	$Sprite2.visible = false
	pass
	

func _on_Timer_timeout():
	$Sprite.visible = not $Sprite.visible
	$Sprite2.visible = not $Sprite.visible
	pass
