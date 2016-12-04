
extends Node2D

func _ready():
	get_node("MusicPlayer").play()
	get_node("Camera/TileMap/Party").set_current_scene(self)

var tag = global.TAG_NO_DUNGEON

var warp_dict = {
	"Back": {"x": 2432, "y": 960, "map": "maps/world"},
	"Next": {"x": 2496, "y": 1088, "map": "maps/world"},
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
		[global.SCRIPT_READ_QUEST_, "maps/north_castle_f2", "King Pass Order"],
		[global.SCRIPT_CONTINUE_IF],
		[global.SCRIPT_NPC_WALK_, "Soldier 1", 1, global.MOVE_LEFT],
		[global.SCRIPT_NPC_ACTION_, "Soldier 1", "right"],
	],
	"Soldier 1": [
		[global.SCRIPT_READ_QUEST_, "maps/north_castle_f2", "King Pass Order"],
		[global.SCRIPT_IF_ELSE, "Soldier 1 Before"],
		[global.SCRIPT_NPC_WALK_, "Soldier 1", 50, global.MOVE_LEFT],
		[global.SCRIPT_NPC_ACTION_, "Soldier 1", "right"],
		"You can pass.",
	],
	"Soldier 1 Before": [
		"You cannot pass.",
	],
	"Soldier 2": ["Talk to captain."],
	"Soldier 3": ["Talk to captain."],
}

