
extends Node2D

func _ready():
	get_node("MusicPlayer").play()
	get_node("Camera/TileMap/Party").set_current_scene(self)

var tag = global.TAG_DUNGEON

var enemy_dict = {
	"d0100": 1,
	"d0101": 1,
	"d0102": 1,
}

var warp_dict = {
	"Back": {"x": 2368, "y": 512, "map": "maps/world"},
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
			"recover_hpmp_50",
		],
		"keys": [
		],
		"equips": [
			"paladin_armor",
			"paladin_shield",
		],
	},
}

var dialog_dict = {
	"START": [
		[global.SCRIPT_NO_CANCEL],
		[global.SCRIPT_READ_QUEST, "Nadia Friend"],
		[global.SCRIPT_CONTINUE_IF],
		[global.SCRIPT_NPC_HIDDEN, "Nadia"],
		[global.SCRIPT_READ_QUEST, "Devil Wiz"],
		[global.SCRIPT_CONTINUE_IF],
		[global.SCRIPT_NPC_HIDDEN, "Devil Wiz"],
	],
	"Nadia": [
		[global.SCRIPT_NO_CANCEL],
		"I need a hero.",
		"Let's join force. :)",
		[global.SCRIPT_NPC_WALK_, "Nadia", 1000, global.MOVE_LEFT],
		[global.SCRIPT_NPC_HIDDEN, "Nadia"],
		[global.SCRIPT_BE_FRIEND, "Nadia"],
		[global.SCRIPT_WRITE_QUEST, "Nadia Friend"],
	],
	"Devil Wiz": [
		[global.SCRIPT_NO_CANCEL],
		"You will all dies!",
		[global.SCRIPT_BATTLE, "Win", "d0199", "Grass0"],
	],
	"Win": [
		[global.SCRIPT_NO_CANCEL],
		[global.SCRIPT_TITLE_SET, "Devil Wiz"],
		"Aarrrgh...",
		[global.SCRIPT_WRITE_QUEST, "Devil Wiz"],
		[global.SCRIPT_NPC_HIDDEN, "Devil Wiz"],
	],
}

