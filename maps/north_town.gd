
extends Node2D

func _ready():
	get_node("MusicPlayer").play()
	get_node("Camera/TileMap/Party").set_current_scene(self)

var tag = global.TAG_NO_DUNGEON

var warp_dict = {
	"Back0": {"x": 2048, "y": 896, "map": "maps/world"},
	"Back1": {"x": 2048, "y": 896, "map": "maps/world"},
}

var shop_dict = {
	"Female Merchant": [
		"recover_hp_25",
		"recover_hp_50",
		"recover_hp_75",
		"recover_hp_100",
		"recover_mp_25",
		"recover_mp_50",
		"recover_hpmp_25",
		"antidote",
		"antiseptic",
	],
}

var door_dict = {
	"Door1": 1,
}

var treasure_dict = {
}

var dialog_dict = {
}

