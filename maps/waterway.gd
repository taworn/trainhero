
extends Node2D

func _ready():
	get_node("MusicPlayer").play()
	get_node("Camera/TileMap/Party").set_current_scene(self)

var tag = global.TAG_DUNGEON

var enemy_dict = {
}

var warp_dict = {
	"To B3": {"x": 0, "y": 1344, "map": "maps/cave_fire_b3"},
	"Next": {"x": 4288, "y": 3072, "map": "maps/world"},
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
		[global.SCRIPT_READ_QUEST, "Devil Wiz Return"],
		[global.SCRIPT_CONTINUE_IF],
		[global.SCRIPT_NPC_HIDDEN, "Devil Wiz Return"],
		[global.SCRIPT_HIDDEN_SCRIPT, "Devil Wiz Return Detected"],
	],
	"Win": [
		[global.SCRIPT_NO_CANCEL],
		[global.SCRIPT_TITLE_SET, "Devil Wiz Return"],
		"Aarrrgh...",
		[global.SCRIPT_WRITE_QUEST, "Devil Wiz Return"],
		[global.SCRIPT_NPC_HIDDEN, "Devil Wiz Return"],
		[global.SCRIPT_HIDDEN_SCRIPT, "Devil Wiz Return Detected"],
	],
	"Devil Wiz Return": [
		[global.SCRIPT_NO_CANCEL],
		[global.SCRIPT_NPC_ACTION, "down"],
		"Now, it's time to die!",
		[global.SCRIPT_BATTLE, "Win", "d0399", "Floor1"],
	],
	"Devil Wiz Return Detected": [
		[global.SCRIPT_NO_CANCEL],
		[global.SCRIPT_TITLE_SET, "Devil Wiz Return"],
		[global.SCRIPT_NPC_ACTION_, "Devil Wiz Return", "down"],
		"Now, it's time to die!",
		[global.SCRIPT_BATTLE, "Win", "d0399", "Floor1"],
	],
	"Recover": [
		[global.SCRIPT_HPMP_FULL],
		"HP/MP recover :)",
	],
}

