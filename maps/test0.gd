
extends Node2D

func _ready():
	get_node("Camera/Group").set_current_scene(self)

var warps = {
	"Town0": {"x": 160, "y": 227, "map": "maps/test0"},
}

var dialogs = {
	Villager0 = [
		"Good morning :)",
		"What u want?",
		global.SCRIPT_OPEN_SHOP,
		global.SCRIPT_SWITCH_TITLE,
		"Bye",
		global.SCRIPT_SWITCH_TITLE,
		"Ok"
	],
	Villager1 = [
		global.SCRIPT_OPEN_SHOP,
	],
}

var shops = {
	Villager0 = [
		"Item 0",
		"Item 1",
		"Item 2",
	],
	Villager1 = [
		"Item 3",
		"Item 4",
	],
}

