
extends Node2D

func _ready():
	get_node("MusicPlayer").play()
	get_node("Camera/TileMap/Party").set_current_scene(self)

var tag = global.TAG_NO_DUNGEON

var warp_dict = {
	"Back": {"x": 896, "y": 2368, "map": "maps/world"},
	"To F2": {"x": 640, "y": 960, "map": "maps/south_castle_f2"},
}

var shop_dict = {
}

var door_dict = {
}

var treasure_dict = {
}

var dialog_dict = {
}

