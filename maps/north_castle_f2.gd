
extends Node2D

func _ready():
	get_node("MusicPlayer").play()
	get_node("Camera/TileMap/Party").set_current_scene(self)

var tag = global.TAG_NO_DUNGEON

var warp_dict = {
	"To F1": {"x": 896, "y": 320, "map": "maps/north_castle_f1"},
}

var shop_dict = {
}

var door_dict = {
}

var treasure_dict = {
}

var dialog_dict = {
	"King": [
		[global.SCRIPT_READ_QUEST_, "maps/north_mountain", "Devil Wiz"],
		[global.SCRIPT_IF_ELSE, "King Before"],
		[global.SCRIPT_WRITE_QUEST, "King Pass Order"],
		"I order the guards to let you pass.",
	],
	"King Before": [
		"Make yourself at home.",
	],

	"Soldier 1": ["Respect the king."],
	"Soldier 2": ["Respect the king."],
	"Soldier 3": ["Respect the king."],
	"Soldier 4": ["Respect the king."],
}

