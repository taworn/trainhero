
extends Node2D

func _ready():
	get_node("Camera/Group").set_current_scene(self)

var dialogs = {
	"Villager0": [
		"Good morning :)",
		"What u want?",
		global.SCRIPT_OPEN_SHOP,
		global.SCRIPT_SWITCH_TITLE,
		"Bye",
		global.SCRIPT_SWITCH_TITLE,
		"Ok",
	],
	"Villager1": [
		global.SCRIPT_OPEN_SHOP,
	],
}

var shops = {
	"Villager0": [
		"Item 0",
		"Item 1",
		"Item 2",
	],
	"Villager1": [
		"Item 3",
		"Item 4",
	],
}

var doors = {
	"Door0": "Grass0",
	"Door1": ["key_0", "Grass1"],
}

var treasures = {
	"Treasure0": [
		"key_0",
	],
}

var warps = {
	"Town0": {"x": 32, "y": 32, "map": "maps/test1"},
}

