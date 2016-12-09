
extends Node2D

func _ready():
	get_node("MusicPlayer").play()
	get_node("Camera/TileMap/Party").set_current_scene(self)

var tag = global.TAG_DUNGEON

var enemy_dict = {
	"d0500": 1,
	"d0501": 2,
	"d0502": 3,
}

var warp_dict = {
	"Back": {"x": 2880, "y": 2176, "map": "maps/world"},
	"Next": {"x": 2880, "y": 3264, "map": "maps/world"},
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
			"hero_shield",
		],
	},
}

var dialog_dict = {
	"START": [
		[global.SCRIPT_NO_CANCEL],
		[global.SCRIPT_READ_QUEST, "Dragon"],
		[global.SCRIPT_CONTINUE_IF],
		[global.SCRIPT_NPC_HIDDEN, "Dragon"],
	],
	"Win": [
		[global.SCRIPT_NO_CANCEL],
		[global.SCRIPT_TITLE_SET, "Dragon"],
		"You are brave as a hero.",
		"Here, the Dragon Sword, use it wisely.",
		[global.SCRIPT_WRITE_QUEST, "Dragon"],
		[global.SCRIPT_NPC_HIDDEN, "Dragon"],
	],
	"Dragon": [
		[global.SCRIPT_NO_CANCEL],
		[global.SCRIPT_NPC_ACTION, "down"],
		"Are you want the Dragon Sword?",
		"Then, fight me!",
		[global.SCRIPT_BATTLE, "Win", "d0599", "Floor1"],
	],
	"Recover": [
		[global.SCRIPT_HPMP_FULL],
		"HP/MP recover :)",
	],
}

