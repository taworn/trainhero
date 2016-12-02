
extends Node2D

func _ready():
	get_node("MusicPlayer").play()
	get_node("Camera/TileMap/Party").set_current_scene(self)

var tag = global.TAG_DUNGEON

var enemy_dict = {
	"d0000": 1,
}

var warp_dict = {
	"Back": {"x": 1088, "y": 704, "map": "maps/world"},
	"To B2": {"x": 64, "y": 960, "map": "maps/first_cave_b2"},
}

var shop_dict = {
}

var door_dict = {
}

var treasure_dict = {
}

var dialog_dict = {
}

