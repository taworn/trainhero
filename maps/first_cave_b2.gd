
extends Node2D

func _ready():
	get_node("MusicPlayer").play()
	get_node("Camera/TileMap/Party").set_current_scene(self)

var tag = global.TAG_DUNGEON

var enemy_dict = {
	"d0000": 1,
}

var warp_dict = {
	"To B1": {"x": 1472, "y": 704, "map": "maps/first_cave_b1"},
	"Next": {"x": 1280, "y": 640, "map": "maps/world"},
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
		[global.SCRIPT_READ_QUEST, "Chameleon"],
		[global.SCRIPT_CONTINUE_IF],
		[global.SCRIPT_NPC_HIDDEN, "Chameleon"],
		[global.SCRIPT_NPC_HIDDEN, "Rydia"],
	],
	"Win": [
		[global.SCRIPT_NO_CANCEL],
		[global.SCRIPT_TITLE_SET, "Chameleon"],
		"Aarrrgh...",
		[global.SCRIPT_WRITE_QUEST, "Chameleon"],
		[global.SCRIPT_NPC_HIDDEN, "Chameleon"],
		[global.SCRIPT_TITLE_SET, 0],
		"Huh...",
		[global.SCRIPT_HERO_ACTION, "down"],
		"...",
		[global.SCRIPT_NPC_ACTION_, "Rydia", "left"],
		[global.SCRIPT_NPC_WALK_, "Rydia", 750, global.MOVE_LEFT],
		[global.SCRIPT_NPC_ACTION_, "Rydia", "up"],
		[global.SCRIPT_TITLE_SET, "Rydia"],
		"Thank you very much :)",
		"I might got to be eaten if you come here too late.",
		"Let's join force. ^_^",
		[global.SCRIPT_NPC_WALK_, "Rydia", 1000, global.MOVE_UP],
		[global.SCRIPT_NPC_HIDDEN, "Rydia"],
		[global.SCRIPT_BE_FRIEND, "Rydia"],
	],
	"Chameleon": [
		[global.SCRIPT_NO_CANCEL],
		"You will die!",
		[global.SCRIPT_BATTLE, "Win", "d0099", "Floor1"],
	],
	"Rydia": [
		"...",
		[global.SCRIPT_TITLE_SET, 0],
		"...",
		"(She is so cute...)",
	],
	"Recover": [
		[global.SCRIPT_HPMP_FULL],
		"HP/MP recover :)",
	],
}

