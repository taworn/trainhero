
extends Node2D

func _ready():
	get_node("MusicPlayer").play()
	get_node("Camera/TileMap/Party").set_current_scene(self)

var tag = global.TAG_DUNGEON

var enemy_dict = {
	"w0200": 1,
	"w0201": 1,
	"w0202": 1,
	"w0203": 1,
}

var warp_dict = {
	"Back": {"x": 4224, "y": 1920, "map": "maps/world"},
	"To B2": {"x": 1792, "y": 576, "map": "maps/cave_fire_b2"},
}

var shop_dict = {
}

var door_dict = {
}

var treasure_dict = {
	"Treasure1": {
		"items": [
			"recover_hp_75",
			"recover_hp_100",
			"recover_hpmp_75",
		],
		"keys": [
		],
		"equips": [
			"starrobe",
		],
	},
	"Treasure2": {
		"items": [
			"recover_mp_75",
			"recover_mp_100",
			"recover_hpmp_75",
		],
		"keys": [
		],
		"equips": [
			"dark_dress",
		],
	},
}

var dialog_dict = {
}

