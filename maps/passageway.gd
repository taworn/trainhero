
extends Node2D

func _ready():
	get_node("MusicPlayer").play()
	get_node("Camera/TileMap/Party").set_current_scene(self)

var tag = global.TAG_DUNGEON

var enemy_dict = {
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
}

var dialog_dict = {
	"START": [
		[global.SCRIPT_NO_CANCEL],
		[global.SCRIPT_READ_QUEST, "Dragon Monster"],
		[global.SCRIPT_CONTINUE_IF],
		[global.SCRIPT_NPC_HIDDEN, "Dragon Monster"],
	],
	"Win": [
		[global.SCRIPT_NO_CANCEL],
		[global.SCRIPT_TITLE_SET, "Dragon Monster"],
		"Aarrrgh...",
		[global.SCRIPT_WRITE_QUEST, "Dragon Monster"],
		[global.SCRIPT_NPC_HIDDEN, "Dragon Monster"],
	],
	"Dragon Monster": [
		[global.SCRIPT_NO_CANCEL],
		[global.SCRIPT_NPC_ACTION, "down"],
		"...",
		[global.SCRIPT_BATTLE, "Win", "d0599", "Floor1"],
	],
	"Recover": [
		[global.SCRIPT_HPMP_FULL],
		"HP/MP recover :)",
	],
}

