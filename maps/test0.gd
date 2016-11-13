
extends Node2D

func _ready():
	get_node("MusicPlayer").play()
	get_node("Camera/TileMap/Party").set_current_scene(self)

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
	"Female3": [
		"Recover MP 25%",
		"Recover MP 50%",
		"Recover MP 75%",
		"Recover MP 100%",
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
		"You want something?",
		global.SCRIPT_OPEN_SHOP,
		"Good bye",
	],
	"Female2": [
		"I'm in this tile.",
		"Yes, it is tile",
	],
	"Female3": [
		global.SCRIPT_OPEN_SHOP,	
	],
}

