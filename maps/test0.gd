
extends Node2D

func _ready():
	get_node("MusicPlayer").play()
	get_node("Camera/TileMap/Party").set_current_scene(self)

var tag = global.TAG_WORLD

var warp_dict = {
	"Test1": {"x": 128, "y": 128, "map": "maps/test1"},
	"Test1Water": {"x": 128, "y": 512, "map": "maps/test1"},
}

var shop_dict = {
	"Female0": [
		"Recover HP 25%",
		"Recover HP 50%",
		"Recover HP 75%",
		"Recover HP 100%",
		"Antidote",
		"Antiseptic",
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
		[global.SCRIPT_HERO_FACE, "down"],
		[global.SCRIPT_NPC_FACE, "up"],
		"...",
		[global.SCRIPT_TITLE_VISIBLE, 1],
		[global.SCRIPT_NPC_FACE, null],
		"You want something?",
		[global.SCRIPT_TITLE_SET, 0],
		"Sure",
		[global.SCRIPT_HERO_WALK, global.MOVE_DOWN],
		[global.SCRIPT_OPEN_SHOP],
		[global.SCRIPT_TITLE_SET, 1],
		"Good bye",
		[global.SCRIPT_NPC_FACE, "right"],
	],
	"Female1": [
		"Hello Hero",
		[global.SCRIPT_NPC_WALK, global.MOVE_DOWN],
		[global.SCRIPT_HERO_FACE, "right"],
		[global.SCRIPT_OPEN_SHOP],
		"Goodbye Hero",
	],
	"Female2": [
		"I'm in this tile.",
		"Yes, it is tile",
	],
	"Female3": [
		[global.SCRIPT_NPC_FACE, "down"],
		"Good bye",
	]
}

