
extends Node2D

func _ready():
	get_node("MusicPlayer").play()
	get_node("Camera/TileMap/Party").set_current_scene(self)

var tag = global.TAG_DUNGEON

var enemy_dict = {
	"w0300": 1,
	"d0400": 1,
	"d0401": 1,
	"d0402": 1,
}

var warp_dict = {
	"To F2": {"x": 1408, "y": 576, "map": "maps/ice_tower_f2"},
	"To F4": {"x": 1600, "y": 576, "map": "maps/ice_tower_f4"},
}

var shop_dict = {
}

var door_dict = {
}

var treasure_dict = {
}

var dialog_dict = {
}

