
extends Node2D

func _ready():
	get_node("MusicPlayer").play()
	get_node("Camera/TileMap/Party").set_current_scene(self)

var tag = global.TAG_DUNGEON

var enemy_dict = {
	"slimes0": 3,
	"slimes1": 1,
}

var enemy_ship_dict = {
	"fish0": 1,
}

var warp_dict = {
	"Test0": {"x": 256, "y": 128, "map": "maps/test0"},
	"Test0Water": {"x": 256, "y": 704, "map": "maps/test0"},
}

var dialog_dict = {
	"START": [
		[global.SCRIPT_NO_CANCEL],
		[global.SCRIPT_READ_QUEST, "King Fake"],
		[global.SCRIPT_CONTINUE_IF],
		[global.SCRIPT_HIDDEN_SCRIPT, "King Fake Battle"],
		[global.SCRIPT_NPC_HIDDEN, "King Fake"],
	],
	"King Fake Battle": [
		[global.SCRIPT_NO_CANCEL],
		"You Die!!\nYou Die!!\nYou Die!!\nYou Die!!",
		"You Die!!\nYou Die!!\nYou Die!!\nYou Die!!",
		[global.SCRIPT_NPC_WALK_, "Female0", 100, global.MOVE_RIGHT],
		[global.SCRIPT_NPC_ACTION_, "Female0", "down"],
		[global.SCRIPT_TITLE_SET, "Female0"],
		"Fight :)",
		[global.SCRIPT_BATTLE, "King Fake Battle Win", "boss0", "bossbackground"],
	],
	"King Fake Battle Win": [
		[global.SCRIPT_NO_CANCEL],
		"I Die T_T",
		[global.SCRIPT_WRITE_QUEST, "King Fake"],
		[global.SCRIPT_HIDDEN_SCRIPT, "King Fake Battle"],
		[global.SCRIPT_NPC_HIDDEN, "King Fake"],
		[global.SCRIPT_TITLE_SET, "Female0"],
		"Yes, you great -_-",
	],
	"Female0": [
		[global.SCRIPT_READ_QUEST, "King Fake"],
		[global.SCRIPT_IF_ELSE, "Female0_Else"],
		"Yes, u r great ^_^",
	],
	"Female0_Else": [
		[global.SCRIPT_NPC_ACTION, null],
		[global.SCRIPT_NPC_ACTION, "left"],
		"Oh, yeah",
		[global.SCRIPT_NPC_WALK, 100, global.MOVE_UP],
		[global.SCRIPT_NPC_ACTION, "left"],
	],
}

