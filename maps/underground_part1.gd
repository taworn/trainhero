
extends Node2D

func _ready():
	get_node("MusicPlayer").play()
	get_node("Camera/TileMap/Party").set_current_scene(self)

var tag = global.TAG_DUNGEON

var enemy_dict = {
}

var warp_dict = {
	"Back": {"x": 1088, "y": 192, "map": "maps/passageway"},
	"Next": {"x": 1600, "y": 3200, "map": "maps/underground_part2"},
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
		[global.SCRIPT_READ_QUEST, "Hydra"],
		[global.SCRIPT_CONTINUE_IF],
		[global.SCRIPT_NPC_HIDDEN, "Hydra"],
	],
	"Win": [
		[global.SCRIPT_NO_CANCEL],
		[global.SCRIPT_WRITE_QUEST, "Hydra"],
		[global.SCRIPT_NPC_HIDDEN, "Hydra"],
		"You received the Hero Sword, equip it. :)",
	],
	"Hydra": [
		[global.SCRIPT_NO_CANCEL],
		[global.SCRIPT_NPC_ACTION, "down"],
		"DIE DIE DIE !!!",
		[global.SCRIPT_BATTLE, "Win", "d0790", "Floor1"],
	],
}

