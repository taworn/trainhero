
extends Node2D

func _ready():
	get_node("MusicPlayer").play()
	get_node("Camera/TileMap/Party").set_current_scene(self)

var tag = global.TAG_NO_DUNGEON

var warp_dict = {
	"Back": {"x": 960, "y": 576, "map": "maps/world"},
}

var shop_dict = {
}

var door_dict = {
	"Door1": 1,
}

var treasure_dict = {
}

var dialog_dict = {
}

