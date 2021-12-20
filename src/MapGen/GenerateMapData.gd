extends Node2D

var wall_class = preload("res://Wall.tscn")
var grass_class = preload("res://Grass.tscn")
var plum_class = preload("res://Plum.tscn")
var harm_class = preload("res://HarmfulArea.tscn")

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
	vm.name = "SplatMap"
	
	var row: int = 0
	while !file.eof_reached():
		var csv : PoolStringArray = file.get_csv_line()
		for x in csv.size()-1:
			var tmp = csv[x]
			var obj
			if tmp == "W": # Wall
				obj = wall_class.instance()
			elif tmp == "G": # Grass
				obj = grass_class.instance()
				#obj.set_type(Collectable.Type.Grass)
			elif tmp == "P": # Plum
				obj = plum_class.instance()
				#obj.set_type(Collectable.Type.Plum)
			elif tmp == "L" or tmp == "S" or tmp == "C" or tmp == "B":
				obj = harm_class.instance()
			else:
				print("Unknown: " + tmp)
				continue
			
			obj.position.x = x * 8
			obj.position.y = row * 8
			vm.add_child(obj)
			obj.owner = vm # Must be after we add it
			pass
		row += 1
		pass
	file.close()

	# Save the scene
	var packed_scene = PackedScene.new()
	packed_scene.pack(vm)
	ResourceSaver.save("SplatMap.tscn", packed_scene)
	pass
	
