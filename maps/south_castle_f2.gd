
extends Node2D

func _ready():
	get_node("MusicPlayer").play()
	get_node("Camera/TileMap/Party").set_current_scene(self)

var tag = global.TAG_NO_DUNGEON

var warp_dict = {
	"To F1": {"x": 704, "y": 320, "map": "maps/south_castle_f1"},
}

var shop_dict = {
}

var door_dict = {
}

var treasure_dict = {
}

var dialog_dict = {
	"King": [
		"Make yourself at home.",
	],
	"Queen": [
		"Make yourself at home.",
	],

	"Soldier 1": ["Respect the king."],
	"Soldier 2": ["Respect the king."],
	"Soldier 3": ["Respect the king."],
	"Soldier 4": ["Respect the king."],
}

