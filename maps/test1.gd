
extends Node2D

func _ready():
	get_node("MusicPlayer").play()
	get_node("Camera/TileMap/Party").set_current_scene(self)

var tag = global.TAG_DUNGEON

var warp_dict = {
	"Test0": {"x": 256, "y": 128, "map": "maps/test0"},
	"Test0Water": {"x": 256, "y": 704, "map": "maps/test0"},
}

