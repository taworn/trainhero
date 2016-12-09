
extends Node2D

func _ready():
	get_node("MusicPlayer").play()
	get_node("Camera/TileMap/Party").set_current_scene(self)

var tag = global.TAG_DUNGEON

var enemy_dict = {
}

var warp_dict = {
	"To F1": {"x": 1216, "y": 704, "map": "maps/crystal_castle_f1"},
	"To F3": {"x": 1216, "y": 960, "map": "maps/crystal_castle_f3"},
}

var shop_dict = {
}

var door_dict = {
}

var treasure_dict = {
	"Treasure1": {
		"items": [
			"recover_hp_100",
			"recover_mp_100",
			"recover_hpmp_100",
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

