
extends Node2D

func _ready():
	get_node("MusicPlayer").play()
	get_node("Camera/TileMap/Party").set_current_scene(self)

var tag = global.TAG_DUNGEON

var enemy_dict = {
	"d0200": 1,
	"d0201": 1,
	"d0202": 1,
}

var warp_dict = {
	"To B2": {"x": 192, "y": 1216, "map": "maps/cave_fire_b2"},
	"Next": {"x": 0, "y": 0, "map": "maps/cave_underwater"},
}

var shop_dict = {
}

var door_dict = {
}

var treasure_dict = {
}

var dialog_dict = {
	"START": [
		[global.SCRIPT_NO_CANCEL],
		[global.SCRIPT_READ_QUEST, "Leon Head"],
		[global.SCRIPT_CONTINUE_IF],
		[global.SCRIPT_NPC_HIDDEN, "Leon Head"],
	],
	"Win": [
		[global.SCRIPT_NO_CANCEL],
		[global.SCRIPT_TITLE_SET, "Leon Head"],
		"Aarrrgh...",
		[global.SCRIPT_WRITE_QUEST, "Leon Head"],
		[global.SCRIPT_NPC_HIDDEN, "Leon Head"],
		[global.SCRIPT_TITLE_SET, "Rydia"],
		"Their is a stair down here.",
		[global.SCRIPT_TITLE_SET, "Nadia"],
		"Let's go.",
	],
	"Leon Head": [
		[global.SCRIPT_NO_CANCEL],
		[global.SCRIPT_NPC_ACTION, "down"],
		"DIE!",
		[global.SCRIPT_BATTLE, "Win", "d0299", "Floor2"],
	],
}

