
extends Node2D

func _ready():
	get_node("MusicPlayer").play()
	get_node("Camera/TileMap/Party").set_current_scene(self)

var tag = global.TAG_DUNGEON

var enemy_dict = {
	"d0403": 3,
}

var warp_dict = {
	"To F4": {"x": 1088, "y": 1152, "map": "maps/ice_tower_f4"},
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
		[global.SCRIPT_READ_QUEST, "Voodoo Man"],
		[global.SCRIPT_CONTINUE_IF],
		[global.SCRIPT_NPC_HIDDEN, "Voodoo Man"],
	],
	"Win": [
		[global.SCRIPT_NO_CANCEL],
		[global.SCRIPT_TITLE_SET, "Voodoo Man"],
		"Aarrrgh...",
		[global.SCRIPT_WRITE_QUEST, "Voodoo Man"],
		[global.SCRIPT_NPC_HIDDEN, "Voodoo Man"],
		[global.SCRIPT_TITLE_SET, "Rydia"],
		"Let's go back to Port and see the Ship Owner.",
	],
	"Voodoo Man": [
		[global.SCRIPT_NO_CANCEL],
		[global.SCRIPT_NPC_ACTION, "down"],
		"You will not go away further!",
		[global.SCRIPT_BATTLE, "Win", "d0499", "Floor3"],
	],
}

