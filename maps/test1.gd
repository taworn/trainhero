
extends Node2D

func _ready():
	get_node("MusicPlayer").play()
	get_node("Camera/TileMap/Party").set_current_scene(self)

var tag = global.TAG_DUNGEON

var warp_dict = {
	"Test0": {"x": 256, "y": 128, "map": "maps/test0"},
	"Test0Water": {"x": 256, "y": 704, "map": "maps/test0"},
}

var dialog_dict = {
	"START": [
		[global.SCRIPT_NO_CANCEL],
		[global.SCRIPT_READ_QUEST, "King Fake"],
		[global.SCRIPT_CONTINUE_IF],
		[global.SCRIPT_SCRIPT_HIDDEN, "King Fake Battle"],
		[global.SCRIPT_NPC_HIDDEN, "King Fake"],
	],
	"King Fake Battle": [
		[global.SCRIPT_NO_CANCEL],
		"You Die!!\nYou Die!!\nYou Die!!\nYou Die!!",
		"You Die!!\nYou Die!!\nYou Die!!\nYou Die!!",
		[global.SCRIPT_BATTLE, "King Fake Battle Win", 0],
	],
	"King Fake Battle Win": [
		[global.SCRIPT_NO_CANCEL],
		"I Die T_T",
		[global.SCRIPT_WRITE_QUEST, "King Fake"],
		[global.SCRIPT_SCRIPT_HIDDEN, "King Fake Battle"],
		[global.SCRIPT_NPC_HIDDEN, "King Fake"],
	],
	"Female0": [
		[global.SCRIPT_NPC_FACE, "left"],
		"Oh, yeah",
		[global.SCRIPT_NPC_WALK, 100, global.MOVE_UP],
		[global.SCRIPT_NPC_WALK, 100, global.MOVE_UP],
		[global.SCRIPT_NPC_FACE, "left"],
	],
}

