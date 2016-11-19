
extends Node2D

func _ready():
	get_node("MusicPlayer").play()
	get_node("Camera/TileMap/Party").set_current_scene(self)

var tag = global.TAG_WORLD

var enemy_dict = {
}

var enemy_ship_dict = {
	"fish0": 1,
	"fish1": 1,
}

var enemy_zone_dict = {
	"Zone0": {
		"slimes0": 2,
		"fish0": 2,
	},
	"Zone1": {
		"fish1": 1,
	},
	"Zone2": {
		"slimes1": 1,
	},
}

var warp_dict = {
	"Test1": {"x": 128, "y": 128, "map": "maps/test1"},
	"Test1Water": {"x": 128, "y": 512, "map": "maps/test1"},
}

var shop_dict = {
	"Female0": [
		"recover_hp_25",
		"recover_hp_50",
		"recover_hp_75",
		"recover_mp_25",
		"recover_mp_50",
		"recover_mp_75",
		"recover_hpmp_25",
		"recover_hpmp_50",
		"recover_hpmp_100",
		"antidote",
		"antiseptic",
	],
	"Female1": [
	],
}

var door_dict = {
	"Door0": 1,
	"Door1": "key_0",
}

var treasure_dict = {
	"Treasure0": [
		"key_0", "key_1",
 	],
}

var dialog_dict = {
	"Female0": [
		"Good morning",
		[global.SCRIPT_TITLE_VISIBLE, 0],
		[global.SCRIPT_HERO_ACTION, "down"],
		[global.SCRIPT_NPC_ACTION, "up"],
		"...",
		[global.SCRIPT_TITLE_VISIBLE, 1],
		[global.SCRIPT_NPC_ACTION, null],
		"You want something?",
		[global.SCRIPT_TITLE_SET, 0],
		"Sure",
		[global.SCRIPT_HERO_WALK, global.MOVE_DOWN],
		[global.SCRIPT_OPEN_SHOP],
		[global.SCRIPT_TITLE_SET, 1],
		"Good bye",
		[global.SCRIPT_NPC_ACTION, "right"],
	],
	"Female1": [
		"Want to sleep a night?",
		"only 50G (press ESC to cancel)",
		[global.SCRIPT_OPEN_INN, 555],
		"Oh, sorry :(",
	],
	"Female2": [
		"I'm in this tile.",
		"Yes, it is tile",
	],
	"Female3": [
		[global.SCRIPT_NPC_ACTION, "down"],
		"Good bye",
	]
}

