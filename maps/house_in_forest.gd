
extends Node2D

func _ready():
	get_node("MusicPlayer").play()
	get_node("Camera/TileMap/Party").set_current_scene(self)

var tag = global.TAG_NO_DUNGEON

var warp_dict = {
	"Back": {"x": 1728, "y": 3520, "map": "maps/world"},
}

var shop_dict = {
}

var door_dict = {
	"Door1": 1,
	"Door2": 1,
}

var treasure_dict = {
	"Treasure1": {
		"items": [
		],
		"keys": [
			"Alpha Key",
		],
		"equips": [
			"void_dress",
		],
	},
}

var dialog_dict = {
	"An Old Man": [
		"You want passage to Monster's Island?",
		"Here, I will give it to you, along with equipment.",
		[global.SCRIPT_NPC_WALK, 500, global.MOVE_UP],
		[global.SCRIPT_NPC_WALK, 500, global.MOVE_RIGHT],
		[global.SCRIPT_NPC_ACTION, "left"],
	],
}

