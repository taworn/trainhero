
extends Node2D

func _ready():
	get_node("MusicPlayer").play()
	get_node("Camera/TileMap/Party").set_current_scene(self)

var tag = global.TAG_NO_DUNGEON

var warp_dict = {
	"Back": {"x": 1728, "y": 320, "map": "maps/north_town"},
	"To F2": {"x": 640, "y": 960, "map": "maps/north_castle_f2"},
}

var shop_dict = {
}

var door_dict = {
}

var treasure_dict = {
}

var dialog_dict = {
	"Soldier 1": ["You can pass."],
	"Soldier 2": ["You can pass."],
	"Soldier 3": ["You can pass."],
	"Soldier 4": ["You can pass."],

	"Oldwoman": ["The king is polite."],
	"Oldman": ["Be quite in the king room."],
}

