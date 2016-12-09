
extends Node2D

func _ready():
	get_node("MusicPlayer").play()
	get_node("Camera/TileMap/Party").set_current_scene(self)

var tag = global.TAG_DUNGEON

var enemy_dict = {
}

var warp_dict = {
	"To F5": {"x": 1216, "y": 1472, "map": "maps/crystal_castle_f5"},
	"To F7": {"x": 1216, "y": 1664, "map": "maps/crystal_castle_f7"},
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
			"miracle_amulet",
		],
	},
	"Treasure2": {
		"items": [
			"recover_hpmp_100",
			"recover_hpmp_100",
			"recover_hpmp_100",
			"antiseptic",
			"antiseptic",
			"antiseptic",
		],
		"keys": [
		],
		"equips": [
		],
	},
}

var dialog_dict = {
}

