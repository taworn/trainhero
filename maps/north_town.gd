
extends Node2D

func _ready():
	get_node("MusicPlayer").play()
	get_node("Camera/TileMap/Party").set_current_scene(self)

var tag = global.TAG_NO_DUNGEON

var warp_dict = {
	"Back0": {"x": 2048, "y": 896, "map": "maps/world"},
	"Back1": {"x": 2048, "y": 896, "map": "maps/world"},
	"To F1": {"x": 896, "y": 1152, "map": "maps/north_castle_f1"},
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
	"Door2": 1,
}

var treasure_dict = {
}

var dialog_dict = {
	"Female Merchant": [
		"Good day",
		[global.SCRIPT_OPEN_SHOP],
	],
	"Innkeeper": [
		"Cost 15 G per night, need a rest?\n(Press ESC/Cancel to cancel)",
		[global.SCRIPT_OPEN_INN, 15],
		"Oh, sorry, you not have enough gold.",
	],
}

