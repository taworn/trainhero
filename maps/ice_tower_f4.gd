
extends Node2D

func _ready():
	get_node("MusicPlayer").play()
	get_node("Camera/TileMap/Party").set_current_scene(self)

var tag = global.TAG_DUNGEON

var enemy_dict = {
	"d0401": 1,
	"d0402": 1,
	"d0403": 3,
}

var warp_dict = {
	"To F3": {"x": 1408, "y": 576, "map": "maps/ice_tower_f3"},
	"To F5": {"x": 1088, "y": 1152, "map": "maps/ice_tower_f5"},
}

var shop_dict = {
}

var door_dict = {
}

var treasure_dict = {
}

var dialog_dict = {
}

