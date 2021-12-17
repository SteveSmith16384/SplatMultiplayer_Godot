extends Node2D

var wall_class = preload("res://Wall.tscn")

func _on_Button_pressed():
	create_map_data(self)
	get_tree().quit()
	pass


func _process(delta):
	if Input.is_action_just_pressed("ui_cancel"):
		get_tree().quit()
		return


func create_map_data(owner : Node):
	var file : File = File.new()
	var res = file.open("res://MapGen/mapdata.csv", file.READ)
	if res != 0:
		push_error("Error opening map file")
		
	var vm = Node2D.new()
	
	var row: int = 0
	while !file.eof_reached():
		var csv : PoolStringArray = file.get_csv_line()
		for x in csv.size()-1:
			var tmp = csv[x]
			if tmp == "W": # Wall
				var wall = wall_class.instance()
				wall.position.x = x * 8
				wall.position.y = row * 8
				vm.add_child(wall)
				wall.owner = vm
				pass
			elif tmp == "G": # Grass
				pass
			else:
				print("Unknown: " + tmp)
				pass
			
		row += 1
		pass
	file.close()

	# Save the scene
	var packed_scene = PackedScene.new()
	packed_scene.pack(vm)
	ResourceSaver.save("SplatMap.tscn", packed_scene)
	return vm
	
