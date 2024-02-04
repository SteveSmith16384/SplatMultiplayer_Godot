extends Node

const VERSION = "1.2"
const RELEASE_MODE = true

const SHOW_FPS = false and !RELEASE_MODE

var player_nums = []
var level : int = 1

enum GameMode {
	ToTheDeath, # Last survivor
	LongPlay # Highest score
	Original # 3 lives etc...
	}
	
var game_mode = GameMode.ToTheDeath

var rnd : RandomNumberGenerator

func _ready():
	rnd = RandomNumberGenerator.new()
	rnd.randomize()
	pass
	

