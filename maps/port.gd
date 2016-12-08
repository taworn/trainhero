
extends Node2D

func _ready():
	get_node("MusicPlayer").play()
	get_node("Camera/TileMap/Party").set_current_scene(self)

var tag = global.TAG_NO_DUNGEON

var enemy_dict = {
}

var warp_dict = {
	"Back": {"x": 4736, "y": 3392, "map": "maps/world"},
	"Next": {"x": 4864, "y": 3392, "map": "maps/world"},
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
		"antidote",
		"antiseptic",
	],
}

var door_dict = {
	"Door1": 1,
	"Door2": 1,
	"Door3": 1,
}

var treasure_dict = {
}

var dialog_dict = {
	"Ship Owner": [
		[global.SCRIPT_READ_QUEST_, "maps/ice_tower_f5", "Voodoo Man"],
		[global.SCRIPT_IF_ELSE, "Ship Owner Before"],
		"I will give this ship for you.",
		[global.SCRIPT_NPC_WALK, 500, global.MOVE_UP],
		[global.SCRIPT_NPC_ACTION, "down"],
	],
	"Ship Owner Before": [
		"Monsters are in the Ice Tower.",
	],

	"Innkeeper": [
		"Need a rest?",
		"It will cost 35 G per night.\n(Press ESC/Cancel to cancel)",
		[global.SCRIPT_OPEN_INN, 35],
		"Oh, sorry, you not have enough gold.",
	],

	"Merchant": [
		[global.SCRIPT_OPEN_SHOP],
	],
}

