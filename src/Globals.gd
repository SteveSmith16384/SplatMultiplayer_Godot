extends Node

const VERSION = "0.1"
const RELEASE_MODE = true

const SHOW_FPS = false and !RELEASE_MODE

var player_nums = []
var level : int = 1

var rnd : RandomNumberGenerator

func _ready():
	rnd = RandomNumberGenerator.new()
	rnd.randomize()
	pass
	

