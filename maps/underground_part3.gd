
extends Node2D

func _ready():
	#get_node("MusicPlayer").play()
	get_node("Camera/TileMap/Party").set_current_scene(self)

var tag = global.TAG_DUNGEON

var enemy_dict = {
}

var warp_dict = {
	"Back": {"x": 1600, "y": 768, "map": "maps/underground_part2"},
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
		[global.SCRIPT_READ_QUEST, "The Dark Lord"],
		[global.SCRIPT_CONTINUE_IF],
		[global.SCRIPT_NPC_HIDDEN, "The Dark Lord"],
	],
	"Win": [
		[global.SCRIPT_NO_CANCEL],
		[global.SCRIPT_TITLE_SET, "The Dark Lord"],
		"I cannot believe it...",
		"You,.. can kill me...",
		"NO No no...",
		[global.SCRIPT_WRITE_QUEST, "The Dark Lord"],
		[global.SCRIPT_NPC_HIDDEN, "The Dark Lord"],
		[global.SCRIPT_TITLE_SET, 0],
		"...",
		[global.SCRIPT_TITLE_SET, "Rydia"],
		"Finally, it done.",
		[global.SCRIPT_TITLE_SET, "Nadia"],
		"Yeah.",
		[global.SCRIPT_TITLE_SET, 0],
		"Then, let's go back. :)",
		[global.SCRIPT_TITLE_VISIBLE, false],
		"THE END",
		[global.SCRIPT_THE_END]
	],
	"The Dark Lord": [
		[global.SCRIPT_NO_CANCEL],
		[global.SCRIPT_NPC_ACTION, "down"],
		"You are all excellent to come to this far.",
		"But...",
		"You will DIE here!",
		[global.SCRIPT_BATTLE, "Win", "d0799", "Floor9"],
	],
}

