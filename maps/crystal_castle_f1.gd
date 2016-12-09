
extends Node2D

func _ready():
	get_node("MusicPlayer").play()
	get_node("Camera/TileMap/Party").set_current_scene(self)

var tag = global.TAG_DUNGEON

var enemy_dict = {
}

var warp_dict = {
	"Back": {"x": 2880, "y": 3136, "map": "maps/world"},
	"To B1": {"x": 640, "y": 384, "map": "maps/crystal_castle_b1"},
	"To F2": {"x": 1216, "y": 704, "map": "maps/crystal_castle_f2"},
}

var shop_dict = {
}

var door_dict = {
}

var treasure_dict = {
}

var dialog_dict = {
}

