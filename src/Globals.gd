extends Node

const VERSION = "0.1"
const RELEASE_MODE = true

const SHOW_FPS = true and !RELEASE_MODE
const NO_ENEMIES = false and !RELEASE_MODE

const PTS_FOR_DIAMOND = 50

# Other settings
var MUSIC_ON = true

var player_nums = []
var level : int = 1

var rnd : RandomNumberGenerator

func _ready():
	rnd = RandomNumberGenerator.new()
	rnd.randomize()
	pass
	

