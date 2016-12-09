
extends Node2D

func _ready():
	get_node("MusicPlayer").play()
	get_node("Camera/TileMap/Party").set_current_scene(self)

var tag = global.TAG_NO_DUNGEON

var warp_dict = {
	"Back": {"x": 896, "y": 2368, "map": "maps/world"},
	"To F2": {"x": 704, "y": 960, "map": "maps/south_castle_f2"},
}

var shop_dict = {
	"Merchant": [
		"recover_hp_25",
		"recover_hp_50",
		"recover_hp_75",
		"recover_hp_100",
		"recover_mp_25",
		"recover_mp_50",
		"recover_mp_75",
		"recover_mp_100",
		"recover_hpmp_25",
		"recover_hpmp_50",
		"recover_hpmp_75",
		"recover_hpmp_100",
		"antidote",
		"antiseptic",
	],
}

var door_dict = {
}

var treasure_dict = {
}

var dialog_dict = {
	"Innkeeper": [
		"Need a rest?",
		"It will cost 50 G per night.\n(Press ESC/Cancel to cancel)",
		[global.SCRIPT_OPEN_INN, 50],
		"Oh, sorry, you not have enough gold.",
	],
	"Merchant": [
		"Look around before you buy.",
		[global.SCRIPT_OPEN_SHOP],
	],

	"Soldier 1": ["You can pass."],
	"Soldier 2": ["You can pass."],

	"Villager Oldman 1": [
		"It's good to work farm here.",
		"But monsters invaded from time to time.",
	],
	"Villager Oldwoman 1": [
		"Hum hum, hum hum...",
		"Oh, sorry, I just complain it ramblingly.",
	],
	"Villager Male 1": [
		"This place have good opportunity to expand construction.",
	],
	"Villager Female 2": [
		"Hello to South Town.",
		"It's small town but it gradually grow up.",
	],
}

