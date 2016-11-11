
extends Node2D

func _ready():
	get_node("MusicPlayer").play()
	get_node("Camera/TileMap/Party").set_current_scene(self)

var door_dict = {
	"Door0": 1,
	"Door1": "key_0",
}

var warp_dict = {
	"Test1": {"x": 128, "y": 128, "map": "maps/test1"},
}

