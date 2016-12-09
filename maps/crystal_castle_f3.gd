
extends Node2D

func _ready():
	get_node("MusicPlayer").play()
	get_node("Camera/TileMap/Party").set_current_scene(self)

var tag = global.TAG_DUNGEON

var enemy_dict = {
}

var warp_dict = {
	"To F2": {"x": 1216, "y": 960, "map": "maps/crystal_castle_f2"},
	"To F4": {"x": 1216, "y": 704, "map": "maps/crystal_castle_f4"},
}

var shop_dict = {
}

var door_dict = {
}

var treasure_dict = {
	"Treasure1": {
		"items": [
		],
		"keys": [
		],
		"equips": [
			"void_ring",
		],
	},
}

var dialog_dict = {
}

